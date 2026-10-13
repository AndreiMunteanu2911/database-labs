/*
ex4
Enunt: Afisati propozitia "Invat PL/SQL" in doua moduri.
Munteanu Andrei
Grupa: 1
*/

VARIABLE g_mesaj VARCHAR2(50)

BEGIN
  :g_mesaj := 'Invat PL/SQL';
END;
/

PRINT g_mesaj

SET SERVEROUTPUT ON

BEGIN
  DBMS_OUTPUT.PUT_LINE('Invat PL/SQL');
END;
/

SET SERVEROUTPUT OFF

/*
G_MESAJ
--------------------------------------------------------------------------------
Invat PL/SQL
Invat PL/SQL
PL/SQL procedure successfully completed.
*/
