--
-- Tarea 5 - Parte #1 del Proyecto de Aula
-- SCRIPTS DE MODIFICACIÓN DE LA BASE DE DATOS
--
-- Miembros del grupo
--Juan Kamilo Algarin Gomez
--Jhoneider David Vergara Cruz
--Duban Alexis Zapata Holguin

--
-- INSTRUCCIONES DE MODIFICACIÓN SOLICITADAS
--

--
-- 5.1.- Agregar al menos 5 índices diferentes que considere importantes en 5 tablas diferentes. 
--

CREATE INDEX idx_paciente_nombre ON paciente(nombre);

CREATE INDEX idx_medico_nombre ON medico(nombre);

CREATE INDEX idx_trimedi_tratamiento ON tratamiento_incluye_medicamento(id_tratamiento);

CREATE INDEX idx_diagcont_diagnostico ON diagnostico_contiene_tratamiento(id_diagnostico);

CREATE INDEX idx_visita_paciente ON visitante_visita_paciente(id_paciente);
--
-- 5.2.- Agregar 5 campos nuevos en 5 tablas diferentes de su preferencia. 
-- 

ALTER TABLE paciente
ADD COLUMN edad INT;

ALTER TABLE medico
ADD COLUMN telefono VARCHAR(20);

ALTER TABLE hospital
ADD COLUMN fecha_ingreso DATE;

ALTER TABLE medicamento
ADD COLUMN stock INT DEFAULT 0;

ALTER TABLE especialidad
ADD COLUMN descripcion TEXT;

--
-- 5.3.- Agregar 5 “CHECK” diferentes en 5 tablas diferentes  de su preferencia. 
--

ALTER TABLE paciente
ADD CONSTRAINT chk_paciente_edad CHECK (edad >= 0);

ALTER TABLE medicamento
ADD CONSTRAINT chk_medicamento_stock CHECK (stock >= 0);

ALTER TABLE medico
ADD CONSTRAINT chk_medico_telefono CHECK (char_length(telefono) >= 7);

ALTER TABLE planta
ADD CONSTRAINT chk_planta_nombre CHECK (nombre <> '');

ALTER TABLE cuarto
ADD CONSTRAINT chk_cuarto_numero CHECK (char_length(numero) > 0);

--
-- 5.4. Modificar los nombres de 5 campos diferentes en 5 tablas diferentes. 
--

ALTER TABLE paciente
RENAME COLUMN nombre TO nombre_paciente;

ALTER TABLE medico
RENAME COLUMN nombre TO nombre_medico;

ALTER TABLE tratamiento
RENAME COLUMN descripcion TO detalle_tratamiento;

ALTER TABLE diagnostico
RENAME COLUMN descripcion TO detalle_diagnostico;

ALTER TABLE hospital
RENAME COLUMN nombre TO nombre_hospital;