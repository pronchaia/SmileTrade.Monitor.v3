--DECLARE @dealid varchar(100);
DECLARE @FK_SyCPTy int;
DECLARE @DealType VARCHAR(50);
DECLARE @CK_De  int;
DECLARE @CK_DePDe  int;
DECLARE @ConsumeAmount NUMERIC(25,9);
DECLARE @PaidAmount NUMERIC(25,9);
DECLARE @FK_DeEDe_BL INT;
DECLARE @StartDate DATETIME;
DECLARE @EndDate DATETIME;
DECLARE @ConsumeStartDate DATETIME;
DECLARE @ConsumeEndDate DATETIME;
DECLARE @TempTable TABLE (AType VARCHAR(50), ATime DATETIME,AuditColumn VARCHAR(150),AuditValue VARCHAR(255),LoginName VARCHAR(255));
--SET @dealid='CRD.2017.12.00006';

SELECT @FK_SyCPTy = FK_SyCPTy,@CK_De=CK_De,@ConsumeAmount=ConsumeAmount,@PaidAmount=PaidAmount,@StartDate=StartDate,@EndDate=EndDate
,@ConsumeStartDate=ConsumeStartDate,@ConsumeEndDate=ConsumeEndDate
FROM kRisCreditPreparationDeal WHERE DealId=@dealid;

SELECT  @FK_DeEDe_BL = PK_DeEDe
FROM    DeaEventDefinition
WHERE   FK_K_StECa = 1;

