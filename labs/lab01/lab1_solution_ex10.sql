/*
ex10
Enunt: Creati org_tab_pnu si introduceti 70 de inregistrari prin doua metode.
Munteanu Andrei
Grupa: 1
*/

CREATE TABLE org_tab_pnu (
  cod_tab  INTEGER,
  text_tab VARCHAR2(50)
);

DECLARE
  v_contor PLS_INTEGER := 1;
BEGIN
  LOOP
    INSERT INTO org_tab_pnu VALUES (v_contor, 'indice loop');
    v_contor := v_contor + 1;
    EXIT WHEN v_contor > 70;
  END LOOP;
END;
/

SELECT COUNT(*) AS numar_linii_loop FROM org_tab_pnu;

TRUNCATE TABLE org_tab_pnu;

BEGIN
  FOR v_contor IN 1..70 LOOP
    INSERT INTO org_tab_pnu VALUES (v_contor, 'indice for');
  END LOOP;
END;
/

SELECT COUNT(*) AS numar_linii_for FROM org_tab_pnu;

/*
Table created.


PL/SQL procedure successfully completed.


NUMAR_LINII_LOOP
----------------
              70


Table truncated.


PL/SQL procedure successfully completed.


NUMAR_LINII_FOR
---------------
             70
*/
