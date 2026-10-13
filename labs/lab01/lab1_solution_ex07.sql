/*
ex7
Enunt: Clasificati un departament ca mic, mediu sau mare dupa numarul angajatilor.
Munteanu Andrei
Grupa: 1
*/

SET SERVEROUTPUT ON
ACCEPT p_cod_dep PROMPT 'Introduceti codul departamentului: '

DECLARE
  v_cod_dep    departments.department_id%TYPE := &p_cod_dep;
  v_numar      PLS_INTEGER;
  v_comentariu VARCHAR2(10);
BEGIN
  SELECT COUNT(*) INTO v_numar
  FROM employees
  WHERE department_id = v_cod_dep;

  IF v_numar < 10 THEN
    v_comentariu := 'mic';
  ELSIF v_numar BETWEEN 10 AND 30 THEN
    v_comentariu := 'mediu';
  ELSE
    v_comentariu := 'mare';
  END IF;

  DBMS_OUTPUT.PUT_LINE('Departamentul ' || v_cod_dep || ' este ' || v_comentariu);
END;
/

SET SERVEROUTPUT OFF

/*
Introduceti codul departamentului: 90
old   2:   v_cod_dep    departments.department_id%TYPE := &p_cod_dep;
new   2:   v_cod_dep    departments.department_id%TYPE := 90;
Departamentul 90 este mic

PL/SQL procedure successfully completed.

SQL> @lab1_solution_ex07.sql
Introduceti codul departamentului: 80
old   2:   v_cod_dep    departments.department_id%TYPE := &p_cod_dep;
new   2:   v_cod_dep    departments.department_id%TYPE := 80;
Departamentul 80 este mare
*/
