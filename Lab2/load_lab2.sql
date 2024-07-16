-- Load data for Lab 2

-- Persons(PersonID, personName, personAddress, birthDate)
COPY Persons FROM stdin USING DELIMITERS '|';
1|John Doe|123 Main Street|1999-05-15
2|Jane Smith|456 Oak Avenue|1999-08-22
3|Bob Johnson|789 Pine Street|2000-03-10
4|Alice Davis|321 Elm Street|1982-11-28
5|Charlie Brown|567 Birch Road|1999-05-15
6|Eva White|910 Maple Avenue|1993-09-18
7|Frank Miller|654 Cedar Lane|1980-02-07
8|Eva White|876 Fir St Road|1991-12-14
9|Henry Jones|234 Spruce Street|2558-06-30
10|Ivy Robinson|876 Fir Road|1996-04-25
11|Adrian Bauer|121E Antonia Street|1999-06-18
\.

-- Actors(actorID, isActorEquity, equityJoinDate, roleCount)
COPY Actors FROM stdin USING DELIMITERS '|';
1|true|2010-08-15|\N
2|false|1901-01-01|1
3|true|2005-12-03|3
4|false|1901-01-01|4
5|true|2012-10-01|3
6|false|1901-01-01|3
7|true|2016-09-05|2
\.

-- ShakespearePlays(playTitle, yearWritten, category)
COPY ShakespearePlays FROM stdin USING DELIMITERS '|';
Hamlet|1600|T
Romeo and Juliet|1597|T
Julius Caesar|1599|T
Much Ado About Nothing|1599|C
Henry V|1599|H
\.

-- Characters(playTitle, characterName)
COPY Characters FROM stdin USING DELIMITERS '|';
Hamlet|Hamlet
Hamlet|Ophelia
Hamlet|Claudius
Julius Caesar|Brutus
Julius Caesar|Julius Caesar
Julius Caesar|Cassius
Romeo and Juliet|Romeo
Romeo and Juliet|Juliet
Much Ado About Nothing|Benedick
Much Ado About Nothing|Beatrice
Henry V|Henry V
Henry V|Catherine
\.

-- Theaters(theaterID, theaterName, theaterAddress, theaterFeePerDay)
COPY Theaters FROM stdin USING DELIMITERS '|';
1|Globe Theatre|London, UK|99.99
2|Verona Amphitheatre|Verona, Italy|1020.50
3|Scottish Playhouse|Edinburgh, UK|1180.75
4|Messina Theater|Messina, Italy|50.25
5|Agincourt Hall|Agincourt, France|600.00
\.

-- Productions(playTitle, productionNum, directorID, theaterID, productionStartDate, productionEndDate)
COPY Productions FROM stdin USING DELIMITERS '|';
Hamlet|1|7|4|2024-03-01|2024-04-15
Romeo and Juliet|1|2|3|2024-05-10|2024-06-25
Julius Caesar|1|11|3|2024-08-05|2024-09-20
Much Ado About Nothing|1|11|5|2024-11-01|2025-01-15
Henry V|1|5|5|2025-02-20|2025-04-05
Hamlet|2|6|2|2025-05-15|2025-07-30
Romeo and Juliet|2|7|3|2025-09-01|2025-10-15
Julius Caesar|2|11|4|2025-11-20|2026-01-05
Much Ado About Nothing|2|9|5|2026-02-10|2026-04-25
Henry V|2|11|1|2026-05-20|2026-07-05
\.

-- CastMembers(playTitle, productionNum, actorID, salaryPerDay, applausePosition)
COPY CastMembers FROM stdin USING DELIMITERS '|';
Hamlet|1|4|54.54|1
Hamlet|1|2|56.78|1
Romeo and Juliet|1|3|300.00|\N
Romeo and Juliet|1|4|220.00|\N
Julius Caesar|1|5|280.00|1
Julius Caesar|1|6|240.00|2
Much Ado About Nothing|1|7|46.00|1
Much Ado About Nothing|1|1|41.00|2
Henry V|1|2|32.00|1
Henry V|1|3|23.00|1
Hamlet|2|4|270.00|1
Hamlet|2|5|200.00|2
Romeo and Juliet|2|6|310.00|1
Romeo and Juliet|2|7|240.00|2
Julius Caesar|2|1|42.01|1
Julius Caesar|2|2|0.01|2
Much Ado About Nothing|2|3|56.00|1
Much Ado About Nothing|2|4|50.00|2
Henry V|2|5|33.33|2
Henry V|2|6|24.50|2
\.

-- Roles(playTitle, productionNum, actorID, characterName)
COPY Roles FROM stdin USING DELIMITERS '|';
Hamlet|1|4|Hamlet
Hamlet|1|2|Ophelia
Romeo and Juliet|1|3|Romeo
Romeo and Juliet|1|4|Juliet
Julius Caesar|1|5|Julius Caesar
Julius Caesar|1|6|Brutus
Much Ado About Nothing|1|7|Benedick
Much Ado About Nothing|1|1|Beatrice
Henry V|1|2|Henry V
Henry V|1|3|Catherine
Hamlet|2|4|Hamlet
Hamlet|2|5|Ophelia
Romeo and Juliet|2|6|Romeo
Romeo and Juliet|2|7|Juliet
Julius Caesar|2|1|Brutus
Julius Caesar|2|2|Cassius
Much Ado About Nothing|2|3|Benedick
Much Ado About Nothing|2|4|Beatrice
Henry V|2|5|Henry V
Henry V|2|6|Catherine
\.
