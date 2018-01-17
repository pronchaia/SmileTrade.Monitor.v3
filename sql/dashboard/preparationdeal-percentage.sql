
-- declare @cnt_preparation int = 0;
-- declare @cnt_deal int =0;
-- select @cnt_preparation = count(*)
-- from kRisCreditPreparationDeal

-- select @cnt_deal = sum(A.cnt)
-- from (
--                                                                                 select count(*) as cnt
--         from DeaPhysical
--     union
--         select count(*) as cnt
--         from DeaOtc
--     union
--         select count(*) as cnt
--         from kDeaVoyageCharter
--     union
--         select count(*) as cnt
--         from DeaStructureCost
-- ) A


-- select @cnt_preparation as [preparation], @cnt_deal as [deal]
-- , (isnull(@cnt_preparation,1) *100/isnull(@cnt_deal,1)) as deal_percentage
-- , FORMAT
-- (@cnt_preparation,'N', 'en-us') AS 'cnt_preparation_format'
-- FOR JSON PATH;


declare @cnt_preparation int = 0;
declare @cnt_deal int =0;
select @cnt_preparation = count(*)
from kRisCreditPreparationDeal

select @cnt_deal = sum(A.cnt)
from (
                                                                                                                select count(*) as cnt
        from DeaPhysical
    union
        select count(*) as cnt
        from DeaOtc
    union
        select count(*) as cnt
        from kDeaVoyageCharter
    union
        select count(*) as cnt
        from DeaStructureCost
) A





-- Result
Declare @XML   xml = (select @cnt_preparation as [preparation], @cnt_deal as [deal]
, (isnull(@cnt_preparation,1) *100/isnull(@cnt_deal,1)) as deal_percentage
, FORMAT
(@cnt_preparation,'N', 'en-us') AS 'cnt_preparation_format'
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
