/**
 * runShakespeareApplication skeleton, to be modified by students
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <errno.h>
#include "libpq-fe.h"

/* These constants would normally be in a header file */
/* Maximum length of string used to submit a connection */
#define MAXCONNECTIONSTRINGSIZE 501
/* Maximum length of string used to submit a SQL statement */
#define MAXSQLSTATEMENTSTRINGSIZE 2001
/* Maximum length of string version of integer; you don't have to use a value this big */
#define MAXNUMBERSTRINGSIZE 20


/* Exit with success after closing connection to the server
 *  and freeing memory that was used by the PGconn object.
 */
static void good_exit(PGconn *conn)
{
    PQfinish(conn);
    exit(EXIT_SUCCESS);
}

/* Exit with failure after closing connection to the server
 *  and freeing memory that was used by the PGconn object.
 */
static void bad_exit(PGconn *conn)
{
    PQfinish(conn);
    exit(EXIT_FAILURE);
}

/* The three C functions that for Lab4 should appear below.
 * Write those functions, as described in Lab4 Section 4 (and Section 5,
 * which describes the Stored Function used by the third C function).
 *
 * Write the tests of those function in main, as described in Section 6
 * of Lab4.
 *
 * You may use "helper" functions to avoid having to duplicate calls and
 * printing, if you'd like, but if Lab4 says do things in a function, do them
 * in that function, and if Lab4 says do things in main, do them in main,
 * possibly using a helper function, if you'd like.
 */

/* Function: countDifferentPlayCharacters:
 * ---------------------------------------
 * Parameters:  connection, and theActorID, which should be the ID of an actor.
 * Returns the number of different play characters which that actor has played,
 * if there is an actor corresponding to theActorID.
 * Returns -1 if no such actor.
 * bad_exit if SQL statement execution fails.
 */


int countDifferentPlayCharacters(PGconn *conn, int theActorID)
{
    PGresult *res = PQexec(conn, "BEGIN TRANSACTION ISOLATION LEVEL SERIALIZABLE");
    if (PQresultStatus(res) != PGRES_COMMAND_OK) {
        printf("BEGIN command failed\n");        
        PQclear(res);
        bad_exit(conn);
    }

    PQclear(res);

    char actorExists[MAXSQLSTATEMENTSTRINGSIZE] = 
        "SELECT a.actorID FROM Actors a WHERE a.actorID = ";
    char strActorID[MAXNUMBERSTRINGSIZE];
    sprintf(strActorID, "%d", theActorID);
    strcat(actorExists, strActorID);
    res = PQexec(conn, actorExists);
    if (PQresultStatus(res) != PGRES_TUPLES_OK) {
        printf("Simple SELECT command failed:\n");
        printf(actorExists);
        printf("\n");
        PQclear(res);
        bad_exit(conn);
    }
    int numFound = 0;
    if (PQntuples(res) == 0) {
        numFound = -1;
    } else {
        PQclear(res);
        char numRoles[MAXSQLSTATEMENTSTRINGSIZE] = 
            "SELECT r.actorID FROM Roles r WHERE r.actorID = ";
        strcat(numRoles, strActorID);
        char secondHalf[MAXSQLSTATEMENTSTRINGSIZE] = 
            " GROUP BY r.actorID, r.characterName, r.playTitle;";
        strcat(numRoles, secondHalf);
        res = PQexec(conn, numRoles);
        // res = PQexec(conn, "SELECT * FROM Roles;");

        if (PQresultStatus(res) != PGRES_TUPLES_OK) {
            printf("SELECT command failed:\n");
            printf(numRoles);
            printf("\n");
            PQclear(res);
            bad_exit(conn);
        } else {
            numFound = PQntuples(res);
        }
    }

    PQclear(res);

    res = PQexec(conn, "COMMIT");
    if (PQresultStatus(res) != PGRES_COMMAND_OK) {
        printf("COMMIT command failed\n");        
        PQclear(res);
        bad_exit(conn);
    }

    PQclear(res);
    return numFound;
}

/* Function: renameTheater:
 * ------------------------
 * Parameters:  connection, and character strings oldTheaterName and newTheaterName.
 * Updates the theaterName values for all theaters in Theaters which whose theaterName
 * was oldTheaterName to newTheaterName, and returns the number of addresses updates.
 *
 * If no theater names are updated (because no theaters have oldTheaterName as their
 * theaterName, return 0; that's not an error.
 *
 * If there are multiple theaters had oldTheaterName as their theaterName, then update
 * the theaterName for all of them, and return the number updated; that's also not an error.
 *
 * However, if there already was a theater whose name is newTheaterName, then return -1,
 * even if there aren't any theaters whose name is oldTheaterName.
 */

