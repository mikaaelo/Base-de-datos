DROP TABLE IF EXISTS estudiantes;
DROP TABLE IF EXISTS carreras;
DROP TABLE IF EXISTS facultades;

CREATE TABLE facultades (
    id_facultad SERIAL PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL,
    codigo VARCHAR(10) UNIQUE NOT NULL,
    decano VARCHAR(100),
    telefono VARCHAR(20)
);

CREATE TABLE carreras (
    id_carrera SERIAL PRIMARY KEY,
    id_facultad INT NOT NULL,
    nombre VARCHAR(150) NOT NULL,
    codigo VARCHAR(10) UNIQUE NOT NULL,
    duracion_semestres INT NOT NULL,
    estado VARCHAR(20) DEFAULT 'ACTIVA',
    FOREIGN KEY (id_facultad) REFERENCES facultades(id_facultad),
    CHECK (duracion_semestres > 0)
);

CREATE TABLE estudiantes (
    id_estudiante SERIAL PRIMARY KEY,
    matricula VARCHAR(20) UNIQUE NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    telefono VARCHAR(20),
    fecha_nacimiento DATE,
    id_carrera INT NOT NULL,
    fecha_ingreso DATE DEFAULT CURRENT_DATE,
    estado VARCHAR(20) DEFAULT 'ACTIVO',
    FOREIGN KEY (id_carrera) REFERENCES carreras(id_carrera)
);

INSERT INTO facultades
(nombre, codigo, decano, telefono)
VALUES
('Facultad de Ingeniería', 'ING', 'Carlos Mendoza', '6121234567'),
('Facultad de Ciencias', 'CIE', 'Laura Ramírez', '6122345678'),
('Facultad de Administración', 'ADM', 'Roberto López', '6123456789');

INSERT INTO carreras
(id_facultad, nombre, codigo, duracion_semestres)
VALUES
(1, 'Ingeniería en Desarrollo de Software', 'IDS', 8),
(1, 'Ingeniería en Tecnologías Computacionales', 'ITC', 8),
(2, 'Licenciatura en Biología', 'BIO', 8),
(3, 'Licenciatura en Administración', 'LAE', 8);

INSERT INTO estudiantes
(matricula, nombre, apellido, email, telefono, fecha_nacimiento, id_carrera)
VALUES
('20260001', 'Juan', 'Pérez', 'juan@universidad.mx', '6121111111', '2005-05-10', 1),
('20260002', 'María', 'López', 'maria@universidad.mx', '6122222222', '2004-08-15', 1),
('20260003', 'Carlos', 'Ramírez', 'carlos@universidad.mx', '6123333333', '2005-01-20', 2),
('20260004', 'Ana', 'Torres', 'ana@universidad.mx', '6124444444', '2004-11-03', 3);

SELECT * FROM facultades;
SELECT * FROM carreras;
SELECT * FROM estudiantes;
