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
BEGIN
   BEGIN
      EXECUTE IMMEDIATE '
        CREATE TABLE Employees (
          EmployeeID NUMBER PRIMARY KEY,
          Name VARCHAR2(100),
          Position VARCHAR2(50),
          Salary NUMBER,
          Department VARCHAR2(50),
          HireDate DATE
        )
      ';
      DBMS_OUTPUT.PUT_LINE('Table "Employees" created successfully.');
   EXCEPTION
      WHEN OTHERS THEN
         IF SQLCODE = -955 THEN
            DBMS_OUTPUT.PUT_LINE('Table "Employees" already exists.');
         ELSE
            DBMS_OUTPUT.PUT_LINE('Error creating Employees table: ' || SQLERRM);
         END IF;
   END;
END;
/
INSERT INTO Customers (CustomerID, Name, DOB, Balance, LastModified, IsVIP)
VALUES (1, 'John Doe', TO_DATE('1980-01-15', 'YYYY-MM-DD'), 5000, SYSDATE, 'FALSE');

INSERT INTO Customers (CustomerID, Name, DOB, Balance, LastModified, IsVIP)
VALUES (2, 'Jane Smith', TO_DATE('1975-05-20', 'YYYY-MM-DD'), 8000, SYSDATE, 'FALSE');

INSERT INTO Accounts (AccountID, CustomerID, Balance, LastModified)
VALUES (1, 1, 1000, SYSDATE);

INSERT INTO Accounts (AccountID, CustomerID, Balance, LastModified)
VALUES (2, 2, 500, SYSDATE);

INSERT INTO Employees (EmployeeID, Name, Position, Salary, Department, HireDate)
VALUES (1, 'Alice Johnson', 'Manager', 70000, 'HR', TO_DATE('2015-06-15','YYYY-MM-DD'));

INSERT INTO Employees (EmployeeID, Name, Position, Salary, Department, HireDate)
VALUES (2, 'Bob Brown', 'Developer', 60000, 'IT', TO_DATE('2017-03-20','YYYY-MM-DD'));

COMMIT;
/
CREATE OR REPLACE PROCEDURE SafeTransferFunds(
  p_fromAcc NUMBER,
  p_toAcc NUMBER,
  p_amount NUMBER
) IS
  v_balance NUMBER;
BEGIN
  SELECT Balance INTO v_balance FROM Accounts WHERE AccountID = p_fromAcc FOR UPDATE;

  IF v_balance < p_amount THEN
    RAISE_APPLICATION_ERROR(-20001, 'Error: Insufficient funds in source account.');
  END IF;

  UPDATE Accounts
  SET Balance = Balance - p_amount, LastModified = SYSDATE
  WHERE AccountID = p_fromAcc;

  UPDATE Accounts
  SET Balance = Balance + p_amount, LastModified = SYSDATE
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
CREATE OR REPLACE PROCEDURE UpdateSalary(
  p_empID NUMBER,
  p_percentage NUMBER
) IS
BEGIN
  UPDATE Employees
  SET Salary = Salary * (1 + p_percentage / 100),
      HireDate = HireDate
  WHERE EmployeeID = p_empID;

  IF SQL%ROWCOUNT = 0 THEN
    DBMS_OUTPUT.PUT_LINE('Error: Employee ID ' || p_empID || ' does not exist.');
  ELSE
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Salary updated successfully for employee ID ' || p_empID || '.');
  END IF;
EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    DBMS_OUTPUT.PUT_LINE('Error during salary update: ' || SQLERRM);
END;
/
CREATE OR REPLACE PROCEDURE AddNewCustomer(
  p_id NUMBER,
  p_name VARCHAR2,
  p_dob DATE,
  p_balance NUMBER
) IS
BEGIN
  INSERT INTO Customers (CustomerID, Name, DOB, Balance, LastModified, IsVIP)
  VALUES (p_id, p_name, p_dob, p_balance, SYSDATE, 'FALSE');

  COMMIT;
  DBMS_OUTPUT.PUT_LINE('Customer ' || p_name || ' added successfully with ID ' || p_id || '.');
EXCEPTION
  WHEN DUP_VAL_ON_INDEX THEN
    DBMS_OUTPUT.PUT_LINE('Error: Customer ID ' || p_id || ' already exists.');
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error adding new customer: ' || SQLERRM);
END;
/
BEGIN
  SafeTransferFunds(1, 2, 200);  -- transfer 200 from account 1 to 2
END;
/

BEGIN
  UpdateSalary(1, 10);  -- increase salary of employee 1 by 10%
END;
/

BEGIN
  AddNewCustomer(3, 'Robert Brown', TO_DATE('1990-08-15','YYYY-MM-DD'), 12000);
END;
/
