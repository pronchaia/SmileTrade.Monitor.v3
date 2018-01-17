-- SELECT TOP 1000 PK_SyTr ,
--        cast(Req as varchar(128)) REQ,
--        cast(HIN as varchar(128)) HOST,
--        cast(UID as int) USERID,
--         B.LoginName   AS LOGINNAME,     
--        ISNULL(cast(Tst as DATETIME),'') DATE,
--        CASE WHEN Par IS NULL THEN '' ELSE cast(Par as varchar(550)) END AS PARAMETER
-- FROM dbo.SysTracer A
-- INNER JOIN dbo.SysUser B ON  cast(UID as int) = B.PK_SyUs
-- ORDER BY PK_SyTr DESC
-- FOR JSON PATH;




-- Result
Declare @XML   xml = (SELECT TOP 2000
    PK_SyTr ,
    cast(Req as varchar(128)) REQ,
    cast(HIN as varchar(128)) HOST,
    cast(UID as int) USERID,
    B.LoginName   AS LOGINNAME,
    ISNULL(cast(Tst as DATETIME),'') DATE,
    CASE WHEN Par IS NULL THEN '' ELSE cast(Par as varchar(550)) END AS PARAMETER
FROM dbo.SysTracer A
    INNER JOIN dbo.SysUser B ON  cast(UID as int) = B.PK_SyUs
ORDER BY Tst DESC

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
