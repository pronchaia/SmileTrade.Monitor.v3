-- SELECT TOP 10
--     ConsumeStartDate, count(*) as cnt
-- FROM kRisCreditPreparationDeal
-- WHERE FK_K_SyCSt IS NOT NULL
-- GROUP BY ConsumeStartDate
-- ORDER BY ConsumeStartDate DESC
-- FOR JSON PATH;




-- Result
Declare @XML   xml = (SELECT TOP 10
    ConsumeStartDate, count(*) as cnt
FROM kRisCreditPreparationDeal
WHERE FK_K_SyCSt IS NOT NULL
GROUP BY ConsumeStartDate
ORDER BY ConsumeStartDate DESC
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
