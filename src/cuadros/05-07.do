* Macros auxiliares y objetos temporales
local id "05-07"

* Especificación
.table = .ol_table.new
.table.rowvar = "_oficio1"
.table.colvar = "_rama1_v1 año"

* Exportación
foreach i of numlist $sectores {
	* BBDD
	use "$proyecto/data/consultas/`id'.dta", clear
	keep if inlist(_rama1_v1, `i', .z)

  * Archivo de destino
	local name : label _rama1_v1 `i'
	label define _rama1_v1 `i' "Sector", modify
  local file "$proyecto/data/cuadros/`name'/bh.xlsx"

  * Título del cuadro
  .table.title =  ///
    "5.7. Distribución de ocupados del sector `name' " +  ///
    "por tipo de ocupación, 2010 y 2016"

	* Exportación
	.table.export_excel bh, file("`file'") sheet("`id'")
}
