DROP      DATABASE IF EXISTS UTILITY_BILLING_MANAGEMENT_SYSTEM;

CREATE    DATABASE UTILITY_BILLING_MANAGEMENT_SYSTEM;

USE       UTILITY_BILLING_MANAGEMENT_SYSTEM;

-- =============================================
-- 2. CUSTOMER
-- =============================================
CREATE    TABLE CUSTOMER (
          CustomerID VARCHAR(20) PRIMARY KEY,
          FirstName VARCHAR(30) NOT NULL,
          LastName VARCHAR(30),
          PhoneNumber BIGINT NOT NULL,
          Email VARCHAR(50),
          ServiceAddress VARCHAR(50),
          City VARCHAR(30),
          ZipCode INT,
          AccountStatus VARCHAR(10)
          );

INSERT    INTO CUSTOMER (CustomerID, FirstName, LastName, PhoneNumber, Email, ServiceAddress, City, ZipCode, AccountStatus)
VALUES    ('CUST-0001', 'Ali', 'Khan', 3001234501, 'ali.khan1@example.com', '123 Main St', 'Karachi', 74400, 'Active'),
          ('CUST-0002', 'Sara', 'Ahmed', 3001234502, 'sara.ahmed2@example.com', '45 Park Ave', 'Lahore', 54000, 'Active'),
          ('CUST-0003', 'Hassan', 'Ali', 3001234503, 'hassan.ali3@example.com', '12 Palm Rd', 'Islamabad', 44000, 'Active'),
          ('CUST-0004', 'Ayesha', 'Khan', 3001234504, 'ayesha.khan4@example.com', '78 Lake St', 'Karachi', 74400, 'Active'),
          ('CUST-0005', 'Bilal', 'Ahmed', 3001234505, 'bilal.ahmed5@example.com', '56 Hill Rd', 'Lahore', 54000, 'Active'),
          ('CUST-0006', 'Zainab', 'Shah', 3001234506, 'zainab.shah6@example.com', '23 River St', 'Islamabad', 44000, 'Active'),
          ('CUST-0007', 'Omar', 'Khan', 3001234507, 'omar.khan7@example.com', '89 Park Ave', 'Karachi', 74400, 'Active'),
          ('CUST-0008', 'Fatima', 'Ali', 3001234508, 'fatima.ali8@example.com', '34 Main St', 'Lahore', 54000, 'Active'),
          ('CUST-0009', 'Imran', 'Shah', 3001234509, 'imran.shah9@example.com', '67 Lake St', 'Islamabad', 44000, 'Active'),
          ('CUST-0010', 'Noor', 'Ahmed', 3001234510, 'noor.ahmed10@example.com', '11 Palm Rd', 'Karachi', 74400, 'Active'),
          ('CUST-0011', 'Sami', 'Khan', 3001234511, 'sami.khan11@example.com', '22 Hill Rd', 'Lahore', 54000, 'Active'),
          ('CUST-0012', 'Hina', 'Ali', 3001234512, 'hina.ali12@example.com', '45 River St', 'Islamabad', 44000, 'Active'),
          ('CUST-0013', 'Ayan', 'Shah', 3001234513, 'ayan.shah13@example.com', '56 Main St', 'Karachi', 74400, 'Active'),
          ('CUST-0014', 'Maryam', 'Khan', 3001234514, 'maryam.khan14@example.com', '78 Park Ave', 'Lahore', 54000, 'Active'),
          ('CUST-0015', 'Danish', 'Ahmed', 3001234515, 'danish.ahmed15@example.com', '89 Lake St', 'Islamabad', 44000, 'Active'),
          ('CUST-0016', 'Eman', 'Shah', 3001234516, 'eman.shah16@example.com', '12 Palm Rd', 'Karachi', 74400, 'Active'),
          ('CUST-0017', 'Raheel', 'Ali', 3001234517, 'raheel.ali17@example.com', '34 Hill Rd', 'Lahore', 54000, 'Active'),
          ('CUST-0018', 'Saba', 'Khan', 3001234518, 'saba.khan18@example.com', '56 River St', 'Islamabad', 44000, 'Active'),
          ('CUST-0019', 'Tariq', 'Ahmed', 3001234519, 'tariq.ahmed19@example.com', '78 Main St', 'Karachi', 74400, 'Active'),
          ('CUST-0020', 'Areeba', 'Shah', 3001234520, 'areeba.shah20@example.com', '11 Park Ave', 'Lahore', 54000, 'Active'),
          ('CUST-0021', 'Shahbaz', 'Khan', 3001234521, 'shahbaz.khan21@example.com', '22 Lake St', 'Islamabad', 44000, 'Active'),
          ('CUST-0022', 'Hadia', 'Ali', 3001234522, 'hadia.ali22@example.com', '33 Palm Rd', 'Karachi', 74400, 'Active'),
          ('CUST-0023', 'Asim', 'Shah', 3001234523, 'asim.shah23@example.com', '44 Hill Rd', 'Lahore', 54000, 'Active'),
          ('CUST-0024', 'Lina', 'Ahmed', 3001234524, 'lina.ahmed24@example.com', '55 River St', 'Islamabad', 44000, 'Active'),
          ('CUST-0025', 'Fawad', 'Khan', 3001234525, 'fawad.khan25@example.com', '66 Main St', 'Karachi', 74400, 'Active'),
          ('CUST-0026', 'Nida', 'Shah', 3001234526, 'nida.shah26@example.com', '77 Park Ave', 'Lahore', 54000, 'Active'),
          ('CUST-0027', 'Junaid', 'Ali', 3001234527, 'junaid.ali27@example.com', '88 Lake St', 'Islamabad', 44000, 'Active'),
          ('CUST-0028', 'Rida', 'Khan', 3001234528, 'rida.khan28@example.com', '99 Palm Rd', 'Karachi', 74400, 'Active'),
          ('CUST-0029', 'Shahid', 'Ahmed', 3001234529, 'shahid.ahmed29@example.com', '21 Hill Rd', 'Lahore', 54000, 'Active'),
          ('CUST-0030', 'Zoya', 'Aziz', 3001234530, 'zoya.aziz30@example.com', '14 Palm Rd', 'Islamabad', 44000, 'Active');

