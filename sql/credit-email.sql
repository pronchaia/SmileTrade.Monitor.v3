Declare @XML   xml = (
select TOP 100
    [PK_SyAQu]
      , [FK_SyACo]
      , [Subject]
      , [Body]
      , [Initiated]
      , ISNULL([Sent],'') AS [Sent]
      , CASE WHEN [Status] IS NULL THEN 'Not send'
			WHEN [Status] = 0 THEN 'Waitting'
			WHEN [Status] = 1 THEN 'Success'
			WHEN [Status] = -1 THEN 'Error'
		END AS [Status]
      , [K_TO]
      , [K_CC]
      , [K_From]
from SysAlertQueue
where FK_SyACo=13
--and CAST([Initiated] as DATE) >= CAST(DATEADD(day,-31,getdate()) as DATE)
order by Initiated desc
FOR XML Raw)
Declare @JSON  varchar(max) = ''

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