IF @FK_SyCPTy =1
BEGIN
    SET @DealType='Physical';
    ----------  First loading
    SELECT TOP 1 @CK_DePDe = PK_DePDe
    FROM DeaPhysicalDetails  D
    WHERE CK_DePh=@CK_De AND PK_DePDe > 0 AND FK_SyDSt <> ( 1 )
    ORDER BY PK_DePDe;

    ----------  Credit status
    WITH cte as (
    SELECT oFK_K_SyCSt,AType FROM DeaPhysicalA WHERE oPK_DePh = @CK_De
    GROUP BY oFK_K_SyCSt,AType
    )
    INSERT INTO @TempTable 
    SELECT CASE AType WHEN 1 THEN 'Insert' WHEN 2 THEN 'Update' WHEN 3 THEN 'Delete' ELSE '-' END AS AType,ATime,'Deal credit status' AS AuditColumn
        ,[StatusName] as AuditValue,[LoginName]  
    FROM cte
    INNER JOIN kSysCreditStatus ON oFK_K_SyCSt = PK_SyCSt
    outer apply(
        select top 1 MIN(ATime) as ATime,MIN(oFK_SyUs_Modified) as oFK_SyUs_Modified
        from DeaPhysicalA a
        where a.oPK_DePh=@CK_De and a.oFK_K_SyCSt = cte.oFK_K_SyCSt
        and a.AType = cte.AType
        order by ATime
    ) credit_audit
    INNER JOIN SysUser ON oFK_SyUs_Modified = PK_SyUs
    ORDER BY ATime;

    ----------  Priviledge
    WITH cte as (
    SELECT oFK_K_SyCPr,AType FROM DeaPhysicalA WHERE oPK_DePh = @CK_De
    GROUP BY oFK_K_SyCPr,AType
    )
    INSERT INTO @TempTable 
    SELECT CASE AType WHEN 1 THEN 'Insert' WHEN 2 THEN 'Update' WHEN 3 THEN 'Delete' ELSE '-' END AS AType,ATime,'Deal priviledge' AS AuditColumn
        ,[Priviledge] as AuditValue,[LoginName] 
    FROM cte
    INNER JOIN kSysCreditPriviledge ON oFK_K_SyCPr = PK_SyCPr
    outer apply(
        select top 1 MIN(ATime) as ATime,MIN(oFK_SyUs_Modified) as oFK_SyUs_Modified
        from DeaPhysicalA a
        where a.oPK_DePh=@CK_De and a.oFK_K_SyCPr = cte.oFK_K_SyCPr
        and a.AType = cte.AType
        order by ATime
    ) credit_audit
    INNER JOIN SysUser ON oFK_SyUs_Modified = PK_SyUs
    ORDER BY ATime;

    ----------  Total value
    WITH cte as (
    SELECT oTotalValue,AType FROM DeaPhysicalA WHERE oPK_DePh = @CK_De
    GROUP BY oTotalValue,AType
    )
    INSERT INTO @TempTable 
    SELECT CASE AType WHEN 1 THEN 'Insert' WHEN 2 THEN 'Update' WHEN 3 THEN 'Delete' ELSE '-' END AS AType,ATime,'Deal total Value' AS AuditColumn
        ,FORMAT([oTotalValue],'N', 'en-us') as AuditValue,[LoginName] 
    FROM cte    
    outer apply(
        select top 1 MIN(ATime) as ATime,MIN(oFK_SyUs_Modified) as oFK_SyUs_Modified
        from DeaPhysicalA a
        where a.oPK_DePh=@CK_De and a.oTotalValue = cte.oTotalValue
        and a.AType = cte.AType
        order by ATime
    ) credit_audit
    INNER JOIN SysUser ON oFK_SyUs_Modified = PK_SyUs
    ORDER BY ATime;    
    ----------  Loading 
    WITH cte as (
        SELECT oPK_DePDe,AType FROM DeaPhysicalDetailsA WHERE oCK_DePh = @CK_De
        GROUP BY oPK_DePDe,AType
    )
    INSERT INTO @TempTable 
    SELECT CASE AType WHEN 1 THEN 'Insert' WHEN 2 THEN 'Update' WHEN 3 THEN 'Delete' ELSE '-' END AS AType,ATime,'Loading' AS AuditColumn
        ,[oPK_DePDe] as AuditValue,[LoginName] 
    FROM cte    
    outer apply(
        select top 1 MIN(ATime) as ATime,MIN(oFK_SyUs_Modified) as oFK_SyUs_Modified
        from DeaPhysicalDetailsA a
        where a.oCK_DePh=@CK_De and a.oPK_DePDe = cte.oPK_DePDe
        and a.AType = cte.AType
        order by ATime
    ) credit_audit
    INNER JOIN SysUser ON oFK_SyUs_Modified = PK_SyUs
    ORDER BY ATime;   

    ----------  Loading Structure
    WITH cte as (
        SELECT oPK_DePDe,oFK_SySt,AType FROM DeaPhysicalDetailsA WHERE oCK_DePh = @CK_De
        GROUP BY oPK_DePDe,oFK_SySt,AType
    )
    INSERT INTO @TempTable 
    SELECT CASE AType WHEN 1 THEN 'Insert' WHEN 2 THEN 'Update' WHEN 3 THEN 'Delete' ELSE '-' END AS AType,ATime,'Loading Structure' AS AuditColumn
        ,[StructureName] as AuditValue,[LoginName] 
    FROM cte    
    INNER JOIN SysStructure ON PK_SySt = cte.oFK_SySt
    outer apply(
        select top 1 MIN(ATime) as ATime,MIN(oFK_SyUs_Modified) as oFK_SyUs_Modified
        from DeaPhysicalDetailsA a
        where a.oCK_DePh=@CK_De and a.oPK_DePDe = cte.oPK_DePDe and a.oFK_SySt = cte.oFK_SySt
        and a.AType = cte.AType
        order by ATime
    ) credit_audit
    INNER JOIN SysUser ON oFK_SyUs_Modified = PK_SyUs
    ORDER BY ATime;   

    ----------  Loading Grade
    WITH cte as (
        SELECT oPK_DePDe,oFK_StGr,AType FROM DeaPhysicalDetailsA WHERE oCK_DePh = @CK_De
        GROUP BY oPK_DePDe,oFK_StGr,AType
    )
    INSERT INTO @TempTable 
    SELECT CASE AType WHEN 1 THEN 'Insert' WHEN 2 THEN 'Update' WHEN 3 THEN 'Delete' ELSE '-' END AS AType,ATime,'Loading Grade' AS AuditColumn
        ,[Grade] as AuditValue,[LoginName] 
    FROM cte    
    INNER JOIN StaGrade ON PK_StGr = cte.oFK_StGr
    outer apply(
        select top 1 MIN(ATime) as ATime,MIN(oFK_SyUs_Modified) as oFK_SyUs_Modified
        from DeaPhysicalDetailsA a
        where a.oCK_DePh=@CK_De and a.oPK_DePDe = cte.oPK_DePDe and a.oFK_StGr = cte.oFK_StGr
        and a.AType = cte.AType
        order by ATime
    ) credit_audit
    INNER JOIN SysUser ON oFK_SyUs_Modified = PK_SyUs
    ORDER BY ATime;       

    ----------  Loading Event BLDate
    WITH cte as (
        SELECT oEventDate,AType FROM DeaPhysicalDetailsEventA WHERE oCK_DePh = @CK_De AND oCK_DePDe=@CK_DePDe
        AND oFK_DeEDe = @FK_DeEDe_BL
        GROUP BY oEventDate,AType
    )
    INSERT INTO @TempTable 
    SELECT CASE AType WHEN 1 THEN 'Insert' WHEN 2 THEN 'Update' WHEN 3 THEN 'Delete' ELSE '-' END AS AType,ATime,'Loading Event BLDate' AS AuditColumn
        ,FORMAT([oEventDate],'dd/MM/yyyy','en-US') as AuditValue,[LoginName] 
    FROM cte    
    outer apply(
        select top 1 MIN(ATime) as ATime,MIN(AUser) as oFK_SyUs_Modified
        from DeaPhysicalDetailsEventA a
        where a.oCK_DePh=@CK_De and a.oCK_DePDe = @CK_DePDe and a.oFK_DeEDe = @FK_DeEDe_BL AND a.oEventDate = cte.oEventDate
        and a.AType = cte.AType
        order by ATime
    ) credit_audit
    INNER JOIN SysUser ON oFK_SyUs_Modified = PK_SyUs
    ORDER BY ATime;          
