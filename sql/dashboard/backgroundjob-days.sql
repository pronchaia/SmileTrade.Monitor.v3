with
    nums
    as
    (
                    select 0 as n
        union all
            select n + 1 as n
            from nums
            where n < 9
    )
SELECT cast(dateadd(d,n *-1, getdate()) as date)  as ConsumeStartDate
INTO #Job
FROM nums
order by ConsumeStartDate;

Declare @XML   xml = (select *
from #Job

FOR XML Raw)
Declare @JSON  varchar(max) = '';

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
            , NewRow = IIF(Lag(Entity,1)  over (Partition By Entity Order By (Select NULL))=Entity,'',',')
            , EndRow = IIF(Lead(Entity,1) over (Partition By Entity Order By (Select NULL))=Entity,',','')
            , JSON   = Concat('"',Value,'"')
        From cteEAV
    )
Select @JSON = @JSON+NewRow+JSON+EndRow
From cteBld

Select '['+Stuff(@JSON,1,1,'')+']';



