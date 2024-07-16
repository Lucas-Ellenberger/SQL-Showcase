CREATE OR REPLACE FUNCTION
increaseSomeCastMemberSalariesFunction(thePlayTitle VARCHAR(40), theProdNum INTEGER, 
                                       maxDailyCost NUMERIC(7, 2))
    RETURNS NUMERIC(7,2) AS $$
DECLARE
    totalDailyCost        NUMERIC(7, 2);
    theActorSalary        NUMERIC(7, 2);
    theActorID            INTEGER;
    proposedIncrease      NUMERIC(7, 2);

DECLARE salaryCursor CURSOR FOR
    SELECT actorID, salaryPerDay 
    FROM CastMembers
    WHERE playTitle = thePlayTitle
      AND productionNum = theProdNum
    ORDER BY salaryPerDay
      FOR UPDATE;

BEGIN
    IF maxDailyCost <= 0 THEN
        RETURN -1;
    END IF;
    SELECT theaterFeePerDay 
    INTO totalDailyCost
    FROM Theaters 
    WHERE theaterID = (SELECT theaterID FROM Productions 
                       WHERE playTitle = thePlayTitle 
                         AND productionNum = theProdNum);
    IF NOT FOUND THEN
        RETURN -2;
    END IF;
    totalDailyCost := totalDailyCost + (SELECT SUM(salaryPerDay) 
                                        FROM CastMembers 
                                        WHERE playTitle = thePlayTitle 
                                          AND productionNum = theProdNum
                                        GROUP BY playTitle, productionNum);
    OPEN salaryCursor;
    LOOP
        FETCH salaryCursor INTO theActorID, theActorSalary;
        EXIT WHEN NOT FOUND;
        proposedIncrease := 0.00;
        IF theActorSalary <= 50.00 THEN proposedIncrease := 6.00;
        ELSIF theActorSalary <= 100 THEN proposedIncrease := 8.50;
        ELSIF theActorSalary <= 200 THEN proposedIncrease := 10.00;
        ELSE EXIT;
        END IF;
        EXIT WHEN maxDailyCost < (totalDailyCost + proposedIncrease);
        UPDATE CastMembers SET salaryPerDay = theActorSalary + proposedIncrease
          WHERE CURRENT OF salaryCursor;
        totalDailyCost := totalDailyCost + proposedIncrease;
    END LOOP;
    CLOSE salaryCursor;
    RETURN totalDailyCost;
END

$$ LANGUAGE plpgsql;
