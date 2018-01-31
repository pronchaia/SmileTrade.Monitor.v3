-- declare @dealid varchar(100);

-- set @dealid='CRD.2017.12.00006';

DECLARE @TempTable TABLE (DealId VARCHAR(100),
    ConsumeDate VARCHAR(150),
    CalculationGroup int,
    CalculationGroupText VARCHAR(255),
    Amount decimal(25,9));

with
    cte
    as
    (
        select deal.dealid, consumption.CalculationGroup, consumption.Amount, consumption.CK_De, consumption.CK_SyPTy
        from kRisCreditPreparationDeal deal
            left join kRisCreditDealConsumption consumption on deal.ck_de = consumption.ck_de and deal.ck_sypty=consumption.ck_sypty
        where deal.dealid=@dealid
        group by deal.dealid,consumption.CalculationGroup,consumption.Amount,consumption.CK_De,consumption.CK_SyPTy
    )

INSERT INTO @TempTable
select cte.DealId, FORMAT(consumption.ConsumeDate, N'dd/MM/yyyy') as ConsumeDate, cte.CalculationGroup
, case cte.CalculationGroup when 1 then 'Deal Credit Risk' when 2 then 'Paper Netting'  when 3 then 'Link (Offset)' 
when 4 then 'Counter Party Limit'  when 5 then 'Parent/Group' when 6 then 'Security' else '' end As 'CalculationGroupText'
, cte.Amount

from cte 
outer apply(
    select top 1
        MIN(ConsumeDate) as ConsumeDate
    from kRisCreditDealConsumption consumption
    where cte.CK_SyPTy=consumption.CK_SyPTy
        and cte.CalculationGroup=consumption.CalculationGroup and cte.Amount=consumption.Amount
    order by ConsumeDate
)  consumption;

declare @XML   xml = (select NEWID() as ID, CalculationGroup, CalculationGroupText, DealId, ConsumeDate, Amount
from @TempTable
order by CalculationGroup desc
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
