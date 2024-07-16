ALTER TABLE Productions
ADD CONSTRAINT productionDatesOkay
CHECK (productionStartDate <= productionEndDate);

ALTER TABLE ShakespearePlays
ADD CONSTRAINT legalCategory
CHECK (category = 'C'
    OR category = 'T'
    OR category = 'H'
    OR category IS NULL);

ALTER TABLE Actors
ADD CONSTRAINT actorsEquityNull
CHECK (isActorsEquity IS NOT NULL
    OR equityJoinDate IS NULL);