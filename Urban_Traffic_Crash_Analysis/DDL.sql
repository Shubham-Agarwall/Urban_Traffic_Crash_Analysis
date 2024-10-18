-- Execution Order
-- City_Dim
-- Source_Dim
-- Contribution_Dim
-- Vehicle_Dim
-- Date_Dim
-- Time_Dim
-- Area_Dim (this assumes City_Dim is referenced; if not, it can be created earlier)
-- Accident_Fact (references Area_Dim, City_Dim, Date_Dim, and Time_Dim)
-- Factless_Vehicle_Crash (references Accident_Fact and Vehicle_Dim)
-- Factless_Contribution_Collision (references Accident_Fact and Contribution_Dim)

CREATE DATABASE final_project;

-- DROP DATABASE final_project;

USE final_project;


CREATE DATABASE final_project;
USE final_project;

-- Area_Dim Table
CREATE TABLE Area_Dim (
  Area_ID INT AUTO_INCREMENT PRIMARY KEY,
  City_ID INT,
  Street_Name VARCHAR(1000),
  Latitude DECIMAL(15, 15),
  Longitude DECIMAL(15, 15),
  Zip_Code VARCHAR(20),
  DI_Process_ID INT,
  DI_Workflow_Filename VARCHAR(500),
  DI_Create_Date TIMESTAMP,
  FOREIGN KEY (City_ID) REFERENCES City_Dim(City_ID) -- Added foreign key reference to City_Dim
);

-- City_Dim Table
CREATE TABLE City_Dim (
  City_ID INT AUTO_INCREMENT PRIMARY KEY,
  City_Name VARCHAR(100),
  DI_Process_ID INT,
  DI_Workflow_Filename VARCHAR(500),
  DI_Create_Date TIMESTAMP
);

-- Date_Dim Table
CREATE TABLE Date_Dim (
  Date_ID INT AUTO_INCREMENT PRIMARY KEY,
  Date DATE,
  Year YEAR,
  Month INT,
  Season VARCHAR(500),
  Is_Weekend BOOLEAN,
  Quarter INT,
  DI_Process_ID INT,
  DI_Workflow_Filename VARCHAR(1000),
  DI_Create_Date TIMESTAMP
);

-- Time_Dim Table
CREATE TABLE Time_Dim (
  Time_ID INT AUTO_INCREMENT PRIMARY KEY,
  Hours INT,
  Minutes INT,
  Time TIME,
  Part_of_day VARCHAR(250),
  DI_Process_ID INT,
  DI_Workflow_Filename VARCHAR(1000),
  DI_Create_Date TIMESTAMP
);

-- Source_Dim Table
CREATE TABLE Source_Dim (
  Source_ID INT AUTO_INCREMENT PRIMARY KEY,
  Source_Name VARCHAR(500)
);

-- Contribution_Dim Table
CREATE TABLE Contribution_Dim (
  Contribution_ID INT AUTO_INCREMENT PRIMARY KEY,
  Contribution_Code VARCHAR(500),
  Contribution_Description VARCHAR(10000),
  DI_Process_ID INT,
  DI_Workflow_Filename VARCHAR(1000),
  DI_Create_Date TIMESTAMP
);

-- Vehicle_Dim Table
CREATE TABLE Vehicle_Dim (
  Vehicle_ID INT AUTO_INCREMENT PRIMARY KEY,
  Vehicle_Type VARCHAR(100),
  DI_Process_ID INT,
  DI_Workflow_Filename VARCHAR(1000),
  DI_Create_Date TIMESTAMP
);

-- Accident_Fact Table
CREATE TABLE Accident_Fact (
  Crash_ID INT AUTO_INCREMENT PRIMARY KEY,
  Area_ID INT,
  City_ID INT,
  Is_Pedestrian_Involved BOOLEAN,
  Vehicle_Count INT,
  Other_Killed INT,
  Total_Injured INT,
  Total_Killed1 INT, 
  Person_Killed_Count INT, 
  Person_Injured_Count INT,
  Pedestrian_Killed_Count INT,
  Pedestrian_Injured INT,
  Motorist_Killed INT,
  Motorist_Injured INT,
  Other_Injured INT,
  Date_ID INT,
  Time_ID INT,
  DI_Process_ID INT,
  DI_Workflow_Filename VARCHAR(1000),
  DI_Create_Date TIMESTAMP,
  FOREIGN KEY (Area_ID) REFERENCES Area_Dim(Area_ID),
  FOREIGN KEY (City_ID) REFERENCES City_Dim(City_ID),
  FOREIGN KEY (Date_ID) REFERENCES Date_Dim(Date_ID),
  FOREIGN KEY (Time_ID) REFERENCES Time_Dim(Time_ID)
);

-- Factless_Vehicle_Crash Table, junction table for many-to-many relationships
CREATE TABLE Factless_Vehicle_Crash (
  Vehicle_Crash_ID INT AUTO_INCREMENT PRIMARY KEY,
  Crash_ID INT,
  Vehicle_ID INT,
  DI_Process_ID INT,
  DI_Workflow_Filename VARCHAR(1000),
  DI_Create_Date TIMESTAMP,
  FOREIGN KEY (Crash_ID) REFERENCES Accident_Fact(Crash_ID),
  FOREIGN KEY (Vehicle_ID) REFERENCES Vehicle_Dim(Vehicle_ID)
);

-- Factless_Contribution_Collision Table, junction table for many-to-many relationships
CREATE TABLE Factless_Contribution_Collision (
  Crash_Contribution_ID INT AUTO_INCREMENT PRIMARY KEY,
  Crash_ID INT,
  Contribution_ID INT,
  DI_Process_ID INT,
  DI_Workflow_Filename VARCHAR(1000),
  DI_Create_Date TIMESTAMP,
  FOREIGN KEY (Crash_ID) REFERENCES Accident_Fact(Crash_ID),
  FOREIGN KEY (Contribution_ID) REFERENCES Contribution_Dim(Contribution_ID)
);

select * from 