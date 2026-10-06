-- LAB 0 - Solutii SQL
-- Oracle / schema HR
-- Fiecare exercitiu este separat si poate fi rulat individual.
-- Observatie: unele cerinte sunt conceptuale; acolo sunt lasate comentarii sau interogari de inspectie.
--
-- Recomandare: rulati acest fisier conectat la schema in care ati executat
-- hr_create.sql + hr_insert.sql (+ hr_project.sql, daca este necesar).

-- =====================================================================
-- EXERCITIUL 1
-- =====================================================================
-- 1a) Consultarea diagramei HR este o cerinta conceptuala.
--
-- 1b) Afisarea cheilor primare si externe din schema curenta:
SELECT c.table_name,
       c.constraint_name,
       c.constraint_type,
       cc.column_name,
       c.r_constraint_name
FROM user_constraints c
JOIN user_cons_columns cc
  ON cc.constraint_name = c.constraint_name
WHERE c.constraint_type IN ('P', 'R')
ORDER BY c.table_name, c.constraint_type, c.constraint_name, cc.position;

-- Relatiile principale din schema HR:
-- REGIONS(region_id) <- COUNTRIES(region_id)
-- COUNTRIES(country_id) <- LOCATIONS(country_id)
-- LOCATIONS(location_id) <- DEPARTMENTS(location_id)
-- EMPLOYEES(employee_id) <- DEPARTMENTS(manager_id)
-- DEPARTMENTS(department_id) <- EMPLOYEES(department_id)
-- JOBS(job_id) <- EMPLOYEES(job_id)
-- EMPLOYEES(employee_id) <- EMPLOYEES(manager_id) [self-reference]
-- EMPLOYEES(employee_id) <- JOB_HISTORY(employee_id)
-- JOBS(job_id) <- JOB_HISTORY(job_id)
-- DEPARTMENTS(department_id) <- JOB_HISTORY(department_id)

-- =====================================================================
-- EXERCITIUL 2
-- =====================================================================
DESC employees;
DESC departments;
DESC jobs;
DESC job_history;
DESC locations;
DESC countries;
DESC regions;

-- =====================================================================
-- EXERCITIUL 3
-- =====================================================================
SELECT last_name,
       department_id
FROM employees
WHERE department_id IN (10, 30)
ORDER BY last_name;

-- =====================================================================
-- EXERCITIUL 4
-- =====================================================================
SELECT SYSDATE AS data_curenta
FROM dual;

SELECT TO_CHAR(SYSDATE, 'DD-MM-YYYY') AS format_1,
       TO_CHAR(SYSDATE, 'DAY, DD MONTH YYYY') AS format_2,
       TO_CHAR(SYSDATE, 'DD-MON-YYYY HH24:MI:SS') AS format_3,
       TO_CHAR(SYSDATE, 'DDD') AS ziua_din_an
FROM dual;

-- =====================================================================
-- EXERCITIUL 5
-- =====================================================================
-- Varianta 1: foloseste conversia implicita DATE -> text.
-- Rezultatul depinde de NLS_DATE_FORMAT al sesiunii.
SELECT last_name,
       hire_date
FROM employees
WHERE hire_date LIKE '%87%';

-- Varianta 2: formatare explicita, recomandata.
SELECT last_name,
       hire_date
FROM employees
WHERE TO_CHAR(hire_date, 'YYYY') = '1987';

-- =====================================================================
-- EXERCITIUL 6
-- =====================================================================
SELECT last_name,
       job_id
FROM employees
WHERE manager_id IS NULL;

-- =====================================================================
-- EXERCITIUL 7
-- =====================================================================
SELECT last_name,
       salary,
       commission_pct
FROM employees
WHERE commission_pct IS NOT NULL
ORDER BY salary DESC, commission_pct DESC;

-- =====================================================================
-- EXERCITIUL 8
-- =====================================================================
SELECT last_name,
       salary,
       commission_pct
FROM employees
ORDER BY salary DESC, commission_pct DESC;

-- In Oracle, la ORDER BY ... DESC, valorile NULL sunt implicit plasate primele
-- pentru cheia respectiva. Echivalent explicit:
SELECT last_name,
       salary,
       commission_pct
FROM employees
ORDER BY salary DESC, commission_pct DESC NULLS FIRST;

-- =====================================================================
-- EXERCITIUL 9
-- =====================================================================
SELECT last_name
FROM employees
WHERE UPPER(last_name) LIKE '__A%';

-- =====================================================================
-- EXERCITIUL 10
-- =====================================================================
SELECT last_name,
       department_id,
       manager_id
FROM employees
WHERE UPPER(last_name) LIKE '%L%L%'
  AND (department_id = 30 OR manager_id = 102);

-- =====================================================================
-- EXERCITIUL 11
-- =====================================================================
SELECT last_name,
       job_id,
       salary
FROM employees
WHERE (job_id LIKE '%CLERK%' OR job_id LIKE '%REP%')
  AND salary NOT IN (1000, 2000, 3000);

-- =====================================================================
-- EXERCITIUL 12
-- =====================================================================
SELECT e.last_name,
       d.department_name
