--DECLARE @dealid varchar(100);
DECLARE @FK_SyCPTy int;
DECLARE @DealType VARCHAR(50);
DECLARE @CK_De  int;
DECLARE @ConsumeAmount NUMERIC(25,9);
DECLARE @PaidAmount NUMERIC(25,9);
DECLARE @FK_DeEDe_BL INT;
DECLARE @StartDate DATETIME;
DECLARE @EndDate DATETIME;
DECLARE @ConsumeStartDate DATETIME;
DECLARE @ConsumeEndDate DATETIME;
DECLARE @TempTable TABLE (
    DealID VARCHAR(100), 
    CK_De int,
    CK_DePDe int,
    DealType VARCHAR(50),
    PSFlag VARCHAR(50),
    FK_K_SyCSt int,
    CreditStatus VARCHAR(50),
    FK_K_SyCPr int,
    Priviledge  VARCHAR(50),
    TotalValue NUMERIC(25,9),
    UnrealValue NUMERIC(25,9),
    K_CrOnlySecurityLimit VARCHAR(10),
    NetAmountCompCCy NUMERIC(25,9),
    K_PaymentAmountCompCCy NUMERIC(25,9),
    ConsumeAmount NUMERIC(25,9),
    PaidAmount NUMERIC(25,9),
    FK_SySt int,
    Structure VARCHAR(255),
    DomainName VARCHAR(50),
    CreditStructureName VARCHAR(255),
    FK_StGr int,
    Grade VARCHAR(255),
    MinBLDate DATETIME,
    StartDate DATETIME,
    EndDate DATETIME,
    ConsumeStartDate DATETIME,
    ConsumeEndDate DATETIME
);

--SET @dealid='CRUD.2017.10.00131';


SELECT @FK_SyCPTy = FK_SyCPTy,@CK_De=CK_De,@ConsumeAmount=ConsumeAmount,@PaidAmount=PaidAmount,@StartDate=StartDate,@EndDate=EndDate
,@ConsumeStartDate=ConsumeStartDate,@ConsumeEndDate=ConsumeEndDate
FROM kRisCreditPreparationDeal WHERE DealId=@dealid;

SELECT  @FK_DeEDe_BL = PK_DeEDe
FROM    DeaEventDefinition
WHERE   FK_K_StECa = 1;

IF @FK_SyCPTy =1
BEGIN
    SET @DealType='Physical';
    INSERT INTO @TempTable
    SELECT @dealid as DealID,PK_DePh, loading.PK_DePDe,@DealType As DealType
    ,CASE PSFlag WHEN -1 THEN 'Sale' ELSE 'Purchase' END AS PSFlag,deal.FK_K_SyCSt,StatusName as CreditStatus
    ,FK_K_SyCPr,Priviledge
    ,TotalValue,UnrealValue,CASE K_CrOnlySecurityLimit WHEN 0 THEN 'No' ELSE 'Yes' END AS K_CrOnlySecurityLimit
    ,cost.NetAmountCompCCy,cost.K_PaymentAmountCompCCy,@ConsumeAmount AS ConsumeAmount,@PaidAmount As PaidAmount
    ,loading.FK_SySt,SysStructure.Structure,DomainName,kSysCreditStructure.StructureName as CreditStructureName
    ,loading.FK_StGr,Grade,dealevent.MinBLDate,@StartDate AS StartDate,@EndDate as EndDate,@ConsumeStartDate As ConsumeStartDate,@ConsumeEndDate as ConsumeEndDate
    --INTO #Consumption
    FROM DeaPhysical deal
    LEFT JOIN kSysCreditStatus ON FK_K_SyCSt = PK_SyCSt
    LEFT JOIN kSysCreditPriviledge ON FK_K_SyCPr = PK_SyCPr
    OUTER APPLY(
        SELECT TOP 1 PK_DePDe,FK_SySt,FK_StGr
        FROM DeaPhysicalDetails  D
        WHERE CK_DePh=PK_DePh AND PK_DePDe > 0 AND FK_SyDSt <> ( 1 )
        ORDER BY PK_DePDe
    ) loading
    OUTER APPLY(
        SELECT SUM(NetAmountCompCCy) as NetAmountCompCCy,SUM(K_PaymentAmountCompCCy) AS K_PaymentAmountCompCCy 
        FROM DeaPhysicalDetailsCost
        WHERE CK_DePh=PK_DePh AND CK_DePDe=loading.PK_DePDe AND K_CreditFlag = 1
        GROUP BY CK_DePh
    ) cost
    OUTER APPLY(
        SELECT TOP 1 EventDate AS MinBLDate 
        FROM DeaPhysicalDetailsEvent 
        WHERE CK_DePh=PK_DePh AND CK_DePDe=PK_DePDe AND FK_DeEDe = @FK_DeEDe_BL
        ORDER BY EventDate
    ) dealevent
    INNER JOIN SysStructure ON PK_SySt=loading.FK_SySt
    INNER JOIN SysDomain ON PK_SyDo = FK_SyDo
    INNER JOIN StaGrade ON PK_StGr = FK_StGr    
    INNER JOIN kSysCreditStructure ON kSysCreditStructure.PK_SyCSt = StaGrade.FK_K_SyCSt
    WHERE PK_DePh=@CK_De;
END
ELSE IF @FK_SyCPTy =2
BEGIN
    SET @DealType='OTC';
END
ELSE IF @FK_SyCPTy =3
BEGIN
    SET @DealType='Spot voyage';
END
ELSE
BEGIN
    SET @DealType='Trans cost';
END

declare @XML   xml = (select NEWID() as ID, *
from @TempTable
FOR XML Raw);

declare @JSON  varchar(max) = '';

--drop table #Consumption;


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
