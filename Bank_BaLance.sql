create database Bank_Balance;
select* from bank_balance;

create table BondBalance(
ID text,
CustID text,
BalanceDate date,
Balance decimal(10,2));
select* from bondBalance;

insert into Bondbalance values
("1","1","2018-12-01",120000);
insert into Bondbalance values
("2","2","2019-01-01",200000);
insert into  Bondbalance values
("3","2","2019-02-01",198000);
insert into  Bondbalance values
("4","2","2019-03-01",196000);
insert into Bondbalance values
("5","3","2019-01-01",600000);
insert into  Bondbalance values
("6","4","2019-01-01",450000);
insert into Bondbalance values
("7","4","2019-02-01",445000);
select* from  Bondbalance;


create table CreditCardBalance(
ID text,
CustID text,
BalanceDate date,
Balance decimal(10,2));
select* from CreditCardBalance;

insert into CreditCardBalance values
("1","1","2019-01-01",2000);
insert into CreditCardBalance values
("2","1","2019-02-01",2500);
insert into CreditCardBalance values
("3","2","2019-02-01",1250);
insert into CreditCardBalance values
("4","3","2019-01-01",800);
insert into CreditCardBalance values
("5","3","2019-02-01",120);
insert into CreditCardBalance values
("6","4","2019-01-01",600);
select * from CreditCardBalance;


create table Customer(
ID text,
CustomerName text);
select* from Customer;

insert into Customer  values 
("1","John Fosudo");
insert into Customer  values 
("2","Clara Ayomikun");
insert into Customer  values 
("3","Tsepho Chinedu");
insert into Customer  values 
("4","Sandeep Sharma");
select* from Customer;

#Desired Result 1
with bt as (SELECT CustID, MAX(BalanceDate) AS "MaxDate", Balance, "Bond" AS AccountType FROM BondBalance),
ct as (SELECT CustID, MAX(BalanceDate) AS "MaxDate", Balance, "CreditCard" AS AccountType FROM CreditCardBalance),
Rr as (Select * from bt union all select * from ct GROUP by CustID) 
Select customer.CustomerName, Rr.MaxDate, Rr.Balance, Rr.AccountType from Rr join Customer on Customer.ID = Rr.CustID;

#Desired Result 2
select CustomerName,MAX(BalanceDate) AS MaxDate,Balance,"Credit Card" AS AccountType
from customer
INNER JOIN creditcardbalance ON customer.ID=creditcardbalance.CustID 
group by CustomerName
UNION ALL
SELECT CustomerName,MAX(BalanceDate) AS MaxDate,Balance,"Bond" AS AccountType
from customer
INNER JOIN bondbalance ON customer.ID=bondbalance.CustID 
group by CustomerName
order by CustomerName;