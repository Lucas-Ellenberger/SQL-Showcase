--FK Constraint Unit Tests--
--FK 1--
INSERT INTO Productions(playTitle, productionNum,
                        directorID, theaterID, 
                        productionStartDate, productionEndDate)
VALUES ('Hamlet', 2, 1, 99, DATE '2024-02-01', DATE '2024-02-05');

--FK 2--
INSERT INTO Productions(playTitle, productionNum,
                        directorID, theaterID, 
                        productionStartDate, productionEndDate)
VALUES ('Hamlet', 2, 99, 1, DATE '2024-02-01', DATE '2024-02-05');

--FK 3--
INSERT INTO Roles(playTitle, productionNum,
                  actorID, characterName)
VALUES ('Hamlet', 1, 1, 'Gandalf the Grey');

--General Constraint Unit Tests--
--GC 1--
UPDATE Productions p
SET productionStartDate = DATE '2020-10-01'
WHERE p.playTitle = 'Hamlet';

UPDATE Productions p
SET productionStartDate = DATE '9999-10-01'
WHERE p.playTitle = 'Hamlet';

--GC 2--
UPDATE ShakespearePlays sp
SET category = 'H'
WHERE sp.category IS NULL;

UPDATE ShakespearePlays sp
SET category = 'L'
WHERE sp.playTitle = 'Hamlet';

--GC 3--
UPDATE Actors a
SET isActorsEquity = true
WHERE a.isActorsEquity = false;

UPDATE Actors a
SET isActorsEquity = NULL
WHERE a.roleCount = 0;