FROM employees e
LEFT JOIN departments d
  ON d.department_id = e.department_id
ORDER BY e.last_name;

-- =====================================================================
-- EXERCITIUL 13
-- =====================================================================
SELECT d.department_name,
       e.last_name
FROM departments d
LEFT JOIN employees e
  ON e.department_id = d.department_id
ORDER BY d.department_name, e.last_name;

-- =====================================================================
-- EXERCITIUL 14
-- =====================================================================
SELECT e.employee_id,
       e.last_name AS employee_name,
       m.last_name AS manager_name,
       m.employee_id AS manager_id
FROM employees e
JOIN employees m
  ON m.employee_id = e.manager_id
ORDER BY e.employee_id;

-- =====================================================================
-- EXERCITIUL 15
-- =====================================================================
SELECT e.employee_id,
       e.last_name AS employee_name,
       m.last_name AS manager_name,
       m.employee_id AS manager_id
FROM employees e
LEFT JOIN employees m
  ON m.employee_id = e.manager_id
ORDER BY e.employee_id;

-- =====================================================================
-- EXERCITIUL 16
-- =====================================================================
SELECT d.department_id
FROM departments d
WHERE NOT EXISTS (
    SELECT 1
    FROM employees e
    WHERE e.department_id = d.department_id
)
ORDER BY d.department_id;

-- =====================================================================
-- EXERCITIUL 17
-- =====================================================================
SELECT ROUND(MAX(salary)) AS "Maxim",
       ROUND(MIN(salary)) AS "Minim",
       ROUND(SUM(salary)) AS "Suma",
       ROUND(AVG(salary)) AS "Media"
FROM employees;

-- =====================================================================
-- EXERCITIUL 18
-- =====================================================================
SELECT job_id,
       ROUND(MIN(salary)) AS minim,
       ROUND(MAX(salary)) AS maxim,
       ROUND(SUM(salary)) AS suma,
       ROUND(AVG(salary)) AS media
FROM employees
GROUP BY job_id
ORDER BY job_id;

-- =====================================================================
-- EXERCITIUL 19
-- =====================================================================
SELECT job_id,
       COUNT(*) AS numar_angajati
FROM employees
GROUP BY job_id
ORDER BY job_id;

-- =====================================================================
-- EXERCITIUL 20
-- =====================================================================
SELECT d.department_name AS departament,
       l.city AS locatie,
       COUNT(e.employee_id) AS numar_angajati,
       ROUND(AVG(e.salary), 2) AS salariu_mediu
FROM departments d
JOIN locations l
  ON l.location_id = d.location_id
LEFT JOIN employees e
  ON e.department_id = d.department_id
GROUP BY d.department_id, d.department_name, l.city
ORDER BY d.department_id;

-- =====================================================================
-- EXERCITIUL 21
-- =====================================================================
SELECT d.department_id,
       d.department_name,
       SUM(e.salary) AS suma_salarii
FROM departments d
JOIN employees e
  ON e.department_id = d.department_id
GROUP BY d.department_id, d.department_name
ORDER BY d.department_id;

-- =====================================================================
-- EXERCITIUL 22
-- =====================================================================
SELECT employee_id,
       last_name,
       salary
FROM employees
WHERE salary > (
    SELECT AVG(salary)
    FROM employees
)
ORDER BY salary DESC;

-- =====================================================================
-- EXERCITIUL 23
-- =====================================================================
SELECT MIN(AVG(salary)) AS salariu_mediu_minim
FROM employees
GROUP BY job_id;

-- =====================================================================
-- EXERCITIUL 24
-- =====================================================================
SELECT job_id,
       ROUND(AVG(salary), 2) AS salariu_mediu
FROM employees
GROUP BY job_id
HAVING AVG(salary) = (
    SELECT MIN(AVG(salary))
    FROM employees
    GROUP BY job_id
);

-- =====================================================================
-- EXERCITIUL 25.1
-- =====================================================================
SELECT d.department_id,
       d.department_name,
       COUNT(e.employee_id) AS numar_angajati
FROM departments d
LEFT JOIN employees e
  ON e.department_id = d.department_id
GROUP BY d.department_id, d.department_name
HAVING COUNT(e.employee_id) < 4
ORDER BY d.department_id;

-- =====================================================================
-- EXERCITIUL 25.2
-- =====================================================================
WITH department_counts AS (
    SELECT d.department_id,
           d.department_name,
           COUNT(e.employee_id) AS numar_angajati
    FROM departments d
    LEFT JOIN employees e
      ON e.department_id = d.department_id
    GROUP BY d.department_id, d.department_name
)
SELECT department_id,
       department_name,
       numar_angajati
FROM department_counts
WHERE numar_angajati = (
    SELECT MAX(numar_angajati)
    FROM department_counts
);

-- =====================================================================
-- EXERCITIUL 26
-- =====================================================================
SELECT COUNT(*) AS numar_departamente
FROM (
    SELECT department_id
    FROM employees
    WHERE department_id IS NOT NULL
    GROUP BY department_id
    HAVING COUNT(*) >= 15
);

-- =====================================================================
-- EXERCITIUL 27
-- =====================================================================
SELECT employee_id,
       first_name,
       last_name,
       hire_date