END
ELSE IF @FK_SyCPTy =2
BEGIN
    SET @DealType='OTC';

    ----------  Credit status
    WITH cte as (
    SELECT oFK_K_SyCSt,AType FROM DeaOtcA WHERE oPK_DeOt = @CK_De
    GROUP BY oFK_K_SyCSt,AType
    )

    INSERT INTO @TempTable 
    SELECT CASE AType WHEN 1 THEN 'Insert' WHEN 2 THEN 'Update' WHEN 3 THEN 'Delete' ELSE '-' END AS AType,ATime,'Deal credit status' AS AuditColumn
        ,[StatusName] as AuditValue,[LoginName]  
    FROM cte
    INNER JOIN kSysCreditStatus ON oFK_K_SyCSt = PK_SyCSt
    outer apply(
        select top 1 MIN(ATime) as ATime,MIN(oFK_SyUs_Modified) as oFK_SyUs_Modified
        from DeaOtcA a
        where a.oPK_DeOt=@CK_De and a.oFK_K_SyCSt = cte.oFK_K_SyCSt
        and a.AType = cte.AType
        order by ATime
    ) credit_audit
    INNER JOIN SysUser ON oFK_SyUs_Modified = PK_SyUs
    ORDER BY ATime;

    ----------  Priviledge
    WITH cte as (
    SELECT oFK_K_SyCPr,AType FROM DeaOtcA WHERE oPK_DeOt = @CK_De
    GROUP BY oFK_K_SyCPr,AType
    )

    INSERT INTO @TempTable 
    SELECT CASE AType WHEN 1 THEN 'Insert' WHEN 2 THEN 'Update' WHEN 3 THEN 'Delete' ELSE '-' END AS AType,ATime,'Deal priviledge' AS AuditColumn
        ,[Priviledge] as AuditValue,[LoginName] 
    FROM cte
    INNER JOIN kSysCreditPriviledge ON oFK_K_SyCPr = PK_SyCPr
    outer apply(
        select top 1 MIN(ATime) as ATime,MIN(oFK_SyUs_Modified) as oFK_SyUs_Modified
        from DeaOtcA a
        where a.oPK_DeOt=@CK_De and a.oFK_K_SyCPr = cte.oFK_K_SyCPr
        and a.AType = cte.AType
        order by ATime
    ) credit_audit
    INNER JOIN SysUser ON oFK_SyUs_Modified = PK_SyUs
    ORDER BY ATime;

    ----------  Total value
    WITH cte as (
    SELECT oTotalValue,AType FROM DeaOtcA WHERE oPK_DeOt = @CK_De
    GROUP BY oTotalValue,AType
    )
    INSERT INTO @TempTable 
    SELECT CASE AType WHEN 1 THEN 'Insert' WHEN 2 THEN 'Update' WHEN 3 THEN 'Delete' ELSE '-' END AS AType,ATime,'Deal total Value' AS AuditColumn
        ,FORMAT([oTotalValue],'N', 'en-us') as AuditValue,[LoginName] 
    FROM cte    
    outer apply(
        select top 1 MIN(ATime) as ATime,MIN(oFK_SyUs_Modified) as oFK_SyUs_Modified
        from DeaOtcA a
        where a.oPK_DeOt=@CK_De and a.oTotalValue = cte.oTotalValue
        and a.AType = cte.AType
        order by ATime
    ) credit_audit
    INNER JOIN SysUser ON oFK_SyUs_Modified = PK_SyUs
    ORDER BY ATime;    
 
    ----------  Loading Structure
    WITH cte as (
        SELECT oPK_DeOt,oFK_SySt,AType FROM DeaOtcA WHERE oPK_DeOt = @CK_De
        GROUP BY oPK_DeOt,oFK_SySt,AType
    )
    INSERT INTO @TempTable 
    SELECT CASE AType WHEN 1 THEN 'Insert' WHEN 2 THEN 'Update' WHEN 3 THEN 'Delete' ELSE '-' END AS AType,ATime,'Loading Structure' AS AuditColumn
        ,[StructureName] as AuditValue,[LoginName] 
    FROM cte    
    INNER JOIN SysStructure ON PK_SySt = cte.oFK_SySt
    outer apply(
        select top 1 MIN(ATime) as ATime,MIN(oFK_SyUs_Modified) as oFK_SyUs_Modified
        from DeaOtcA a
        where a.oPK_DeOt = cte.oPK_DeOt and a.oFK_SySt = cte.oFK_SySt
        and a.AType = cte.AType
        order by ATime
    ) credit_audit
    INNER JOIN SysUser ON oFK_SyUs_Modified = PK_SyUs
    ORDER BY ATime;   
 
    ----------  Loading Event BLDate
    WITH cte as (
        SELECT oDealDate,AType FROM DeaOtcA WHERE oPK_DeOt = @CK_De 
        GROUP BY oDealDate,AType
    )
    INSERT INTO @TempTable 
    SELECT CASE AType WHEN 1 THEN 'Insert' WHEN 2 THEN 'Update' WHEN 3 THEN 'Delete' ELSE '-' END AS AType,ATime,'Loading Event BLDate' AS AuditColumn
        ,FORMAT([oDealDate],'dd/MM/yyyy','en-US') as AuditValue,[LoginName] 
    FROM cte    
    outer apply(
        select top 1 MIN(ATime) as ATime,MIN(AUser) as oFK_SyUs_Modified
        from DeaOtcA a
        where a.oPK_DeOt=@CK_De AND a.oDealDate = cte.oDealDate
        and a.AType = cte.AType
        order by ATime
    ) credit_audit
    INNER JOIN SysUser ON oFK_SyUs_Modified = PK_SyUs
    ORDER BY ATime;     


