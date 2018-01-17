SELECT TOP 200
    PK_SyTr , cast(Req as varchar(128)) Req, cast(HIN as varchar(128)) HIN, cast(HID as int) HID, cast(UID as int) UID,
    cast(Tst as DATETIME) Tst, cast(Par as varchar(550)) Par, B.LoginName
FROM dbo.SysTracer A
    INNER JOIN dbo.SysUser B ON  cast(UID as int) = B.PK_SyUs
WHERE cast(Req as varchar(128)) like '%CAL_kCredit_Main%'
    AND B.LoginName='SYS.BACKGROUNDJOB'
ORDER BY cast(Tst as DATETIME) DESC
FOR JSON PATH;