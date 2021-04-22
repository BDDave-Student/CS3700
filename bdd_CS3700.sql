-- Brandon Dave, Samantha Stetz
-- CS3700:  Final Project
-- The entered data is fictional.

-- Drop Commands 
DROP TABLE SHIPMENT;
DROP TABLE INVOICE;
DROP TABLE PAYMENT;
DROP TABLE DOG;
DROP TABLE DOGFOOD;
DROP TABLE SUPPLIER;
DROP TABLE CUSTOMER;

DROP MATERIALIZED VIEW VWCUSTOMERDOGFAVORITEFOOD;
DROP MATERIALIZED VIEW VWCUSTOMERINVOICEDOGFOOD;

-- Create Commands
CREATE TABLE CUSTOMER(
CustID NUMERIC(10) CONSTRAINT customer_CustID_pk PRIMARY KEY,
CustLast VARCHAR(30),
CustFirst VARCHAR(30)
);

CREATE TABLE SUPPLIER(
SuppID NUMERIC(10) CONSTRAINT supplier_SuppID_pk PRIMARY KEY,
SuppName VARCHAR(30),
SuppCity VARCHAR(30),
SuppState CHAR(2)
);

CREATE TABLE DOGFOOD(
FoodID NUMERIC(10) CONSTRAINT dogfood_FoodID_pk PRIMARY KEY,
FoodBrand VARCHAR(30),
SuppID NUMERIC(10) CONSTRAINT dogfood_SuppID_fk REFERENCES SUPPLIER(SuppID)
);

CREATE TABLE DOG (
DogID NUMERIC(10) CONSTRAINT dog_DogID_pk PRIMARY KEY,
DogName VARCHAR(30),
DogBreed VARCHAR(30),
DogAge NUMERIC(2),
DogWeight NUMERIC(3),
DogImage BLOB,
CustID NUMERIC(15) CONSTRAINT dog_CustID_fk REFERENCES CUSTOMER(CustID),
FoodID NUMERIC(10) CONSTRAINT dog_FoodID_fk REFERENCES DOGFOOD(FoodID)
);

CREATE TABLE PAYMENT (
PayID NUMERIC(10) CONSTRAINT payment_PayID_pk PRIMARY KEY,
PayCardNumber CHAR(4),
PayExpirationDate DATE,
PayType VARCHAR(30),
CustID NUMERIC(10) CONSTRAINT payment_CustID_fk REFERENCES CUSTOMER(CustID)
);

CREATE TABLE INVOICE(
InvoiceID NUMERIC(10) CONSTRAINT invoice_InvoiceID_pk PRIMARY KEY,
InvoiceDate DATE,
InvoiceTotalPrice NUMERIC(6,2), 
CustID NUMERIC(15) CONSTRAINT invoice_CustID_fk REFERENCES CUSTOMER(CustID),
FoodID NUMERIC(10) CONSTRAINT invoice_FoodID_fk REFERENCES DOGFOOD(FoodID),
PayID NUMERIC(10) CONSTRAINT invoice_PayID_fk REFERENCES PAYMENT(PayID)
);

CREATE TABLE SHIPMENT (
ShipID NUMERIC(10) CONSTRAINT shipment_ShipID_pk PRIMARY KEY,
ShipRoadNumber NUMERIC(10),
ShipRoadName VARCHAR(30),
ShipCity VARCHAR(30),
ShipState CHAR(2),
ShipZip CHAR(5),
InvoiceID NUMERIC(10) CONSTRAINT shipment_InvoiceID_fk REFERENCES INVOICE(InvoiceID)
);

-- Insert Commands
-- CUSTOMER(CustID, CustLast, CustFirst)
INSERT INTO CUSTOMER(CustID, CustLast, CustFirst)
VALUES ('01', 'Doe', 'John');
INSERT INTO CUSTOMER(CustID, CustLast, CustFirst)
VALUES ('02', 'Felix', 'Jane');
INSERT INTO CUSTOMER(CustID, CustLast, CustFirst)
VALUES ('03', 'Edgar', 'Greg');
INSERT INTO CUSTOMER(CustID, CustLast, CustFirst)
VALUES ('04', 'Euler', 'Matt');
INSERT INTO CUSTOMER(CustID, CustLast, CustFirst)
VALUES ('05', 'Proof', 'Kristin');

