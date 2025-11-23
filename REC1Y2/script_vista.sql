-- 1 join
SELECT a.nombre_sede, b.nombre_programa
FROM universidades a
INNER JOIN universidades b
ON a.id_sede = b.id_sede;

-- 2 join 
SELECT u1.nombre_sede, u1.nombre_programa, u2.departamento
FROM universidades u1
LEFT JOIN universidades u2
ON u1.id_departamento = u2.id_departamento;

-- 3 join
SELECT a.nombre_sede, b.departamento
FROM universidades a
INNER JOIN universidades b
ON a.id_departamento = b.id_departamento;


-- 4 join
SELECT a.municipio,
       a.nombre_programa AS prog_1,
       b.nombre_programa AS prog_2
FROM universidades a
INNER JOIN universidades b
ON a.id_municipio = b.id_municipio;

-- 5 join
SELECT a.metologia AS metodo,
       a.nombre_programa AS programa_1,
       b.nombre_programa AS programa_2
FROM universidades a
INNER JOIN universidades b
ON a.id_metologiaa = b.id_metologiaa;

-- join 6
SELECT a.total_graduados,
       a.nombre_sede AS sede_1,
       b.nombre_sede AS sede_2
FROM universidades a
INNER JOIN universidades b
ON a.total_graduados = b.total_graduados;