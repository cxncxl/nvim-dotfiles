vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
    callback = function ()
        vim.opt.langmap = "ФA,ИB,СC,ВD,УE,АF,ПG,РH,ШI,ОJ,ЛK,ДL,ЬM,ЩO,ЗP,ЙQ,КE,ІS,ЕT,ГU,МV,ЦW,ЧX,НY,ЯZ,фa,иb,сc,вd,уe,аf,пg,рh,шi,оj,лk,дl,ьm,щo,зp,йq,кe,іs,еt,гu,мv,цw,чx,нy,яz"
    end
})
