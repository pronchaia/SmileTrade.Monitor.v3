declare @cnt int = 0;
declare @cntall int =0;

select @cnt = sum(A.cnt)
from (
	select count(*) as cnt
        from DeaPhysical where CAST(DealDate as Date) =  CAST(getdate() as Date)
    union
        select count(*) as cnt
        from DeaOtc where CAST(DealDate as Date) =  CAST(getdate() as Date)
    union
        select count(*) as cnt
        from kDeaVoyageCharter where CAST(DealDate as Date) =  CAST(getdate() as Date)
    union
        select count(*) as cnt
        from DeaStructureCost where CAST(DealDate as Date) =  CAST(getdate() as Date)
) A


select @cntall = sum(A.cnt)
from (
	select count(*) as cnt
        from DeaPhysical where DATEADD(MONTH, DATEDIFF(MONTH, 0,  DealDate), 0) = DATEADD(MONTH, DATEDIFF(MONTH, 0, getdate()), 0) 
    union
        select count(*) as cnt
        from DeaOtc where DATEADD(MONTH, DATEDIFF(MONTH, 0,  DealDate), 0) = DATEADD(MONTH, DATEDIFF(MONTH, 0, getdate()), 0) 
    union
        select count(*) as cnt
        from kDeaVoyageCharter where DATEADD(MONTH, DATEDIFF(MONTH, 0,  DealDate), 0) = DATEADD(MONTH, DATEDIFF(MONTH, 0, getdate()), 0) 
    union
        select count(*) as cnt
        from DeaStructureCost where DATEADD(MONTH, DATEDIFF(MONTH, 0,  DealDate), 0) = DATEADD(MONTH, DATEDIFF(MONTH, 0, getdate()), 0) 
) A

Declare @XML   xml = (
select @cnt as [cnt], @cntall as [cntall]
, case when @cntall =0 then 0 else (isnull(@cnt,1) *100/isnull(@cntall,1)) end as percentage

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
