--Laborator0_PLSQL.docx

/*
ex1
Enunt: Consultati diagrama HR. Identificati cheile primare/externe si tipurile relatiilor.
Munteanu Andrei
Grupa: 2

Rezolvare:

Chei primare:
- REGIONS: region_id
- COUNTRIES: country_id
- LOCATIONS: location_id
- DEPARTMENTS: department_id
- JOBS: job_id
- EMPLOYEES: employee_id
- JOB_HISTORY: (employee_id, start_date)

Chei externe:
- COUNTRIES.region_id -> REGIONS.region_id
- LOCATIONS.country_id -> COUNTRIES.country_id
- DEPARTMENTS.location_id -> LOCATIONS.location_id
- DEPARTMENTS.manager_id -> EMPLOYEES.employee_id
- EMPLOYEES.department_id -> DEPARTMENTS.department_id
- EMPLOYEES.job_id -> JOBS.job_id
- EMPLOYEES.manager_id -> EMPLOYEES.employee_id
- JOB_HISTORY.employee_id -> EMPLOYEES.employee_id
- JOB_HISTORY.job_id -> JOBS.job_id
- JOB_HISTORY.department_id -> DEPARTMENTS.department_id

Tipuri de relatii:
- REGIONS 1:N COUNTRIES
- COUNTRIES 1:N LOCATIONS
- LOCATIONS 1:N DEPARTMENTS
- DEPARTMENTS 1:N EMPLOYEES
- JOBS 1:N EMPLOYEES
- EMPLOYEES 1:N EMPLOYEES (relatie recursiva manager-subordonati)
- EMPLOYEES 1:N JOB_HISTORY
- JOBS 1:N JOB_HISTORY
- DEPARTMENTS 1:N JOB_HISTORY
- EMPLOYEES 1:N DEPARTMENTS prin manager_id
*/

/*
ex2
Enunt: Listati structura tabelelor HR: EMPLOYEES, DEPARTMENTS, JOBS, JOB_HISTORY, LOCATIONS, COUNTRIES, REGIONS.
Munteanu Andrei
Grupa: 2
*/
DESC employees;
DESC departments;
DESC jobs;
DESC job_history;
DESC locations;
DESC countries;
DESC regions;

/*
SQL> Name                                         Null?    Type
 ----------------------------------------- -------- ----------------------------
 EMPLOYEE_ID                               NOT NULL NUMBER(6)
 FIRST_NAME                                         VARCHAR2(20)
 LAST_NAME                                 NOT NULL VARCHAR2(25)
 EMAIL                                     NOT NULL VARCHAR2(25)
 PHONE_NUMBER                                       VARCHAR2(20)
 HIRE_DATE                                 NOT NULL DATE
 JOB_ID                                    NOT NULL VARCHAR2(10)
 SALARY                                             NUMBER(8,2)
 COMMISSION_PCT                                     NUMBER(2,2)
 MANAGER_ID                                         NUMBER(6)
 DEPARTMENT_ID                                      NUMBER(4)

SQL>  Name                                         Null?    Type
 ----------------------------------------- -------- ----------------------------
 DEPARTMENT_ID                             NOT NULL NUMBER(4)
 DEPARTMENT_NAME                           NOT NULL VARCHAR2(30)
 MANAGER_ID                                         NUMBER(6)
 LOCATION_ID                                        NUMBER(4)

SQL>  Name                                         Null?    Type
 ----------------------------------------- -------- ----------------------------
 JOB_ID                                    NOT NULL VARCHAR2(10)
 JOB_TITLE                                 NOT NULL VARCHAR2(35)
 MIN_SALARY                                         NUMBER(6)
 MAX_SALARY                                         NUMBER(6)

SQL>  Name                                         Null?    Type
 ----------------------------------------- -------- ----------------------------
 EMPLOYEE_ID                               NOT NULL NUMBER(6)
 START_DATE                                NOT NULL DATE
 END_DATE                                  NOT NULL DATE
 JOB_ID                                    NOT NULL VARCHAR2(10)
 DEPARTMENT_ID                                      NUMBER(4)

SQL>  Name                                         Null?    Type
 ----------------------------------------- -------- ----------------------------
 LOCATION_ID                               NOT NULL NUMBER(4)
 STREET_ADDRESS                                     VARCHAR2(40)
 POSTAL_CODE                                        VARCHAR2(12)
 CITY                                      NOT NULL VARCHAR2(30)
 STATE_PROVINCE                                     VARCHAR2(25)
 COUNTRY_ID                                         CHAR(2)

SQL>  Name                                         Null?    Type
 ----------------------------------------- -------- ----------------------------
 COUNTRY_ID                                NOT NULL CHAR(2)
 COUNTRY_NAME                                       VARCHAR2(40)
 REGION_ID                                          NUMBER
*/

