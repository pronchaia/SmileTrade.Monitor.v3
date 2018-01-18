with nums as (
      select 0 as n
      union all
      select n + 1 as n
      from nums
      where n < 9
     )
SELECT cast(dateadd(d,n *-1, getdate()) as date) as DateExecution, 
CASE WHEN ISNULL([Description],'') = 'Save data error' THEN -5
ELSE
ISNULL(DATEDIFF(SECOND, StartExecution, EndExecution),-1) END as [SECOND] INTO #Job
FROM nums E
left join kSysCreditMessage M ON cast(dateadd(d,n *-1, getdate()) as date) = CAST(M.StartExecution AS DATE) AND DATEPART(HOUR, M.StartExecution) = 8 
left join SysUser on M.FK_SyUs=PK_SyUs AND  LoginName='SYS.BACKGROUNDJOB'
order by DateExecution;


Declare @XML   xml = (select E.DateExecution,E.SECOND as [SECOND]
from #Job E
order by E.DateExecution

FOR XML Raw)
Declare @JSON  varchar(max) = ''
DROP TABLE #Job;

;with
    cteEAV
    as
    (
        Select RowNr     = Row_Number() over (Order By (Select NULL))
            , Entity    = xRow.value('@*[1]','varchar(100)')
            , Attribute = xAtt.value('local-name(.)','varchar(100)')
            , Value     = xAtt.value('.','varchar(max)')
        From @XML.nodes('/row') As A(xRow)
       Cross Apply A.xRow.nodes('./@*') As B(xAtt)
    )
     ,
    cteBld
    as
    (
        Select *
            , NewRow = IIF(Lag(Entity,1)  over (Partition By Entity Order By (Select NULL))=Entity,'',',{')
            , EndRow = IIF(Lead(Entity,1) over (Partition By Entity Order By (Select NULL))=Entity,',','}')
            , JSON   = Concat('"',Attribute,'":','"',Value,'"')
        From cteEAV
    )
Select @JSON = @JSON+NewRow+JSON+EndRow
From cteBld

Select '['+Stuff(@JSON,1,1,'')+']';
