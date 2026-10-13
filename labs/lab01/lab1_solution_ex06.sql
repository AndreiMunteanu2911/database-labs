/*
ex6
Enunt: Afisati media salariilor angajatilor departamentului 50.
Munteanu Andrei
Grupa: 1
*/

SET SERVEROUTPUT ON

DECLARE
  v_media_sal employees.salary%TYPE;
  v_dept      NUMBER := 50;
BEGIN
  SELECT AVG(salary)
  INTO v_media_sal
  FROM employees
  WHERE department_id = v_dept;

  DBMS_OUTPUT.PUT_LINE('Media salariilor este ' || v_media_sal);
END;
/

SET SERVEROUTPUT OFF

/*
Media salariilor este 3475.56
*/
