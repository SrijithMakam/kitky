SET SERVEROUTPUT ON;
-- Stored Procedure to add feedback,rating,tips

CREATE OR REPLACE PROCEDURE ADD_FEEDBACK (
    PI_ORDER_ID NUMBER,
    PI_FEEDBACK VARCHAR2,
    PI_RATING NUMBER,
    PI_TIPS NUMBER
)
AS
    INVALID_ORDER EXCEPTION;
    V_ORDER_ID NUMBER;
BEGIN
    SELECT COUNT(ORDER_ID) INTO V_ORDER_ID FROM ORDERS WHERE ORDER_ID = PI_ORDER_ID;

    IF V_ORDER_ID = 0 THEN
        RAISE INVALID_ORDER;
    END IF;

    UPDATE ORDERS 
    SET FEEDBACK = INITCAP(PI_FEEDBACK),
        RATING = PI_RATING,
        TIP_TO_AGENT = PI_TIPS
    WHERE ORDER_ID = PI_ORDER_ID;

    COMMIT;
    DBMS_OUTPUT.PUT_LINE('FEEDBACK ADDED SUCCESSFULLY');
EXCEPTION
    WHEN INVALID_ORDER THEN
        DBMS_OUTPUT.PUT_LINE('Order_id not found');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
END ADD_FEEDBACK;
/

--EXEC ADD_FEEDBACK(4,'GOOD JOB', 5,6);


--Stored procedure to add agent id (matching driver)
CREATE OR REPLACE PROCEDURE MATCH_DRIVER(PI_ORDER_ID NUMBER, PI_AGENT_ID NUMBER)
AS
    INVALID_AGENT EXCEPTION;
    V_AGENT_ID NUMBER;
BEGIN
    SELECT COUNT(AGENT_ID) INTO V_AGENT_ID FROM DELIVERY_AGENT WHERE AGENT_ID = PI_AGENT_ID;

    IF V_AGENT_ID = 0 THEN
        RAISE INVALID_AGENT;
    END IF;

    UPDATE ORDERS 
    SET AGENT_ID = PI_AGENT_ID
    WHERE ORDER_ID = PI_ORDER_ID;

    COMMIT;
    DBMS_OUTPUT.PUT_LINE('AGENT MATCHED SUCCESSFULLY');
EXCEPTION
    WHEN INVALID_AGENT THEN
        DBMS_OUTPUT.PUT_LINE('AGENT NOT FOUND');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
END MATCH_DRIVER;
/

--EXEC MATCH_DRIVER(5,9);

