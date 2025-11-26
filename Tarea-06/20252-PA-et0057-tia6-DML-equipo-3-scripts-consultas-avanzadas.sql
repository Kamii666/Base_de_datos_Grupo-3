--
-- Tarea 6 - Parte #2 del Proyecto de Aula
-- SCRIPTS DE Elaboración de consultas avanzadas (SELECT / Con JOIN)
--
-- Miembros del grupo
-- Juan Kamilo Algarin Gomez
-- Jhoneider David Vergara Cruz
-- Duban Alexis Zapata Holguin

SELECT h.id_hospitalizacion, p.nombre_paciente AS paciente, h.fecha_ingreso
FROM hospitalizacion h
JOIN paciente p ON h.id_paciente = p.id_paciente
ORDER BY h.fecha_ingreso DESC;

SELECT h.id_hospitalizacion, m.nombre_medico AS medico, h.fecha_ingreso
FROM hospitalizacion h
JOIN medico m ON h.id_medico = m.id_medico
ORDER BY m.nombre_medico ASC;

SELECT h.id_hospitalizacion, hos.nombre_hospital AS hospital
FROM hospitalizacion h
JOIN hospital hos ON h.id_hospital = hos.id_hospital
ORDER BY hos.nombre_hospital ASC;

SELECT h.id_hospitalizacion, p.nombre_paciente AS paciente, m.nombre_medico AS medico
FROM hospitalizacion h
JOIN paciente p ON h.id_paciente = p.id_paciente
JOIN medico m ON h.id_medico = m.id_medico
ORDER BY p.nombre_paciente ASC;

SELECT h.id_hospitalizacion, hos.nombre_hospital AS hospital, en.nombre_enfermero AS enfermero
FROM hospitalizacion h
JOIN hospital hos ON h.id_hospital = hos.id_hospital
JOIN enfermero en ON h.id_enfermero = en.id_enfermero
ORDER BY en.nombre_enfermero ASC;

SELECT p.nombre AS paciente, m.nombre AS medico, e.nombre_especialidad,
       COUNT(*) AS total_visitas
FROM hospitalizacion h
JOIN paciente p ON h.id_paciente = p.id_paciente
JOIN medico m ON h.id_medico = m.id_medico
JOIN especialidad_medica e ON m.id_especialidad = e.id_especialidad
GROUP BY p.nombre, m.nombre, e.nombre_especialidad
ORDER BY total_visitas DESC;

SELECT hos.nombre_hospital AS hospital, p.nombre_paciente AS paciente,
       AVG(h.fecha_salida - h.fecha_ingreso) AS promedio_estancia
FROM hospitalizacion h
JOIN hospital hos ON h.id_hospital = hos.id_hospital
JOIN paciente p ON h.id_paciente = p.id_paciente
GROUP BY hos.nombre_hospital, p.nombre_paciente
ORDER BY promedio_estancia DESC;


SELECT 
    p.nombre_paciente AS paciente,
    m.nombre_medico AS medico,
    en.nombre_enfermero AS enfermero,
    hos.nombre_hospital AS hospital,
    MAX(h.fecha_ingreso) AS ultima_hospitalizacion
FROM hospitalizacion h
JOIN paciente p ON h.id_paciente = p.id_paciente
JOIN medico m ON h.id_medico = m.id_medico
JOIN enfermero en ON h.id_enfermero = en.id_enfermero
JOIN hospital hos ON h.id_hospital = hos.id_hospital
GROUP BY p.nombre_paciente, m.nombre_medico, en.nombre_enfermero, hos.nombre_hospital
ORDER BY ultima_hospitalizacion DESC;


SELECT 
    p.nombre_paciente AS paciente,
    m.nombre_medico AS medico,
    en.nombre_enfermero AS enfermero,
    hos.nombre_hospital AS hospital,
    SUM(h.fecha_salida - h.fecha_ingreso) AS total_dias_hospitalizado,
    MIN(h.fecha_ingreso) AS primera_vez_hospitalizado
FROM hospitalizacion h
JOIN paciente p ON h.id_paciente = p.id_paciente
JOIN medico m ON h.id_medico = m.id_medico
JOIN enfermero en ON h.id_enfermero = en.id_enfermero
JOIN hospital hos ON h.id_hospital = hos.id_hospital

JOIN (
    SELECT id_hospitalizacion 
    FROM hospitalizacion
) extra ON extra.id_hospitalizacion = h.id_hospitalizacion
GROUP BY p.nombre_paciente, m.nombre_medico, en.nombre_enfermero, hos.nombre_hospital
ORDER BY total_dias_hospitalizado DESC;
