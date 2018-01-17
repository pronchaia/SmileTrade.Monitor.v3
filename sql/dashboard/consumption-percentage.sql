-- declare @group1 as numeric(25,9) = 0;
-- declare @group2 as numeric(25,9) = 0;
-- declare @group4 as numeric(25,9) = 0;
-- declare @group5 as numeric(25,9) = 0;
-- declare @group6 as numeric(25,9) = 0;

-- select @group1 = SUM(Amount)
-- from kRisCreditDealConsumption
-- where CAST(ConsumeDate as Date) =CAST(Getdate() as Date)
--     and CalculationGroup=1 and ReferenceId=0

-- select @group2 = SUM(Amount)
-- from kRisCreditDealConsumption
-- where CAST(ConsumeDate as Date) =CAST(Getdate() as Date)
--     and CalculationGroup=2

-- select @group4 = SUM(Amount)
-- from kRisCreditDealConsumption
-- where CAST(ConsumeDate as Date) =CAST(Getdate() as Date)
--     and CalculationGroup=4 and ReferenceId=0

-- select @group5 = SUM(Amount)
-- from kRisCreditDealConsumption
-- where CAST(ConsumeDate as Date) =CAST(Getdate() as Date)
--     and CalculationGroup=5 and ReferenceId=-1

-- select @group6= SUM(Amount)
-- from kRisCreditDealConsumption
-- where CAST(ConsumeDate as Date) =CAST(Getdate() as Date)
--     and CalculationGroup=6 and ReferenceId >0


-- select (@group2+@group4+@group5+@group6) as [consume], @group1 as [total]
-- , ((@group2+@group4+@group5+@group6) * 100)/@group1 as [percentage]
-- , FORMAT
-- ((@group2+@group4+@group5+@group6),'N', 'en-us') AS 'consumeformat'
-- FOR JSON PATH;

declare @group1 as numeric(25,9) = 0;
declare @group2 as numeric(25,9) = 0;
declare @group4 as numeric(25,9) = 0;
declare @group5 as numeric(25,9) = 0;
declare @group6 as numeric(25,9) = 0;

select @group1 = SUM(Amount)
from kRisCreditDealConsumption
where CAST(ConsumeDate as Date) =CAST(Getdate() as Date)
    and CalculationGroup=1 and ReferenceId=0

select @group2 = SUM(Amount)
from kRisCreditDealConsumption
where CAST(ConsumeDate as Date) =CAST(Getdate() as Date)
    and CalculationGroup=2

select @group4 = SUM(Amount)
from kRisCreditDealConsumption
where CAST(ConsumeDate as Date) =CAST(Getdate() as Date)
    and CalculationGroup=4 and ReferenceId=0

select @group5 = SUM(Amount)
from kRisCreditDealConsumption
where CAST(ConsumeDate as Date) =CAST(Getdate() as Date)
    and CalculationGroup=5 and ReferenceId=-1

select @group6= SUM(Amount)
from kRisCreditDealConsumption
where CAST(ConsumeDate as Date) =CAST(Getdate() as Date)
    and CalculationGroup=6 and ReferenceId >0





-- Result
Declare @XML   xml = (select (@group2+@group4+@group5+@group6) as [consume], @group1 as [total]
, ((@group2+@group4+@group5+@group6) * 100)/@group1 as [percentage]
, FORMAT
((@group2+@group4+@group5+@group6),'N', 'en-us') AS 'consumeformat'
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