-- SUPPLIER(SuppID, SuppName, SuppCity, SuppState)
INSERT INTO SUPPLIER(SuppID, SuppName, SuppCity, SuppState)
VALUES ('01', 'Barkers Supplies', 'Fairborn', 'OH');
INSERT INTO SUPPLIER(SuppID, SuppName, SuppCity, SuppState)
VALUES ('02', 'Dog Co', 'Beavercreek', 'OH');
INSERT INTO SUPPLIER(SuppID, SuppName, SuppCity, SuppState)
VALUES ('03', 'Paws and More', 'Dayton', 'OH');

-- DOGFOOD(FoodID, FoodBrand, SuppID)
INSERT INTO DOGFOOD(FoodID, FoodBrand, SuppID)
VALUES('01', 'Blue Square', '01');
INSERT INTO DOGFOOD(FoodID, FoodBrand, SuppID)
VALUES('02', 'WeAreFamily', '01');
INSERT INTO DOGFOOD(FoodID, FoodBrand, SuppID)
VALUES('03', 'Furrina', '02');
INSERT INTO DOGFOOD(FoodID, FoodBrand, SuppID)
VALUES('04', 'Special Paws', '02');
INSERT INTO DOGFOOD(FoodID, FoodBrand, SuppID)
VALUES('05', 'Old Paws', '02');
INSERT INTO DOGFOOD(FoodID, FoodBrand, SuppID)
VALUES('06', 'Bedigree', '03');

-- DOG(DogID, DogName, DogBreed, DogAge, DogWeight, DogImage, CustID, FoodID)
INSERT INTO DOG(DogID, DogName, DogBreed, DogAge, DogWeight, DogImage, CustID, FoodID)
vALUES('01', 'Chuckie', 'German Shephard', '06', '68', '', '01', '02');
INSERT INTO DOG(DogID, DogName, DogBreed, DogAge, DogWeight, DogImage, CustID, FoodID)
VALUES('02', 'Bean', 'Golden Retriever', '04', '77', '', '02', '01');
INSERT INTO DOG(DogID, DogName, DogBreed, DogAge, DogWeight, DogImage, CustID, FoodID)
VALUES('03', 'Tommy', 'Poodle', '03', '55', '', '02', '01');
INSERT INTO DOG(DogID, DogName, DogBreed, DogAge, DogWeight, DogImage, CustID, FoodID)
VALUES('04', 'Ralphy', 'Bulldog', '04', '52', '', '03', '02');
INSERT INTO DOG(DogID, DogName, DogBreed, DogAge, DogWeight, DogImage, CustID, FoodID)
VALUES('05', 'Mickey', 'Dachshund', '07', '28', '', '04', '06');
INSERT INTO DOG(DogID, DogName, DogBreed, DogAge, DogWeight, DogImage, CustID, FoodID)
VALUES('06', 'Draco', 'Siberian Husky', '03', '49', '', '05', '04');
INSERT INTO DOG(DogID, DogName, DogBreed, DogAge, DogWeight, DogImage, CustID, FoodID)
VALUES('07', 'Carlos', 'Chihuahua', '02', '04', '', '05', '04');
INSERT INTO DOG(DogID, DogName, DogBreed, DogAge, DogWeight, DogImage, CustID, FoodID)
VALUES('08', 'Mobi', 'Bulldog', '02', '55', '', '03', '02');

-- PAYMENT(PayID, PayCardNumber, PayExpirationDate, PayType, CustID)
INSERT INTO PAYMENT(PayID, PayCardNumber, PayExpirationDate, PayType, CustID)
VALUES('01', '5667', '31-JUL-23', 'VISA', '05');
INSERT INTO PAYMENT(PayID, PayCardNumber, PayExpirationDate, PayType, CustID)
VALUES('02', '7812', '30-APR-20', 'AMEX', '03');
INSERT INTO PAYMENT(PayID, PayCardNumber, PayExpirationDate, PayType, CustID)
VALUES('03', '9090', '31-DEC-23', 'VISA', '02');
INSERT INTO PAYMENT(PayID, PayCardNumber, PayExpirationDate, PayType, CustID)
VALUES('04', '1778', '31-JAN-24', 'AMEX', '01');
INSERT INTO PAYMENT(PayID, PayCardNumber, PayExpirationDate, PayType, CustID)
VALUES('05', '2334', '01-AUG-23', 'VISA', '04');

