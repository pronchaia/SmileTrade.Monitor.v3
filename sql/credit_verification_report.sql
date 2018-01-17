-- Declare @Result Table (id int, Name varchar(50), Physical int, OTC int, VoyageCharter int, TransCost int)
-- Declare @Name varchar(50), @Physical int, @OTC int, @VoyageCharter int, @TransCost int

-- -- Product Type
-- Declare @PhysicalProductType Table (id int)
-- insert into @PhysicalProductType SELECT A.PK_SyPTy FROM dbo.SysProductTypes A INNER JOIN  dbo.kSysCreditProductType B ON B.PK_SyCPTy = A.FK_K_SyCPTy WHERE B.PK_SyCPTy = 1
-- Declare @OTCProductType Table (id int)
-- insert into @OTCProductType  SELECT A.PK_SyPTy FROM dbo.SysProductTypes A INNER JOIN  dbo.kSysCreditProductType B ON B.PK_SyCPTy = A.FK_K_SyCPTy WHERE B.PK_SyCPTy = 2
-- Declare @VoyageCharterProductType INT = (SELECT TOP 1 A.PK_SyPTy FROM dbo.SysProductTypes A INNER JOIN  dbo.kSysCreditProductType B ON B.PK_SyCPTy = A.FK_K_SyCPTy WHERE B.PK_SyCPTy = 3)
-- Declare @TransCostProductType int = (SELECT dbo.SF_SysVarInt('ProductTypeTransCost'))


-- Set @Name = 'Total Deals'
-- select @Physical = count(1) from DeaPhysical
-- select @OTC = count(1) from DeaOtc
-- select @VoyageCharter = count(1) from kDeaVoyageCharter
-- select @TransCost = count(1) from DeaStructureCost
-- insert into @Result select 0, @Name, @Physical, @OTC, @VoyageCharter, @TransCost

-- Set @Name = 'Deal Deleted'
-- Declare @DeleteStatus int = CAST(dbo.SF_SysVarInt('DeletedDealStatus') AS INT)
-- select @Physical = count(1) from DeaPhysical where FK_SyDSt = @DeleteStatus
-- select @OTC = count(1) from DeaOtc where FK_SyDSt = @DeleteStatus
-- select @VoyageCharter = count(1) from kDeaVoyageCharter where FK_SyDSt = @DeleteStatus
-- select @TransCost = count(1) from DeaStructureCost where FK_SyDSt = @DeleteStatus
-- insert into @Result select 0, @Name, @Physical, @OTC, @VoyageCharter, @TransCost

-- Set @Name = 'Total'
-- select @Physical = count(1) from kRisCreditPreparationDeal p inner join @PhysicalProductType d on p.CK_SyPTy = d.id
-- select @OTC = count(1) from kRisCreditPreparationDeal p inner join @OTCProductType d on p.CK_SyPTy = d.id
-- select @VoyageCharter = count(1) from kRisCreditPreparationDeal p where p.CK_SyPTy = @VoyageCharterProductType
-- select @TransCost = count(1) from kRisCreditPreparationDeal p where p.CK_SyPTy = @TransCostProductType
-- insert into @Result select 1, @Name, @Physical, @OTC, @VoyageCharter, @TransCost

-- Set @Name = 'Calc Credit'
-- select @Physical = count(1) from kRisCreditPreparationDeal p inner join @PhysicalProductType d on p.CK_SyPTy = d.id where p.CalculateFlag = 1
-- select @OTC = count(1) from kRisCreditPreparationDeal p inner join @OTCProductType d on p.CK_SyPTy = d.id where p.CalculateFlag = 1
-- select @VoyageCharter = count(1) from kRisCreditPreparationDeal p where p.CK_SyPTy = @VoyageCharterProductType and p.CalculateFlag = 1
-- select @TransCost = count(1) from kRisCreditPreparationDeal p where p.CK_SyPTy = @TransCostProductType and p.CalculateFlag = 1
-- insert into @Result select 2, @Name, @Physical, @OTC, @VoyageCharter, @TransCost

