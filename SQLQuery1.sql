--Database creation

USE CMS;

--Creating Tables--
-- Table Departments 
CREATE TABLE Departments 
(
DepartmentId 		INT PRIMARY KEY IDENTITY(1,1),
DepartmentName		VARCHAR(30) NOT NULL,
);


-- Table Roles
CREATE TABLE Roles
(
RoleId 			INT PRIMARY KEY IDENTITY(1,1),
RoleName 			VARCHAR(30) NOT NULL,
);


-- Table AppointmentTypes
CREATE TABLE AppointmentTypes
(
AppointmentTypeId 		INT PRIMARY KEY IDENTITY(1,1),
AppointmentType 		VARCHAR(30) NOT NULL,
);



-- Table Specializations
CREATE TABLE Specializations
(
SpecializationId 		INT PRIMARY KEY IDENTITY(1,1),
SpecializationName		VARCHAR(30) NOT NULL,
);

-- Table Labs
CREATE TABLE Labs
(
LabId 				INT PRIMARY KEY IDENTITY(1,1),
LabName 			VARCHAR(30) NOT NULL,
IsActive 			BIT NOT NULL
);

-- Table Login
CREATE TABLE Login
(
LoginId 			INT PRIMARY KEY IDENTITY(1,1),
UserName 			VARCHAR(30) NOT NULL,
Password 			VARCHAR(30) NOT NULL,
RoleId 			INT NOT NULL,

CONSTRAINT FK_ROLE_LOGIN FOREIGN KEY(RoleId) REFERENCES Roles(RoleId)
);
alter table Login
add EmployeeId INT NOT NULL;
alter table Login
ADD constraint  FK_emp_id FOREIGN KEY(EmployeeId) REFERENCES Employees(EmployeeId);


-- Table Employees
CREATE TABLE Employees
(
EmployeeId 			INT PRIMARY KEY IDENTITY(1,1),
EmployeeName 		VARCHAR(30) NOT NULL,
Age				INT NOT NULL,
MobileNo 			NUMERIC NOT NULL,
Gender 			VARCHAR(10) NOT NULL,
DateOfJoining 		DATE NOT NULL,
DepartmentId		INT NOT NULL,
RoleId 			INT NOT NULL,
IsActive 			BIT NOT NULL,

CONSTRAINT FK_EMPLOYEE_DEPT FOREIGN KEY(DepartmentId) REFERENCES Departments(DepartmentId),

CONSTRAINT FK_EMPLOYEE_ROLE FOREIGN KEY(RoleId) REFERENCES Roles(RoleId),

CHECK(Gender IN ('Male','Female'))
);

-- Table Patients
CREATE TABLE Patients
(
PatientId 			INT PRIMARY KEY IDENTITY(1,1),
PatientName			VARCHAR(30) NOT NULL,
Age 				INT NOT NULL,
MobileNo 			NUMERIC NOT NULL,
Gender 			VARCHAR(10) NOT NULL,
Address 			VARCHAR(30) NOT NULL,
IsActive 			BIT NOT NULL,

CHECK(Gender IN ('Male','Female'))
);

-- Table Appointments
CREATE TABLE Appointments
(
AppointmentId 		INT PRIMARY KEY IDENTITY(1,1),
AppointmentTypeId		INT NOT NULL,
PatientId 			INT NOT NULL,
EmployeeId 			INT NOT NULL,
AppointmentStatus 		BIT NOT NULL,

CONSTRAINT FK_APPOINTMENT_APTYPE FOREIGN KEY(AppointmentTypeId) REFERENCES AppointmentTypes(AppointmentTypeId),

CONSTRAINT FK_APPOINTMENT_PATIENT FOREIGN KEY(PatientId) REFERENCES Patients(PatientId),

CONSTRAINT FK_APPOINTMENT_EMP FOREIGN KEY(EmployeeId) REFERENCES Employees(EmployeeId),
);
alter table Appointments
add AppointmentDate datetime;

