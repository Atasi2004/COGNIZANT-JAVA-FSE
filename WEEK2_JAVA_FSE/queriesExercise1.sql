BEGIN
   -- Create Customers table
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
      DBMS_OUTPUT.PUT_LINE('Table created successfully.');
   EXCEPTION
      WHEN OTHERS THEN
         IF SQLCODE = -955 THEN
            DBMS_OUTPUT.PUT_LINE('Table "Customers" already exists.');
         ELSE
            DBMS_OUTPUT.PUT_LINE('Error creating table: ' || SQLERRM);
         END IF;
   END;

   -- Insert customers
   EXECUTE IMMEDIATE 'INSERT INTO Customers (CustomerID, Name, DOB, Balance, LastModified, IsVIP) ' ||
                     'VALUES (1, ''John Doe'', TO_DATE(''1955-03-10'', ''YYYY-MM-DD''), 15000, SYSDATE, ''FALSE'')';

   EXECUTE IMMEDIATE 'INSERT INTO Customers (CustomerID, Name, DOB, Balance, LastModified, IsVIP) ' ||
                     'VALUES (2, ''Jane Smith'', TO_DATE(''1980-07-25'', ''YYYY-MM-DD''), 8000, SYSDATE, ''FALSE'')';

   EXECUTE IMMEDIATE 'INSERT INTO Customers (CustomerID, Name, DOB, Balance, LastModified, IsVIP) ' ||
                     'VALUES (3, ''Robert Brown'', TO_DATE(''1948-12-05'', ''YYYY-MM-DD''), 12000, SYSDATE, ''FALSE'')';

   DBMS_OUTPUT.PUT_LINE('Data inserted successfully.');
END;
/

-- Create and populate Loans table
BEGIN
   BEGIN
      EXECUTE IMMEDIATE '
        CREATE TABLE Loans (
          LoanID NUMBER PRIMARY KEY,
          CustomerID NUMBER,
          LoanAmount NUMBER,
          InterestRate NUMBER,
          StartDate DATE,
          EndDate DATE,
          FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
        )
      ';
      DBMS_OUTPUT.PUT_LINE('Table loans created successfully.');
   EXCEPTION
      WHEN OTHERS THEN
         IF SQLCODE = -955 THEN
            DBMS_OUTPUT.PUT_LINE('Table "Loans" already exists.');
         ELSE
            DBMS_OUTPUT.PUT_LINE('Error creating table: ' || SQLERRM);
         END IF;
   END;

   EXECUTE IMMEDIATE 'INSERT INTO Loans (LoanID, CustomerID, LoanAmount, InterestRate, StartDate, EndDate) VALUES (1, 1, 5000, 5.0, SYSDATE, SYSDATE + 60)';
   EXECUTE IMMEDIATE 'INSERT INTO Loans (LoanID, CustomerID, LoanAmount, InterestRate, StartDate, EndDate) VALUES (2, 2, 7000, 6.0, SYSDATE, SYSDATE + 90)';
   EXECUTE IMMEDIATE 'INSERT INTO Loans (LoanID, CustomerID, LoanAmount, InterestRate, StartDate, EndDate) VALUES (3, 3, 9000, 7.0, SYSDATE, SYSDATE + 20)';

   DBMS_OUTPUT.PUT_LINE('Data inserted successfully.');
END;
/



BEGIN
  FOR rec IN (
    SELECT l.LoanID
    FROM Loans l
    JOIN Customers c ON l.CustomerID = c.CustomerID
    WHERE FLOOR(MONTHS_BETWEEN(SYSDATE, c.DOB)/12) > 60
  ) LOOP
    UPDATE Loans
    SET InterestRate = InterestRate - 1
    WHERE LoanID = rec.LoanID;
  END LOOP;

  COMMIT;
  DBMS_OUTPUT.PUT_LINE('Discount applied to loans of customers older than 60.');
END;
/


BEGIN
  FOR rec IN (
    SELECT CustomerID
    FROM Customers
    WHERE Balance > 10000
  ) LOOP
    UPDATE Customers
    SET IsVIP = 'TRUE'
    WHERE CustomerID = rec.CustomerID;
  END LOOP;

  COMMIT;
  DBMS_OUTPUT.PUT_LINE('VIP status updated for customers with balance over $10,000.');
END;
/


DECLARE
  v_name Customers.Name%TYPE;
BEGIN
  FOR rec IN (
    SELECT l.LoanID, l.CustomerID, l.EndDate
    FROM Loans l
    WHERE l.EndDate BETWEEN SYSDATE AND SYSDATE + 30
  ) LOOP
    SELECT Name INTO v_name FROM Customers WHERE CustomerID = rec.CustomerID;

    DBMS_OUTPUT.PUT_LINE('Reminder: Loan ' || rec.LoanID || ' for customer ' || v_name ||
                         ' is due on ' || TO_CHAR(rec.EndDate, 'DD-MON-YYYY'));
  END LOOP;
END;
/