-- =============================================
-- ACCOUNT (Created without MeterID FK first)
-- =============================================
CREATE    TABLE ACCOUNT (
          AccountID VARCHAR(20) PRIMARY KEY,
          CustomerID VARCHAR(20),
          UtilityType VARCHAR(20),
          ServiceStartDate DATE NOT NULL,
          FOREIGN KEY (CustomerID) REFERENCES CUSTOMER (CustomerID)
          );

INSERT    INTO ACCOUNT (AccountID, CustomerID, UtilityType, ServiceStartDate)
VALUES    ('ACC-0001', 'CUST-0001', 'Electricity', '2023-01-01'),
          ('ACC-0002', 'CUST-0002', 'Water', '2023-01-05'),
          ('ACC-0003', 'CUST-0003', 'Gas', '2023-01-10'),
          ('ACC-0004', 'CUST-0004', 'Electricity', '2023-01-15'),
          ('ACC-0005', 'CUST-0005', 'Water', '2023-01-20'),
          ('ACC-0006', 'CUST-0006', 'Gas', '2023-01-25'),
          ('ACC-0007', 'CUST-0007', 'Electricity', '2023-01-30'),
          ('ACC-0008', 'CUST-0008', 'Water', '2023-02-04'),
          ('ACC-0009', 'CUST-0009', 'Gas', '2023-02-09'),
          ('ACC-0010', 'CUST-0010', 'Electricity', '2023-02-14'),
          ('ACC-0011', 'CUST-0011', 'Water', '2023-02-19'),
          ('ACC-0012', 'CUST-0012', 'Gas', '2023-02-24'),
          ('ACC-0013', 'CUST-0013', 'Electricity', '2023-03-01'),
          ('ACC-0014', 'CUST-0014', 'Water', '2023-03-06'),
          ('ACC-0015', 'CUST-0015', 'Gas', '2023-03-11'),
          ('ACC-0016', 'CUST-0016', 'Electricity', '2023-03-16'),
          ('ACC-0017', 'CUST-0017', 'Water', '2023-03-21'),
          ('ACC-0018', 'CUST-0018', 'Gas', '2023-03-26'),
          ('ACC-0019', 'CUST-0019', 'Electricity', '2023-03-31'),
          ('ACC-0020', 'CUST-0020', 'Water', '2023-04-05'),
          ('ACC-0021', 'CUST-0021', 'Gas', '2023-04-10'),
          ('ACC-0022', 'CUST-0022', 'Electricity', '2023-04-15'),
          ('ACC-0023', 'CUST-0023', 'Water', '2023-04-20'),
          ('ACC-0024', 'CUST-0024', 'Gas', '2023-04-25'),
          ('ACC-0025', 'CUST-0025', 'Electricity', '2023-04-30'),
          ('ACC-0026', 'CUST-0026', 'Water', '2023-05-05'),
          ('ACC-0027', 'CUST-0027', 'Gas', '2023-05-10'),
          ('ACC-0028', 'CUST-0028', 'Electricity', '2023-05-15'),
          ('ACC-0029', 'CUST-0029', 'Water', '2023-05-20'),
          ('ACC-0030', 'CUST-0030', 'Gas', '2023-05-25');

