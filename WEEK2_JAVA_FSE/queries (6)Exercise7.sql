BEGIN
   BEGIN
      EXECUTE IMMEDIATE '
        CREATE TABLE Customers (
          CustomerID NUMBER PRIMARY KEY,
          Name VARCHAR2(100),
          DOB DATE,
          Balance NUMBER
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
        CREATE TABLE Employees (
          EmployeeID NUMBER PRIMARY KEY,
          Name VARCHAR2(100),
          Position VARCHAR2(50),
          Salary NUMBER,
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
BEGIN
   BEGIN
      EXECUTE IMMEDIATE '
        CREATE TABLE Accounts (
          AccountID NUMBER PRIMARY KEY,
          CustomerID NUMBER,
          Balance NUMBER,
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
CREATE OR REPLACE PACKAGE CustomerManagement IS
  PROCEDURE AddCustomer(p_id NUMBER, p_name VARCHAR2, p_dob DATE, p_balance NUMBER);
  PROCEDURE UpdateCustomer(p_id NUMBER, p_name VARCHAR2, p_dob DATE);
  FUNCTION GetCustomerBalance(p_id NUMBER) RETURN NUMBER;
END;
/
CREATE OR REPLACE PACKAGE BODY CustomerManagement IS
  PROCEDURE AddCustomer(p_id NUMBER, p_name VARCHAR2, p_dob DATE, p_balance NUMBER) IS
  BEGIN
    INSERT INTO Customers (CustomerID, Name, DOB, Balance)
    VALUES (p_id, p_name, p_dob, p_balance);
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Customer added with ID: ' || p_id);
  END;

  PROCEDURE UpdateCustomer(p_id NUMBER, p_name VARCHAR2, p_dob DATE) IS
  BEGIN
    UPDATE Customers SET Name = p_name, DOB = p_dob WHERE CustomerID = p_id;
    IF SQL%ROWCOUNT = 0 THEN
      DBMS_OUTPUT.PUT_LINE('Customer ID ' || p_id || ' not found.');
    ELSE
      COMMIT;
      DBMS_OUTPUT.PUT_LINE('Customer ID ' || p_id || ' updated.');
    END IF;
  END;

  FUNCTION GetCustomerBalance(p_id NUMBER) RETURN NUMBER IS
    v_balance NUMBER;
  BEGIN
    SELECT Balance INTO v_balance FROM Customers WHERE CustomerID = p_id;
    RETURN v_balance;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RETURN NULL;
  END;
END;
/
CREATE OR REPLACE PACKAGE EmployeeManagement IS
  PROCEDURE HireEmployee(p_id NUMBER, p_name VARCHAR2, p_position VARCHAR2, p_salary NUMBER);
  PROCEDURE UpdateEmployee(p_id NUMBER, p_position VARCHAR2, p_salary NUMBER);
  FUNCTION CalculateAnnualSalary(p_id NUMBER) RETURN NUMBER;
END;
/
CREATE OR REPLACE PACKAGE BODY EmployeeManagement IS
  PROCEDURE HireEmployee(p_id NUMBER, p_name VARCHAR2, p_position VARCHAR2, p_salary NUMBER) IS
  BEGIN
    INSERT INTO Employees (EmployeeID, Name, Position, Salary, HireDate)
    VALUES (p_id, p_name, p_position, p_salary, SYSDATE);
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Employee hired with ID: ' || p_id);
  END;

  PROCEDURE UpdateEmployee(p_id NUMBER, p_position VARCHAR2, p_salary NUMBER) IS
  BEGIN
    UPDATE Employees SET Position = p_position, Salary = p_salary WHERE EmployeeID = p_id;
    IF SQL%ROWCOUNT = 0 THEN
      DBMS_OUTPUT.PUT_LINE('Employee ID ' || p_id || ' not found.');
    ELSE
      COMMIT;
      DBMS_OUTPUT.PUT_LINE('Employee ID ' || p_id || ' updated.');
    END IF;
  END;

  FUNCTION CalculateAnnualSalary(p_id NUMBER) RETURN NUMBER IS
    v_salary NUMBER;
  BEGIN
    SELECT Salary INTO v_salary FROM Employees WHERE EmployeeID = p_id;
    RETURN v_salary * 12;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RETURN NULL;
  END;
END;
/
CREATE OR REPLACE PACKAGE AccountOperations IS
  PROCEDURE OpenAccount(p_accID NUMBER, p_custID NUMBER, p_balance NUMBER);
  PROCEDURE CloseAccount(p_accID NUMBER);
  FUNCTION GetTotalCustomerBalance(p_custID NUMBER) RETURN NUMBER;
END;
/
CREATE OR REPLACE PACKAGE BODY AccountOperations IS
  PROCEDURE OpenAccount(p_accID NUMBER, p_custID NUMBER, p_balance NUMBER) IS
  BEGIN
    INSERT INTO Accounts (AccountID, CustomerID, Balance)
    VALUES (p_accID, p_custID, p_balance);
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Account ' || p_accID || ' opened for customer ' || p_custID);
  END;

  PROCEDURE CloseAccount(p_accID NUMBER) IS
  BEGIN
    DELETE FROM Accounts WHERE AccountID = p_accID;
    IF SQL%ROWCOUNT = 0 THEN
      DBMS_OUTPUT.PUT_LINE('Account ID ' || p_accID || ' not found.');
    ELSE
      COMMIT;
      DBMS_OUTPUT.PUT_LINE('Account ID ' || p_accID || ' closed.');
    END IF;
  END;

  FUNCTION GetTotalCustomerBalance(p_custID NUMBER) RETURN NUMBER IS
    v_total NUMBER;
  BEGIN
    SELECT NVL(SUM(Balance),0) INTO v_total FROM Accounts WHERE CustomerID = p_custID;
    RETURN v_total;
  END;
END;
/
