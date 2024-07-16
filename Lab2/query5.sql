SELECT DISTINCT p.playTitle, p.theaterID
FROM Productions p
WHERE p.theaterID = ALL (SELECT p1.theaterID 
                        FROM Productions p1 
                        WHERE p1.playTitle = p.playTitle);