-- =============================================
-- METER
-- =============================================
CREATE    TABLE METER (
          MeterNumber VARCHAR(20) PRIMARY KEY,
          MeterType VARCHAR(20),
          InstallationDate DATE,
          AccountID VARCHAR(20) NOT NULL,
          FOREIGN KEY (AccountID) REFERENCES ACCOUNT (AccountID)
          );

INSERT    INTO METER (MeterNumber, MeterType, InstallationDate, AccountID)
VALUES   
          -- Account 1 (Electricity, Water)
          ('MTR-1001', 'Electricity', '2023-01-01', 'ACC-0001'),
          ('MTR-1002', 'Water', '2023-01-05', 'ACC-0001'),
          -- Account 2 (Water, Gas)
          ('MTR-2001', 'Water', '2023-01-05', 'ACC-0002'),
          ('MTR-2002', 'Gas', '2023-01-10', 'ACC-0002'),
          -- Account 3 (Gas, Electricity)
          ('MTR-3001', 'Gas', '2023-01-10', 'ACC-0003'),
          ('MTR-3002', 'Electricity', '2023-01-15', 'ACC-0003'),
          -- Account 4 (Electricity only)
          ('MTR-4001', 'Electricity', '2023-01-15', 'ACC-0004'),
          -- Account 5 (Water only)
          ('MTR-5001', 'Water', '2023-01-20', 'ACC-0005'),
          -- Account 6 (Gas only)
          ('MTR-6001', 'Gas', '2023-01-25', 'ACC-0006'),
          -- Account 7 (Electricity, Water, Gas)
          ('MTR-7001', 'Electricity', '2023-01-30', 'ACC-0007'),
          ('MTR-7002', 'Water', '2023-02-01', 'ACC-0007'),
          ('MTR-7003', 'Gas', '2023-02-05', 'ACC-0007'),
          -- Account 8 (Water only)
          ('MTR-8001', 'Water', '2023-02-04', 'ACC-0008'),
          -- Account 9 (Gas, Electricity)
          ('MTR-9001', 'Gas', '2023-02-09', 'ACC-0009'),
          ('MTR-9002', 'Electricity', '2023-02-14', 'ACC-0009'),
          -- Account 10 (Electricity only)
          ('MTR-10001', 'Electricity', '2023-02-14', 'ACC-0010'),
          -- Account 11 (Water only)
          ('MTR-11001', 'Water', '2023-02-19', 'ACC-0011'),
          -- Account 12 (Gas only)
          ('MTR-12001', 'Gas', '2023-02-24', 'ACC-0012'),
          -- Account 13 (Electricity, Water)
          ('MTR-13001', 'Electricity', '2023-03-01', 'ACC-0013'),
          ('MTR-13002', 'Water', '2023-03-03', 'ACC-0013'),
          -- Account 14 (Water only)
          ('MTR-14001', 'Water', '2023-03-06', 'ACC-0014'),
          -- Account 15 (Gas only)
          ('MTR-15001', 'Gas', '2023-03-11', 'ACC-0015'),
          -- Account 16 (Electricity, Gas)
          ('MTR-16001', 'Electricity', '2023-03-16', 'ACC-0016'),
          ('MTR-16002', 'Gas', '2023-03-21', 'ACC-0016'),
          -- Account 17 (Water, Electricity)
          ('MTR-17001', 'Water', '2023-03-21', 'ACC-0017'),
          ('MTR-17002', 'Electricity', '2023-03-26', 'ACC-0017'),
          -- Account 18 (Gas only)
          ('MTR-18001', 'Gas', '2023-03-26', 'ACC-0018'),
          -- Account 19 (Electricity, Water)
          ('MTR-19001', 'Electricity', '2023-03-31', 'ACC-0019'),
          ('MTR-19002', 'Water', '2023-04-02', 'ACC-0019'),
          -- Account 20 (Water only)
          ('MTR-20001', 'Water', '2023-04-05', 'ACC-0020'),
          -- Account 21 (Gas, Electricity)
          ('MTR-21001', 'Gas', '2023-04-10', 'ACC-0021'),
          ('MTR-21002', 'Electricity', '2023-04-12', 'ACC-0021'),
          -- Account 22 (Electricity, Water, Gas)
          ('MTR-22001', 'Electricity', '2023-04-15', 'ACC-0022'),
          ('MTR-22002', 'Water', '2023-04-20', 'ACC-0022'),
          ('MTR-22003', 'Gas', '2023-04-25', 'ACC-0022'),
          -- Account 23 (Water only)
          ('MTR-23001', 'Water', '2023-04-20', 'ACC-0023'),
          -- Account 24 (Gas only)
          ('MTR-24001', 'Gas', '2023-04-25', 'ACC-0024'),
          -- Account 25 (Electricity only)
          ('MTR-25001', 'Electricity', '2023-04-30', 'ACC-0025'),
          -- Account 26 (Water, Gas)
          ('MTR-26001', 'Water', '2023-05-05', 'ACC-0026'),
          ('MTR-26002', 'Gas', '2023-05-07', 'ACC-0026'),
          -- Account 27 (Gas only)
          ('MTR-27001', 'Gas', '2023-05-10', 'ACC-0027'),
          -- Account 28 (Electricity, Water)
          ('MTR-28001', 'Electricity', '2023-05-15', 'ACC-0028'),
          ('MTR-28002', 'Water', '2023-05-17', 'ACC-0028'),
          -- Account 29 (Water only)
          ('MTR-29001', 'Water', '2023-05-20', 'ACC-0029'),
          -- Account 30 (Gas only)
          ('MTR-30001', 'Gas', '2023-05-25', 'ACC-0030');

