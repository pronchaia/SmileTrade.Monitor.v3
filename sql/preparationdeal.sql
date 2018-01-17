SELECT CK_SyPTy, CK_De, FK_SyCPTy, DealId, CounterpartyName 
, ConsumeStartDate, ConsumeEndDate, ConsumeAmount, PaidAmount, PaidAmountChange
FROM kRisCreditPreparationDeal
WHERE FK_K_SyCSt
IS NOT NULL
ORDER BY ConsumeStartDate
FOR JSON PATH;