int renameTheater(PGconn *conn, char *oldTheaterName, char *newTheaterName)
{
    PGresult *res = PQexec(conn, "BEGIN TRANSACTION ISOLATION LEVEL SERIALIZABLE");
    if (PQresultStatus(res) != PGRES_COMMAND_OK) {
        printf("BEGIN command failed\n");        
        PQclear(res);
        bad_exit(conn);
    }

    PQclear(res);
    int numUpdated = 0;
    char myCommand[MAXSQLSTATEMENTSTRINGSIZE] = 
        "SELECT t.theaterID FROM Theaters t WHERE t.theaterName = '";
    strcat(myCommand, newTheaterName);
    strcat(myCommand, "';");
    res = PQexec(conn, myCommand);
    if ((PQresultStatus(res) != PGRES_COMMAND_OK) && (PQresultStatus(res) != PGRES_TUPLES_OK)) {
        printf("SELECT newTheater command failed:\n"); 
        printf(myCommand);
        printf("\n");
        PQclear(res);
        bad_exit(conn);
    }
    if (PQntuples(res) != 0) {
        numUpdated = -1;
        PQclear(res);
    } else {
        PQclear(res);
        char myCommand[MAXSQLSTATEMENTSTRINGSIZE] = 
            "SELECT t.theaterID FROM Theaters t WHERE t.theaterName = '";
        strcat(myCommand, oldTheaterName);
        strcat(myCommand, "';");
        res = PQexec(conn, myCommand);
        if (PQresultStatus(res) != PGRES_TUPLES_OK) {
            printf("SELECT oldTheater command failed\n");
            printf(myCommand);
            printf("\n"); 
            PQclear(res);
            bad_exit(conn);
        }
        PQclear(res);
        // UPDATE QUERY
        char updateCommand[MAXSQLSTATEMENTSTRINGSIZE] = 
            "UPDATE Theaters t SET theaterName = '";
        strcat(updateCommand, newTheaterName);
        char secondHalf[MAXSQLSTATEMENTSTRINGSIZE] = "' WHERE t.theaterName = '";
        strcat(updateCommand, secondHalf);
        strcat(updateCommand, oldTheaterName);
        strcat(updateCommand, "';");
        res = PQexec(conn, updateCommand);
        if (PQresultStatus(res) != PGRES_COMMAND_OK) {
            printf("UPDATE command failed:\n");
            printf(updateCommand); 
            printf("\n");
            PQclear(res);
            bad_exit(conn);
        }
        numUpdated = atoi(PQcmdTuples(res));
        PQclear(res);
    }

    res = PQexec(conn, "COMMIT"); 
    if (PQresultStatus(res) != PGRES_COMMAND_OK) {
        printf("COMMIT command failed\n");        
        PQclear(res);
        bad_exit(conn);
    }

    PQclear(res);
    return numUpdated;
}

/* Function: increaseSomeCastMemberSalaries:
 * -----------------------------------------
 * Parameters:  connection, a character string thePlayTitle, and integers theProdNum and
 * maxDailyCost. thePlayTitle and theProdNum should identify a production in Productions.
 *
 * IncreaseSomeCastMemberSalaries will try to increase the salaryPerDay of some cast members,
 * starting with those who have the lowest salaryPerDay, aa described in Section 5 of the Lab4 pdf.
 *
 * However, the Total Daily Cost for this production, counting the theaterFeePerDay for the
 * production and the total salaryPerDay of all cast members should not be more than maxDailyCost.
 *
 * Executes by invoking a Stored Function, IncreaseSomeCastMemberSalariesFunction, which does 
 * all of the work.
 *
 * Returns the new Total Daily Cost after any salaryPerDay increases have been applied.
 * However, if maxDailyCost is not postiive, this function returns -1.
 *
 * And it is possible that Total Daily Cost already equals (or even if greater than) maxDailyCost.
 * That's not an error.  In that case, IncreaseSomeCastMemberSalaries changes no salaries, and
 * returns (the unchanged) Total Daily Cost.
 */

float increaseSomeCastMemberSalaries(PGconn *conn, char *playTitle, int prodNum, float maxDailyCost)
{
    char functionCommand[MAXSQLSTATEMENTSTRINGSIZE] = "SELECT increaseSomeCastMemberSalariesFunction('";
    strcat(functionCommand, playTitle);
    strcat(functionCommand, "', ");
    char strProdNum[MAXNUMBERSTRINGSIZE];
    sprintf(strProdNum, "%d, ", prodNum);
    strcat(functionCommand, strProdNum);
    char strMaxDailyCost[MAXNUMBERSTRINGSIZE];
    sprintf(strMaxDailyCost, "%7.2f);", maxDailyCost);
    strcat(functionCommand, strMaxDailyCost);
    PGresult *res = PQexec(conn, functionCommand);

    if (PQresultStatus(res) != PGRES_TUPLES_OK) {
        printf("Stored function execution failed\n");
        printf(functionCommand);
        printf("\n");     
        PQclear(res);
        bad_exit(conn);
    }
    float ret_val = atof(PQgetvalue(res, 0, 0));
    PQclear(res);
    return ret_val;
}

/*
 * Prints the proper message for countDifferentPlayCharacters based 
 * on the return value of the postgreSQL operation.
 */
void printCountActor(int ret_val, int actorID) {
    if (ret_val >= 0) {
        printf("Number of different play characters for %d is %d\n", actorID, ret_val);
    } else {
        printf("There is no actor whose actorID is %d\n", actorID);
    }
}

