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