FROM employees
WHERE EXTRACT(DAY FROM hire_date) IN (
    SELECT zi
    FROM (
        SELECT EXTRACT(DAY FROM hire_date) AS zi,
               COUNT(*) AS nr_angajari
        FROM employees
        GROUP BY EXTRACT(DAY FROM hire_date)
    )
    WHERE nr_angajari = (
        SELECT MAX(nr_angajari)
        FROM (
            SELECT COUNT(*) AS nr_angajari
            FROM employees
            GROUP BY EXTRACT(DAY FROM hire_date)
        )
    )
)
ORDER BY hire_date, employee_id;

-- =====================================================================
-- EXERCITIUL 28 - metoda 1: subinterogare corelata
-- =====================================================================
SELECT e.department_id,
       e.last_name,
       e.salary
FROM employees e
WHERE e.salary = (
    SELECT MIN(e2.salary)
    FROM employees e2
    WHERE e2.department_id = e.department_id
)
ORDER BY e.department_id, e.last_name;

-- EXERCITIUL 28 - metoda 2: functie analitica
SELECT department_id,
       last_name,
       salary
FROM (
    SELECT e.department_id,
           e.last_name,
           e.salary,
           DENSE_RANK() OVER (
               PARTITION BY e.department_id
               ORDER BY e.salary
           ) AS pozitie
    FROM employees e
    WHERE e.department_id IS NOT NULL
)
WHERE pozitie = 1
ORDER BY department_id, last_name;

-- =====================================================================
-- EXERCITIUL 29
-- =====================================================================
SELECT employee_id,
       first_name,
       last_name,
       salary
FROM employees
ORDER BY salary DESC
FETCH FIRST 10 ROWS ONLY;

-- =====================================================================
-- EXERCITIUL 30
-- =====================================================================
SELECT e.*
FROM employees e
WHERE e.salary > (
    SELECT AVG(e2.salary)
    FROM employees e2
    WHERE e2.department_id = e.department_id
)
ORDER BY e.department_id, e.salary DESC;

-- =====================================================================
-- EXERCITIUL 31
-- =====================================================================
-- Interpretare pe baza schemei disponibile:
-- fiecare inregistrare din JOB_HISTORY reprezinta o schimbare istorica de job.
SELECT e.employee_id,
       e.first_name,
       e.last_name,
       COUNT(jh.employee_id) AS numar_schimbari_job
FROM employees e
LEFT JOIN job_history jh
  ON jh.employee_id = e.employee_id
GROUP BY e.employee_id, e.first_name, e.last_name
ORDER BY e.employee_id;

-- =====================================================================
-- EXERCITIUL 32
-- =====================================================================
-- Cerinta solicita istoricul salariilor pentru acelasi job.
-- In schema HR furnizata, JOB_HISTORY nu contine o coloana de salariu,
-- iar EMPLOYEES contine doar salariul curent. Prin urmare, cerinta nu
-- poate fi determinata corect exclusiv din tabelele HR furnizate.
--
-- Verificare structura:
DESC job_history;
DESC employees;

-- =====================================================================
-- EXERCITIUL 33
-- =====================================================================
SELECT e.department_id,
       e.employee_id,
       e.first_name,
       e.last_name,
       e.job_id,
       e.salary
FROM employees e
WHERE e.salary = (
    SELECT MAX(e2.salary)
    FROM employees e2
    WHERE e2.department_id = e.department_id
)
ORDER BY e.department_id, e.employee_id;

-- =====================================================================
-- EXERCITIUL 34.1
-- Primele 2 zile din luna curenta.
-- =====================================================================
SELECT d.zi,
       COUNT(e.employee_id) AS numar_angajari
FROM (
    SELECT TRUNC(SYSDATE, 'MM') + LEVEL - 1 AS zi
    FROM dual
    CONNECT BY LEVEL <= 2
) d
LEFT JOIN employees e
  ON TRUNC(e.hire_date) = d.zi
GROUP BY d.zi
ORDER BY d.zi;

-- =====================================================================
-- EXERCITIUL 34.2
-- Doar zilele din luna curenta in care au existat angajari.
-- =====================================================================
SELECT TRUNC(hire_date) AS zi,
       COUNT(*) AS numar_angajari
FROM employees
WHERE hire_date >= TRUNC(SYSDATE, 'MM')
  AND hire_date < ADD_MONTHS(TRUNC(SYSDATE, 'MM'), 1)
GROUP BY TRUNC(hire_date)
ORDER BY zi;

-- =====================================================================
-- EXERCITIUL 34.3
-- Toate zilele lunii curente, inclusiv cele fara angajari.
-- =====================================================================
SELECT d.zi,
       COUNT(e.employee_id) AS numar_angajari
FROM (
    SELECT TRUNC(SYSDATE, 'MM') + LEVEL - 1 AS zi
    FROM dual
    CONNECT BY LEVEL <= EXTRACT(DAY FROM LAST_DAY(SYSDATE))
) d
LEFT JOIN employees e
  ON TRUNC(e.hire_date) = d.zi
GROUP BY d.zi
ORDER BY d.zi;
