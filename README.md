# Prashant-Choudhary-DBMS-AssignmentSolution
A.) Problem Statement Is Presented With 3 Approaches Keeping Data Normalisation As Base In Structure, where Tables are checked that they confirm to 1NF and 3NF such that
it can be implied that if Relation R conforms 1NF,3NF=> It will definitely conform 2NF
1.) Approach 1 uses decomposition of Passenger Table into 2 Tables as Passenger, and Routes that keeps info/data on Passenger details and Their Routes/Transport segreggated in  
these two tables, suitable primary and foreign keys were incorporated that finally relates to Price Table that again is separate from Passenger & Route Tables
2.) Approach 2 uses Passenger table and Price table in the same form as given in problem statement, with no primary & foreign keys present, and then these two given tables
Passenger & Price are related
3.) Approach 3 again uses the same two tables Passenger & Price where each table has their primary keys and foreign key where referencing table is Passenger and referenced 
table is Price;
So many approaches were provided to make more practice with the given problem statement and to check how queries behave on these distinct solutions
