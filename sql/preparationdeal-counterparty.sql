SELECT CounterpartyName, COUNT(*) AS Cnt
FROM kRisCreditPreparationDeal
WHERE CounterpartyName IS NOT NULL
GROUP BY CounterpartyName
ORDER BY COUNT(*) DESC
FOR JSON PATH;