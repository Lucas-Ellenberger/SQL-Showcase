SELECT DISTINCT p.playTitle theTitle, p.productionNum theNum, 
p.productionStartDate theStartDate, p.productionEndDate theEndDate
FROM Productions p, CastMembers cm
WHERE p.playTitle = cm.playTitle
AND p.productionNum = cm.productionNum
AND cm.applausePosition IS NOT NULL
AND (cm.playTitle, cm.productionNum, cm.applausePosition) = ANY 
    (SELECT cm1.playTitle, cm1.productionNum, cm1.applausePosition
     FROM CastMembers cm1
     WHERE cm.actorID != cm1.actorID);