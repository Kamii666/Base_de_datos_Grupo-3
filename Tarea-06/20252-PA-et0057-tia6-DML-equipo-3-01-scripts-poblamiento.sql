--
-- Tarea 6 - Parte #2 del Proyecto de Aula
-- SCRIPTS DE POBLAMIENTO DE LA BASE DE DATOS (INSERTS)
--
-- Miembros del grupo
-- Juan Kamilo Algarin Gomez
-- Jhoneider David Vergara Cruz
-- Duban Alexis Zapata Holguin

-- Se crean las tablas en Excel, luego los archivos se guardan en formato .CSV para importarlos en PostgreSQL


--
-- Hospitales
--
COPY hospital (
    id_hospital,
    nombre_hospital,
    direccion,
    telefono
)
FROM 'C:/BD1 TIA6/hospital.csv'
DELIMITER ','
CSV HEADER;


--.
-- Especialidades Médicas
--
COPY especialidad (
    id_especialidad,
    nombre_especialidad,
    descripcion
)
FROM 'C:/BD1 TIA6/especialidad.csv'
DELIMITER ','
CSV HEADER;


--
-- Pacientes
--
COPY paciente (
    id_paciente,
    nombre_paciente,
    genero,
    fecha_nacimiento,
    id_eps
)
FROM 'C:/BD1 TIA6/paciente.csv'
DELIMITER ','
CSV HEADER;


--
-- Médicos
--
COPY medico (
    id_medico,
    nombre_medico,
    genero,
    id_especialidad,
    telefono,
    registro_medico
)
FROM 'C:/BD1 TIA6/medico.csv'
DELIMITER ','
CSV HEADER;


--
-- Enfermeras
--
COPY enfermero (
    id_enfermero,
    nombre_enfermero,
    genero,
    telefono
)
FROM 'C:/BD1 TIA6/enfermero.csv'
DELIMITER ','
CSV HEADER;



--
-- Hospitalizaciones 
--
COPY hospitalizacion (
    id_hospitalizacion,
    id_paciente,
    id_hospital,
    id_cuarto,
    id_medico,
    id_enfermero,
    fecha_ingreso,
    fecha_salida,
    motivo
)
FROM 'C:/BD1 TIA6/hospitalizacion.csv'
DELIMITER ','
CSV HEADER;
