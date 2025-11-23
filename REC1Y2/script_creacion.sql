CREATE TABLE universidades (
    id                  SERIAL PRIMARY KEY,

    id_sede             INTEGER         NOT NULL,
    nombre_sede         VARCHAR(150)    NOT NULL,

    id_programa         INTEGER         NOT NULL,
    nombre_programa     VARCHAR(200)    NOT NULL,

    id_departamento     INTEGER         NOT NULL,
    departamento        VARCHAR(120)    NOT NULL,

    id_municipio        INTEGER         NOT NULL,
    municipio           VARCHAR(120)    NOT NULL,

    id_metologiaa       INTEGER         NOT NULL,
    metologia           VARCHAR(80)     NOT NULL,

    total_graduados     INTEGER         NOT NULL
);