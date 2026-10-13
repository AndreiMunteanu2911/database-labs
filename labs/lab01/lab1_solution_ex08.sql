/*
ex8
Enunt: Actualizati comisionul angajatilor fara comision dintr-un departament si afisati numarul liniilor afectate.
Munteanu Andrei
Grupa: 1
*/

CREATE TABLE emp_pnu AS SELECT * FROM employees;

SET SERVEROUTPUT ON
SET VERIFY OFF
ACCEPT p_cod_dep PROMPT 'Introduceti codul departamentului: '
ACCEPT p_com PROMPT 'Introduceti comisionul procentual (0-100): '

DECLARE
  v_cod_dep emp_pnu.department_id%TYPE := &p_cod_dep;
  v_com     NUMBER := &p_com;
BEGIN
  IF v_com NOT BETWEEN 0 AND 100 THEN
    RAISE_APPLICATION_ERROR(-20001, 'Comisionul trebuie sa fie intre 0 si 100.');
  END IF;

  UPDATE emp_pnu
  SET commission_pct = v_com / 100
  WHERE department_id = v_cod_dep
    AND commission_pct IS NULL;

  IF SQL%ROWCOUNT = 0 THEN
    DBMS_OUTPUT.PUT_LINE('Nici o linie actualizata');
  ELSE
    DBMS_OUTPUT.PUT_LINE(SQL%ROWCOUNT || ' linii actualizate');
  END IF;
END;
/

SET VERIFY ON
SET SERVEROUTPUT OFF

/*
Table created.

Introduceti codul departamentului: 20
Introduceti comisionul procentual (0-100): 5
2 linii actualizate

PL/SQL procedure successfully completed.
*/
