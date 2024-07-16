SELECT DISTINCT t.theaterName
FROM Theaters as t, Productions as pr, Persons as p, Characters as c, CastMembers as cm
WHERE t.theaterFeePerDay < 100
AND t.theaterID = pr.theaterID
AND pr.directorID = p.personID
AND p.personName = 'Adrian Bauer'
AND pr.playTitle = c.playTitle
AND c.characterName LIKE 'C%'
AND pr.productionNum = cm.productionNum
AND cm.salaryPerDay <= 56.78;