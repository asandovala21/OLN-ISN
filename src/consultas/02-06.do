* Macros auxiliares
local id   "02-06"
local temp "_tamaño_empresa_v1"

* Especificación
.table = .ol_table.new
.table.cmds       = "{total _counter}"
.table.cmds_lb    = "{N}"
.table.years      = "2016"
.table.months     = "2 5 8 11"
.table.subpops    = "."
.table.subpops_lb = "{Ocupados}"
.table.by         = "_cise_v3"
.table.along      = "_rama1_v1 `temp'"
.table.aggregate  = "{`temp'} {_cise_v3} {`temp' _cise_v3}"
.table.src        = "ene"
.table.from       = "$datos"
.table.varlist0   = "_cise_v3 _ocupado _rama1_v1 `temp'"

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
