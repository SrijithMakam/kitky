SET SERVEROUTPUT ON;

DECLARE
    V_USER VARCHAR(100);
BEGIN
    SELECT USERNAME INTO V_USER FROM ALL_USERS WHERE USERNAME='KITKY_ADMIN';
    DBMS_OUTPUT.PUT_LINE('USER: KITKY_ADMIN already exists');
EXCEPTION
    WHEN NO_DATA_FOUND THEN
    EXECUTE IMMEDIATE 'CREATE USER KITKY_ADMIN IDENTIFIED BY Admin1234567';
    EXECUTE IMMEDIATE '
    GRANT 
        CONNECT,
        RESOURCE, 
        CREATE USER, 
        DROP USER,
        CREATE ANY VIEW,
        UNLIMITED TABLESPACE
    TO 
        KITKY_ADMIN 
    WITH 
        ADMIN OPTION';
    DBMS_OUTPUT.PUT_LINE ('KITKY_ADMIN created successfully');
END;
/