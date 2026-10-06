--Laborator0_PLSQL.docx

/*
ex12
Enunt: Afisati numele salariatilor si numele departamentelor in care lucreaza. Se vor afisa si salariatii care nu au asociat un departament.
Munteanu Andrei
Grupa: 2
*/
SELECT e.last_name, d.department_name FROM employees e LEFT JOIN departments d ON e.department_id = d.department_id;

/*
LAST_NAME                 JOB_ID         SALARY
------------------------- ---------- ----------
Khoo                      PU_CLERK         3100
Baida                     PU_CLERK         2900
Tobias                    PU_CLERK         2800
Himuro                    PU_CLERK         2600
Colmenares                PU_CLERK         2500
Nayer                     ST_CLERK         3200
Mikkilineni               ST_CLERK         2700
Landry                    ST_CLERK         2400
Markle                    ST_CLERK         2200
Bissot                    ST_CLERK         3300
Atkinson                  ST_CLERK         2800
107 rows selected.
*/

/*
ex13
Enunt: Afisati numele departamentelor si numele salariatilor care lucreaza in ele. Se vor afisa si departamentele care nu au salariati.
Munteanu Andrei
Grupa: 2
*/
SELECT d.department_name, e.last_name FROM departments d LEFT JOIN employees e ON d.department_id = e.department_id;
/*
LAST_NAME                 DEPARTMENT_NAME
------------------------- ------------------------------
Whalen                    Administration
Hartstein                 Marketing
Fay                       Marketing
Raphaely                  Purchasing
Khoo                      Purchasing
Baida                     Purchasing
Tobias                    Purchasing
Himuro                    Purchasing
Colmenares                Purchasing
Mavris                    Human Resources
Weiss                     Shipping
122 rows selected.
*/

/*
ex14
Enunt: Afisati codul angajatului si numele acestuia, impreuna cu numele si codul sefului sau direct.
Munteanu Andrei
Grupa: 2
*/
SELECT e.employee_id, e.last_name AS employee_name, m.last_name AS manager_name, m.employee_id AS manager_id FROM employees e JOIN employees m ON e.manager_id = m.employee_id;

/*
EMPLOYEE_ID EMPLOYEE_NAME             MANAGER_NAME              MANAGER_ID
----------- ------------------------- ------------------------- ----------
        101 Kochhar                   King                             100
        102 De Haan                   King                             100
        114 Raphaely                  King                             100
        120 Weiss                     King                             100
        121 Fripp                     King                             100
        122 Kaufling                  King                             100
        123 Vollman                   King                             100
        124 Mourgos                   King                             100
        145 Russell                   King                             100
        146 Partners                  King                             100
        147 Errazuriz                 King                             100
106 rows selected.
*/

/*
ex15
Enunt: Modificati cererea anterioara pentru a afisa toti salariatii, inclusiv cei care nu au sef.
Munteanu Andrei
Grupa: 2
*/
SELECT e.employee_id, e.last_name AS employee_name, m.last_name AS manager_name, m.employee_id AS manager_id FROM employees e LEFT JOIN employees m ON e.manager_id = m.employee_id;

/*
EMPLOYEE_ID EMPLOYEE_NAME             MANAGER_NAME              MANAGER_ID
----------- ------------------------- ------------------------- ----------
        101 Kochhar                   King                             100
        102 De Haan                   King                             100
        114 Raphaely                  King                             100
        120 Weiss                     King                             100
        121 Fripp                     King                             100
        122 Kaufling                  King                             100
        123 Vollman                   King                             100
        124 Mourgos                   King                             100
        145 Russell                   King                             100
        146 Partners                  King                             100
        147 Errazuriz                 King                             100
107 rows selected.
*/

/*
ex16
Enunt: Obtineti codurile departamentelor in care nu lucreaza nimeni.
Munteanu Andrei
Grupa: 2
*/
SELECT d.department_id FROM departments d WHERE NOT EXISTS (SELECT 1 FROM employees e WHERE e.department_id = d.department_id) ORDER BY d.department_id;

/*
DEPARTMENT_ID
-------------
          120
          130
          140
          150
          160
          170
          180
          190
          200
          210
          220
16 rows selected.
*/

/*
ex17
Enunt: Afisati cel mai mare salariu, cel mai mic salariu, suma si media salariilor tuturor angajatilor. Etichetati coloanele Maxim, Minim, Suma, respectiv Media. Rotunjiti rezultatele.
Munteanu Andrei
Grupa: 2
*/
SELECT ROUND(MAX(salary)) AS "Maxim", ROUND(MIN(salary)) AS "Minim", ROUND(SUM(salary)) AS "Suma", ROUND(AVG(salary)) AS "Media" FROM employees;

/*
     Maxim      Minim       Suma      Media
---------- ---------- ---------- ----------
     24000       2100     691400       6462
*/

/*
ex18
Enunt: Afisati minimul, maximul, suma si media salariilor pentru fiecare job.
Munteanu Andrei
Grupa: 2
*/
SELECT job_id, ROUND(MIN(salary)) AS minim, ROUND(MAX(salary)) AS maxim, ROUND(SUM(salary)) AS suma, ROUND(AVG(salary)) AS media FROM employees GROUP BY job_id ORDER BY job_id;

/*
JOB_ID          MINIM      MAXIM       SUMA      MEDIA
---------- ---------- ---------- ---------- ----------
AC_ACCOUNT       8300       8300       8300       8300
AC_MGR          12000      12000      12000      12000
AD_ASST          4400       4400       4400       4400
AD_PRES         24000      24000      24000      24000
AD_VP           17000      17000      34000      17000
FI_ACCOUNT       6900       9000      39600       7920
FI_MGR          12000      12000      12000      12000
HR_REP           6500       6500       6500       6500
IT_PROG          4200       9000      28800       5760
MK_MAN          13000      13000      13000      13000
MK_REP           6000       6000       6000       6000
19 rows selected.
*/

