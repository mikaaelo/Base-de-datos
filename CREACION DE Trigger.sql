CREATE OR REPLACE FUNCTION validar_monto_pago()
RETURNS TRIGGER AS $$
BEGIN

    IF NEW.monto > 20000 THEN
        RAISE EXCEPTION 'El monto supera el límite permitido.';
    END IF;

    RETURN NEW;

END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER verificar_monto_pago
BEFORE INSERT ON pagos
FOR EACH ROW
EXECUTE FUNCTION validar_monto_pago();



/* =========================================================
   PRUEBA DEL TRIGGER
   ========================================================= */

SELECT
    p.id_pago,
    p.id_estudiante,
    p.id_periodo,
    p.concepto,
    p.monto
FROM pagos p 
ORDER BY p.id_pago;

SELECT
    g.id_grupo,
    m.nombre AS materia,
    g.grupo,
    g.cupo_maximo,
    COUNT(i.id_inscripcion) AS alumnos_inscritos
FROM grupos g
INNER JOIN materias m
    ON g.id_materia = m.id_materia
LEFT JOIN inscripciones i
    ON g.id_grupo = i.id_grupo
WHERE i.estado = 'INSCRITO'
GROUP BY
    g.id_grupo,
    m.nombre,
    g.grupo,
    g.cupo_maximo;

SELECT
    e.matricula,
    e.nombre,
    e.apellido,
    p.concepto,
    p.monto,
    p.metodo_pago,
    p.referencia
FROM pagos p
INNER JOIN estudiantes e
    ON p.id_estudiante = e.id_estudiante;


CREATE OR REPLACE FUNCTION validar_rango_calificacion()
RETURNS TRIGGER
AS $$
BEGIN

    IF NEW.calificacion < 0 OR NEW.calificacion > 100 THEN
        RAISE EXCEPTION 'La calificación debe estar entre 0 y 100';
    END IF;

    RETURN NEW;

END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_validar_rango_calificacion
BEFORE INSERT OR UPDATE
ON calificaciones
FOR EACH ROW
EXECUTE FUNCTION validar_rango_calificacion();





CREATE OR REPLACE PROCEDURE cambiar_estado_estudiante(
    p_matricula VARCHAR,
    p_estado VARCHAR
)

LANGUAGE plpgsql
AS $$
BEGIN

    UPDATE estudiantes
    SET estado = p_estado
    WHERE matricula = p_matricula;


    IF NOT FOUND THEN

        RAISE EXCEPTION
        'No existe un estudiante con la matrícula %',
        p_matricula;

    END IF;


    RAISE NOTICE
    'Estado del estudiante actualizado correctamente.';

END;
$$;


CALL cambiar_estado_estudiante(
    '20260001',
    'INACTIVO'
);


/* Verificar */

SELECT
    matricula,
    nombre,
    apellido,
    estado
FROM estudiantes
WHERE matricula = '20260001';


/* Regresarlo a ACTIVO */

CALL cambiar_estado_estudiante(
    '20260001',
    'ACTIVO'
);
