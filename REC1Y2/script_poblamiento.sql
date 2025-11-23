COPY universidades(
    id_sede,
    nombre_sede,
    id_programa,
	nombre_programa,
	id_departamento,
	departamento,
	id_municipio,
	municipio,
	id_metologiaa,
	metologia,
	total_graduados
)
FROM 'C:\bas1\base de datos graduados.csv'
DELIMITER ';'
CSV
HEADER
ENCODING 'UTF8';


copy universidades from 'C:\bas1\base de datos graduados.csv' delimiter ';' csv header;