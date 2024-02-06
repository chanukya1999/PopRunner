################################################################################
##                          Class Project                                     ##
################################################################################

# This class project is to test your knowledge of SELECT statement

################################################################################
##                                  PopRunner caselet                         ##
################################################################################
# Student Name - Chanukya Bolli
# This script is based on the PopRunner data - PopRunner is an online retailer
# Use the caselet and data (consumer.csv, pop_up.csv, purchase.csv, email.csv) 
# on D2L to answer questions below
# In this script, we will use SQL to do descriptive statistics
# Think about the managerial implications as you go along

options(warn=-1) # R function to turn off warnings
library(sqldf)

################################################################################

# Read the data in: consumer, pop_up, purchase and email tables

# set your working directory and use read.csv() to read files

setwd("C:/Users/Srinivas Bolli/Documents/DBMS-FINAL")

consumer<-read.csv("consumer.csv",header=TRUE)
pop_up<- read.csv("pop_up.csv",header=TRUE)
purchase<-read.csv("purchase.csv",header=TRUE)
email<-read.csv("email.csv",header=TRUE)

# Let us first start with exploring various tables

################################################################################

# Using SQL's LIMIT clause, display first 5 rows of all the four tables

# observe different rows and columns of the tables

################################################################################

# Query 1) Display first 5 rows of consumer table

sqldf("select * from consumer limit 5")

################################################################################

# Query 2) Display first 5 rows of pop_up table

sqldf("select * from pop_up limit 5")

################################################################################

# Query 3) Display first 5 rows of purchase table

sqldf("select * from purchase limit 5")

################################################################################

# Query 4) Display first 5 rows of email table

sqldf("select * from email limit 5")

################################################################################

# Now, let's look at the descriptive statistics one table at a time: consumer table

# Query 5: Display how many consumers are female and male (column alias: gender_count), 
#          also show what is the average age (column alias: average_age) of consumers by gender

# SELECT COUNT(*) AS <new column name>,
#        AVG(<column name>) AS <new column name>,
#        <grouping variable 1> FROM <table name> 
# GROUP BY <grouping variable 1>

# Hint: you will GROUP BY gender

sqldf("SELECT COUNT(*) AS gender_count, AVG(age) AS average_age, gender FROM consumer GROUP BY gender")

# Interpret your output in simple English (1-2 lines):
# Ans) The number of female consumers is 6903 and their average age is 30.61394 .
#      The number of male consumers is 2129 and their average age is 32.45186 .  

################################################################################

# Query 6: How many consumers are there in each loyalty status group (column alias: loyalty_count), 
# what is the average age (column alias: average_age) of consumers in each group

# Syntax: 

# SELECT COUNT(*) AS <new column name>,
#        AVG(<column name>) AS <new column name>,
#        <grouping variable 1> FROM <table name> 
# GROUP BY <grouping variable 1>

# Hint: you will GROUP BY loyalty_status

sqldf("SELECT COUNT(*) AS loyalty_count, AVG(age) AS average_age, loyalty_status FROM consumer GROUP BY loyalty_status")

# Interpret your output in simple English (1-2 lines):
# Ans) The number of consumers in the loyalty groups of 0, 1, 2, 3, 4 are 1529, 1740, 2612, 1385, 1766 and 
#      their average ages are 29.37345, 30.10345, 30.69908, 31.59278, 33.51302 respectively.   

################################################################################

# Next, let's look at the pop_up table

# Query 7: How many consumers (column alias: consumer_count) who received a
# pop_up message (column alias: pop_up)
# continue adding discount code to their card (column alias: discount_code) 
# opposed to consumers who do not receive a pop_up message

# Syntax: 

# SELECT COUNT(*) AS <new column name>,
#        <grouping variable 1> AS <new column name>, 
#        <grouping variable 2> AS <new column name> FROM <table name> 
# GROUP BY <grouping variable 1>, <grouping variable 2>

# Hint: you will use two grouping variable: GROUP BY pop_up, saved_discount

sqldf("SELECT COUNT(*) AS consumer_count, pop_up AS pop_up, saved_discount AS discount_code FROM pop_up GROUP BY pop_up, saved_discount")

# Interpret your output in simple English (1-2 lines):
# Ans) 1487 consumers that have received a pop up message continue adding discount code to their card as
#      opposed to 4516 consumers that did not receive a pop up and also have not applied a discount code,
#      while 3029 consumers have received a pop up but did not add the discount code.

################################################################################

# This is purchase table

# Query 8: On an average, how much did consumers spend on their 
# total sales (column alias: total_sales) during their online purchase

# Syntax:

# SELECT AVG(<column name>) AS <new column name> FROM <table name>

sqldf("SELECT AVG(sales_amount_total) AS total_sales FROM purchase")

# Interpret your output in simple English (1-2 lines):
# Ans) On an average consumers spend 135.2142 on their total sales during their online purchase.
################################################################################

# Finally, let's look at the email table

# Query 9: How many consumers (column alias: consumer_count) of the total opened the email blast

# Syntax:

# SELECT COUNT(*) AS <new column name>,
#       <group variable 1> from <table name> 
#   GROUP BY <group variable 1>


sqldf("SELECT COUNT(*) AS consumer_count, opened_email FROM email GROUP BY opened_email")