/*
 * Prints the proper message for the renameTheater based on the
 * return value of the postgreSQL operation.
 */
void printRenameTheater(int ret_val, char *theater) {
    if (ret_val >= 0) {
        printf("%d theater names were renamed to %s by renameTheater\n", ret_val, theater);
    } else {
        printf("There already is a theater whose theaterName is %s\n", theater);
    }
}

/*
 * Prints the proper message for the increaseSomeCastMemberSalaries 
 * based on the return value of the postgreSQL operation.
 */
void printIncreaseSalaries(float ret_val, PGconn *conn, char *playTitle, int prodNum, int maxDailyCost) {
    if (ret_val >= 0) {
        printf("Total Daily Cost for %s, %d is now %7.2f\n", playTitle, prodNum, ret_val);
    } else if (ret_val == -1) {
        fprintf(stderr, "The play: %s with production num: %d was given an \
                invalid maxDailyCost: %7.2f\n", playTitle, prodNum, maxDailyCost);
        // Call bad exit if stored function returns an error code.
        bad_exit(conn);
    } else {
        fprintf(stderr, "The play: %s with production num: %d does not exist\n",
                playTitle, prodNum);
        // Call bad exit if stored function returns an error code.
        bad_exit(conn);
    }
}

int main(int argc, char **argv)
{
    PGconn *conn;
    int theResult;

    if (argc != 3)
    {
        fprintf(stderr, "Usage: ./runHighwayApplication <username> <password>\n");
        exit(EXIT_FAILURE);
    }

    char *userID = argv[1];
    char *pwd = argv[2];

    char conninfo[MAXCONNECTIONSTRINGSIZE] = "host=cse180-db.lt.ucsc.edu user=";
    strcat(conninfo, userID);
    strcat(conninfo, " password=");
    strcat(conninfo, pwd);

    /* Make a connection to the database */
    conn = PQconnectdb(conninfo);

    /* Check to see if the database connection was successfully made. */
    if (PQstatus(conn) != CONNECTION_OK)
    {
        fprintf(stderr, "Connection to database failed: %s\n",
                PQerrorMessage(conn));
        bad_exit(conn);
    }

    // PQexec(conn, "")
    
    /* Perform the calls to countDifferentPlayCharacters  listed in Section 6 of Lab4,
     * and print messages as described.
     */
    int ret_val = countDifferentPlayCharacters(conn, 1);
    printCountActor(ret_val, 1);
    ret_val = countDifferentPlayCharacters(conn, 2);
    printCountActor(ret_val, 2);
    ret_val = countDifferentPlayCharacters(conn, 6);
    printCountActor(ret_val, 6);
    ret_val = countDifferentPlayCharacters(conn, 7);
    printCountActor(ret_val, 7);
    /* Extra newline for readability */
    printf("\n");

    
    /* Perform the calls to renameTheater  listed in Section 6 of Lab4,
     * and print messages as described.
     */
    ret_val = renameTheater(conn, "West End Theater", "Olivier Theatre");
    printRenameTheater(ret_val, "Olivier Theatre");
    ret_val = renameTheater(conn, "Broadway Theater", "Sondheim Theater");
    printRenameTheater(ret_val, "Sondheim Theater");
    ret_val = renameTheater(conn, "Booth Theater", "New Booth Theater");
    printRenameTheater(ret_val, "New Booth Theater");
    /* Extra newline for readability */
    printf("\n");

    
    /* Perform the calls to IncreaseSomeCastMemberSalaries  listed in Section 6 of Lab4,
     * and print messages as described.
     * You may use helper functions to do this, if you want.
     */
    float ret_cost;
    ret_cost = increaseSomeCastMemberSalaries(conn, "Romeo and Juliet", 1, 2000.00);
    printIncreaseSalaries(ret_cost, conn, "Romeo and Juliet", 1, 2000.00);
    ret_cost = increaseSomeCastMemberSalaries(conn, "Macbeth", 1, 990.00);
    printIncreaseSalaries(ret_cost, conn, "Macbeth", 1, 990.00);
    ret_cost = increaseSomeCastMemberSalaries(conn, "The Merry Wives of Windsor", 1, 1125.00);
    printIncreaseSalaries(ret_cost, conn, "The Merry Wives of Windsor", 1, 1125.00);
    ret_cost = increaseSomeCastMemberSalaries(conn, "A Midsummer Nights Dream", 1, 1100.00);
    printIncreaseSalaries(ret_cost, conn, "A Midsummer Nights Dream", 1, 1100.00);
    ret_cost = increaseSomeCastMemberSalaries(conn, "Henry IV, Part 1", 1, 1060.00);
    printIncreaseSalaries(ret_cost, conn, "Henry IV, Part 1", 1, 1060.00);
    ret_cost = increaseSomeCastMemberSalaries(conn, "Hamlet", 1, 730.00);
    printIncreaseSalaries(ret_cost, conn, "Hamlet", 1, 730.00);

    good_exit(conn);
    return 0;
}
