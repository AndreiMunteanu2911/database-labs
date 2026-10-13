/*
ex12
Enunt: Adaugati coloana stea si afisati o steluta pentru fiecare 100 USD din salariu.
Munteanu Andrei
Grupa: 1
*/

ALTER TABLE emp_pnu ADD stea VARCHAR2(250);

SET SERVEROUTPUT ON
SET VERIFY OFF
ACCEPT p_cod_ang PROMPT 'Dati codul angajatului: '

DECLARE
  v_cod_ang emp_pnu.employee_id%TYPE := &p_cod_ang;
  v_salariu emp_pnu.salary%TYPE;
  v_stea    emp_pnu.stea%TYPE := NULL;
BEGIN
  SELECT salary INTO v_salariu
  FROM emp_pnu
  WHERE employee_id = v_cod_ang;

  FOR i IN 1..TRUNC(v_salariu / 100) LOOP
    v_stea := v_stea || '*';
  END LOOP;

  UPDATE emp_pnu
  SET stea = v_stea
  WHERE employee_id = v_cod_ang;

  COMMIT;
  DBMS_OUTPUT.PUT_LINE('Stelele au fost actualizate pentru angajatul ' || v_cod_ang);
END;
/

SET VERIFY ON
SET SERVEROUTPUT OFF

SELECT employee_id, last_name, salary, stea
FROM emp_pnu
WHERE employee_id = &p_cod_ang;

/*
Dati codul angajatului: 101
Stelele au fost actualizate pentru angajatul 101

PL/SQL procedure successfully completed.

old   3: WHERE employee_id = &p_cod_ang
new   3: WHERE employee_id = 101

EMPLOYEE_ID LAST_NAME                     SALARY
----------- ------------------------- ----------
STEA
--------------------------------------------------------------------------------
        101 Kochhar                        17000
********************************************************************************
********************************************************************************
**********
*/
