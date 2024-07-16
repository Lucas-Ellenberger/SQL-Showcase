SELECT DISTINCT r.playTitle, r.characterName
FROM Actors as a, Roles as r, Persons as p
WHERE a.actorID = p.personID
AND a.actorID = r.actorID
AND a.roleCount IS NOT NULL
AND p.personAddress LIKE '% Street';