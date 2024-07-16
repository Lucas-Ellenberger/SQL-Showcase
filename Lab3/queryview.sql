SELECT a.isActorsEquity, COUNT(*) as theCount
FROM MisreportedActorsView m, Actors a
WHERE m.actorID = a.actorID
GROUP BY a.isActorsEquity;
-- OUTPUT

-- Roles(playTitle, productionNum, actorID, characterName)
DELETE FROM Roles
WHERE playTitle = 'A Midsummer Nights Dream'
  AND productionNum = 1
  AND actorID = 1
  AND characterName = 'Titania';

DELETE FROM Roles
WHERE playTitle = 'Macbeth'
  AND productionNum = 1
  AND actorID = 3
  AND characterName = 'Macbeth';

SELECT a.isActorsEquity, COUNT(*) as theCount
FROM MisreportedActorsView m, Actors a
WHERE m.actorID = a.actorID
GROUP BY a.isActorsEquity;
-- OUTPUT