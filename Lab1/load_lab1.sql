--Script to populate the Shakespeare schema for W24 CSE 180 Lab1

-- Persons(PersonID, personName, personAddress, birthDate)
COPY Persons FROM stdin USING DELIMITERS '|';
8212|Adrian Bauer|121E Antonia St, Detroit, MI|1999-06-18
2572|Andrew Wontson|246B Athens St, Las Vegas, NV|1942-11-20
1255|Kevin Human|567E Oak St, Santa Clara, CA|1990-10-31
4396|Charles Connington|135A Cyan St, Los Angeles, CA|1988-08-04
6056|Narah Vaasen|56C Concordia St, Denver, CO|2000-09-21
7777|Thomas Kainor|789B Marble Av, Rochester, NY|2002-08-15
3579|Jen Kerring|230C Randyll Street, Trenton, NJ|1999-02-03
\.

-- Actors(actorID, isActorEquity, equityJoinDate, roleCount)
COPY Actors FROM stdin USING DELIMITERS '|';
8212|TRUE|2020-12-01|6
2572|FALSE|1901-01-01|1
6056|TRUE|2018-03-12|1
1255|TRUE|2019-04-04|1
4396|TRUE|2018-07-04|0
7777|TRUE|2021-05-19|1
\.

-- ShakespearePlays(playTitle, yearWritten, category)
COPY ShakespearePlays FROM stdin USING DELIMITERS '|';
Hamlet|1600|T
Julius Caesar|1599|T
Much Ado About Nothing|1598|C
King Lear|1606|T
\.

-- Characters(playTitle, characterName)
COPY Characters FROM stdin USING DELIMITERS '|';
Julius Caesar|Brutus
Julius Caesar|Julius Caesar
Julius Caesar|Cassius
Hamlet|Hamlet
Hamlet|Claudius
Hamlet|Gertrude
Much Ado About Nothing|Claudio
Much Ado About Nothing|Hero
\.

-- Theaters(theaterID, theaterName, theaterAddress, theaterFeePerDay)
COPY Theaters FROM stdin USING DELIMITERS '|';
11|The Globe|New Globe Walk, London, SE1|1234.56
22|Blackfriars Theatre|795E Main St, Rochester, NY, 14605|754.67
33|Santa Cruz Shakespeare|501 Upper Park Rd, Santa Cruz, CA ,95065|1337.15
\.

-- Productions(playTitle, productionNum, directorID, theaterID, productionStartDate, productionEndDate)
COPY Productions FROM stdin USING DELIMITERS '|';
Julius Caesar|1|2572|11|2021-03-13|2021-03-15
Julius Caesar|2|8212|22|2022-03-13|2022-03-15
Hamlet|1|3579|33|2023-07-07|2023-08-03
Much Ado About Nothing|1|3579|22|2022-05-15|2022-05-20
\.

-- CastMembers(playTitle, productionNum, actorID, salaryPerDay, applausePosition)
COPY CastMembers FROM stdin USING DELIMITERS '|';
Julius Caesar|2|8212|821.25|1
Hamlet|1|7777|555.25|5
Hamlet|1|1255|5.99|5
Hamlet|1|2572|565.55|3
Much Ado About Nothing|1|4396|765.43|3
Much Ado About Nothing|1|8212|765.43|2
Much Ado About Nothing|1|6056|789.42|1
\.

-- Roles(playTitle, productionNum, actorID, characterName)
COPY Roles FROM stdin USING DELIMITERS '|';
Julius Caesar|2|8212|Cassius
Julius Caesar|2|8212|Brutus
Julius Caesar|2|8212|Julius Caesar
Hamlet|1|1255|Hamlet
Hamlet|1|2572|Gertrude
Hamlet|1|7777|Claudius
Much Ado About Nothing|1|8212|Claudio
Much Ado About Nothing|1|6056|Hero
\.

