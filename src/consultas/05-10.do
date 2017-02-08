* Macros auxiliares
local id "05-10"

* Especificación
.table = .ol_table.new
.table.cmds       = "{total _counter} {proportion _cise_v3}"
.table.cmds_lb    = "{N} {%}"
.table.years      = "2016"
.table.months     = "2 5 8 11"
.table.subpops    = "."
.table.subpops_lb = "{Ocupados}"
.table.by         = "_cise_v3"
.table.along      = "_rama1_v1 _oficio1"
.table.aggregate  = "{_cise_v3} {_oficio1} {_cise_v3 _oficio1}"
.table.src        = "ene"
.table.from       = "$datos"
.table.varlist0   = "_cise_v3 _ocupado _oficio1 _rama1_v1"

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

* Estructura
.table.rowvar    = "_oficio1"
.table.colvar    = "_cise_v3"

* Exportación
keep if inlist(_rama1_v1, $sector)
.table.export_excel bh, file("$proyecto/data/tabla 05-10.xlsx")
.table.export_excel cv, file("$proyecto/data/tabla 05-10.xlsx")



*/