-- =============================================
-- METER_READING
-- =============================================
CREATE    TABLE METER_READING (
          ReadingID VARCHAR(20) PRIMARY KEY,
          MeterNumber VARCHAR(20) NOT NULL,
          ReadingDate DATE NOT NULL,
          PreviousReading INT,
          CurrentReading INT NOT NULL,
          FOREIGN KEY (MeterNumber) REFERENCES METER (MeterNumber)
          );

INSERT    INTO METER_READING (ReadingID, MeterNumber, ReadingDate, PreviousReading, CurrentReading)
VALUES   
          -- Account 1
          ('RD-0001', 'MTR-1001', '2023-11-01', 100, 150),
          ('RD-0002', 'MTR-1002', '2023-11-01', 80, 130),
          -- Account 2
          ('RD-0003', 'MTR-2001', '2023-11-01', 50, 90),
          ('RD-0004', 'MTR-2002', '2023-11-01', 20, 60),
          -- Account 3
          ('RD-0005', 'MTR-3001', '2023-11-01', 70, 120),
          ('RD-0006', 'MTR-3002', '2023-11-01', 60, 110),
          -- Account 4
          ('RD-0007', 'MTR-4001', '2023-11-01', 100, 160),
          -- Account 5
          ('RD-0008', 'MTR-5001', '2023-11-01', 30, 75),
          -- Account 6
          ('RD-0009', 'MTR-6001', '2023-11-01', 40, 90),
          -- Account 7
          ('RD-0010', 'MTR-7001', '2023-11-01', 120, 170),
          ('RD-0011', 'MTR-7002', '2023-11-01', 60, 100),
          ('RD-0012', 'MTR-7003', '2023-11-01', 20, 50),
          -- Account 8
          ('RD-0013', 'MTR-8001', '2023-11-01', 55, 95),
          -- Account 9
          ('RD-0014', 'MTR-9001', '2023-11-01', 35, 80),
          ('RD-0015', 'MTR-9002', '2023-11-01', 60, 115),
          -- Account 10
          ('RD-0016', 'MTR-10001', '2023-11-01', 70, 120),
          -- Account 11
          ('RD-0017', 'MTR-11001', '2023-11-01', 45, 90),
          -- Account 12
          ('RD-0018', 'MTR-12001', '2023-11-01', 30, 70),
          -- Account 13
          ('RD-0019', 'MTR-13001', '2023-11-01', 80, 130),
          ('RD-0020', 'MTR-13002', '2023-11-01', 40, 85),
          -- Account 14
          ('RD-0021', 'MTR-14001', '2023-11-01', 60, 105),
          -- Account 15
          ('RD-0022', 'MTR-15001', '2023-11-01', 50, 95),
          -- Account 16
          ('RD-0023', 'MTR-16001', '2023-11-01', 90, 145),
          ('RD-0024', 'MTR-16002', '2023-11-01', 30, 75),
          -- Account 17
          ('RD-0025', 'MTR-17001', '2023-11-01', 40, 85),
          ('RD-0026', 'MTR-17002', '2023-11-01', 70, 120),
          -- Account 18
          ('RD-0027', 'MTR-18001', '2023-11-01', 20, 60),
          -- Account 19
          ('RD-0028', 'MTR-19001', '2023-11-01', 100, 150),
          ('RD-0029', 'MTR-19002', '2023-11-01', 60, 110),
          -- Account 20
          ('RD-0030', 'MTR-20001', '2023-11-01', 35, 75),
          -- Account 21
          ('RD-0031', 'MTR-21001', '2023-11-01', 25, 70),
          ('RD-0032', 'MTR-21002', '2023-11-01', 50, 100),
          -- Account 22
          ('RD-0033', 'MTR-22001', '2023-11-01', 110, 160),
          ('RD-0034', 'MTR-22002', '2023-11-01', 60, 100),
          ('RD-0035', 'MTR-22003', '2023-11-01', 30, 70),
          -- Account 23
          ('RD-0036', 'MTR-23001', '2023-11-01', 40, 85),
          -- Account 24
          ('RD-0037', 'MTR-24001', '2023-11-01', 30, 70),
          -- Account 25
          ('RD-0038', 'MTR-25001', '2023-11-01', 80, 130),
          -- Account 26
          ('RD-0039', 'MTR-26001', '2023-11-01', 60, 100),
          ('RD-0040', 'MTR-26002', '2023-11-01', 20, 60),
          -- Account 27
          ('RD-0041', 'MTR-27001', '2023-11-01', 50, 95),
          -- Account 28
          ('RD-0042', 'MTR-28001', '2023-11-01', 90, 145),
          ('RD-0043', 'MTR-28002', '2023-11-01', 40, 85),
          -- Account 29
          ('RD-0044', 'MTR-29001', '2023-11-01', 35, 75),
          -- Account 30
          ('RD-0045', 'MTR-30001', '2023-11-01', 25, 60);

