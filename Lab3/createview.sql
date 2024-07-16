CREATE VIEW MisreportedActorsView AS
    SELECT a.actorID, 
          (SELECT COUNT(*)
           FROM Roles r
           WHERE r.actorID = a.actorID
           GROUP BY r.actorID) AS calculatedRoleCount,
           a.roleCount AS reportedRoleCount
    FROM Actors a
    WHERE a.roleCount - 2 >= (SELECT COUNT(*)
                              FROM Roles r
                              WHERE r.actorID = a.actorID
                              GROUP BY r.actorID)
       OR a.roleCount + 2 <= (SELECT COUNT(*)
                              FROM Roles r
                              WHERE r.actorID = a.actorID
                              GROUP BY r.actorID);