END
ELSE IF @FK_SyCPTy =3
BEGIN
    SET @DealType='Spot voyage';

    ----------  Credit status
    WITH cte as (
    SELECT oFK_SyCSt,AType FROM kDeaVoyageCharterA WHERE oPK_DeVCh = @CK_De
    GROUP BY oFK_SyCSt,AType
    )

    INSERT INTO @TempTable 
    SELECT CASE AType WHEN 1 THEN 'Insert' WHEN 2 THEN 'Update' WHEN 3 THEN 'Delete' ELSE '-' END AS AType,ATime,'Deal credit status' AS AuditColumn
        ,[StatusName] as AuditValue,[LoginName]  
    FROM cte
    INNER JOIN kSysCreditStatus ON oFK_SyCSt = PK_SyCSt
    outer apply(
        select top 1 MIN(ATime) as ATime,MIN(oFK_SyUs_Modified) as oFK_SyUs_Modified
        from kDeaVoyageCharterA a
        where a.oPK_DeVCh=@CK_De and a.oFK_SyCSt = cte.oFK_SyCSt
        and a.AType = cte.AType
        order by ATime
    ) credit_audit
    INNER JOIN SysUser ON oFK_SyUs_Modified = PK_SyUs
    ORDER BY ATime;

    ----------  Priviledge
    WITH cte as (
    SELECT oFK_SyCPr,AType FROM kDeaVoyageCharterA WHERE oPK_DeVCh = @CK_De
    GROUP BY oFK_SyCPr,AType
    )

    INSERT INTO @TempTable 
    SELECT CASE AType WHEN 1 THEN 'Insert' WHEN 2 THEN 'Update' WHEN 3 THEN 'Delete' ELSE '-' END AS AType,ATime,'Deal priviledge' AS AuditColumn
        ,[Priviledge] as AuditValue,[LoginName] 
    FROM cte
    INNER JOIN kSysCreditPriviledge ON oFK_SyCPr = PK_SyCPr
    outer apply(
        select top 1 MIN(ATime) as ATime,MIN(oFK_SyUs_Modified) as oFK_SyUs_Modified
        from kDeaVoyageCharterA a
        where a.oPK_DeVCh=@CK_De and a.oFK_SyCPr = cte.oFK_SyCPr
        and a.AType = cte.AType
        order by ATime
    ) credit_audit
    INNER JOIN SysUser ON oFK_SyUs_Modified = PK_SyUs
    ORDER BY ATime;

    ----------  Total value
    WITH cte as (
    SELECT oTotalValue,AType FROM kDeaVoyageCharterA WHERE oPK_DeVCh = @CK_De
    GROUP BY oTotalValue,AType
    )
    INSERT INTO @TempTable 
    SELECT CASE AType WHEN 1 THEN 'Insert' WHEN 2 THEN 'Update' WHEN 3 THEN 'Delete' ELSE '-' END AS AType,ATime,'Deal total Value' AS AuditColumn
        ,FORMAT([oTotalValue],'N', 'en-us') as AuditValue,[LoginName] 
    FROM cte    
    outer apply(
        select top 1 MIN(ATime) as ATime,MIN(oFK_SyUs_Modified) as oFK_SyUs_Modified
        from kDeaVoyageCharterA a
        where a.oPK_DeVCh=@CK_De and a.oTotalValue = cte.oTotalValue
        and a.AType = cte.AType
        order by ATime
    ) credit_audit
    INNER JOIN SysUser ON oFK_SyUs_Modified = PK_SyUs
    ORDER BY ATime;    
 
    ----------  Loading Structure
    WITH cte as (
        SELECT oPK_DeVCh,oFK_SySt,AType FROM kDeaVoyageCharterA WHERE oPK_DeVCh = @CK_De
        GROUP BY oPK_DeVCh,oFK_SySt,AType
    )
    INSERT INTO @TempTable 
    SELECT CASE AType WHEN 1 THEN 'Insert' WHEN 2 THEN 'Update' WHEN 3 THEN 'Delete' ELSE '-' END AS AType,ATime,'Loading Structure' AS AuditColumn
        ,[StructureName] as AuditValue,[LoginName] 
    FROM cte    
    INNER JOIN SysStructure ON PK_SySt = cte.oFK_SySt
    outer apply(
        select top 1 MIN(ATime) as ATime,MIN(oFK_SyUs_Modified) as oFK_SyUs_Modified
        from kDeaVoyageCharterA a
        where a.oPK_DeVCh = cte.oPK_DeVCh and a.oFK_SySt = cte.oFK_SySt
        and a.AType = cte.AType
        order by ATime
    ) credit_audit
    INNER JOIN SysUser ON oFK_SyUs_Modified = PK_SyUs
    ORDER BY ATime;   
 
    ----------  Loading Event BLDate
    WITH cte as (
        SELECT oDealDate,AType FROM kDeaVoyageCharterA WHERE oPK_DeVCh = @CK_De 
        GROUP BY oDealDate,AType
    )
    INSERT INTO @TempTable 
    SELECT CASE AType WHEN 1 THEN 'Insert' WHEN 2 THEN 'Update' WHEN 3 THEN 'Delete' ELSE '-' END AS AType,ATime,'Loading Event BLDate' AS AuditColumn
        ,FORMAT([oDealDate],'dd/MM/yyyy','en-US') as AuditValue,[LoginName] 
    FROM cte    
    outer apply(
        select top 1 MIN(ATime) as ATime,MIN(AUser) as oFK_SyUs_Modified
        from kDeaVoyageCharterA a
        where a.oPK_DeVCh=@CK_De AND a.oDealDate = cte.oDealDate
        and a.AType = cte.AType
        order by ATime
    ) credit_audit
    INNER JOIN SysUser ON oFK_SyUs_Modified = PK_SyUs
    ORDER BY ATime;     