-- Table EmployeeSpecializations
CREATE TABLE EmployeeSpecializations
(
ESId 				INT PRIMARY KEY IDENTITY(1,1),
SpecializationId 		INT NOT NULL,
EmployeeId 			INT NOT NULL,

CONSTRAINT FK_ES_Specialization FOREIGN KEY(SpecializationId) REFERENCES Specializations(SpecializationId),

CONSTRAINT FK_ES_Employee FOREIGN KEY(EmployeeId) REFERENCES Employees(EmployeeId),
);

-- Table Prescriptions
CREATE TABLE Prescriptions
(
PrescriptionId 		INT PRIMARY KEY IDENTITY(1,1),
Prescription 			VARCHAR(250) NOT NULL,
PrescriptionDate 		DATE NOT NULL,
EmployeeId 			INT NOT NULL,
PatientId 			INT NOT NULL,

CONSTRAINT FK_PRESCRIPTION_PATIENT FOREIGN KEY(PatientId) REFERENCES Patients(PatientId),
CONSTRAINT FK_PRESCRIPTION_EMPLOYEE FOREIGN KEY(EmployeeId) REFERENCES Employees(EmployeeId),
);
alter table Prescriptions
add Tests varchar(250);

-- Table TestReports
CREATE TABLE TestReports
(
TestReportId 			INT PRIMARY KEY IDENTITY(1,1),
TestReport 			VARCHAR(250) NOT NULL,
PatientId 			INT NOT NULL,
DoctorId 			INT NOT NULL,
LabTechnicianId 		INT NOT NULL,

CONSTRAINT FK_TESTREPORTS_PATIENT FOREIGN KEY(PatientId) REFERENCES Patients(PatientId),

CONSTRAINT FK_TESTREPORTS_EMP_DOCTOR FOREIGN KEY(DoctorId) REFERENCES Employees(EmployeeId),

CONSTRAINT FK_TESTREPORTS_EMP_TECHNICIAN FOREIGN KEY(LabTechnicianId) REFERENCES Employees(EmployeeId),
);
alter table TestReports
add ReportGeneratedDate varchar(250);


-- Table Queries
CREATE TABLE Queries
(
QueryId 			INT PRIMARY KEY IDENTITY(1,1),
Query 			VARCHAR(500) NOT NULL,
IsAnswered 			BIT,
AnsweredBy 			INT,

CONSTRAINT FK_QUERIES_EMPLOYEE FOREIGN KEY(AnsweredBy) REFERENCES Employees(EmployeeId),
);
-- Table Payments
CREATE TABLE Payments
(
PaymentId 			INT PRIMARY KEY IDENTITY(1,1),
Amount 			MONEY NOT NULL,
PatientId 			INT NOT NULL,

CONSTRAINT FK_PAYMENTS_PATIENTS FOREIGN KEY(PatientId) REFERENCES Patients(PatientId),
);
alter table Payments
add PaymentDate datetime;
alter table Payments
add Status varchar(10);

---  Table LabHasTechnician

CREATE TABLE LabHasTechnician
(
LTId        INT PRIMARY KEY IDENTITY(1,1),
LabId 		INT NOT NULL,
LabTechnicianId 			INT NOT NULL,

CONSTRAINT FK_LT_Labs FOREIGN KEY(LabId) REFERENCES Labs(LabId),

CONSTRAINT FK_LT_Employee FOREIGN KEY(LabTechnicianId) REFERENCES Employees(EmployeeId)
);
CREATE TABLE LabTests
(
TestId INT PRIMARY KEY NOT NULL IDENTITY(1,1),
TestName Varchar(30),
)
create table Announcement(
AnnId int identity(1,1) not null primary key,
AnnText varchar(250),
AnnDate date,
EmployeeId int not null,
constraint fk_emp foreign key (EmployeeId) references Employees(EmployeeId));


