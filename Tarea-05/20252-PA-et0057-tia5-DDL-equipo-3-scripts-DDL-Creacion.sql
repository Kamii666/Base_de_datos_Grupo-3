--
-- Tarea 5 - Parte #1 del Proyecto de Aula
-- SCRIPTS DE CREACIÓN DE LA BASE DE DATOS
--
-- Miembros del grupo
--Juan Kamilo Algarin Gomez
--Jhoneider David Vergara Cruz
--Duban Alexis Zapata Holguin

--
-- Tablas en orden de creación
-- 1.- Tablas Independientes
eps
hospital
planta
especialidad
visitante
medicamento

-- 2.- Tablas Dependientes
--
cuarto
paciente
tarjeta_de_visita
medico
diagnostico
tratamiento
--
-- Tabla "1"
--
CREATE TABLE eps (
    id_eps SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
);
--
-- Tabla "2"
--
CREATE TABLE hospital (
    id_hospital SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
);
--
-- Tabla "3"
--
CREATE TABLE planta (
    id_planta SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
);
--
-- Tabla "4"
--
CREATE TABLE especialidad (
    id_especialidad SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
);
--
-- Tabla "5"
--
CREATE TABLE visitante (
    id_visitante SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
);
--
-- Tabla "6"
--
CREATE TABLE medicamento (
    id_medicamento SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
);
--
-- Tabla "7"
--
CUARTO → pertenece a planta (1:N)
CREATE TABLE cuarto (
    id_cuarto SERIAL PRIMARY KEY,
    numero VARCHAR(20),
    id_planta INT NOT NULL,
    FOREIGN KEY (id_planta) REFERENCES planta(id_planta)
);
--
-- Tabla "8"
--
CREATE TABLE paciente (
    id_paciente SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    id_eps INT NOT NULL,
    FOREIGN KEY (id_eps) REFERENCES eps(id_eps)
);
--
-- Tabla "9"
--
CREATE TABLE tarjeta_visita (
    id_tarjeta SERIAL PRIMARY KEY,
    id_paciente INT UNIQUE NOT NULL,
    id_visitante INT UNIQUE NOT NULL,
    FOREIGN KEY (id_paciente) REFERENCES paciente(id_paciente),
    FOREIGN KEY (id_visitante) REFERENCES visitante(id_visitante)
);
--
-- Tabla "10"
--
CREATE TABLE medico (
    id_medico SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
);
--
-- Tabla "11"
--
CREATE TABLE diagnostico (
    id_diagnostico SERIAL PRIMARY KEY,
    descripcion TEXT NOT NULL
);
--
-- Tabla "12"
--
CREATE TABLE tratamiento (
    id_tratamiento SERIAL PRIMARY KEY,
    descripcion TEXT NOT NULL
);
