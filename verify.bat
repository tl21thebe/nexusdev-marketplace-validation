@echo off

echo Running database verification...

psql -h localhost -p 5433 -U postgres -d marketplace -f queries.sql
pause