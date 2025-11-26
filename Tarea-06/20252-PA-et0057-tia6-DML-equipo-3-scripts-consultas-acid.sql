-- 1. Limpiamos cualquier error previo
ROLLBACK;

-- 2. Aseguramos que existan los datos BASE (Hospital, Médico, Enfermero 1)
INSERT INTO public.especialidad (id_especialidad, nombre_especialidad, descripcion) VALUES (1, 'General', 'Base') ON CONFLICT DO NOTHING;
INSERT INTO public.hospital (id_hospital, nombre_hospital, direccion) VALUES (1, 'Hospital Base', 'Calle 1') ON CONFLICT DO NOTHING;
INSERT INTO public.medico (id_medico, nombre_medico, genero, id_especialidad, registro_medico) VALUES (1, 'Medico Base', 'M', 1, 'RM000') ON CONFLICT DO NOTHING;
INSERT INTO public.enfermero (id_enfermero, nombre_enfermero, genero) VALUES (1, 'Enfermero Base', 'M') ON CONFLICT DO NOTHING;

-- 3. Creamos la especialidad EXTRA para la prueba del CASO 8
INSERT INTO public.especialidad (id_especialidad, nombre_especialidad, descripcion) VALUES (100, 'Prueba Borrar', 'Vacia') ON CONFLICT DO NOTHING;

-- 4. Arreglamos los contadores
SELECT setval('public.hospitalizacion_id_hospitalizacion_seq', (SELECT COALESCE(MAX(id_hospitalizacion), 1) FROM public.hospitalizacion));
SELECT setval('public.paciente_id_paciente_seq', (SELECT COALESCE(MAX(id_paciente), 1) FROM public.paciente));

-- CASO 1: Transacción Exitosa (Atomicidad y Durabilidad)
-- Explicación: Insertamos un paciente y su hospitalización en un solo bloque. 
BEGIN;
    -- Paso 1: Crear Paciente
    INSERT INTO public.paciente (nombre_paciente, genero, fecha_nacimiento, id_eps)
    VALUES ('Prueba ACID Juan', 'M', '1985-01-01', 'EPS001');

    -- Paso 2: Crear Hospitalización
    -- CORRECCIÓN: Aquí abajo cambiamos el 1992 por un 1
    INSERT INTO public.hospitalizacion (id_paciente, id_hospital, id_cuarto, id_medico, id_enfermero, fecha_ingreso, motivo)
    VALUES (currval('public.paciente_id_paciente_seq'), 1, 101, 1, 1, '2023-10-27', 'Prueba Atomicidad');
COMMIT;

-- Resultado: Ambos registros se crean permanentemente.
-- CASO 2: Validación de Constraint CHECK (Consistencia)
INSERT INTO public.medico (nombre_medico, genero, id_especialidad, telefono, registro_medico)
VALUES ('Dr. Error', 'X', 1, '555-0000', 'REG999');
-- Resultado esperado: ERROR: el nuevo registro para la relación «medico» viola la restricción check «medico_genero_check»

-- CASO 3: Validación de Unicidad (Consistencia)
-- Explicación: Intentamos insertar un médico con un registro que YA existe (suponiendo que 'RM001' ya está en la BD o insertamos uno nuevo y lo repetimos).
INSERT INTO public.medico (nombre_medico, genero, id_especialidad, telefono, registro_medico)
VALUES ('Dr. Duplicado', 'M', 1, '555-1111', 'RM_TEST_DUP');

-- CASO 4: Rollback Manual (Atomicidad)
-- Explicación: Iniciamos una transacción, modificamos un dato, pero nos "arrepentimos" 
BEGIN;
    UPDATE public.hospital SET direccion = 'Calle Falsa 123' WHERE id_hospital = 1;
    -- Verificamos y decidimos no guardar cambios
ROLLBACK;
-- Resultado: La dirección del hospital 1 NO cambió. La operación fue atómica (todo o nada).


-- CASO 5: Actualización Masiva Exitosa (Durabilidad)
-- Explicación: Actualizamos múltiples registros. Una vez confirmado (COMMIT), 
-- el cambio persiste ante fallos del sistema.
BEGIN;
    UPDATE public.hospitalizacion 
    SET motivo = motivo || ' (Revisado)' 
    WHERE fecha_ingreso = '2023-10-27';
COMMIT;
-- Resultado: Todos los registros de esa fecha quedan actualizados permanentemente.


-- CASO 6: Violación de Integridad Referencial (Consistencia)
-- Explicación: Intentamos asignar una especialidad que NO existe (ID 9999) a un médico.
-- La BD bloquea el update para evitar registros huérfanos.
UPDATE public.medico 
SET id_especialidad = 9999 
WHERE id_medico = 1;
-- Resultado esperado: ERROR: inserción o actualización en la tabla «medico» viola la llave foránea «medico_id_especialidad_fkey»


--------------------------------------------------------------------------------
-- 3. OPERACIONES DE DELETE (Consistencia y Atomicidad)
--------------------------------------------------------------------------------

-- CASO 7: Protección de Datos Relacionados (Consistencia)
-- Explicación: Intentamos borrar un Hospital que ya tiene hospitalizaciones registradas.
DELETE FROM public.hospital WHERE id_hospital = 1;
-- Resultado esperado: ERROR: update o delete en «hospital» viola la llave foránea «hospitalizacion_id_hospital_fkey»

-- CASO 8: Borrado Atómico con Rollback (Atomicidad)
-- Explicación: Simulamos un borrado accidental dentro de una transacción y lo recuperamos.
BEGIN;
    -- Intentamos borrar la especialidad 100 (que sí está vacía)
    DELETE FROM public.especialidad WHERE id_especialidad = 100;    
ROLLBACK;

-- Resultado: Si buscas la especialidad 100, seguirá ahí. ¡El Rollback funcionó!
-- Resultado: La especialidad 2 sigue existiendo. El sistema recuperó el estado previo.

-- CASO 9: Borrado Exitoso (Durabilidad)
-- Explicación: Borramos un registro que no viola reglas (ej. la hospitalización de prueba creada en el Caso 1).
ROLLBACK;
BEGIN;
    -- 1. Borramos TODAS las hospitalizaciones asociadas a ese nombre de paciente
    -- (Esto asegura que no quede nada "huerfano" bloqueando el borrado)
    DELETE FROM public.hospitalizacion 
    WHERE id_paciente IN (SELECT id_paciente FROM public.paciente WHERE nombre_paciente = 'Prueba ACID Juan');

    -- Ahora que está limpio, borramos al paciente
    DELETE FROM public.paciente 
    WHERE nombre_paciente = 'Prueba ACID Juan';
COMMIT;
-- Resultado: Los datos de prueba han sido eliminados permanentemente.