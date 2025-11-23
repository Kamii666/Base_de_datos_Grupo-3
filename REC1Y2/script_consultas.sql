select * from universidades;

SELECT DISTINCT id_sede, nombre_sede
FROM universidades
ORDER BY nombre_sede;

SELECT nombre_sede, nombre_programa
FROM universidades
WHERE id_sede = 2719;