-- Set @Name = 'Not Calc Credit'
-- select @Physical = count(1) from kRisCreditPreparationDeal p inner join @PhysicalProductType d on p.CK_SyPTy = d.id where p.CalculateFlag = 0
-- select @OTC = count(1) from kRisCreditPreparationDeal p inner join @OTCProductType d on p.CK_SyPTy = d.id where p.CalculateFlag = 0
-- select @VoyageCharter = count(1) from kRisCreditPreparationDeal p where p.CK_SyPTy = @VoyageCharterProductType and p.CalculateFlag = 0
-- select @TransCost = count(1) from kRisCreditPreparationDeal p where p.CK_SyPTy = @TransCostProductType and p.CalculateFlag = 0
-- insert into @Result select 3, @Name, @Physical, @OTC, @VoyageCharter, @TransCost

-- Set @Name = '> DealId IS NULL'
-- select @Physical = count(1) from kRisCreditPreparationDeal p inner join @PhysicalProductType d on p.CK_SyPTy = d.id where p.DealId is null
-- select @OTC = count(1) from kRisCreditPreparationDeal p inner join @OTCProductType d on p.CK_SyPTy = d.id where p.DealId is null
-- select @VoyageCharter = count(1) from kRisCreditPreparationDeal p where p.CK_SyPTy = @VoyageCharterProductType and p.DealId is null
-- select @TransCost = count(1) from kRisCreditPreparationDeal p where p.CK_SyPTy = @TransCostProductType and p.DealId is null
-- insert into @Result select 31, @Name, @Physical, @OTC, @VoyageCharter, @TransCost

-- Set @Name = '> StartDate IS NULL'
-- select @Physical = count(1) from kRisCreditPreparationDeal p inner join @PhysicalProductType d on p.CK_SyPTy = d.id where p.DealId is not null and p.StartDate is null
-- select @OTC = count(1) from kRisCreditPreparationDeal p inner join @OTCProductType d on p.CK_SyPTy = d.id where p.DealId is not null and p.StartDate is null
-- select @VoyageCharter = count(1) from kRisCreditPreparationDeal p where p.CK_SyPTy = @VoyageCharterProductType and p.DealId is not null and p.StartDate is null
-- select @TransCost = count(1) from kRisCreditPreparationDeal p where p.CK_SyPTy = @TransCostProductType and p.DealId is not null and p.StartDate is null
-- insert into @Result select 32, @Name, @Physical, @OTC, @VoyageCharter, @TransCost

-- Set @Name = '> EndDate IS NULL'
-- select @Physical = count(1) from kRisCreditPreparationDeal p inner join @PhysicalProductType d on p.CK_SyPTy = d.id where p.DealId is not null and p.StartDate is not null and p.EndDate is null
-- select @OTC = count(1) from kRisCreditPreparationDeal p inner join @OTCProductType d on p.CK_SyPTy = d.id where p.DealId is not null and p.StartDate is not null and p.EndDate is null
-- select @VoyageCharter = count(1) from kRisCreditPreparationDeal p where p.CK_SyPTy = @VoyageCharterProductType and p.DealId is not null and p.StartDate is not null and p.EndDate is null
-- select @TransCost = count(1) from kRisCreditPreparationDeal p where p.CK_SyPTy = @TransCostProductType and p.DealId is not null and p.StartDate is not null and p.EndDate is null
-- insert into @Result select 33, @Name, @Physical, @OTC, @VoyageCharter, @TransCost

-- Set @Name = '> Consume Amount = 0'
-- select @Physical = count(1) from kRisCreditPreparationDeal p inner join @PhysicalProductType d on p.CK_SyPTy = d.id where p.DealId is not null and p.StartDate is not null and p.EndDate is not null and ConsumeAmount = 0
-- select @OTC = count(1) from kRisCreditPreparationDeal p inner join @OTCProductType d on p.CK_SyPTy = d.id where p.DealId is not null and p.StartDate is not null and p.EndDate is not null and ConsumeAmount = 0

-- select @VoyageCharter = count(1) from kRisCreditPreparationDeal p where p.CK_SyPTy = @VoyageCharterProductType and p.DealId is not null and p.StartDate is not null and p.EndDate is not null and ConsumeAmount = 0
-- select @TransCost = count(1) from kRisCreditPreparationDeal p where p.CK_SyPTy = @TransCostProductType and p.DealId is not null and p.StartDate is not null and p.EndDate is not null and ConsumeAmount = 0
-- insert into @Result select 34, @Name, @Physical, @OTC, @VoyageCharter, @TransCost

