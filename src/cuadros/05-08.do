* Macros auxiliares
local id "05-08"
local origen  "$proyecto/data/consultas"
local destino "$proyecto/data/cuadros"
local bylist  `""" "" "" "_mujer" "_capacitado""'

* Especificación de cuadro
.table = .ol_table.new
.table.rowvar = "_oficio1"
.table.colvar = "cmd_lb"

* Preparación de la BBDD
tempfile df1 df2
forvalues j = 1(1)2 {
	drop _all
	save `df`j'', emptyok
	forvalues k = 1(1)5 {
		* Ajustes preliminares
		use "`origen'/`id' [`k'].dta", clear
		drop if (cmd_type == "proportion")
		
		* Agregación y creación de proporciones (hay dos métodos)
		local by : word `k' of `bylist'
		.table.annualize_v`j', over("_rama1_v1 _oficio1 `by'")
		if inlist(`k', 4, 5) {
			.table.as_proportion, by(" `by'") along("_rama1_v1 _oficio1")
			keep if (`by' == 1)
			drop `by'
		}
		
		* Anexión
		replace cmd_lb = `k' 
		append using `df`j''
		save `df`j'', replace
	}
	* Etiquetado
	label values cmd_lb cmd_lb
	label define cmd_lb 1 "Edad promedio", modify
	label define cmd_lb 2 "Escolaridad promedio", modify
	label define cmd_lb 3 "Ingreso promedio ocupación principal", modify
	label define cmd_lb 4 "Mujeres (%)", modify
	label define cmd_lb 5 "Capacitados (%)", modify
	
	* Guardado
	save `df`j'', replace
}

* Exportación del cuadro
forvalues i = 1(1)1 {
	forvalues j = 1(1)1 {
		* BBDD
		use `df`j'', clear
		keep if inlist(_rama1_v1, `i')

		* Identificación del nombre del sector
		local name : label _rama1_v1 `i'
		label define _rama1_v1 `i' "Sector", modify

		* Exportación (cuerpo)
		local file "`destino'/`name'/bh [`j'].xlsx"
		.table.export_excel bh, file("`file'") sheet("`id'")
		*.table.export_excel cv, file("`file'") sheet("`id'")

		* Título
		local msg = "5.8. Características generales de los ocupados del sector `name' por tipo de ocupación, 2015"
		putexcel set "`file'", sheet("`id'") modify
		putexcel A1 = "`msg'", font("Times New Roman", 11) bold
	}
}
