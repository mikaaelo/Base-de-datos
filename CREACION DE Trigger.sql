BEGIN;


UPDATE grupos
SET cupo_maximo = cupo_maximo - 1
WHERE id_grupo = 2;


INSERT INTO inscripciones (
    id_estudiante,
    id_grupo,
    id_periodo,
    estado
)
VALUES (
    3,
    2,
    2,
    'INSCRITO'
);


INSERT INTO pagos (
    id_pago,
    id_estudiante,
    id_periodo,
    concepto,
    monto,
    fecha_pago,
    metodo_pago,
    referencia,
    estado
)
VALUES (
    10,
    3,
    2,
    'Inscripción',
    3500.00,
    CURRENT_TIMESTAMP,
    'Tarjeta',
    'REF010',
    'PAGADO'
);

COMMIT;

SELECT *
FROM inscripciones
WHERE id_estudiante = 3
AND id_grupo = 2;

SELECT *
FROM pagos
WHERE id_pago = 10;

SELECT *
FROM grupos
WHERE id_grupo = 2;


BEGIN;

UPDATE grupos
SET cupo_maximo = cupo_maximo - 1
WHERE id_grupo = 2;

INSERT INTO inscripciones (
    id_estudiante,
    id_grupo,
    id_periodo,
    estado
)
VALUES (
    4,
    3,
    2,
    'INSCRITO'
);

-- fallo:
ROLLBACK;