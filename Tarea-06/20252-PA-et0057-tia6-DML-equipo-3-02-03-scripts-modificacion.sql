--
-- Tarea 6 - Parte #2 del Proyecto de Aula
-- SCRIPTS DE MODIFICACIÓN DE LA BASE DE DATOS (UPDATE, DELETES)
--
-- Miembros del grupo
-- Juan Kamilo Algarin Gomez
-- Jhoneider David Vergara Cruz
-- Duban Alexis Zapata Holguin

--
-- INSTRUCCIONES DE MODIFICACIÓN SOLICITADAS
--

--
-- Instrucciones UPDATE 
--

-- 1. Tabla paciente
-- 1.1. Actualizar el teléfono del paciente David Escobar (id_paciente = 3009)
UPDATE paciente
SET telefono = '3015557788'
WHERE id_paciente = 3009;

-- 1.2. Actualizar EPS
-- La paciente cambió de eps a una nueva entidad.
UPDATE paciente 
SET id_eps = 5 
WHERE id_paciente = 3010;

-- 1.3. Corregir fecha de nacimiento
UPDATE paciente
SET fecha_nacimiento = '1992-04-21'
WHERE id_paciente = 3011;

-- 1.4. Actualizar genero
UPDATE paciente 
SET genero = 'M' 
WHERE id_paciente = 3012;

-- 1.5. Actualizar nombre
UPDATE paciente 
SET nombre_paciente = 'Diego Mateo Cardenas' 
WHERE id_paciente = 3013;



-- 2. Tabla medico
-- 2.1. Actualizar telefono
-- El médico actualizó su número de contacto personal.
UPDATE medico 
SET telefono = '3219876543' 
WHERE id_medico = 5001;

-- 2.2. Actualizar especialidad
-- El Dr. Felipe terminó su especialización y cambia de área.
UPDATE medico 
SET id_especialidad = 5 
WHERE id_medico = 5002;

-- 2.3. Actualizar nombre
UPDATE medico 
SET nombre_medico = 'Dr. Andres Felipe Zapata' 
WHERE id_medico = 5003;

-- 2.4. Actualizar registro medico
UPDATE medico 
SET registro_medico = 'TP-998877-Renew' 
WHERE id_medico = 5004;

-- 2.5. Actualizar genero 
UPDATE medico 
SET genero = 'F' 
WHERE id_medico = 5005;



-- 3. Tabla especialidad
-- 3.1. Actualizar descripcion
UPDATE especialidad 
SET descripcion = 'Atención primaria, preventiva y chequeos generales' 
WHERE id_especialidad = 1;

-- 3.2. Actualizar nombre
UPDATE especialidad 
SET nombre_especialidad = 'Cardiología Intervencionista' 
WHERE id_especialidad = 2;

-- 3.3. Actualizar descripcion (Repetido por límite de columnas)
UPDATE especialidad
SET descripcion = 'Atención integral a recién nacidos, niños y adolescentes, con enfoque preventivo y de desarrollo saludable'
WHERE id_especialidad = 3;

-- 3.4. Actualizar descripcion (Repetido por límite de columnas)
UPDATE especialidad 
SET descripcion = 'Salud integral del sistema reproductivo de la mujer' 
WHERE id_especialidad = 4;

-- 3.5. Actualizar nombre (Repetido por límite de columnas)
UPDATE especialidad 
SET nombre_especialidad = 'TRAUMATOLOGIA Y ORTOPEDIA' 
WHERE id_especialidad = 5;



-- 4. Tabla enfermero
-- 4.1. Actualizar telefono
UPDATE enfermero 
SET telefono = '3155550000' 
WHERE id_enfermero = 7001;

-- 4.2. Actualizar nombre 
UPDATE enfermero 
SET nombre_enfermero = 'Sandra Patricia de Gaviria' 
WHERE id_enfermero = 7004;

-- 4.3. Actualizar genero 
UPDATE enfermero 
SET genero = 'M' 
WHERE id_enfermero = 7003;

-- 4.4. Actualizar nombre (Repetido por límite de columnas)
UPDATE enfermero 
SET nombre_enfermero = 'Paola Andrea Gil' 
WHERE id_enfermero = 7005;

-- 4.5. Actualizar telefono (Repetido por límite de columnas)
UPDATE enfermero 
SET telefono = '3000001111' 
WHERE id_enfermero = 7002;



-- 5. Tabla hospital
-- 5.1. Actualizar direccion
UPDATE hospital 
SET direccion = 'Calle 64 Nueva # 51D-200' 
WHERE id_hospital = 1;

-- 5.2. Actualizar telefono
UPDATE hospital 
SET telefono = '604-3429999' 
WHERE id_hospital = 2;

-- 5.3. Actualizar nombre
UPDATE hospital 
SET nombre_hospital = 'Hospital General de Medellín – Unidad Central'
WHERE id_hospital = 3;

-- 5.4. Actualizar direccion (Repetido por límite de columnas)
UPDATE hospital
SET direccion = 'Calle 78B 69-241'
WHERE id_hospital = 4;

-- 5.5. Actualizar telefono (Repetido por límite de columnas)
UPDATE hospital 
SET telefono = '604-4441500' 
WHERE id_hospital = 5;



-- 6. Tabla hospitalizacion
-- 6.1. Actualizar motivo
UPDATE hospitalizacion 
SET motivo = 'Intoxicación por mariscos' 
WHERE id_hospitalizacion = 50;

-- 6.2. Actualizar fecha salida
UPDATE hospitalizacion 
SET fecha_salida = '2024-07-30' 
WHERE id_hospitalizacion = 51;

-- 6.3. Actualizar cuarto
UPDATE hospitalizacion 
SET id_cuarto = 320 
WHERE id_hospitalizacion = 52;

-- 6.4. Actualizar enfermero asignado
UPDATE hospitalizacion
SET id_enfermero = 7003
WHERE id_hospitalizacion = 53;

-- 5. Actualizar fecha ingreso
UPDATE hospitalizacion 
SET fecha_ingreso = '2024-08-09' 
WHERE id_hospitalizacion = 54;



--
-- INSTRUCCIONES DELETE 
-- 

-- 1. Tabla hospitalizacion
-- Eliminación de registros por depuración de datos históricos o errores de ingreso.
DELETE FROM hospitalizacion 
WHERE id_hospitalizacion IN (22, 23, 24, 25, 26);

-- 2. Tabla paciente
-- Solicitud de eliminación de datos personales por parte administrativa.
DELETE FROM paciente 
WHERE id_paciente IN (4011, 4012, 4013, 4014, 4015);

-- 3. Tabla enfermero
-- Finalización de contratos temporales en la planta de enfermería.
DELETE FROM enfermero 
WHERE id_enfermero IN (7006, 7007, 7008, 7009, 7010);

-- 4. Tabla hospital
-- Cierre de convenios con estas entidades; ya no forman parte de la red de servicios.
DELETE FROM hospital 
WHERE id_hospital IN (6, 7, 8, 9, 10);

-- 5. Tabla medico
-- Retiro voluntario y jubilación de los especialistas listados.
DELETE FROM medico 
WHERE id_medico IN (5016, 6001, 6002, 6003, 6004);

-- 6. Tabla especialidad
-- Reestructuración de servicios; el hospital dejará de prestar servicios directos de Oncología y Anestesiología.
DELETE FROM especialidad 
WHERE id_especialidad IN (9, 10);


