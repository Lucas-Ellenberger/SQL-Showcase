-- Initial create file for CSE 180 Fall 2023 Lab2, which you should modify

-- The following two lines are useful.
DROP SCHEMA Lab2 CASCADE;
CREATE SCHEMA Lab2;


-- Persons(PersonID, personName, personAddress, birthDate)
CREATE TABLE Persons(
    personID INT PRIMARY KEY,
    personName VARCHAR(40) NOT NULL,
    personAddress VARCHAR(60),
    birthDate DATE,
    UNIQUE (personName, personAddress)
);

-- Actors(actorID, isActorEquity, equityJoinDate, roleCount)
CREATE TABLE Actors(
    actorID INT PRIMARY KEY REFERENCES Persons(personID),
    isActorsEquity BOOLEAN,
    equityJoinDate DATE,
    roleCount INT
);

-- ShakespearePlays(playTitle, yearWritten, category)
CREATE TABLE ShakespearePlays(
    playTitle VARCHAR(40) PRIMARY KEY,
    yearWritten INT,
    category CHAR(1)
);

-- Characters(playTitle, characterName)
CREATE TABLE Characters(
    playTitle VARCHAR(40) REFERENCES ShakespearePlays,
    characterName VARCHAR(40),
    PRIMARY KEY (playTitle, characterName)
);

-- Theaters(theaterID, theaterName, theaterAddress, theaterFeePerDay)
CREATE TABLE Theaters(
    theaterID INT PRIMARY KEY,
    theaterName VARCHAR(40) NOT NULL,
    theaterAddress VARCHAR(60),
    theaterFeePerDay NUMERIC(6,2) NOT NULL,
    UNIQUE (theaterName)
);

-- Productions(playTitle, productionNum, directorID, theaterID, productionStartDate, productionEndDate)
CREATE TABLE Productions(
    playTitle VARCHAR(40) REFERENCES ShakespearePlays,
    productionNum INT,
    directorID INT REFERENCES Persons(personID),
    theaterID INT REFERENCES Theaters,
    productionStartDate DATE,
    productionEndDate DATE,
    PRIMARY KEY (playTitle, productionNum),
    UNIQUE (theaterID, productionStartDate)
);

-- CastMembers(playTitle, productionNum, actorID, salaryPerDay, applausePosition)
CREATE TABLE CastMembers(
    playTitle VARCHAR(40),
    productionNum INT,
    actorID INT REFERENCES Actors,
    salaryPerDay NUMERIC(5,2),
    applausePosition INT,
    FOREIGN KEY (playTitle, productionNum) REFERENCES Productions,
    PRIMARY KEY (playTitle, productionNum, actorID)
);

-- Roles(playTitle, productionNum, actorID, characterName)
CREATE TABLE Roles(
    playTitle VARCHAR(40),
    productionNum INT,
    actorID INT,
    characterName VARCHAR(40),
    FOREIGN KEY (playTitle, productionNum, actorID) REFERENCES CastMembers,
    FOREIGN KEY (playTitle, characterName) REFERENCES Characters,
    PRIMARY KEY (playTitle, productionNum, actorID, characterName)
);
