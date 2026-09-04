--Created database
CREATE DATABASE RaceDayDB;
GO

USE RaceDayDB;
GO

--Create user table
CREATE TABLE [User]
(
    UserId INT IDENTITY(1,1) PRIMARY KEY,

    Name NVARCHAR(100) NOT NULL,

    Email NVARCHAR(150) NOT NULL UNIQUE,

    PasswordHash NVARCHAR(255) NOT NULL,

    Role NVARCHAR(20) NOT NULL
        CONSTRAINT CK_User_Role
        CHECK (Role IN ('Organiser', 'Participant')),

    CreatedAt DATETIME2 NOT NULL
        CONSTRAINT DF_User_CreatedAt
        DEFAULT SYSDATETIME()
);
GO

--Creating Events table
CREATE TABLE Event
(
    EventId INT IDENTITY(1,1) PRIMARY KEY,

    OrganiserId INT NOT NULL,

    Name NVARCHAR(150) NOT NULL,

    Description NVARCHAR(500) NULL,

    EventDate DATE NOT NULL,

    Location NVARCHAR(200) NOT NULL,

    Status NVARCHAR(20) NOT NULL
        CONSTRAINT DF_Event_Status
        DEFAULT 'Scheduled',

    CreatedAt DATETIME2 NOT NULL
        CONSTRAINT DF_Event_CreatedAt
        DEFAULT SYSDATETIME(),

    CONSTRAINT FK_Event_Organiser
        FOREIGN KEY (OrganiserId)
        REFERENCES [User](UserId),

    CONSTRAINT CK_Event_Status
        CHECK (Status IN ('Scheduled', 'Completed', 'Cancelled'))
);
GO

--Craeting category table
CREATE TABLE Category
(
    CategoryId INT IDENTITY(1,1) PRIMARY KEY,

    EventId INT NOT NULL,

    Name NVARCHAR(100) NOT NULL,

    DistanceKm DECIMAL(6,2) NOT NULL,

    MaxParticipants INT NOT NULL
        CONSTRAINT DF_Category_MaxParticipants
        DEFAULT 100,

    CONSTRAINT FK_Category_Event
        FOREIGN KEY (EventId)
        REFERENCES Event(EventId),

    CONSTRAINT CK_Category_Distance
        CHECK (DistanceKm > 0),

    CONSTRAINT CK_Category_MaxParticipants
        CHECK (MaxParticipants > 0),

    CONSTRAINT UQ_Category_Event_Name
        UNIQUE (EventId, Name)
);
GO

--Creating Route table
CREATE TABLE Route
(
    RouteId INT IDENTITY(1,1) PRIMARY KEY,

    EventId INT NOT NULL,

    RouteName NVARCHAR(150) NOT NULL,

    DistanceKm DECIMAL(6,2) NOT NULL,

    Description NVARCHAR(500) NULL,

    CONSTRAINT FK_Route_Event
        FOREIGN KEY (EventId)
        REFERENCES Event(EventId),

    CONSTRAINT CK_Route_Distance
        CHECK (DistanceKm > 0)
);
GO

--Creating Enrolment table
CREATE TABLE Enrolment
(
    EnrolmentId INT IDENTITY(1,1) PRIMARY KEY,

    UserId INT NOT NULL,

    EventId INT NOT NULL,

    CategoryId INT NOT NULL,

    EnrolmentDate DATETIME2 NOT NULL
        CONSTRAINT DF_Enrolment_Date
        DEFAULT SYSDATETIME(),

    Status NVARCHAR(20) NOT NULL
        CONSTRAINT DF_Enrolment_Status
        DEFAULT 'Active',

    CONSTRAINT FK_Enrolment_User
        FOREIGN KEY (UserId)
        REFERENCES [User](UserId),

    CONSTRAINT FK_Enrolment_Event
        FOREIGN KEY (EventId)
        REFERENCES Event(EventId),

    CONSTRAINT FK_Enrolment_Category
        FOREIGN KEY (CategoryId)
        REFERENCES Category(CategoryId),

    CONSTRAINT CK_Enrolment_Status
        CHECK (Status IN ('Active', 'Cancelled', 'Completed')),

    CONSTRAINT UQ_Enrolment_User_Event_Category
        UNIQUE (UserId, EventId, CategoryId)
);
GO

--Craeting results table
CREATE TABLE Result
(
    ResultId INT IDENTITY(1,1) PRIMARY KEY,

    EnrolmentId INT NOT NULL UNIQUE,

    FinishTime TIME NULL,

    Position INT NULL,

    CONSTRAINT FK_Result_Enrolment
        FOREIGN KEY (EnrolmentId)
        REFERENCES Enrolment(EnrolmentId),

    CONSTRAINT CK_Result_Position
        CHECK (Position IS NULL OR Position > 0)
);
GO

--Craeting weather cache
CREATE TABLE WeatherCache
(
    WeatherId INT IDENTITY(1,1) PRIMARY KEY,

    EventId INT NOT NULL,

    TemperatureC DECIMAL(5,2) NULL,

    Conditions NVARCHAR(100) NULL,

    WindSpeedKmh DECIMAL(6,2) NULL,

    FetchedAt DATETIME2 NOT NULL
        CONSTRAINT DF_WeatherCache_FetchedAt
        DEFAULT SYSDATETIME(),

    CONSTRAINT FK_WeatherCache_Event
        FOREIGN KEY (EventId)
        REFERENCES Event(EventId)
);
GO

