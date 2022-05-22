-- touch 3-concurrency-issues-{1-dirty-reads,2-non-repeatable-reads,3-phantom-reads,4-deadlock}-t{1,2}.sql
USE [dbms-a3]; GO

-- insert a few values
DELETE FROM T1 WHERE name IS NOT NULL
INSERT INTO T1 VALUES ('name1', 2), ('name2', 2), ('name3', 2)


/*
How to run:
1. For a particular problem, like dirty reads, run the corresponding 't1' file, then
immediately run the corresponding 't2' file.
2. Switch between the problem and the solution by commenting out either of the 2 'SET TRANSACTION ISOLATION LEVEL'
statements.

How to easily run (in JetBrains DataGrip at least):
1. preparation:
    1. make sure there are different sessions associated with t1 and t2
    2. Ctrl + A in both t1 and t1 files to select all statements
    3. Go to t2 and then go to t1. (in order to be able to use Ctrl + Tab to switch between them)
2. actual running:
    1. Ctrl + Enter in t1 file
    2. Ctrl + Tab to switch to t2 file
    3. Ctrl + Enter in t2 file
3. For switching between problem and solution (aka between isolation levels) see 'How to run' step 2
    - note: in order to easily comment between problem and solution:
                always go on the first 'SET TRANSACTION ISOLATION LEVEL' statement and then
                double press the key combination 'Ctrl + /'.
                Even faster: use 'Ctrl + G', 4, Enter to go to that 1st line/statement.
*/


/***************************************************************************/
/******************************* Dirty Reads *******************************/
/***************************************************************************/

/***************************************************************************/
/**************************** Non-repeatable Reads *************************/
/***************************************************************************/

/***************************************************************************/
/****************************** Phantom Reads ******************************/
/***************************************************************************/

/***************************************************************************/
/******************************** Deadlock *********************************/
/***************************************************************************/
