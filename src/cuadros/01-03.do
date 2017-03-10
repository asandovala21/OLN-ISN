* Macros auxiliares y objetos temporales
local id "01-03"

* Especificación
.table = .ol_table.new
.table.rowvar = "año mes"
.table.colvar = "_rama1_v1"

* Exportación
foreach i of numlist $sectores {
	* BBDD
	use "$proyecto/data/consultas/`id'", clear
	keep if inlist(_rama1_v1, `i', .z)

	* Archivo de destino
	local name : label _rama1_v1 `i'
	local file "$proyecto/data/cuadros/`name'/bh.xlsx"
	label define _rama1_v1 `i' "Sector", modify

	* Título del cuadro
	.table.title =  ///
		"1.3. Tasa de cesantía nacional y tasa de cesantía del sector " +  ///
		"`name', 2010-2016"

	* Exportación
	.table.export_excel bh, file("`file'") sheet("`id'")
}
