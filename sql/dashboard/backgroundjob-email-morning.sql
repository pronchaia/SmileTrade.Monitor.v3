
Declare @XML   xml = (
SELECT (SELECT COUNT(*) FROM SysAlertQueue WHERE FK_SyACo=13 AND CAST([Initiated] as DATE) = CAST(GETDATE() as DATE) 
AND DATEPART(HOUR, [Initiated]) = 8 AND CHARINDEX('Credit Overlimit Blocked for Deal ID',[Subject]) <> 0) AS 'BLOCKED-OVERLIMIT'
,(SELECT COUNT(*) FROM SysAlertQueue WHERE FK_SyACo=13 AND CAST([Initiated] as DATE) = CAST(GETDATE() as DATE) 
AND DATEPART(HOUR, [Initiated]) = 8 AND CHARINDEX('Credit Block for No Assigned Security',[Subject]) <> 0) AS 'BLOCKED-NO-SEC-ALTER-BLDATE'
,(SELECT COUNT(*) FROM SysAlertQueue WHERE FK_SyACo=13 AND CAST([Initiated] as DATE) = CAST(GETDATE() as DATE) 
AND DATEPART(HOUR, [Initiated]) = 8 AND CHARINDEX('Security Number Required for',[Subject]) <> 0)  AS 'NO-SEC-BEFORE-BLDATE'

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
            , NewRow = IIF(Lag(Entity,1)  over (Partition By Entity Order By (Select NULL))=Entity,'',',')
            , EndRow = IIF(Lead(Entity,1) over (Partition By Entity Order By (Select NULL))=Entity,',','')
            , JSON   = Concat('"',Value,'"')
        From cteEAV
    )
Select @JSON = @JSON+NewRow+JSON+EndRow
From cteBld

Select '['+Stuff(@JSON,1,1,'')+']';
