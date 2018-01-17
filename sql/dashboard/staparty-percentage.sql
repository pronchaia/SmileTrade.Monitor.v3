declare @cnt int = 0;
declare @cnt_all int =0;

select @cnt=count(*) from StaPartyA where oK_SyncFromSAP = 1 and  AType=1 and cast(ATime as Date) = cast(getdate() as date);
select @cnt_all=count(*) from StaPartyA where oK_SyncFromSAP = 1 and  AType=1;

Declare @XML   xml = (
select @cnt as 'cnt',@cnt_all as 'cntall', case when @cnt_all =0 then 0 else (isnull(@cnt,0)* 100)/isnull(@cnt_all,0) end as 'percentage'
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
