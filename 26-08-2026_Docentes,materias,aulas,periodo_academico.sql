CREATE TABLE docentes (
    id_docente SERIAL PRIMARY KEY,
    numero_empleado VARCHAR(20) UNIQUE NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    telefono VARCHAR(20),
    id_facultad INT NOT NULL,
    es_tiempo_completo BOOLEAN DEFAULT FALSE,

    CONSTRAINT fk_docente_facultad
        FOREIGN KEY (id_facultad)
        REFERENCES facultades(id_facultad)
);


INSERT INTO docentes
(numero_empleado, nombre, apellido, email, telefono, id_facultad, es_tiempo_completo)
VALUES
('EMP001', 'Pedro', 'Martínez', 'pedro@universidad.mx', '6125551111', 1, TRUE),
('EMP002', 'Sofía', 'Hernández', 'sofia@universidad.mx', '6125552222', 1, TRUE),
('EMP003', 'Miguel', 'García', 'miguel@universidad.mx', '6125553333', 2, FALSE);


# 6. Tabla Materias

CREATE TABLE materias (
    id_materia SERIAL PRIMARY KEY,
    id_carrera INT NOT NULL,
    clave VARCHAR(20) UNIQUE NOT NULL,
    nombre VARCHAR(150) NOT NULL,
    creditos INT NOT NULL,
    tipo VARCHAR(50),
    descripcion TEXT,

    CONSTRAINT fk_materia_carrera
        FOREIGN KEY (id_carrera)
        REFERENCES carreras(id_carrera)
);

INSERT INTO materias
(id_carrera, clave, nombre, creditos, tipo, descripcion)
VALUES
(1, 'IDS101', 'Metodología de la Programación', 8, 'Obligatoria', 'Fundamentos de programación'),
(1, 'IDS201', 'Programación Web', 8, 'Obligatoria', 'Desarrollo de aplicaciones web'),
(1, 'IDS301', 'Base de Datos II', 8, 'Obligatoria', 'Bases de datos avanzadas'),
(2, 'ITC101', 'Redes de Computadoras', 7, 'Obligatoria', 'Fundamentos de redes');


# 7. Tabla aulas

CREATE TABLE aulas (
    id_aula SERIAL PRIMARY KEY,
    codigo VARCHAR(20) UNIQUE NOT NULL,
    edificio VARCHAR(100),
    capacidad INT NOT NULL,
    tipo VARCHAR(50)
);

INSERT INTO aulas (codigo, edificio, capacidad, tipo)
VALUES
('A-101', 'Edificio A', 30, 'Laboratorio'),
('A-102', 'Edificio A', 40, 'Aula'),
('B-201', 'Edificio B', 25, 'Laboratorio'),
('B-202', 'Edificio B', 35, 'Aula');