-- Create the database
-- create the table (fraudulents)
-- import the data from fraudulents & select header
create table fraudulent (
	step int,
	type varchar(10),
	amount float,
	nameOrig varchar(50),
	oldbalanceOrg float,
	newbalanceOrig float,
	nameDest varchar(50),
	oldbalanceDest float,
	newbalanceDest float,
	isFraud int,
	isFlaggedFraud int

);


select * from fraudulent


-- Q1How many transactions happened per transaction type
select type, count(type) 
from fraudulent
group by type
order by 2 desc;

OR

select type, count(*) as no_of_transactions
from fraudulent
group by type
order by count(*) desc;


--Q2 Which transaction type as the highest number of fraudulent transcation?
select type, count(*) as no_of_transactions
from fraudulent
group by type
order by count(*) desc
limit 1;


--Q3 What is the average fraudulent transaction amount?
select type, round(avg(amount)::numeric, 2)
from fraudulent
where isfraud = 1
group by type;


--Q4 What is the maximum transaction fraudulent amount?
select max(amount)
from fraudulent;


--Q5 What is the minimum transaction fraudulent amount?
select min(amount)
from fraudulent;


--Q6 Who are the top 10 customers that are defrauded?
select nameorig, sum(amount)
from fraudulent
where isfraud = 1
group by nameorig
order by sum(amount) desc
limit 10;


select * from fraudulent

--Q7 How effective is the bank in detecting fraud?
select sum(isflaggedfraud) as flagged, sum(isfraud) as fraud, sum(isfraud)/sum(isflaggedfraud) as fraud_committed
from fraudulent;

--513 frauds are committed before the bank detects fraud. 
--Its advised the bank change it fraud detection system.
--The bank is not effective in detecting fraud.


--Q8 Who are the top 20 fraudsters?

select namedest, sum(amount) as total_amount
from fraudulent
where isfraud = 1
group by namedest
order by sum(amount) desc
limit 20;