/*
ex3
Enunt: Afisati numele salariatilor si codul departamentelor pentru angajatii din departamentele 10 si 30, alfabetic.
Munteanu Andrei
Grupa: 2
*/
SELECT last_name, department_id FROM employees WHERE department_id IN (10, 30) ORDER BY last_name;

/*
LAST_NAME                 DEPARTMENT_ID
------------------------- -------------
Baida                                30
Colmenares                           30
Himuro                               30
Khoo                                 30
Raphaely                             30
Tobias                               30
Whalen                               10

7 rows selected.
*/

/*
ex4
Enunt: Afisati data curenta in diferite formate.
Munteanu Andrei
Grupa: 2
*/
SELECT SYSDATE FROM dual;
SELECT TO_CHAR(SYSDATE,'DD-MM-YYYY') AS data1, TO_CHAR(SYSDATE,'DD-MON-YYYY HH24:MI:SS') AS data2 FROM dual;

/*
SYSDATE
---------
06-OCT-26

DATA1      DATA2
---------- -----------------------------
06-10-2026 06-OCT-2026 08:23:44
*/

/*
ex5
Enunt: Afisati numele si data angajarii pentru salariatii angajati in 1987, in 2 variante.
Munteanu Andrei
Grupa: 2
*/
SELECT last_name, hire_date FROM employees WHERE hire_date LIKE '%87%';
SELECT last_name, hire_date FROM employees WHERE TO_CHAR(hire_date,'YYYY')='1987';

/*
LAST_NAME                 HIRE_DATE
------------------------- ---------
King                      17-JUN-87
*/

/*
ex6
Enunt: Afisati numele si job-ul angajatilor care nu au manager.
Munteanu Andrei
Grupa: 2
*/
SELECT last_name, job_id FROM employees WHERE manager_id IS NULL;

/*
LAST_NAME                 JOB_ID
------------------------- ----------
King                      AD_PRES
*/

/*
ex7
Enunt: Afisati numele, salariul si comisionul celor care castiga comision; sortati descrescator dupa salariu si comision.
Munteanu Andrei
Grupa: 2
*/
SELECT last_name, salary, commission_pct FROM employees WHERE commission_pct IS NOT NULL ORDER BY salary DESC, commission_pct DESC;

/*
LAST_NAME                     SALARY COMMISSION_PCT
------------------------- ---------- --------------
Russell                        14000             .4
Partners                       13500             .3
Errazuriz                      12000             .3
Ozer                           11500            .25
Cambrault                      11000             .3
Abel                           11000             .3
Vishney                        10500            .25
Zlotkey                        10500             .2
King                           10000            .35
...................................................

35 rows selected.
*/

/*
ex8
Enunt: Eliminati WHERE din cererea anterioara. Unde sunt plasate valorile NULL in ordinea descrescatoare?
Munteanu Andrei
Grupa: 2
*/
SELECT last_name, salary, commission_pct FROM employees ORDER BY salary DESC, commission_pct DESC;
-- In Oracle, pentru ORDER BY ... DESC, valorile NULL sunt plasate implicit primele pentru coloana respectiva.

/*
LAST_NAME                     SALARY COMMISSION_PCT
------------------------- ---------- --------------
Russell                        14000             .4
Partners                       13500             .3
Errazuriz                      12000             .3
Ozer                           11500            .25
Cambrault                      11000             .3
Abel                           11000             .3
Vishney                        10500            .25
Zlotkey                        10500             .2
King                           10000            .35
Tucker                         10000             .3
Bloom                          10000             .2
107 rows selected.
*/

/*
ex9
Enunt: Listati numele angajatilor care au a treia litera din nume 'A'.
Munteanu Andrei
Grupa: 2
*/
SELECT last_name FROM employees WHERE UPPER(last_name) LIKE '__A%';

/*
LAST_NAME
-------------------------
Grant
Grant
Whalen
*/

/*
ex10
Enunt: Listati angajatii cu 2 litere 'L' in nume si care lucreaza in dept. 30 sau au managerul 102.
Munteanu Andrei
Grupa: 2
*/
SELECT last_name FROM employees WHERE UPPER(last_name) LIKE '%L%L%' AND (department_id=30 OR manager_id=102);

/*
no rows selected
*/

/*
ex11
Enunt: Afisati numele, job-ul si salariul celor cu job continand CLERK sau REP si salariu diferit de 1000, 2000, 3000.
Munteanu Andrei
Grupa: 2
*/
SELECT last_name, job_id, salary FROM employees WHERE (job_id LIKE '%CLERK%' OR job_id LIKE '%REP%') AND salary NOT IN (1000,2000,3000);

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
...............................................

76 rows selected.
*/
