BEGIN
   BEGIN
      EXECUTE IMMEDIATE '
        CREATE TABLE Customers (
          CustomerID NUMBER PRIMARY KEY,
          Name VARCHAR2(100),
          DOB DATE,
          Balance NUMBER,
          LastModified DATE,
          IsVIP VARCHAR2(5)
        )
      ';
      DBMS_OUTPUT.PUT_LINE('Table "Customers" created successfully.');
   EXCEPTION
      WHEN OTHERS THEN
         IF SQLCODE = -955 THEN
            DBMS_OUTPUT.PUT_LINE('Table "Customers" already exists.');
         ELSE
            DBMS_OUTPUT.PUT_LINE('Error creating Customers table: ' || SQLERRM);
         END IF;
   END;
END;
/
BEGIN
   BEGIN
      EXECUTE IMMEDIATE '
        CREATE TABLE Accounts (
          AccountID NUMBER PRIMARY KEY,
          CustomerID NUMBER,
          Balance NUMBER,
          LastModified DATE,
          FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
        )
      ';
      DBMS_OUTPUT.PUT_LINE('Table "Accounts" created successfully.');
   EXCEPTION
      WHEN OTHERS THEN
         IF SQLCODE = -955 THEN
            DBMS_OUTPUT.PUT_LINE('Table "Accounts" already exists.');
         ELSE
            DBMS_OUTPUT.PUT_LINE('Error creating Accounts table: ' || SQLERRM);
         END IF;
   END;
END;
/
CREATE OR REPLACE PROCEDURE SafeTransferFunds(
  p_fromAcc NUMBER,
  p_toAcc NUMBER,
  p_amount NUMBER
) IS
  v_balance NUMBER;
BEGIN
  -- Lock and check source account balance
  SELECT Balance INTO v_balance FROM Accounts WHERE AccountID = p_fromAcc FOR UPDATE;

  IF v_balance < p_amount THEN
    RAISE_APPLICATION_ERROR(-20001, 'Error: Insufficient funds in source account.');
  END IF;

  -- Debit source account
  UPDATE Accounts
  SET Balance = Balance - p_amount,
      LastModified = SYSDATE
  WHERE AccountID = p_fromAcc;

  -- Credit destination account
  UPDATE Accounts
  SET Balance = Balance + p_amount,
      LastModified = SYSDATE
  WHERE AccountID = p_toAcc;

  COMMIT;
  DBMS_OUTPUT.PUT_LINE('Transfer of ' || p_amount || ' completed successfully.');
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    ROLLBACK;
    DBMS_OUTPUT.PUT_LINE('Error: One of the accounts does not exist.');
  WHEN OTHERS THEN
    ROLLBACK;
    DBMS_OUTPUT.PUT_LINE('Error during fund transfer: ' || SQLERRM);
END;
/


-- Add a blank line or comment to separate the two blocks


