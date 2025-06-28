BEGIN
   BEGIN
      EXECUTE IMMEDIATE '
        CREATE TABLE Customers (
          CustomerID NUMBER PRIMARY KEY,
          Name VARCHAR2(100)
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
        CREATE TABLE Loans (
          LoanID NUMBER PRIMARY KEY,
          CustomerID NUMBER,
          LoanAmount NUMBER,
          InterestRate NUMBER,
          FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
        )
      ';
      DBMS_OUTPUT.PUT_LINE('Table "Loans" created successfully.');
   EXCEPTION
      WHEN OTHERS THEN
         IF SQLCODE = -955 THEN
            DBMS_OUTPUT.PUT_LINE('Table "Loans" already exists.');
         ELSE
            DBMS_OUTPUT.PUT_LINE('Error creating Loans table: ' || SQLERRM);
         END IF;
   END;
END;
/
BEGIN
   BEGIN
      EXECUTE IMMEDIATE '
        CREATE TABLE Transactions (
          TransactionID NUMBER PRIMARY KEY,
          CustomerID NUMBER,
          Amount NUMBER,
          TransactionDate DATE
        )
      ';
      DBMS_OUTPUT.PUT_LINE('Table "Transactions" created successfully.');
   EXCEPTION
      WHEN OTHERS THEN
         IF SQLCODE = -955 THEN
            DBMS_OUTPUT.PUT_LINE('Table "Transactions" already exists.');
         ELSE
            DBMS_OUTPUT.PUT_LINE('Error creating Transactions table: ' || SQLERRM);
         END IF;
   END;
END;
/
DECLARE
  CURSOR txn_cursor IS
    SELECT t.CustomerID, c.Name, t.TransactionID, t.Amount, t.TransactionDate
    FROM Transactions t
    JOIN Customers c ON t.CustomerID = c.CustomerID
    WHERE TRUNC(t.TransactionDate, 'MM') = TRUNC(SYSDATE, 'MM')
    ORDER BY t.CustomerID, t.TransactionDate;
  
  v_customerID Transactions.CustomerID%TYPE;
  v_name Customers.Name%TYPE;
  v_txnID Transactions.TransactionID%TYPE;
  v_amount Transactions.Amount%TYPE;
  v_date Transactions.TransactionDate%TYPE;
BEGIN
  OPEN txn_cursor;
  LOOP
    FETCH txn_cursor INTO v_customerID, v_name, v_txnID, v_amount, v_date;
    EXIT WHEN txn_cursor%NOTFOUND;

    DBMS_OUTPUT.PUT_LINE('Customer: ' || v_name || ' | TxnID: ' || v_txnID || 
                         ' | Amount: ' || v_amount || ' | Date: ' || TO_CHAR(v_date, 'DD-MON-YYYY'));
  END LOOP;
  CLOSE txn_cursor;
END;
/
DECLARE
  CURSOR acc_cursor IS
    SELECT AccountID, Balance FROM Accounts;
  
  v_accID Accounts.AccountID%TYPE;
  v_balance Accounts.Balance%TYPE;
  v_fee CONSTANT NUMBER := 100;  -- annual fee
BEGIN
  OPEN acc_cursor;
  LOOP
    FETCH acc_cursor INTO v_accID, v_balance;
    EXIT WHEN acc_cursor%NOTFOUND;

    UPDATE Accounts
    SET Balance = Balance - v_fee
    WHERE AccountID = v_accID;
    
    DBMS_OUTPUT.PUT_LINE('Annual fee applied to Account ' || v_accID || '. New balance: ' || (v_balance - v_fee));
  END LOOP;
  CLOSE acc_cursor;

  COMMIT;
END;
/
DECLARE
  CURSOR loan_cursor IS
    SELECT LoanID, InterestRate FROM Loans;
  
  v_loanID Loans.LoanID%TYPE;
  v_oldRate Loans.InterestRate%TYPE;
  v_newRate Loans.InterestRate%TYPE;
BEGIN
  OPEN loan_cursor;
  LOOP
    FETCH loan_cursor INTO v_loanID, v_oldRate;
    EXIT WHEN loan_cursor%NOTFOUND;

    -- Example policy: increase rates by 0.5%
    v_newRate := v_oldRate + 0.5;

    UPDATE Loans
    SET InterestRate = v_newRate
    WHERE LoanID = v_loanID;
    
    DBMS_OUTPUT.PUT_LINE('Loan ' || v_loanID || ': Interest rate updated from ' || v_oldRate || ' to ' || v_newRate);
  END LOOP;
  CLOSE loan_cursor;

  COMMIT;
END;
/
