-- Clinic Booking System SQL Schema
-- Author: Daniel Kiluu
-- Date: 2025-05-14

-- Drop existing tables (for clean import)
DROP TABLE IF EXISTS Doctor_Specializations, Medical_Records, Appointments, Specializations, Doctors, Departments, Patients, Users;

-- Create Departments
CREATE TABLE Departments (
    DepartmentID INT AUTO_INCREMENT PRIMARY KEY,
    DepartmentName VARCHAR(100) NOT NULL UNIQUE
);

-- Create Users (for system login)
CREATE TABLE Users (
    UserID INT AUTO_INCREMENT PRIMARY KEY,
    Username VARCHAR(50) NOT NULL UNIQUE,
    PasswordHash VARCHAR(255) NOT NULL,
    Role ENUM('admin', 'staff') NOT NULL
);

-- Create Doctors
CREATE TABLE Doctors (
    DoctorID INT AUTO_INCREMENT PRIMARY KEY,
    FullName VARCHAR(100) NOT NULL,
    DepartmentID INT,
    Email VARCHAR(100) UNIQUE,
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

-- Create Specializations
CREATE TABLE Specializations (
    SpecializationID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL UNIQUE
);

-- Many-to-Many: Doctor_Specializations
CREATE TABLE Doctor_Specializations (
    DoctorID INT,
    SpecializationID INT,
    PRIMARY KEY (DoctorID, SpecializationID),
    FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID),
    FOREIGN KEY (SpecializationID) REFERENCES Specializations(SpecializationID)
);

-- Create Patients
CREATE TABLE Patients (
    PatientID INT AUTO_INCREMENT PRIMARY KEY,
    FullName VARCHAR(100) NOT NULL,
    DateOfBirth DATE,
    Phone VARCHAR(15),
    Email VARCHAR(100) UNIQUE
);

-- Create Appointments
CREATE TABLE Appointments (
    AppointmentID INT AUTO_INCREMENT PRIMARY KEY,
    PatientID INT NOT NULL,
    DoctorID INT NOT NULL,
    AppointmentDate DATETIME NOT NULL,
    Reason TEXT,
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
    FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID)
);

-- Create Medical Records
CREATE TABLE Medical_Records (
    RecordID INT AUTO_INCREMENT PRIMARY KEY,
    PatientID INT,
    DoctorID INT,
    RecordDate DATETIME NOT NULL,
    Notes TEXT,
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
    FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID)
);