-- Set @Name = '> Consume Amount < 0'
-- select @Physical = count(1) from kRisCreditPreparationDeal p inner join @PhysicalProductType d on p.CK_SyPTy = d.id where p.DealId is not null and p.StartDate is not null and p.EndDate is not null and ConsumeAmount < 0
-- --select @OTC = count(1) from kRisCreditPreparationDeal p inner join @OTCProductType d on p.CK_SyPTy = d.id where p.DealId is not null and p.StartDate is not null and p.EndDate is not null and ConsumeAmount < 0
-- select @OTC = 0
-- select @VoyageCharter = count(1) from kRisCreditPreparationDeal p where p.CK_SyPTy = @VoyageCharterProductType and p.DealId is not null and p.StartDate is not null and p.EndDate is not null and ConsumeAmount < 0
-- select @TransCost = count(1) from kRisCreditPreparationDeal p where p.CK_SyPTy = @TransCostProductType and p.DealId is not null and p.StartDate is not null and p.EndDate is not null and ConsumeAmount < 0
-- insert into @Result select 35, @Name, @Physical, @OTC, @VoyageCharter, @TransCost

-- Set @Name = '> CR Flag = 0'
-- select @Physical = count(1) from kRisCreditPreparationDeal p inner join @PhysicalProductType d on p.CK_SyPTy = d.id where p.DealId is not null and p.StartDate is not null and p.EndDate is not null and ConsumeAmount > 0 and p.CRFlag = 0
-- select @OTC = count(1) from kRisCreditPreparationDeal p inner join @OTCProductType d on p.CK_SyPTy = d.id where p.DealId is not null and p.StartDate is not null and p.EndDate is not null and ConsumeAmount <> 0 and p.CRFlag = 0
-- select @VoyageCharter = count(1) from kRisCreditPreparationDeal p where p.CK_SyPTy = @VoyageCharterProductType and p.DealId is not null and p.StartDate is not null and p.EndDate is not null and ConsumeAmount > 0 and p.CRFlag = 0
-- select @TransCost = count(1) from kRisCreditPreparationDeal p where p.CK_SyPTy = @TransCostProductType and p.DealId is not null and p.StartDate is not null and p.EndDate is not null and ConsumeAmount > 0 and p.CRFlag = 0
-- insert into @Result select 36, @Name, @Physical, @OTC, @VoyageCharter, @TransCost

-- Set @Name = '> Internal Party'
-- select @Physical = count(1) from kRisCreditPreparationDeal p inner join @PhysicalProductType d on p.CK_SyPTy = d.id where p.DealId is not null and p.StartDate is not null and p.EndDate is not null and ConsumeAmount > 0 and p.CRFlag = 1 and p.FK_StPCa_CP <> 2
-- --select @OTC = count(1) from kRisCreditPreparationDeal p inner join @OTCProductType d on p.CK_SyPTy = d.id where p.DealId is not null and p.StartDate is not null and p.EndDate is not null and ConsumeAmount > 0 and p.CRFlag = 1 and p.FK_StPCa_CP <> 2
-- select @OTC = count(1) from kRisCreditPreparationDeal p inner join @OTCProductType d on p.CK_SyPTy = d.id where p.DealId is not null and p.StartDate is not null and p.EndDate is not null and ConsumeAmount <> 0 and p.CRFlag = 1 and p.FK_StPCa_CP <> 2
-- select @VoyageCharter = count(1) from kRisCreditPreparationDeal p where p.CK_SyPTy = @VoyageCharterProductType and p.DealId is not null and p.StartDate is not null and p.EndDate is not null and ConsumeAmount > 0 and p.CRFlag = 1 and p.FK_StPCa_CP <> 2
-- select @TransCost = count(1) from kRisCreditPreparationDeal p where p.CK_SyPTy = @TransCostProductType and p.DealId is not null and p.StartDate is not null and p.EndDate is not null and ConsumeAmount > 0 and p.CRFlag = 1 and p.FK_StPCa_CP <> 2
-- insert into @Result select 37, @Name, @Physical, @OTC, @VoyageCharter, @TransCost