END
ELSE
BEGIN
    SET @DealType='Trans cost';
    ----------  Credit status
    WITH cte as (
    SELECT oFK_K_SyCSt,AType FROM DeaStructureCostA WHERE oPK_DeSCo = @CK_De
    GROUP BY oFK_K_SyCSt,AType
    )

    INSERT INTO @TempTable 
    SELECT CASE AType WHEN 1 THEN 'Insert' WHEN 2 THEN 'Update' WHEN 3 THEN 'Delete' ELSE '-' END AS AType,ATime,'Deal credit status' AS AuditColumn
        ,[StatusName] as AuditValue,[LoginName]  
    FROM cte
    INNER JOIN kSysCreditStatus ON oFK_K_SyCSt = PK_SyCSt
    outer apply(
        select top 1 MIN(ATime) as ATime,MIN(oFK_SyUs_Modified) as oFK_SyUs_Modified
        from DeaStructureCostA a
        where a.oPK_DeSCo=@CK_De and a.oFK_K_SyCSt = cte.oFK_K_SyCSt
        and a.AType = cte.AType
        order by ATime
    ) credit_audit
    INNER JOIN SysUser ON oFK_SyUs_Modified = PK_SyUs
    ORDER BY ATime;

    ----------  Priviledge
    WITH cte as (
    SELECT oFK_K_SyCPr,AType FROM DeaStructureCostA WHERE oPK_DeSCo = @CK_De
    GROUP BY oFK_K_SyCPr,AType
    )

    INSERT INTO @TempTable 
    SELECT CASE AType WHEN 1 THEN 'Insert' WHEN 2 THEN 'Update' WHEN 3 THEN 'Delete' ELSE '-' END AS AType,ATime,'Deal priviledge' AS AuditColumn
        ,[Priviledge] as AuditValue,[LoginName] 
    FROM cte
    INNER JOIN kSysCreditPriviledge ON oFK_K_SyCPr = PK_SyCPr
    outer apply(
        select top 1 MIN(ATime) as ATime,MIN(oFK_SyUs_Modified) as oFK_SyUs_Modified
        from DeaStructureCostA a
        where a.oPK_DeSCo=@CK_De and a.oFK_K_SyCPr = cte.oFK_K_SyCPr
        and a.AType = cte.AType
        order by ATime
    ) credit_audit
    INNER JOIN SysUser ON oFK_SyUs_Modified = PK_SyUs
    ORDER BY ATime;

    ----------  Total value
    WITH cte as (
    SELECT oTotalValue,AType FROM DeaStructureCostA WHERE oPK_DeSCo = @CK_De
    GROUP BY oTotalValue,AType
    )
    INSERT INTO @TempTable 
    SELECT CASE AType WHEN 1 THEN 'Insert' WHEN 2 THEN 'Update' WHEN 3 THEN 'Delete' ELSE '-' END AS AType,ATime,'Deal total Value' AS AuditColumn
        ,FORMAT([oTotalValue],'N', 'en-us') as AuditValue,[LoginName] 
    FROM cte    
    outer apply(
        select top 1 MIN(ATime) as ATime,MIN(oFK_SyUs_Modified) as oFK_SyUs_Modified
        from DeaStructureCostA a
        where a.oPK_DeSCo=@CK_De and a.oTotalValue = cte.oTotalValue
        and a.AType = cte.AType
        order by ATime
    ) credit_audit
    INNER JOIN SysUser ON oFK_SyUs_Modified = PK_SyUs
    ORDER BY ATime;    
 
    ----------  Loading Structure
    WITH cte as (
        SELECT oPK_DeSCo,oFK_SySt,AType FROM DeaStructureCostA WHERE oPK_DeSCo = @CK_De
        GROUP BY oPK_DeSCo,oFK_SySt,AType
    )
    INSERT INTO @TempTable 
    SELECT CASE AType WHEN 1 THEN 'Insert' WHEN 2 THEN 'Update' WHEN 3 THEN 'Delete' ELSE '-' END AS AType,ATime,'Loading Structure' AS AuditColumn
        ,[StructureName] as AuditValue,[LoginName] 
    FROM cte    
    INNER JOIN SysStructure ON PK_SySt = cte.oFK_SySt
    outer apply(
        select top 1 MIN(ATime) as ATime,MIN(oFK_SyUs_Modified) as oFK_SyUs_Modified
        from DeaStructureCostA a
        where a.oPK_DeSCo = cte.oPK_DeSCo and a.oFK_SySt = cte.oFK_SySt
        and a.AType = cte.AType
        order by ATime
    ) credit_audit
    INNER JOIN SysUser ON oFK_SyUs_Modified = PK_SyUs
    ORDER BY ATime;   
 
    ----------  Loading Event BLDate
    WITH cte as (
        SELECT oDealDate,AType FROM DeaStructureCostA WHERE oPK_DeSCo = @CK_De 
        GROUP BY oDealDate,AType
    )
    INSERT INTO @TempTable 
    SELECT CASE AType WHEN 1 THEN 'Insert' WHEN 2 THEN 'Update' WHEN 3 THEN 'Delete' ELSE '-' END AS AType,ATime,'Loading Event BLDate' AS AuditColumn
        ,FORMAT([oDealDate],'dd/MM/yyyy','en-US') as AuditValue,[LoginName] 
    FROM cte    
    outer apply(
        select top 1 MIN(ATime) as ATime,MIN(AUser) as oFK_SyUs_Modified
        from DeaStructureCostA a
        where a.oPK_DeSCo=@CK_De AND a.oDealDate = cte.oDealDate
        and a.AType = cte.AType
        order by ATime
    ) credit_audit
    INNER JOIN SysUser ON oFK_SyUs_Modified = PK_SyUs
    ORDER BY ATime;     
    
END


declare @XML   xml = (select ROW_NUMBER()  OVER(ORDER BY AuditColumn,ATime ASC) ID, *
from @TempTable order by AuditColumn,ATime
FOR XML Raw);

declare @JSON  varchar(max) = '';


;with
    cteEAV
    as
    (
        Select RowNr     = Row_Number() over (Order By (Select NULL))
            , Entity    = xRow.value('@*[1]','varchar(200)')
            , Attribute = xAtt.value('local-name(.)','varchar(200)')
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
