--alter session set "_oracle_script"=true;
--drop user SSPY CASCADE;

alter session set "_oracle_script"=true;
create user SSPY identified by java;
grant connect, resource, unlimited tablespace to SSPY;
conn SSPY/java;

