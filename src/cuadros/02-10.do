/* * Macros auxiliares y objetos temporales
local id "02-10"

* Especificación
.table = .ol_table.new
.table.rowvar = "_educ"
.table.colvar = "temp"

* Exportación
foreach i in $sectores {
	* BBDD
	use "$proyecto/data/consultas/`id'.dta", clear
	keep if inlist(_rama1_v1, `i')
  rename _tamaño_empresa temp

  * Archivo de destino
	local name : label _rama1_v1 `i'
	label define _rama1_v1 `i' "Sector", modify
  local file "$proyecto/data/cuadros/`name'/bh.xlsx"

  * Título del cuadro
  local title = ///
    "2.10. Brechas de ingreso de género para trabajadores dependientes " + ///
    "del sector, según nivel educacional y tamaño de empresa, 2015."

	* Exportación
	.table.export_excel bh, file("`file'") sheet("`id'")
	putexcel set "`file'", sheet("`id'") modify
	putexcel A1 = "`title'", font("Times New Roman", 11) bold
} */