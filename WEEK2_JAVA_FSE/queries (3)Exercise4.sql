BEGIN
   BEGIN
      EXECUTE IMMEDIATE '
        CREATE TABLE Customers (
          CustomerID NUMBER PRIMARY KEY,
          Name VARCHAR2(100),
          DOB DATE
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
        CREATE TABLE Loans (
          LoanID NUMBER PRIMARY KEY,
          LoanAmount NUMBER,
          InterestRate NUMBER,
          LoanDurationYears NUMBER
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
        CREATE TABLE Accounts (
          AccountID NUMBER PRIMARY KEY,
          Balance NUMBER
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

-- Customers
INSERT INTO Customers (CustomerID, Name, DOB) VALUES (1, 'John Doe', TO_DATE('1980-01-15','YYYY-MM-DD'));
INSERT INTO Customers (CustomerID, Name, DOB) VALUES (2, 'Jane Smith', TO_DATE('1990-07-25','YYYY-MM-DD'));

-- Loans
INSERT INTO Loans (LoanID, LoanAmount, InterestRate, LoanDurationYears) VALUES (1, 10000, 7, 5);
INSERT INTO Loans (LoanID, LoanAmount, InterestRate, LoanDurationYears) VALUES (2, 5000, 5, 3);

-- Accounts
INSERT INTO Accounts (AccountID, Balance) VALUES (1, 5000);
INSERT INTO Accounts (AccountID, Balance) VALUES (2, 3000);

COMMIT;
/
CREATE OR REPLACE FUNCTION CalculateAge(p_dob DATE) RETURN NUMBER IS
  v_age NUMBER;
BEGIN
  v_age := FLOOR(MONTHS_BETWEEN(SYSDATE, p_dob) / 12);
  RETURN v_age;
END;
/

CREATE OR REPLACE FUNCTION CalculateMonthlyInstallment(
  p_amount NUMBER,
  p_annual_rate NUMBER,
  p_years NUMBER
) RETURN NUMBER IS
  v_monthly_rate NUMBER := p_annual_rate / 12 / 100;
  v_n NUMBER := p_years * 12;
  v_monthly_payment NUMBER;
BEGIN
  IF v_monthly_rate = 0 THEN
    v_monthly_payment := p_amount / v_n;
  ELSE
    v_monthly_payment := p_amount * v_monthly_rate / (1 - POWER(1 + v_monthly_rate, -v_n));
  END IF;

  RETURN ROUND(v_monthly_payment, 2);
END;
/
CREATE OR REPLACE FUNCTION HasSufficientBalance(
  p_accID NUMBER,
  p_amount NUMBER
) RETURN BOOLEAN IS
  v_balance NUMBER;
BEGIN
  SELECT Balance INTO v_balance FROM Accounts WHERE AccountID = p_accID;
  RETURN v_balance >= p_amount;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RETURN FALSE;
END;
/
SELECT CustomerID, Name, TO_CHAR(DOB, 'DD-MON-YYYY') AS DOB, CalculateAge(DOB) AS Age
FROM Customers
ORDER BY CustomerID;
/