-- =============================================
-- BILL
-- =============================================
CREATE    TABLE BILL (
          BillID VARCHAR(20) PRIMARY KEY NOT NULL,
          AccountID VARCHAR(20) NOT NULL,
          ReadingID VARCHAR(20) NOT NULL,
          IssueDate DATE NOT NULL,
          DueDate DATE NOT NULL,
          UnitsConsumed INT,
          EnergyCharges DECIMAL(10, 2),
          ServiceCharges DECIMAL(10, 2),
          TaxAmount DECIMAL(10, 2),
          TotalAmount DECIMAL(12, 2),
          PaymentStatus VARCHAR(20) DEFAULT 'Unpaid',
          FOREIGN KEY (AccountID) REFERENCES ACCOUNT (AccountID),
          FOREIGN KEY (ReadingID) REFERENCES METER_READING (ReadingID)
          );

INSERT    INTO BILL (
          BillID,
          AccountID,
          ReadingID,
          IssueDate,
          DueDate,
          UnitsConsumed,
          EnergyCharges,
          ServiceCharges,
          TaxAmount,
          TotalAmount,
          PaymentStatus
          )
VALUES   
          -- Account 1
          ('BILL-0001', 'ACC-0001', 'RD-0001', '2023-11-05', '2023-11-20', 50, 375, 25, 37.5, 437.5, 'Unpaid'),
          ('BILL-0002', 'ACC-0001', 'RD-0002', '2023-11-05', '2023-11-20', 50, 275, 15, 13.75, 303.75, 'Unpaid'),
          -- Account 2
          ('BILL-0003', 'ACC-0002', 'RD-0003', '2023-11-05', '2023-11-20', 40, 220, 15, 11, 246, 'Unpaid'),
          ('BILL-0004', 'ACC-0002', 'RD-0004', '2023-11-05', '2023-11-20', 40, 220, 15, 11, 246, 'Unpaid'),
          -- Account 3
          ('BILL-0005', 'ACC-0003', 'RD-0005', '2023-11-05', '2023-11-20', 50, 325, 18, 26, 369, 'Unpaid'),
          ('BILL-0006', 'ACC-0003', 'RD-0006', '2023-11-05', '2023-11-20', 50, 325, 18, 26, 369, 'Unpaid'),
          -- Account 4
          ('BILL-0007', 'ACC-0004', 'RD-0007', '2023-11-05', '2023-11-20', 60, 450, 25, 45, 520, 'Unpaid'),
          -- Account 5
          ('BILL-0008', 'ACC-0005', 'RD-0008', '2023-11-05', '2023-11-20', 45, 247.5, 15, 12.375, 274.875, 'Unpaid'),
          -- Account 6
          ('BILL-0009', 'ACC-0006', 'RD-0009', '2023-11-05', '2023-11-20', 50, 375, 25, 37.5, 437.5, 'Unpaid'),
          -- Account 7
          ('BILL-0010', 'ACC-0007', 'RD-0010', '2023-11-05', '2023-11-20', 50, 375, 25, 37.5, 437.5, 'Unpaid'),
          ('BILL-0011', 'ACC-0007', 'RD-0011', '2023-11-05', '2023-11-20', 40, 260, 18, 20.8, 298.8, 'Unpaid'),
          ('BILL-0012', 'ACC-0007', 'RD-0012', '2023-11-05', '2023-11-20', 30, 195, 18, 15.6, 228.6, 'Unpaid'),
          -- Account 8
          ('BILL-0013', 'ACC-0008', 'RD-0013', '2023-11-05', '2023-11-20', 40, 220, 15, 11, 246, 'Unpaid'),
          -- Account 9
          ('BILL-0014', 'ACC-0009', 'RD-0014', '2023-11-05', '2023-11-20', 45, 292.5, 18, 23.4, 333.9, 'Unpaid'),
          ('BILL-0015', 'ACC-0009', 'RD-0015', '2023-11-05', '2023-11-20', 55, 357.5, 18, 28.6, 404.1, 'Unpaid'),
          -- Account 10
          ('BILL-0016', 'ACC-0010', 'RD-0016', '2023-11-05', '2023-11-20', 50, 375, 25, 37.5, 437.5, 'Unpaid'),
          -- Account 11
          ('BILL-0017', 'ACC-0011', 'RD-0017', '2023-11-05', '2023-11-20', 45, 247.5, 15, 12.375, 274.875, 'Unpaid'),
          -- Account 12
          ('BILL-0018', 'ACC-0012', 'RD-0018', '2023-11-05', '2023-11-20', 40, 300, 25, 30, 355, 'Unpaid'),
          -- Account 13
          ('BILL-0019', 'ACC-0013', 'RD-0019', '2023-11-05', '2023-11-20', 50, 275, 15, 13.75, 303.75, 'Unpaid'),
          ('BILL-0020', 'ACC-0013', 'RD-0020', '2023-11-05', '2023-11-20', 45, 247.5, 15, 12.375, 274.875, 'Unpaid'),
          -- Account 14
          ('BILL-0021', 'ACC-0014', 'RD-0021', '2023-11-05', '2023-11-20', 45, 292.5, 18, 23.4, 333.9, 'Unpaid'),
          -- Account 15
          ('BILL-0022', 'ACC-0015', 'RD-0022', '2023-11-05', '2023-11-20', 45, 337.5, 25, 33.75, 396.25, 'Unpaid'),
          -- Account 16
          ('BILL-0023', 'ACC-0016', 'RD-0023', '2023-11-05', '2023-11-20', 55, 302.5, 15, 15.125, 332.625, 'Unpaid'),
          ('BILL-0024', 'ACC-0016', 'RD-0024', '2023-11-05', '2023-11-20', 45, 247.5, 15, 12.375, 274.875, 'Unpaid'),
          -- Account 17
          ('BILL-0025', 'ACC-0017', 'RD-0025', '2023-11-05', '2023-11-20', 45, 292.5, 18, 23.4, 333.9, 'Unpaid'),
          ('BILL-0026', 'ACC-0017', 'RD-0026', '2023-11-05', '2023-11-20', 50, 325, 18, 26, 369, 'Unpaid'),
          -- Account 18
          ('BILL-0027', 'ACC-0018', 'RD-0027', '2023-11-05', '2023-11-20', 40, 300, 25, 30, 355, 'Unpaid'),
          -- Account 19
          ('BILL-0028', 'ACC-0019', 'RD-0028', '2023-11-05', '2023-11-20', 50, 275, 15, 13.75, 303.75, 'Unpaid'),
          ('BILL-0029', 'ACC-0019', 'RD-0029', '2023-11-05', '2023-11-20', 50, 275, 15, 13.75, 303.75, 'Unpaid'),
          -- Account 20
          ('BILL-0030', 'ACC-0020', 'RD-0030', '2023-11-05', '2023-11-20', 40, 260, 18, 20.8, 298.8, 'Unpaid'),
          -- Account 21
          ('BILL-0031', 'ACC-0021', 'RD-0031', '2023-11-05', '2023-11-20', 45, 337.5, 25, 33.75, 396.25, 'Unpaid'),
          ('BILL-0032', 'ACC-0021', 'RD-0032', '2023-11-05', '2023-11-20', 50, 375, 25, 37.5, 437.5, 'Unpaid'),
          -- Account 22
          ('BILL-0033', 'ACC-0022', 'RD-0033', '2023-11-05', '2023-11-20', 50, 275, 15, 13.75, 303.75, 'Unpaid'),
          ('BILL-0034', 'ACC-0022', 'RD-0034', '2023-11-05', '2023-11-20', 40, 220, 15, 11, 246, 'Unpaid'),
          ('BILL-0035', 'ACC-0022', 'RD-0035', '2023-11-05', '2023-11-20', 40, 220, 15, 11, 246, 'Unpaid'),
          -- Account 23
          ('BILL-0036', 'ACC-0023', 'RD-0036', '2023-11-05', '2023-11-20', 45, 292.5, 18, 23.4, 333.9, 'Unpaid'),
          -- Account 24
          ('BILL-0037', 'ACC-0024', 'RD-0037', '2023-11-05', '2023-11-20', 40, 300, 25, 30, 355, 'Unpaid'),
          -- Account 25
          ('BILL-0038', 'ACC-0025', 'RD-0038', '2023-11-05', '2023-11-20', 50, 275, 15, 13.75, 303.75, 'Unpaid'),
          -- Account 26
          ('BILL-0039', 'ACC-0026', 'RD-0039', '2023-11-05', '2023-11-20', 40, 260, 18, 20.8, 298.8, 'Unpaid'),
          ('BILL-0040', 'ACC-0026', 'RD-0040', '2023-11-05', '2023-11-20', 40, 260, 18, 20.8, 298.8, 'Unpaid'),
          -- Account 27
          ('BILL-0041', 'ACC-0027', 'RD-0041', '2023-11-05', '2023-11-20', 45, 337.5, 25, 33.75, 396.25, 'Unpaid'),
          -- Account 28
          ('BILL-0042', 'ACC-0028', 'RD-0042', '2023-11-05', '2023-11-20', 55, 302.5, 15, 15.125, 332.625, 'Unpaid'),
          ('BILL-0043', 'ACC-0028', 'RD-0043', '2023-11-05', '2023-11-20', 45, 247.5, 15, 12.375, 274.875, 'Unpaid'),
          -- Account 29
          ('BILL-0044', 'ACC-0029', 'RD-0044', '2023-11-05', '2023-11-20', 40, 260, 18, 20.8, 298.8, 'Unpaid'),
          -- Account 30
          ('BILL-0045', 'ACC-0030', 'RD-0045', '2023-11-05', '2023-11-20', 35, 262.5, 25, 26.25, 313.75, 'Unpaid');