-- -- Result
-- select Name, Physical, OTC, VoyageCharter, TransCost from @Result order by id FOR JSON PATH;


Declare @Result Table (id int,
    Name varchar(50),
    Physical int,
    OTC int,
    VoyageCharter int,
    TransCost int)
Declare @Name varchar(50), @Physical int, @OTC int, @VoyageCharter int, @TransCost int

-- Product Type
Declare @PhysicalProductType Table (id int)
insert into @PhysicalProductType
SELECT A.PK_SyPTy
FROM dbo.SysProductTypes A INNER JOIN dbo.kSysCreditProductType B ON B.PK_SyCPTy = A.FK_K_SyCPTy
WHERE B.PK_SyCPTy = 1
Declare @OTCProductType Table (id int)
insert into @OTCProductType
SELECT A.PK_SyPTy
FROM dbo.SysProductTypes A INNER JOIN dbo.kSysCreditProductType B ON B.PK_SyCPTy = A.FK_K_SyCPTy
WHERE B.PK_SyCPTy = 2
Declare @VoyageCharterProductType INT = (SELECT TOP 1
    A.PK_SyPTy
FROM dbo.SysProductTypes A INNER JOIN dbo.kSysCreditProductType B ON B.PK_SyCPTy = A.FK_K_SyCPTy
WHERE B.PK_SyCPTy = 3)
Declare @TransCostProductType int = (SELECT dbo.SF_SysVarInt('ProductTypeTransCost'))


Set @Name = 'Total Deals'
select @Physical = count(1)
from DeaPhysical
select @OTC = count(1)
from DeaOtc
select @VoyageCharter = count(1)
from kDeaVoyageCharter
select @TransCost = count(1)
from DeaStructureCost
insert into @Result
select 0, @Name, @Physical, @OTC, @VoyageCharter, @TransCost

Set @Name = 'Deal Deleted'
Declare @DeleteStatus int = CAST(dbo.SF_SysVarInt('DeletedDealStatus') AS INT)
select @Physical = count(1)
from DeaPhysical
where FK_SyDSt = @DeleteStatus
select @OTC = count(1)
from DeaOtc
where FK_SyDSt = @DeleteStatus
select @VoyageCharter = count(1)
from kDeaVoyageCharter
where FK_SyDSt = @DeleteStatus
select @TransCost = count(1)
from DeaStructureCost
where FK_SyDSt = @DeleteStatus
insert into @Result
select 0, @Name, @Physical, @OTC, @VoyageCharter, @TransCost

Set @Name = 'Total'
select @Physical = count(1)
from kRisCreditPreparationDeal p inner join @PhysicalProductType d on p.CK_SyPTy = d.id
select @OTC = count(1)
from kRisCreditPreparationDeal p inner join @OTCProductType d on p.CK_SyPTy = d.id
select @VoyageCharter = count(1)
from kRisCreditPreparationDeal p
where p.CK_SyPTy = @VoyageCharterProductType
select @TransCost = count(1)
from kRisCreditPreparationDeal p
where p.CK_SyPTy = @TransCostProductType
insert into @Result
select 1, @Name, @Physical, @OTC, @VoyageCharter, @TransCost

Set @Name = 'Calc Credit'
select @Physical = count(1)
from kRisCreditPreparationDeal p inner join @PhysicalProductType d on p.CK_SyPTy = d.id
where p.CalculateFlag = 1
select @OTC = count(1)
from kRisCreditPreparationDeal p inner join @OTCProductType d on p.CK_SyPTy = d.id
where p.CalculateFlag = 1
select @VoyageCharter = count(1)
from kRisCreditPreparationDeal p
where p.CK_SyPTy = @VoyageCharterProductType and p.CalculateFlag = 1
select @TransCost = count(1)
from kRisCreditPreparationDeal p
where p.CK_SyPTy = @TransCostProductType and p.CalculateFlag = 1
insert into @Result
select 2, @Name, @Physical, @OTC, @VoyageCharter, @TransCost

