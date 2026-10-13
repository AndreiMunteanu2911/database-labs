/*
ex5
Enunt: Afisati orasul departamentului 30 folosind %TYPE, in doua moduri.
Munteanu Andrei
Grupa: 1
*/

SET SERVEROUTPUT ON

DECLARE
  v_oras locations.city%TYPE;
BEGIN
  SELECT l.city
  INTO v_oras
  FROM departments d JOIN locations l ON l.location_id = d.location_id
  WHERE d.department_id = 30;

  DBMS_OUTPUT.PUT_LINE('Orasul este ' || v_oras);
END;
/

SET SERVEROUTPUT OFF

VARIABLE g_oras VARCHAR2(30)

BEGIN
  SELECT l.city
  INTO :g_oras
  FROM departments d JOIN locations l ON l.location_id = d.location_id
  WHERE d.department_id = 30;
END;
/

PRINT g_oras

/*
G_ORAS
--------------------------------------------------------------------------------
Seattle
*/