# Interpret your output in simple English (1-2 lines):
# Ans) 716 consumers opened the email blast. 
######################################################################################################

# Now we will combine/ merge tables to find answers

# Query 10: Was the pop-up advertisement successful? Mention yes/ no. 
# In other words, did consumers who received a pop_up message buy more

# Syntax:

# SELECT SUM(<column name>) AS <new column name>,
#        AVG(<column name>) AS <new column name>, 
#        <grouping variable 1> from <table 1>, <table 2>
#      WHERE <table 1>.<key column>=<table 2>.<key column> 
#      GROUP BY <grouping variable 1>

# Hint: you will calculate SUM of sales_amount_total (column alias: sum_sales)
# and AVG of sales_amount_total (column alias: avg_sales)
# GROUP BY pop_up
# Inner join on purchase and pop_up table on consumer_id

sqldf("SELECT SUM(sales_amount_total) AS sum_sales, AVG(sales_amount_total) AS avg_sales, pop_up FROM purchase, pop_up WHERE purchase.consumer_id=pop_up.consumer_id GROUP BY pop_up")

# Interpret your output in simple English (1-2 lines):
# Ans) No the pop up advertisement was not successful.
######################################################################################################

# Query 11) Did the consumer who spend the least during online shopping opened the pop_up message? Use nested queries.

# Write two separate queries 

# Query 11.1) Find the consumer_id who spent the least from the purchase table

# you can use ORDER BY and LIMIT clause together

# Syntax: 

# SELECT <column name> FROM <table name>
# ORDER BY <column name> LIMIT 1)

# Note: Here I am expecting details of only one consumer with minimum purchase. 
# Therefore, LIMIT 1. There are many consumers with sales_amount_total = 0, 
# however, you need information of any one for your second part of the project.

sqldf("SELECT consumer_id FROM purchase ORDER BY sales_amount_total LIMIT 1")

# Query 11.2) Use the consumer_id from the previous SELECT query to find if the consumer received a pop_up message from the pop_up table

sqldf("SELECT Consumer_id, pop_up FROM pop_up WHERE consumer_id = 5887286353")

# Query 11.3) Using ? for inner query, create a template to write nested query

sqldf("SELECT Consumer_id, pop_up FROM pop_up WHERE consumer_id = (?)")

# Query 11.4) Replace ? with the inner query

# Syntax:

# SELECT <column name 1>, <column name 2> FROM <table name> WHERE consumer_id = 
#      (inner query from Query 11.1)


sqldf("SELECT Consumer_id, pop_up FROM pop_up WHERE consumer_id = (SELECT consumer_id FROM purchase ORDER BY sales_amount_total LIMIT 1)")

# Interpret your output in simple English (1-2 lines):
# Ans) The consumer who spent the least during online shopping did not open the pop_up message
######################################################################################################

# Query 12: Was the email blast successful? Mention yes/ no. 
# In other words, did consumers who opened the email blast buy more

# Syntax:

# SELECT SUM(<column name>) AS <new column name>,
#        AVG(<column name>) AS <new column name>, 
#        <grouping variable 1> from <table 1>, <table 2>
#      WHERE <table 1>.<key column>=<table 2>.<key column> 
#      GROUP BY <grouping variable 1>

# Hint: you will calculate SUM of sales_amount_total (column alias: sum_sales) 
# and AVG of sales_amount_total (column alias: avg_sales)
# GROUP BY opened_email
# Inner join on purchase and email table on consumer_id

sqldf("SELECT SUM(sales_amount_total) AS sum_sales, AVG(sales_amount_total) AS avg_sales, opened_email FROM purchase, email WHERE purchase.consumer_id = email.consumer_id GROUP BY opened_email")

# Interpret your output in simple English (1-2 lines):
# Ans) Yes the email blast was successful, the consumers who opened the email bought more as 
#      their average sales is higher.

######################################################################################################

# Query 13) Did the consumer who spend the most during online shopping opened the email message? Use nested queries.

# Write two separate queries 

# Query 13.1) Find the consumer_id who spent the most from the purchase table

# you can use ORDER BY and LIMIT clause together

# Syntax: 

# SELECT <column name> FROM <table name>
# ORDER BY <column name> DESC LIMIT 1)

sqldf("SELECT consumer_id FROM purchase ORDER BY sales_amount_total DESC LIMIT 1")

# Query 13.2) Use the consumer_id from the previous SELECT query to find if the consumer opened the email from the email table

sqldf("SELECT * FROM email WHERE consumer_id = 5955534353")

# Query 13.3) Using ? for inner query, create a template to write nested query

sqldf("SELECT consumer_id, opened_email FROM email WHERE consumer_id IN(?)")

# #sqldf("SELECT * FROM table1 WHERE column1 IN(SELECT column2 FROM table2 WHERE column3 = ?)")

# Query 13.4) Replace ? with the inner query

# Syntax:

# SELECT <column name 1>, <column name 2> FROM <table name> WHERE consumer_id IN 
#      (inner query from Query 13.1)


sqldf("SELECT consumer_id, opened_email FROM email WHERE consumer_id IN(SELECT consumer_id FROM purchase ORDER BY sales_amount_total DESC LIMIT 1)")

# Interpret your output in simple English (1-2 lines):
# Ans) Yes the consumer who spent the most during the online shoping opened the email message
######################################################################################################
# Best Luck!
######################################################################################################

