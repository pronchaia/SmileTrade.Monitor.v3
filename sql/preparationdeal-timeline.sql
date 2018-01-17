DECLARE @date DATE = DATEADD(day,-8,getdate());
;WITH
    N(N)
    AS
    (
        SELECT 1
        FROM(VALUES(1),
                (1),
                (1),
                (1),
                (1),
                (1))M(N)
    ),
    tally(N)
    AS

    (
        SELECT ROW_NUMBER()OVER(ORDER BY N.N)
        FROM N, N a
    )
--SELECT top(day(EOMONTH(@date)))
SELECT top 12
    N Day, dateadd(d,N-1, @date) as ConsumeStartDate, ISNULL(deal.cnt,0) as Cnt
FROM tally
    left join (
SELECT ConsumeStartDate, count(*) as cnt
    FROM kRisCreditPreparationDeal
    WHERE FK_K_SyCSt IS NOT NULL AND ConsumeStartDate >= CAST(@date AS DATE)
    GROUP BY ConsumeStartDate 
) deal on deal.ConsumeStartDate=dateadd(d,N-1, @date)

FOR JSON PATH;