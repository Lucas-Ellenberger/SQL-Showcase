SELECT DISTINCT p.personName AS actorName, p.birthDate AS actorBirthDate
FROM Actors AS a, Persons AS p, CastMembers AS c
WHERE a.actorID = p.personID
AND a.isActorsEquity = FALSE
AND p.birthDate < DATE '1999-06-01'
AND a.actorID = c.actorID
ORDER BY p.birthDate DESC, p.personName;