Set @Name = 'Not Calc Credit'
select @Physical = count(1)
from kRisCreditPreparationDeal p inner join @PhysicalProductType d on p.CK_SyPTy = d.id
where p.CalculateFlag = 0
select @OTC = count(1)
from kRisCreditPreparationDeal p inner join @OTCProductType d on p.CK_SyPTy = d.id
where p.CalculateFlag = 0
select @VoyageCharter = count(1)
from kRisCreditPreparationDeal p
where p.CK_SyPTy = @VoyageCharterProductType and p.CalculateFlag = 0
select @TransCost = count(1)
from kRisCreditPreparationDeal p
where p.CK_SyPTy = @TransCostProductType and p.CalculateFlag = 0
insert into @Result
select 3, @Name, @Physical, @OTC, @VoyageCharter, @TransCost

Set @Name = '> DealId IS NULL'
select @Physical = count(1)
from kRisCreditPreparationDeal p inner join @PhysicalProductType d on p.CK_SyPTy = d.id
where p.DealId is null
select @OTC = count(1)
from kRisCreditPreparationDeal p inner join @OTCProductType d on p.CK_SyPTy = d.id
where p.DealId is null
select @VoyageCharter = count(1)
from kRisCreditPreparationDeal p
where p.CK_SyPTy = @VoyageCharterProductType and p.DealId is null
select @TransCost = count(1)
from kRisCreditPreparationDeal p
where p.CK_SyPTy = @TransCostProductType and p.DealId is null
insert into @Result
select 31, @Name, @Physical, @OTC, @VoyageCharter, @TransCost

Set @Name = '> StartDate IS NULL'
select @Physical = count(1)
from kRisCreditPreparationDeal p inner join @PhysicalProductType d on p.CK_SyPTy = d.id
where p.DealId is not null and p.StartDate is null
select @OTC = count(1)
from kRisCreditPreparationDeal p inner join @OTCProductType d on p.CK_SyPTy = d.id
where p.DealId is not null and p.StartDate is null
select @VoyageCharter = count(1)
from kRisCreditPreparationDeal p
where p.CK_SyPTy = @VoyageCharterProductType and p.DealId is not null and p.StartDate is null
select @TransCost = count(1)
from kRisCreditPreparationDeal p
where p.CK_SyPTy = @TransCostProductType and p.DealId is not null and p.StartDate is null
insert into @Result
select 32, @Name, @Physical, @OTC, @VoyageCharter, @TransCost

Set @Name = '> EndDate IS NULL'
select @Physical = count(1)
from kRisCreditPreparationDeal p inner join @PhysicalProductType d on p.CK_SyPTy = d.id
where p.DealId is not null and p.StartDate is not null and p.EndDate is null
select @OTC = count(1)
from kRisCreditPreparationDeal p inner join @OTCProductType d on p.CK_SyPTy = d.id
where p.DealId is not null and p.StartDate is not null and p.EndDate is null
select @VoyageCharter = count(1)
from kRisCreditPreparationDeal p
where p.CK_SyPTy = @VoyageCharterProductType and p.DealId is not null and p.StartDate is not null and p.EndDate is null
select @TransCost = count(1)
from kRisCreditPreparationDeal p
where p.CK_SyPTy = @TransCostProductType and p.DealId is not null and p.StartDate is not null and p.EndDate is null
insert into @Result
select 33, @Name, @Physical, @OTC, @VoyageCharter, @TransCost

Set @Name = '> Consume Amount = 0'
select @Physical = count(1)
from kRisCreditPreparationDeal p inner join @PhysicalProductType d on p.CK_SyPTy = d.id
where p.DealId is not null and p.StartDate is not null and p.EndDate is not null and ConsumeAmount = 0
select @OTC = count(1)
from kRisCreditPreparationDeal p inner join @OTCProductType d on p.CK_SyPTy = d.id
where p.DealId is not null and p.StartDate is not null and p.EndDate is not null and ConsumeAmount = 0

select @VoyageCharter = count(1)
from kRisCreditPreparationDeal p
where p.CK_SyPTy = @VoyageCharterProductType and p.DealId is not null and p.StartDate is not null and p.EndDate is not null and ConsumeAmount = 0
select @TransCost = count(1)
from kRisCreditPreparationDeal p
where p.CK_SyPTy = @TransCostProductType and p.DealId is not null and p.StartDate is not null and p.EndDate is not null and ConsumeAmount = 0
insert into @Result
select 34, @Name, @Physical, @OTC, @VoyageCharter, @TransCost