-- INVOICE(InvoiceID, InvoiceDate, InvoiceTotalPrice, CustID, FoodID, PayID)
INSERT INTO INVOICE(InvoiceID, InvoiceDate, InvoiceTotalPrice, CustID, FoodID, PayID)
VALUES('01', '12-MAR-21', '15.99', '04', '06', '05');
INSERT INTO INVOICE(InvoiceID, InvoiceDate, InvoiceTotalPrice, CustID, FoodID, PayID)
VALUES('02', '01-FEB-21', '23.99', '02', '01', '03');
INSERT INTO INVOICE(InvoiceID, InvoiceDate, InvoiceTotalPrice, CustID, FoodID, PayID)
VALUES('03', '06-JAN-21', '32.95', '05', '04', '01');
INSERT INTO INVOICE(InvoiceID, InvoiceDate, InvoiceTotalPrice, CustID, FoodID, PayID)
VALUES('04', '23-MAR-21', '26.99', '01', '02', '04');
INSERT INTO INVOICE(InvoiceID, InvoiceDate, InvoiceTotalPrice, CustID, FoodID, PayID)
VALUES('05', '01-MAR-21', '23.99', '02', '01', '03');
INSERT INTO INVOICE(InvoiceID, InvoiceDate, InvoiceTotalPrice, CustID, FoodID, PayID)
VALUES('06', '02-APR-21', '18.99', '03', '02', '02');
INSERT INTO INVOICE(InvoiceID, InvoiceDate, InvoiceTotalPrice, CustID, FoodID, PayID)
VALUES('07', '01-APR-21', '23.99', '02', '01', '03');
INSERT INTO INVOICE(InvoiceID, InvoiceDate, InvoiceTotalPrice, CustID, FoodID, PayID)
VALUES('08', '16-APR-21', '20.99', '05', '05', '01');

-- SHIPMENT(ShipID, ShipRoadNumber, ShipRoadName, ShipCity, ShipState, ShipZip, InvoiceID)
INSERT INTO SHIPMENT(ShipID, ShipRoadNumber, ShipRoadName, ShipCity, ShipState, ShipZip, InvoiceID)
VALUES('01', '943', 'Shiny Lane', 'Fairborn', 'OH', '45324', '01');
INSERT INTO SHIPMENT(ShipID, ShipRoadNumber, ShipRoadName, ShipCity, ShipState, ShipZip, InvoiceID)
VALUES('02', '1567', 'Villa Crossing', 'Fairborn', 'OH', '45324', '02');
INSERT INTO SHIPMENT(ShipID, ShipRoadNumber, ShipRoadName, ShipCity, ShipState, ShipZip, InvoiceID)
VALUES('03', '606', 'Faith Road', 'Dayton', 'OH', '45402', '03');
INSERT INTO SHIPMENT(ShipID, ShipRoadNumber, ShipRoadName, ShipCity, ShipState, ShipZip, InvoiceID)
VALUES('04', '788', 'Square Blvd', 'Beavercreek', 'OH', '45435', '04');
INSERT INTO SHIPMENT(ShipID, ShipRoadNumber, ShipRoadName, ShipCity, ShipState, ShipZip, InvoiceID)
VALUES('05', '1567', 'Villa Crossing', 'Fairborn', 'OH', '45324', '05');
INSERT INTO SHIPMENT(ShipID, ShipRoadNumber, ShipRoadName, ShipCity, ShipState, ShipZip, InvoiceID)
VALUES('06', '216', 'Tree Road', 'Beavercreek', 'OH', '45435', '06');
INSERT INTO SHIPMENT(ShipID, ShipRoadNumber, ShipRoadName, ShipCity, ShipState, ShipZip, InvoiceID)
VALUES('07', '1567', 'Villa Crossing', 'Fairborn', 'OH', '45324', '07');
INSERT INTO SHIPMENT(ShipID, ShipRoadNumber, ShipRoadName, ShipCity, ShipState, ShipZip, InvoiceID)
VALUES('08', '606', 'Faith Road', 'Dayton', 'OH', '45402', '03');

