/*
ex9
Enunt: Afisati ziua saptamanii prin ambele forme ale instructiunii CASE.
Munteanu Andrei
Grupa: 1
*/

SET SERVEROUTPUT ON
SET VERIFY OFF
ACCEPT p_zi PROMPT 'Introduceti abrevierea zilei (L, M, MI, J, V, S, D): '

DECLARE
  v_zi         VARCHAR2(2) := UPPER('&p_zi');
  v_comentariu VARCHAR2(20);
BEGIN
  CASE v_zi
    WHEN 'L' THEN v_comentariu := 'Luni';
    WHEN 'M' THEN v_comentariu := 'Marti';
    WHEN 'MI' THEN v_comentariu := 'Miercuri';
    WHEN 'J' THEN v_comentariu := 'Joi';
    WHEN 'V' THEN v_comentariu := 'Vineri';
    WHEN 'S' THEN v_comentariu := 'Sambata';
    WHEN 'D' THEN v_comentariu := 'Duminica';
    ELSE v_comentariu := 'eroare';
  END CASE;
  DBMS_OUTPUT.PUT_LINE('CASE simplu: ' || v_comentariu);

  CASE
    WHEN v_zi = 'L' THEN v_comentariu := 'Luni';
    WHEN v_zi = 'M' THEN v_comentariu := 'Marti';
    WHEN v_zi = 'MI' THEN v_comentariu := 'Miercuri';
    WHEN v_zi = 'J' THEN v_comentariu := 'Joi';
    WHEN v_zi = 'V' THEN v_comentariu := 'Vineri';
    WHEN v_zi = 'S' THEN v_comentariu := 'Sambata';
    WHEN v_zi = 'D' THEN v_comentariu := 'Duminica';
    ELSE v_comentariu := 'eroare';
  END CASE;
  DBMS_OUTPUT.PUT_LINE('CASE cautat: ' || v_comentariu);
END;
/

SET SERVEROUTPUT OFF

/*
Introduceti abrevierea zilei (L, M, MI, J, V, S, D): MI
old   2:   v_zi         VARCHAR2(2) := UPPER('&p_zi');
new   2:   v_zi         VARCHAR2(2) := UPPER('MI');
CASE simplu: Miercuri
CASE cautat: Miercuri
*/
