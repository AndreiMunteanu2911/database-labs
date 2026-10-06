# Database Labs

Local Oracle environment for the **Sisteme de Baze de Date** university labs.

## Stack

- Docker Desktop
- Oracle Database Free
- CloudBeaver Community
- VS Code
- Oracle SQL Developer extension
- Faculty-provided HR setup scripts

## Project structure

```text
database-labs/
├── compose.yaml
├── .env
├── .gitignore
├── README.md
├── setup/
│   ├── hr_create.sql
│   ├── hr_insert.sql
│   └── hr_project.sql
└── labs/
    └── lab0/
        └── ...
```

## Docker services

### Oracle

```text
Container: database-labs-oracle
Port: 1521
Service name: FREEPDB1
```

### CloudBeaver

```text
Container: database-labs-cloudbeaver
Port: 8978
URL: http://localhost:8978
```

## Secrets / passwords

Passwords are stored only in `.env` and must not be committed.

Example:

```env
ORACLE_PASSWORD=<your-local-oracle-password>
```

`.gitignore` should include:

```gitignore
.env
```

Do not write real passwords in this README, source files, screenshots, or committed configuration.

## Docker networking

From Windows / VS Code / PowerShell:

```text
Host: localhost
Port: 1521
Service name: FREEPDB1
```

From CloudBeaver (inside Docker):

```text
Host: oracle
Port: 1521
Service name: FREEPDB1
```

CloudBeaver must use `oracle`, not `localhost`, because `oracle` is the Docker Compose service hostname.

## Oracle users

### SYSTEM

Use only for administration:

- create users
- grant privileges
- manage tablespace quota
- other privileged tasks

Connection from Windows:

```text
Host: localhost
Port: 1521
Service name: FREEPDB1
Username: SYSTEM
Password: <value from .env>
```

Connection from CloudBeaver:

```text
Host: oracle
Port: 1521
Service name: FREEPDB1
Username: SYSTEM
Password: <value from .env>
```

### GRUPA4052

Normal student/lab schema.

```text
Username: GRUPA4052
Password: <local student password>
```

The faculty HR tables and data were created in this schema.

Connection from Windows:

```text
Host: localhost
Port: 1521
Service name: FREEPDB1
Username: GRUPA4052
Password: <local student password>
```

Connection from CloudBeaver:

```text
Host: oracle
Port: 1521
Service name: FREEPDB1
Username: GRUPA4052
Password: <local student password>
```

Use **Service Name**, not SID.

## Student schema privileges

Equivalent setup:

```sql
CREATE USER grupa4052 IDENTIFIED BY <password>;

GRANT CREATE SESSION TO grupa4052;
GRANT CREATE TABLE TO grupa4052;
GRANT CREATE VIEW TO grupa4052;
GRANT CREATE SEQUENCE TO grupa4052;
GRANT CREATE PROCEDURE TO grupa4052;

ALTER USER grupa4052 QUOTA UNLIMITED ON USERS;
```

The quota is required. Without it, inserts may fail with:

```text
ORA-01950: insufficient quota on tablespace USERS
```

## Faculty setup scripts

Files:

```text
setup/hr_create.sql
setup/hr_insert.sql
setup/hr_project.sql
```

Run them in this order:

```text
1. hr_create.sql
2. hr_insert.sql
3. hr_project.sql
```

They should be executed while connected as `GRUPA4052`.

### hr_create.sql

Creates the HR schema objects, including:

```text
REGIONS
COUNTRIES
LOCATIONS
DEPARTMENTS
JOBS
EMPLOYEES
JOB_HISTORY
JOB_GRADES
```

It also creates constraints, indexes, sequences and `EMP_DETAILS_VIEW`.

### hr_insert.sql

Populates the HR tables with the sample data used in the labs.

### hr_project.sql

Creates and populates:

```text
PROJECT
WORKS_ON
```

These reference employee data, so this script must run after `hr_insert.sql`.

## Running setup scripts with SQL*Plus

Copy scripts into the Oracle container:

```powershell
docker cp .\setup\hr_create.sql database-labs-oracle:/tmp/hr_create.sql
docker cp .\setup\hr_insert.sql database-labs-oracle:/tmp/hr_insert.sql
docker cp .\setup\hr_project.sql database-labs-oracle:/tmp/hr_project.sql
```

