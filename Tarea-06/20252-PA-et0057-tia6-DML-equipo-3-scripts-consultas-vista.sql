CREATE OR REPLACE VIEW vista_detalle_hospitalizacion AS
SELECT 
    h.id_hospitalizacion,
    -- Datos Paciente
    p.nombre_paciente,
    p.genero AS genero_paciente,
    p.fecha_nacimiento,
    EXTRACT(YEAR FROM AGE(p.fecha_nacimiento)) AS edad_paciente,
    -- Datos Hospital
    hos.nombre_hospital,
    hos.direccion AS direccion_hospital,
    -- Datos Médico y Especialidad
    m.nombre_medico,
    e.nombre_especialidad,
    -- Datos Enfermero
    enf.nombre_enfermero,
    -- Datos Hospitalización
    h.fecha_ingreso,
    h.fecha_salida,
    (h.fecha_salida - h.fecha_ingreso) AS dias_estancia,
    h.motivo,
    -- Indicador de reingreso (del 6to Join)
    CASE 
        WHEN h_prev.id_hospitalizacion IS NOT NULL THEN 'SI' 
        ELSE 'NO' 
    END AS tiene_historial_previo
FROM 
    public.hospitalizacion h
    -- Join 1: Paciente
    JOIN public.paciente p ON h.id_paciente = p.id_paciente
    -- Join 2: Hospital
    JOIN public.hospital hos ON h.id_hospital = hos.id_hospital
    -- Join 3: Médico
    JOIN public.medico m ON h.id_medico = m.id_medico
    -- Join 4: Especialidad (A través del médico)
    JOIN public.especialidad e ON m.id_especialidad = e.id_especialidad
    -- Join 5: Enfermero
    JOIN public.enfermero enf ON h.id_enfermero = enf.id_enfermero
    -- Join 6: Self Join (Busca si existe una hospitalización anterior del mismo paciente)
    LEFT JOIN public.hospitalizacion h_prev ON h.id_paciente = h_prev.id_paciente 
        AND h_prev.fecha_ingreso < h.fecha_ingreso;

--consulta 1 Cantidad de hospitalizaciones por Especialidad y Hospital
		SELECT 
    nombre_hospital,
    nombre_especialidad,
    COUNT(id_hospitalizacion) AS total_pacientes_atendidos
FROM 
    vista_detalle_hospitalizacion
GROUP BY 
    nombre_hospital, 
    nombre_especialidad
ORDER BY 
    total_pacientes_atendidos DESC;

--consulta 2 Análisis de días de estancia (Carga de ocupación)
	SELECT 
    nombre_hospital,
    SUM(dias_estancia) AS total_dias_ocupacion,
    MIN(dias_estancia) AS estancia_minima_dias,
    MAX(dias_estancia) AS estancia_maxima_dias
FROM 
    vista_detalle_hospitalizacion
WHERE 
    dias_estancia IS NOT NULL -- Filtramos hospitalizaciones activas sin fecha salida
GROUP BY 
    nombre_hospital;

-- CONSULTA 3: Carga laboral de enfermeros por género del paciente
	SELECT 
    nombre_enfermero,
    genero_paciente,
    COUNT(*) AS atenciones_realizadas
FROM 
    vista_detalle_hospitalizacion
GROUP BY 
    nombre_enfermero, 
    genero_paciente
ORDER BY 
    atenciones_realizadas DESC
LIMIT 5;

-- CONSULTA 4: Edad máxima de pacientes atendidos por especialidad
SELECT 
    nombre_especialidad,
    MAX(edad_paciente) AS edad_paciente_mas_longevo
FROM 
    vista_detalle_hospitalizacion
GROUP BY 
    nombre_especialidad;


-- CONSULTA 5: Resumen de reingresos 
SELECT 
    nombre_hospital,
    tiene_historial_previo,
    COUNT(id_hospitalizacion) AS cantidad_casos
FROM 
    vista_detalle_hospitalizacion
WHERE 
    tiene_historial_previo = 'SI'
GROUP BY 
    nombre_hospital, 
    tiene_historial_previo;

