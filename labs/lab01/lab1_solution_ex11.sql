/*
ex11
Enunt: Actualizati text_tab cu mesajul par sau impar, dupa valoarea cod_tab.
Munteanu Andrei
Grupa: 1
*/

SET SERVEROUTPUT ON

BEGIN
  UPDATE org_tab_pnu
  SET text_tab = CASE
                   WHEN MOD(cod_tab, 2) = 0 THEN 'numar par'
                   ELSE 'numar impar'
                 END;
  DBMS_OUTPUT.PUT_LINE(SQL%ROWCOUNT || ' linii actualizate');
END;
/

SELECT cod_tab, text_tab
FROM org_tab_pnu
ORDER BY cod_tab;

SET SERVEROUTPUT OFF

/*
   COD_TAB TEXT_TAB
---------- --------------------------------------------------
         1 numar impar
         2 numar par
         3 numar impar
         4 numar par
         5 numar impar
         6 numar par
         7 numar impar
         8 numar par
         9 numar impar
        10 numar par
        11 numar impar

   COD_TAB TEXT_TAB
---------- --------------------------------------------------
        12 numar par
        13 numar impar
        14 numar par
        15 numar impar
        16 numar par
        17 numar impar
        18 numar par
        19 numar impar
        20 numar par
        21 numar impar
        22 numar par
70 rows selected.
*/