SELECT CustFirst, CustLast, DogName, DogBreed, DogWeight, FoodBrand
FROM CUSTOMER, DOG, DOGFOOD
WHERE CUSTOMER.CustID = DOG.CustID
AND DOG.FoodID = DOGFOOD.FoodID
AND DOG.DogWeight >= 50
ORDER BY DogWeight;

Select DOGFOOD.FOODID, DOGFOOD.FOODBRAND, AVG(INVOICETOTALPRICE) as "Quarterly Costs", COUNT(INVOICE.FOODID) as "Amount of times purchased"
From INVOICE, DOGFOOD
WHERE InvoiceDate >= add_months(sysdate, -3)
and INVOICE.FOODID = DOGFOOD.FOODID
GROUP BY DOGFOOD.FOODID, DOGFOOD.FOODBRAND
ORDER BY FOODID;

--  Nested SubQuery
--  Display the highest invoice total price and the city name it was shipped to
SELECT ShipCity, InvoiceTotalPrice
FROM INVOICE, SHIPMENT
WHERE INVOICE.InvoiceID = SHIPMENT.InvoiceID
AND SHIPMENT.ShipCity IN
        	(SELECT ShipCity
        	FROM SHIPMENT, INVOICE
        	WHERE INVOICE.InvoiceID = SHIPMENT.InvoiceID
        	AND TO_CHAR(INVOICE.InvoiceDate, 'MM') = 3 )
AND INVOICE.InvoiceTotalPrice IN
	(SELECT MAX(InvoiceTotalPrice)
	FROM INVOICE
	WHERE TO_CHAR(INVOICE.InvoiceDate, 'MM') = 3 );

--  Create Materialized View
--  Display Customer info along with their dog and the dog's favorite food
CREATE MATERIALIZED VIEW vwCustomerDogFavoriteFood
AS SELECT CustFirst as FIRST_NAME, CustLast as LAST_NAME, DOGNAME as DOG_NAME,
DOGFOOD.FOODBRAND as FAVORITE_FOOD
FROM CUSTOMER, DOG, DOGFOOD
WHERE CUSTOMER.CUSTID = DOG.CUSTID
and DOG.FOODID = DOGFOOD.FOODID
Order by CUSTOMER.CUSTID;

--  Create Materialized View
--  Displays Customer name and their respective invoice with the dog food they purchased
CREATE MATERIALIZED VIEW vwCustomerInvoiceDogFood
AS SELECT CustFirst as FIRST_NAME, CustLast as LAST_NAME, 
INVOICE.INVOICEDATE AS INVOICE_DATE, INVOICE.INVOICETOTALPRICE AS PURCHASE_COSTS,
DOGFOOD.FOODBRAND as PURCHASED_FOOD
FROM CUSTOMER, INVOICE, DOGFOOD
WHERE CUSTOMER.CUSTID = INVOICE.CUSTID
and INVOICE.FOODID = DOGFOOD.FOODID
ORDER BY INVOICEDATE;

--  PL/SQL Statement
--  Automate increment of dog age every year
DECLARE
CURSOR DogAgeCursor IS
SELECT DogName, DogAge
FROM DOG
WHERE DogAge > 5;
DogName DOG.DogName%type;
NewDogAge DOG.DogAge%type;
BEGIN
--Update dog ages to be one year older
UPDATE DOG
SET DogAge = DogAge + 1;
--Intro messages
DBMS_OUTPUT.PUT_LINE('A year has passed!');
DBMS_OUTPUT.PUT_LINE('DOGS OVER 5 YEARS OLD:');
OPEN DogAgeCursor;
LOOP
FETCH DogAgeCursor INTO DogName,NewDogAge;
EXIT WHEN DogAgeCursor%NOTFOUND;
DBMS_OUTPUT.PUT_LINE(DogName||' is now '||NewDogAge||' years old!');
END LOOP;
CLOSE DogAgeCursor;
END;