Open a shell:

```powershell
docker exec -it database-labs-oracle bash
```

Then:

```bash
cd /tmp
sqlplus grupa4052/<password>@FREEPDB1
```

Run:

```sql
@hr_create.sql
@hr_insert.sql
@hr_project.sql
```

## Verify the schema

Connected as `GRUPA4052`:

```sql
SELECT table_name FROM user_tables ORDER BY table_name;
```

Expected course tables include:

```text
COUNTRIES
DEPARTMENTS
EMPLOYEES
JOB_GRADES
JOBS
JOB_HISTORY
LOCATIONS
PROJECT
REGIONS
WORKS_ON
```

Sanity checks:

```sql
SELECT COUNT(*) FROM employees;
SELECT COUNT(*) FROM departments;
SELECT COUNT(*) FROM jobs;
SELECT COUNT(*) FROM job_history;
SELECT COUNT(*) FROM project;
SELECT COUNT(*) FROM works_on;
```

## CloudBeaver

Open:

```text
http://localhost:8978
```

Recommended connection:

```text
Host: oracle
Port: 1521
Service name: FREEPDB1
Username: GRUPA4052
Password: <local student password>
```

If CloudBeaver reports an error mentioning:

```text
SID FREEPDB1 is not registered
```

the connection is configured as SID instead of Service Name.

Use **Service Name**, or an equivalent JDBC URL:

```text
jdbc:oracle:thin:@//oracle:1521/FREEPDB1
```

## VS Code

Use the Oracle SQL Developer extension.

Recommended connection:

```text
Connection name: Local GRUPA4052
Host: localhost
Port: 1521
Service name: FREEPDB1
Username: GRUPA4052
Password: <local student password>
```

## SQL*Plus terminal access

For plain text output:

```powershell
docker exec -it database-labs-oracle sqlplus grupa4052/<password>@FREEPDB1
```

Useful display settings:

```sql
SET LINESIZE 200
SET PAGESIZE 100
SET TRIMSPOOL ON
```

For interactive terminal pasting, prefer **one-line SQL statements**. Multi-line paste can be interpreted incorrectly by SQL*Plus depending on the terminal/paste behavior.

Example:

```sql
SELECT last_name, department_id FROM employees WHERE department_id IN (10, 30) ORDER BY last_name;
```

`DESC` commands can also be entered one line at a time:

```sql
DESC employees;
```

## Saving SQL*Plus output

Inside SQL*Plus:

```sql
SPOOL lab_output.txt
```

Run queries, then:

```sql
SPOOL OFF
```

## Docker commands

Start:

```powershell
docker compose up -d
```

Status:

```powershell
docker compose ps
```

Oracle logs:

```powershell
docker compose logs -f oracle
```

CloudBeaver logs:

```powershell
docker compose logs -f cloudbeaver
```

Stop:

```powershell
docker compose stop
```

Start existing containers:

```powershell
docker compose start
```

Remove containers/network but preserve volumes:

```powershell
docker compose down
```

Do not use the following unless all local database data should be deleted:

```powershell
docker compose down -v
```

## Persistent data

Named volumes:

```text
database-labs_oracle-data
database-labs_cloudbeaver-data
```

Stopping/recreating containers does not delete the database while these volumes are preserved.

## Existing Docker projects

Another Compose project named `e4e-dev` may run at the same time.

Relevant ports for this project:

```text
1521  Oracle
8978  CloudBeaver
```

## Typical lab workflow

```text
1. docker compose up -d
2. Connect as GRUPA4052
3. Edit lab SQL in VS Code
4. Use CloudBeaver for visual browsing
5. Use SQL*Plus for plain-text output
6. docker compose stop when finished
```

## Notes for future agents

- Database runs locally in Docker.
- Oracle service is `FREEPDB1`.
- Normal student schema is `GRUPA4052`.
- `SYSTEM` is administration-only.
- Faculty scripts have already been executed successfully.
- `GRUPA4052` requires quota on `USERS`.
- Host-side clients use `localhost`.
- Docker-side CloudBeaver uses hostname `oracle`.
- Use Service Name, not SID.
- CloudBeaver is at `http://localhost:8978`.
- Never expose or hard-code real passwords in documentation or committed files.
