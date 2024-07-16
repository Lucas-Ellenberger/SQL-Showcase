BEGIN TRANSACTION ISOLATION LEVEL SERIALIZABLE;
-- CastMembers(playTitle, productionNum, actorID, salaryPerDay, applausePosition)
-- CastMemberDeltas(playTitle, productionNum, actorID, salaryPerDayDelta, applausePosition)
UPDATE CastMembers cm
SET applausePosition = newcm.applausePosition, 
    salaryPerDay = (newcm.salaryPerDayDelta + cm.salaryPerDay)
FROM CastMemberDeltas newcm
WHERE cm.playTitle = newcm.playTitle
  AND cm.productionNum = newcm.productionNum
  AND cm.actorID = newcm.actorID;
INSERT INTO CastMembers(playTitle, productionNum, actorID, salaryPerDay, applausePosition)
SELECT playTitle, productionNum, actorID, salaryPerDayDelta, applausePosition
FROM CastMemberDeltas cmd
WHERE (cmd.playTitle, cmd.productionNum, cmd.actorID) NOT IN
    (SELECT cm.playTitle, cm.productionNum, cm.actorID
     FROM CastMembers cm);
COMMIT;