-- =============================================
-- PAYMENT
-- =============================================
CREATE    TABLE PAYMENT (
          PaymentID VARCHAR(20) PRIMARY KEY,
          BillID VARCHAR(20) NOT NULL,
          PaymentDate DATE NOT NULL,
          PaymentAmount DECIMAL(12, 2) NOT NULL,
          PaymentMethod VARCHAR(20),
          TransactionID VARCHAR(50),
          FOREIGN KEY (BillID) REFERENCES BILL (BillID)
          );

INSERT    INTO PAYMENT (PaymentID, BillID, PaymentDate, PaymentAmount, PaymentMethod, TransactionID)
VALUES    ('PAY-0001', 'BILL-0001', '2023-11-10', 437.5, 'Credit Card', 'TXN-1001'),
          ('PAY-0002', 'BILL-0002', '2023-11-10', 303.75, 'Bank Transfer', 'TXN-1002'),
          ('PAY-0003', 'BILL-0003', '2023-11-11', 246, 'Credit Card', 'TXN-1003'),
          ('PAY-0004', 'BILL-0004', '2023-11-11', 246, 'Cash', 'TXN-1004'),
          ('PAY-0005', 'BILL-0005', '2023-11-12', 369, 'Credit Card', 'TXN-1005'),
          ('PAY-0006', 'BILL-0006', '2023-11-12', 369, 'Bank Transfer', 'TXN-1006'),
          ('PAY-0007', 'BILL-0007', '2023-11-13', 520, 'Credit Card', 'TXN-1007'),
          ('PAY-0008', 'BILL-0008', '2023-11-13', 274.875, 'Cash', 'TXN-1008'),
          ('PAY-0009', 'BILL-0009', '2023-11-14', 437.5, 'Credit Card', 'TXN-1009'),
          ('PAY-0010', 'BILL-0010', '2023-11-14', 437.5, 'Bank Transfer', 'TXN-1010'),
          ('PAY-0011', 'BILL-0011', '2023-11-15', 298.8, 'Credit Card', 'TXN-1011'),
          ('PAY-0012', 'BILL-0012', '2023-11-15', 228.6, 'Cash', 'TXN-1012'),
          ('PAY-0013', 'BILL-0013', '2023-11-16', 246, 'Credit Card', 'TXN-1013'),
          ('PAY-0014', 'BILL-0014', '2023-11-16', 333.9, 'Bank Transfer', 'TXN-1014'),
          ('PAY-0015', 'BILL-0015', '2023-11-17', 404.1, 'Credit Card', 'TXN-1015'),
          ('PAY-0016', 'BILL-0016', '2023-11-17', 437.5, 'Cash', 'TXN-1016'),
          ('PAY-0017', 'BILL-0017', '2023-11-18', 274.875, 'Credit Card', 'TXN-1017'),
          ('PAY-0018', 'BILL-0018', '2023-11-18', 355, 'Bank Transfer', 'TXN-1018'),
          ('PAY-0019', 'BILL-0019', '2023-11-19', 303.75, 'Credit Card', 'TXN-1019'),
          ('PAY-0020', 'BILL-0020', '2023-11-19', 274.875, 'Cash', 'TXN-1020'),
          ('PAY-0021', 'BILL-0021', '2023-11-20', 333.9, 'Credit Card', 'TXN-1021'),
          ('PAY-0022', 'BILL-0022', '2023-11-20', 396.25, 'Bank Transfer', 'TXN-1022'),
          ('PAY-0023', 'BILL-0023', '2023-11-21', 332.625, 'Credit Card', 'TXN-1023'),
          ('PAY-0024', 'BILL-0024', '2023-11-21', 274.875, 'Cash', 'TXN-1024'),
          ('PAY-0025', 'BILL-0025', '2023-11-22', 333.9, 'Credit Card', 'TXN-1025'),
          ('PAY-0026', 'BILL-0026', '2023-11-22', 369, 'Bank Transfer', 'TXN-1026'),
          ('PAY-0027', 'BILL-0027', '2023-11-23', 355, 'Credit Card', 'TXN-1027'),
          ('PAY-0028', 'BILL-0028', '2023-11-23', 303.75, 'Cash', 'TXN-1028'),
          ('PAY-0029', 'BILL-0029', '2023-11-24', 303.75, 'Credit Card', 'TXN-1029'),
          ('PAY-0030', 'BILL-0030', '2023-11-24', 298.8, 'Bank Transfer', 'TXN-1030'),
          ('PAY-0031', 'BILL-0031', '2023-11-25', 396.25, 'Credit Card', 'TXN-1031'),
          ('PAY-0032', 'BILL-0032', '2023-11-25', 437.5, 'Cash', 'TXN-1032'),
          ('PAY-0033', 'BILL-0033', '2023-11-26', 303.75, 'Credit Card', 'TXN-1033'),
          ('PAY-0034', 'BILL-0034', '2023-11-26', 246, 'Bank Transfer', 'TXN-1034'),
          ('PAY-0035', 'BILL-0035', '2023-11-26', 246, 'Credit Card', 'TXN-1035'),
          ('PAY-0036', 'BILL-0036', '2023-11-27', 333.9, 'Cash', 'TXN-1036'),
          ('PAY-0037', 'BILL-0037', '2023-11-27', 355, 'Credit Card', 'TXN-1037'),
          ('PAY-0038', 'BILL-0038', '2023-11-28', 303.75, 'Bank Transfer', 'TXN-1038'),
          ('PAY-0039', 'BILL-0039', '2023-11-28', 298.8, 'Credit Card', 'TXN-1039'),
          ('PAY-0040', 'BILL-0040', '2023-11-28', 298.8, 'Cash', 'TXN-1040'),
          ('PAY-0041', 'BILL-0041', '2023-11-29', 396.25, 'Credit Card', 'TXN-1041'),
          ('PAY-0042', 'BILL-0042', '2023-11-29', 332.625, 'Bank Transfer', 'TXN-1042'),
          ('PAY-0043', 'BILL-0043', '2023-11-29', 274.875, 'Credit Card', 'TXN-1043'),
          ('PAY-0044', 'BILL-0044', '2023-11-30', 298.8, 'Cash', 'TXN-1044'),
          ('PAY-0045', 'BILL-0045', '2023-11-30', 313.75, 'Credit Card', 'TXN-1045');

-- ================================================================
-- CHARGES
-- ================================================================
CREATE    TABLE CHARGES (
          UtilityType VARCHAR(20) PRIMARY KEY,
          RatePerUnit DECIMAL(10, 2) NOT NULL,
          FixedCharge DECIMAL(10, 2) NOT NULL,
          TaxPercentage DECIMAL(5, 2) NOT NULL,
          ServiceFee DECIMAL(10, 2) NOT NULL
          );

INSERT    INTO CHARGES (UtilityType, RatePerUnit, FixedCharge, TaxPercentage, ServiceFee)
VALUES    ('Electricity', 7.5, 120, 10, 25),
          ('Water', 5.5, 100, 5, 15),
          ('Gas', 6.5, 110, 8, 18);