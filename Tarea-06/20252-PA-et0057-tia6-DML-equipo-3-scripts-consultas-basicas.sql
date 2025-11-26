--
-- Tarea 6 - Parte #2 del Proyecto de Aula
-- SCRIPTS DE Elaboración de consultas básicas 
--
-- Miembros del grupo
-- Juan Kamilo Algarin Gomez
-- Jhoneider David Vergara Cruz
-- Duban Alexis Zapata Holguin
--
SELECT *
FROM hospitalizacion
ORDER BY id_hospitalizacion ASC;

SELECT id_paciente
FROM hospitalizacion
ORDER BY id_paciente ASC;

SELECT id_hospitalizacion, fecha_ingreso
FROM hospitalizacion
ORDER BY fecha_ingreso DESC;

SELECT id_medico
FROM hospitalizacion
ORDER BY id_medico ASC;

SELECT id_hospital
FROM hospitalizacion
ORDER BY id_hospital DESC;

SELECT COUNT(*) AS total_hospitalizaciones
FROM hospitalizacion
ORDER BY total_hospitalizaciones;

SELECT MAX(fecha_ingreso) AS ultima_fecha_ingreso
FROM hospitalizacion
ORDER BY ultima_fecha_ingreso;

SELECT MIN(fecha_ingreso) AS primera_fecha_ingreso
FROM hospitalizacion
ORDER BY primera_fecha_ingreso;

SELECT AVG(fecha_salida - fecha_ingreso) AS promedio_dias
FROM hospitalizacion
ORDER BY promedio_dias;

SELECT SUM(fecha_salida - fecha_ingreso) AS total_dias_hospitalizados
FROM hospitalizacion
ORDER BY total_dias_hospitalizados;