Set @Name = '> Consume Amount < 0'
select @Physical = count(1)
from kRisCreditPreparationDeal p inner join @PhysicalProductType d on p.CK_SyPTy = d.id
where p.DealId is not null and p.StartDate is not null and p.EndDate is not null and ConsumeAmount < 0
--select @OTC = count(1) from kRisCreditPreparationDeal p inner join @OTCProductType d on p.CK_SyPTy = d.id where p.DealId is not null and p.StartDate is not null and p.EndDate is not null and ConsumeAmount < 0
select @OTC = 0
select @VoyageCharter = count(1)
from kRisCreditPreparationDeal p
where p.CK_SyPTy = @VoyageCharterProductType and p.DealId is not null and p.StartDate is not null and p.EndDate is not null and ConsumeAmount < 0
select @TransCost = count(1)
from kRisCreditPreparationDeal p
where p.CK_SyPTy = @TransCostProductType and p.DealId is not null and p.StartDate is not null and p.EndDate is not null and ConsumeAmount < 0
insert into @Result
select 35, @Name, @Physical, @OTC, @VoyageCharter, @TransCost

Set @Name = '> CR Flag = 0'
select @Physical = count(1)
from kRisCreditPreparationDeal p inner join @PhysicalProductType d on p.CK_SyPTy = d.id
where p.DealId is not null and p.StartDate is not null and p.EndDate is not null and ConsumeAmount > 0 and p.CRFlag = 0
select @OTC = count(1)
from kRisCreditPreparationDeal p inner join @OTCProductType d on p.CK_SyPTy = d.id
where p.DealId is not null and p.StartDate is not null and p.EndDate is not null and ConsumeAmount <> 0 and p.CRFlag = 0
select @VoyageCharter = count(1)
from kRisCreditPreparationDeal p
where p.CK_SyPTy = @VoyageCharterProductType and p.DealId is not null and p.StartDate is not null and p.EndDate is not null and ConsumeAmount > 0 and p.CRFlag = 0
select @TransCost = count(1)
from kRisCreditPreparationDeal p
where p.CK_SyPTy = @TransCostProductType and p.DealId is not null and p.StartDate is not null and p.EndDate is not null and ConsumeAmount > 0 and p.CRFlag = 0
insert into @Result
select 36, @Name, @Physical, @OTC, @VoyageCharter, @TransCost

Set @Name = '> Internal Party'
select @Physical = count(1)
from kRisCreditPreparationDeal p inner join @PhysicalProductType d on p.CK_SyPTy = d.id
where p.DealId is not null and p.StartDate is not null and p.EndDate is not null and ConsumeAmount > 0 and p.CRFlag = 1 and p.FK_StPCa_CP <> 2
--select @OTC = count(1) from kRisCreditPreparationDeal p inner join @OTCProductType d on p.CK_SyPTy = d.id where p.DealId is not null and p.StartDate is not null and p.EndDate is not null and ConsumeAmount > 0 and p.CRFlag = 1 and p.FK_StPCa_CP <> 2
select @OTC = count(1)
from kRisCreditPreparationDeal p inner join @OTCProductType d on p.CK_SyPTy = d.id
where p.DealId is not null and p.StartDate is not null and p.EndDate is not null and ConsumeAmount <> 0 and p.CRFlag = 1 and p.FK_StPCa_CP <> 2
select @VoyageCharter = count(1)
from kRisCreditPreparationDeal p
where p.CK_SyPTy = @VoyageCharterProductType and p.DealId is not null and p.StartDate is not null and p.EndDate is not null and ConsumeAmount > 0 and p.CRFlag = 1 and p.FK_StPCa_CP <> 2
select @TransCost = count(1)
from kRisCreditPreparationDeal p
where p.CK_SyPTy = @TransCostProductType and p.DealId is not null and p.StartDate is not null and p.EndDate is not null and ConsumeAmount > 0 and p.CRFlag = 1 and p.FK_StPCa_CP <> 2
insert into @Result
select 37, @Name, @Physical, @OTC, @VoyageCharter, @TransCost

-- Result
Declare @XML   xml = (select Name, Physical, OTC, VoyageCharter, TransCost
from @Result
order by id
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
