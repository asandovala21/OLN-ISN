* Macros auxiliares
local id "05-09"

* Especificación
.table = .ol_table.new
.table.cmds       = "{proportion _educ}"
.table.cmds_lb    = "{%}"
.table.years      = "2016"
.table.months     = "2 5 8 11"
.table.subpops    = "."
.table.subpops_lb = "{Ocupados}"
.table.by         = "_educ"
.table.along      = "_rama1_v1 _oficio1"
.table.aggregate  = "{_educ} {_oficio1} {_educ _oficio1}"
.table.src        = "ene"
.table.from       = "$datos"
.table.varlist0   = "_educ _ocupado _oficio1 _rama1_v1"

* Estimación
drop _all
tempfile df
save `df', emptyok
forvalues i = 1(1)13 {
  .table.subpops = "{if (_ocupado == 1) & (_rama1_v1 == `i')}"
  .table.create
  append using `df'
  save `df', replace
}
save "$proyecto/data/consultas/`id'.dta", replace













/*

.table.rowvar    = "_oficio1"
.table.colvar    = "_educ"





* Estimación
drop _all
tempfile df
save `df', emptyok
forvalues i = 1(1)13 {
    * Especificación (act)
    .table.subpops = "{if (_ocupado == 1) & (_rama1_v1 == `i')}"
    * Estimación
    .table.create
    .table.annualize
    * Anexión
    append using `df'
    save `df', replace
}
save "$proyecto/data/tabla 05-09.dta", replace

* Exportación
keep if inlist(_rama1_v1, $sector)
.table.export_excel bh, file("$proyecto/data/tabla 05-09.xlsx")
.table.export_excel cv, file("$proyecto/data/tabla 05-09.xlsx")
*/