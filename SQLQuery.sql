--Database creation
create database CMS;
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
