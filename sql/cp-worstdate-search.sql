--declare @longname varchar(200) = N'SENTEK MARINE & TRADING PTE LTD';
--declare	@lStartDate										DATE	= '2017-06-01 00:00:00';
--declare @lEndDate										DATE	= '2017-12-31 00:00:00';


declare @PK_StPa int;
declare @lPK_StPa										T_PK_StaParty;
declare	@lFK_StPa_P										T_PK_StaParty;
select @PK_StPa = PK_StPa
from StaParty
where Longname = @longname;

INSERT INTO @lPK_StPa
SELECT *
FROM StaParty
where PK_StPa =  @PK_StPa;



declare @kRisCreditDealConsumption						T_PK_kRisCreditDealConsumption;
declare @pkRisCreditPreparationDeal						T_PK_kRisCreditPreparationDeal;
declare @kRisCreditPreparationDate						T_PK_kRisCreditPreparationDate;
declare @lStaParty										T_PK_StaParty;


WITH
    cte
    AS
    (
                    SELECT a.*
            FROM StaParty  a
            WHERE exists (select 1
            from @lPK_StPa p
            where ISNULL(p.FK_K_StPa_P,p.PK_StPa)=a.PK_StPa)
        UNION ALL
            SELECT a.*
            FROM StaParty a JOIN cte c ON a.FK_K_StPa_P = c.PK_StPa
    )
INSERT INTO @lStaParty
SELECT *
FROM cte;


INSERT INTO @pkRisCreditPreparationDeal
SELECT DISTINCT CrePreDea.*
FROM kRisCreditPreparationDeal CrePreDea
    INNER JOIN @lStaParty StPa ON StPa.PK_StPa = CrePreDea.FK_StPa_CP
WHERE ISNULL(CrePreDea.CRFlag, 0) > 0
    AND (
			 EXISTS (SELECT 1
    FROM kRisCreditPreparationDate cpd
    WHERE CrePreDea.CK_De=cpd.CK_De AND CrePreDea.CK_SyPTy=cpd.CK_SyPTy
        AND cpd.ConsumeDate BETWEEN @lStartDate AND @lEndDate)
    OR (CrePreDea.StartDate <= @lEndDate AND CrePreDea.EndDate >= @lStartDate)
			)
;

INSERT INTO @kRisCreditPreparationDate
SELECT CrePreDat.*
FROM kRisCreditPreparationDate CrePreDat
    INNER JOIN kRisCreditPreparationDeal CrePreDea
    ON CrePreDea.CK_De = CrePreDat.CK_De
        AND CrePreDea.CK_SyPTy = CrePreDat.CK_SyPTy
WHERE CrePreDat.ConsumeDate BETWEEN @lStartDate AND @lEndDate

SELECT SF.PK_StPa, SP.LongName, SF.ConsumeDate
FROM dbo.SF_kCredit_GetWorstDate(@kRisCreditDealConsumption, @pkRisCreditPreparationDeal, @kRisCreditPreparationDate, @lStaParty, @lStartDate, @lEndDate) SF
    inner join StaParty SP ON SF.PK_StPa=SP.PK_StPa