-- Load data for Lab 2

-- Persons(PersonID, personName, personAddress, birthDate)
COPY Persons(personID, personName, personAddress, birthDate) FROM stdin USING DELIMITERS '|';
1|John Doe|123 Main St, Anytown, USA|1990-05-15
2|Jane Smith|456 Elm St, Othertown, USA|1988-08-20
3|Alice Johnson|789 Oak St, Anycity, USA|1975-03-10
4|Michael Brown|111 Pine St, Anothercity, USA|1985-11-25
5|Emily Davis|222 Maple St, Someplace, USA|1995-07-03
\.

-- Actors(actorID, isActorsEquity, equityJoinDate, roleCount)
COPY Actors(actorID, isActorsEquity, equityJoinDate, roleCount) FROM stdin USING DELIMITERS '|';
1|true|\N|1
2|false|1901-01-01|1
3|false|1901-01-01|2
4|\N|\N|5
5|true|2012-09-01|0
\.


-- ShakespearePlays(playTitle, yearWritten, category)
COPY ShakespearePlays(playTitle, yearWritten, category) FROM stdin USING DELIMITERS '|';
Hamlet|1600|T
Romeo and Juliet|1597|T
Macbeth|1606|T
Henry V|1599|H
A Midsummer Nights Dream|1595|C
Julius Caesar|1599|\N
\.


-- Characters(playTitle, characterName)
COPY Characters(playTitle, characterName) FROM stdin USING DELIMITERS '|';
Hamlet|Hamlet
Hamlet|Ophelia
Hamlet|Claudius
Romeo and Juliet|Romeo
Romeo and Juliet|Juliet
Macbeth|Macbeth
Henry V|Henry V
Henry V|Catherine
A Midsummer Nights Dream|Bottom
A Midsummer Nights Dream|Titania
\.

-- Theaters(theaterID, theaterName, theaterAddress, theaterFeePerDay)
COPY Theaters(theaterID, theaterName, theaterAddress, theaterFeePerDay) FROM stdin USING DELIMITERS '|';
1|Globe Theatre|London, UK|500.00
2|Broadway Theatre|New York, USA|1000.00
3|Royal Opera House|London, UK|750.00
4|West End Theatre|London, UK|800.00
5|Theatre Royal|Sydney, Australia|900.00
\.

-- Productions(playTitle, productionNum, directorID, theaterID, productionStartDate, productionEndDate)
COPY Productions(playTitle, productionNum, directorID, theaterID, productionStartDate, productionEndDate) FROM stdin USING DELIMITERS '|';
Hamlet|1|1|1|2023-10-01|2023-11-01
Romeo and Juliet|1|2|2|2023-12-01|2024-01-01
Macbeth|1|3|3|2024-02-01|2024-03-01
Henry V|1|4|4|2024-04-01|2024-04-01
A Midsummer Nights Dream|1|5|5|2024-06-01|2024-07-01
\.

-- CastMembers(playTitle, productionNum, actorID, salaryPerDay, applausePosition)
COPY CastMembers(playTitle, productionNum, actorID, salaryPerDay, applausePosition) FROM stdin USING DELIMITERS '|';
Hamlet|1|1|100.00|1
Hamlet|1|3|110.00|\N
Romeo and Juliet|1|2|150.00|2
Romeo and Juliet|1|1|250.00|1
Romeo and Juliet|1|3|200.00|3
Macbeth|1|1|120.00|1
Macbeth|1|3|110.00|2
Henry V|1|4|180.00|2
Henry V|1|1|150.00|1
A Midsummer Nights Dream|1|5|130.00|3
A Midsummer Nights Dream|1|1|75.00|4
\.

-- Roles(playTitle, productionNum, actorID, characterName)
COPY Roles(playTitle, productionNum, actorID, characterName) FROM stdin USING DELIMITERS '|';
Hamlet|1|1|Hamlet
Hamlet|1|3|Ophelia
Hamlet|1|3|Claudius
Romeo and Juliet|1|2|Romeo
Romeo and Juliet|1|1|Romeo
Romeo and Juliet|1|3|Juliet
Macbeth|1|1|Macbeth
Macbeth|1|3|Macbeth
Henry V|1|4|Henry V
Henry V|1|1|Catherine
A Midsummer Nights Dream|1|5|Bottom
A Midsummer Nights Dream|1|5|Titania
A Midsummer Nights Dream|1|1|Titania
\.

-- CastMemberDeltas(playTitle, productionNum, actorID, salaryPerDayDelta, applausePosition)
COPY CastMemberDeltas(playTitle, productionNum, actorID, salaryPerDayDelta, applausePosition) FROM stdin USING DELIMITERS '|';
Hamlet|1|1|11.11|1
Romeo and Juliet|1|2|5.55|2
Romeo and Juliet|1|3|15.15|3
Macbeth|1|4|80.00|1
Henry V|1|3|120.00|2
A Midsummer Nights Dream|1|2|100.00|3
\.

