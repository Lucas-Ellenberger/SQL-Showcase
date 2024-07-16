DROP SCHEMA Lab1 CASCADE;
CREATE SCHEMA Lab1;
CREATE TABLE Persons (
    personID INTEGER PRIMARY KEY,
    personName VARCHAR(40),
    personAddress VARCHAR(60),
    birthDate DATE
);

CREATE TABLE Actors (
    actorID INTEGER PRIMARY KEY,
    isActorsEquity BOOLEAN,
    equityJoinDate DATE,
    roleCount INTEGER,
    FOREIGN KEY (actorID) REFERENCES Persons(personID)
);

CREATE TABLE ShakespearePlays(
    playTitle VARCHAR(40) PRIMARY KEY,
    yearWritten INTEGER,
    category CHAR(1)
);

CREATE TABLE Characters(
    playTitle VARCHAR(40),
    characterName VARCHAR(40),
    PRIMARY KEY (playTitle, characterName),
    FOREIGN KEY (playTitle) REFERENCES ShakespearePlays
);

CREATE TABLE Theaters(
    theaterID INTEGER PRIMARY KEY,
    theaterName VARCHAR(40),
    theaterAddress VARCHAR(60),
    theaterFeePerDay NUMERIC(6, 2)
);

CREATE TABLE Productions(
    playTitle VARCHAR(40),
    productionNum INTEGER,
    directorID INTEGER,
    theaterID INTEGER,
    productionStartDate DATE,
    productionEndDate DATE,
    PRIMARY KEY (playTitle, productionNum),
    FOREIGN KEY (playTitle) REFERENCES ShakespearePlays,
    FOREIGN KEY (directorID) REFERENCES Persons(personID),
    FOREIGN KEY (theaterID) REFERENCES Theaters
);

CREATE TABLE CastMembers(
    playTitle VARCHAR(40),
    productionNum INTEGER,
    actorID INTEGER,
    salaryPerDay NUMERIC(5, 2),
    applausePosition INTEGER,
    PRIMARY KEY (playTitle, productionNum, actorID),
    FOREIGN KEY (playTitle, productionNum) REFERENCES Productions(playTitle, productionNum),
    FOREIGN KEY (actorID) REFERENCES Actors
);

CREATE TABLE Roles(
    playTitle VARCHAR(40),
    productionNum INTEGER,
    actorID INTEGER,
    characterName VARCHAR(40),
    PRIMARY KEY (playTitle, productionNum, actorID, characterName),
    FOREIGN KEY (playTitle, productionNum, actorID) REFERENCES CastMembers(playTitle, productionNum, actorID),
    FOREIGN KEY (playTitle, characterName) REFERENCES Characters(playTitle, characterName)
);
