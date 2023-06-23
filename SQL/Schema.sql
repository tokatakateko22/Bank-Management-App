/*==============================================================*/
/* DBMS name:      Microsoft SQL Server 2012                    */
/* Created on:     5/24/2023 2:50:30 AM                         */
/*==============================================================*/


if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('BANKACC') and o.name = 'FK_BANKACC_RELATIONS_BANK')
alter table BANKACC
   drop constraint FK_BANKACC_RELATIONS_BANK
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('BANKACC') and o.name = 'FK_BANKACC_RELATIONS_ACCOUNT')
alter table BANKACC
   drop constraint FK_BANKACC_RELATIONS_ACCOUNT
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('BANKBRANCH') and o.name = 'FK_BANKBRAN_RELATIONS_BANK')
alter table BANKBRANCH
   drop constraint FK_BANKBRAN_RELATIONS_BANK
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('BANKEMPLOYEE') and o.name = 'FK_BANKEMPL_RELATIONS_BANK')
alter table BANKEMPLOYEE
   drop constraint FK_BANKEMPL_RELATIONS_BANK
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('BANKEMPLOYEE') and o.name = 'FK_BANKEMPL_RELATIONS_EMPLOYEE')
alter table BANKEMPLOYEE
   drop constraint FK_BANKEMPL_RELATIONS_EMPLOYEE
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('BANKLOAN') and o.name = 'FK_BANKLOAN_RELATIONS_BANK')
alter table BANKLOAN
   drop constraint FK_BANKLOAN_RELATIONS_BANK
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('BANKLOAN') and o.name = 'FK_BANKLOAN_RELATIONS_LOAN')
alter table BANKLOAN
   drop constraint FK_BANKLOAN_RELATIONS_LOAN
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('CUSTOMERACC') and o.name = 'FK_CUSTOMER_RELATIONS_ACCOUNT')
alter table CUSTOMERACC
   drop constraint FK_CUSTOMER_RELATIONS_ACCOUNT
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('CUSTOMERACC') and o.name = 'FK_CUSTOMER_RELATIONS_CUSTOMER')
alter table CUSTOMERACC
   drop constraint FK_CUSTOMER_RELATIONS_CUSTOMER
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('CUSTOMERLOAN') and o.name = 'FK_CUSTOMER_RELATIONS_LOAN')
alter table CUSTOMERLOAN
   drop constraint FK_CUSTOMER_RELATIONS_LOAN
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('EMPLOYEE') and o.name = 'FK_EMPLOYEE_RELATIONS_BANKBRAN')
alter table EMPLOYEE
   drop constraint FK_EMPLOYEE_RELATIONS_BANKBRAN
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('RELATIONSHIP_2') and o.name = 'FK_RELATION_RELATIONS_BANKCUST2')
alter table RELATIONSHIP_2
   drop constraint FK_RELATION_RELATIONS_BANKCUST2
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('RELATIONSHIP_2') and o.name = 'FK_RELATION_RELATIONS_BANK')
alter table RELATIONSHIP_2
   drop constraint FK_RELATION_RELATIONS_BANK
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('RELATIONSHIP_3') and o.name = 'FK_RELATION_RELATIONS_BANKCUST')
alter table RELATIONSHIP_3
   drop constraint FK_RELATION_RELATIONS_BANKCUST
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('RELATIONSHIP_3') and o.name = 'FK_RELATION_RELATIONS_CUSTOMER')
alter table RELATIONSHIP_3
   drop constraint FK_RELATION_RELATIONS_CUSTOMER
go

if exists (select 1
            from  sysobjects
           where  id = object_id('ACCOUNT')
            and   type = 'U')
   drop table ACCOUNT
go

if exists (select 1
            from  sysobjects
           where  id = object_id('BANK')
            and   type = 'U')
   drop table BANK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('BANKACC')
            and   name  = 'RELATIONSHIP_17_FK'
            and   indid > 0
            and   indid < 255)
   drop index BANKACC.RELATIONSHIP_17_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('BANKACC')
            and   name  = 'RELATIONSHIP_16_FK'
            and   indid > 0
            and   indid < 255)
   drop index BANKACC.RELATIONSHIP_16_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('BANKACC')
            and   type = 'U')
   drop table BANKACC
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('BANKBRANCH')
            and   name  = 'RELATIONSHIP_6_FK'
            and   indid > 0
            and   indid < 255)
   drop index BANKBRANCH.RELATIONSHIP_6_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('BANKBRANCH')
            and   type = 'U')
   drop table BANKBRANCH
go

if exists (select 1
            from  sysobjects
           where  id = object_id('BANKCUSTOMER')
            and   type = 'U')
   drop table BANKCUSTOMER
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('BANKEMPLOYEE')
            and   name  = 'RELATIONSHIP_15_FK'
            and   indid > 0
            and   indid < 255)
   drop index BANKEMPLOYEE.RELATIONSHIP_15_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('BANKEMPLOYEE')
            and   name  = 'RELATIONSHIP_14_FK'
            and   indid > 0
            and   indid < 255)
   drop index BANKEMPLOYEE.RELATIONSHIP_14_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('BANKEMPLOYEE')
            and   type = 'U')
   drop table BANKEMPLOYEE
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('BANKLOAN')
            and   name  = 'RELATIONSHIP_11_FK'
            and   indid > 0
            and   indid < 255)
   drop index BANKLOAN.RELATIONSHIP_11_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('BANKLOAN')
            and   name  = 'RELATIONSHIP_10_FK'
            and   indid > 0
            and   indid < 255)
   drop index BANKLOAN.RELATIONSHIP_10_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('BANKLOAN')
            and   type = 'U')
   drop table BANKLOAN
go

if exists (select 1
            from  sysobjects
           where  id = object_id('CUSTOMER')
            and   type = 'U')
   drop table CUSTOMER
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('CUSTOMERACC')
            and   name  = 'RELATIONSHIP_19_FK'
            and   indid > 0
            and   indid < 255)
   drop index CUSTOMERACC.RELATIONSHIP_19_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('CUSTOMERACC')
            and   name  = 'RELATIONSHIP_18_FK'
            and   indid > 0
            and   indid < 255)
   drop index CUSTOMERACC.RELATIONSHIP_18_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('CUSTOMERACC')
            and   type = 'U')
   drop table CUSTOMERACC
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('CUSTOMERLOAN')
            and   name  = 'RELATIONSHIP_13_FK'
            and   indid > 0
            and   indid < 255)
   drop index CUSTOMERLOAN.RELATIONSHIP_13_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('CUSTOMERLOAN')
            and   name  = 'RELATIONSHIP_12_FK'
            and   indid > 0
            and   indid < 255)
   drop index CUSTOMERLOAN.RELATIONSHIP_12_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('CUSTOMERLOAN')
            and   type = 'U')
   drop table CUSTOMERLOAN
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('EMPLOYEE')
            and   name  = 'RELATIONSHIP_20_FK'
            and   indid > 0
            and   indid < 255)
   drop index EMPLOYEE.RELATIONSHIP_20_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('EMPLOYEE')
            and   type = 'U')
   drop table EMPLOYEE
go

if exists (select 1
            from  sysobjects
           where  id = object_id('LOAN')
            and   type = 'U')
   drop table LOAN
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('RELATIONSHIP_2')
            and   name  = 'RELATIONSHIP_2_FK'
            and   indid > 0
            and   indid < 255)
   drop index RELATIONSHIP_2.RELATIONSHIP_2_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('RELATIONSHIP_2')
            and   type = 'U')
   drop table RELATIONSHIP_2
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('RELATIONSHIP_3')
            and   name  = 'RELATIONSHIP_4_FK'
            and   indid > 0
            and   indid < 255)
   drop index RELATIONSHIP_3.RELATIONSHIP_4_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('RELATIONSHIP_3')
            and   type = 'U')
   drop table RELATIONSHIP_3
go

/*==============================================================*/
/* Table: ACCOUNT                                               */
/*==============================================================*/
create table ACCOUNT (
   ACCOUNTID            numeric(15)          not null,
   BALANCE              money                not null,
   ACCOUNTTYPE          varchar(50)          not null,
   constraint PK_ACCOUNT primary key nonclustered (ACCOUNTID)
)
go

/*==============================================================*/
/* Table: BANK                                                  */
/*==============================================================*/
create table BANK (
   BANKID               numeric(15)          not null,
   BANKADDRESS          varchar(50)          not null,
   BANKNAME             varchar(50)          not null,
   BANKPHONENO          numeric(15)          null,
   constraint PK_BANK primary key nonclustered (BANKID)
)
go

/*==============================================================*/
/* Table: BANKACC                                               */
/*==============================================================*/
create table BANKACC (
   BANKID               numeric(15)          not null,
   ACCOUNTID            numeric(15)          not null,
   constraint PK_BANKACC primary key (BANKID, ACCOUNTID)
)
go

/*==============================================================*/
/* Index: RELATIONSHIP_16_FK                                    */
/*==============================================================*/
create index RELATIONSHIP_16_FK on BANKACC (
BANKID ASC
)
go

/*==============================================================*/
/* Index: RELATIONSHIP_17_FK                                    */
/*==============================================================*/
create index RELATIONSHIP_17_FK on BANKACC (
ACCOUNTID ASC
)
go

/*==============================================================*/
/* Table: BANKBRANCH                                            */
/*==============================================================*/
create table BANKBRANCH (
   BRANCHADDRESS        varchar(50)          not null,
   BRANCHID             numeric(15)          not null,
   BANKID               numeric(15)          null,
   BRANCHPHONENO        numeric(15)          not null,
   constraint PK_BANKBRANCH primary key nonclustered (BRANCHID)
)
go

/*==============================================================*/
/* Index: RELATIONSHIP_6_FK                                     */
/*==============================================================*/
create index RELATIONSHIP_6_FK on BANKBRANCH (
BANKID ASC
)
go

/*==============================================================*/
/* Table: BANKCUSTOMER                                          */
/*==============================================================*/
create table BANKCUSTOMER (
   JOINED               datetime             not null,
   BANKID               char(10)             not null,
   CUSTOMERID           char(10)             not null,
   constraint PK_BANKCUSTOMER primary key (BANKID, CUSTOMERID)
)
go

/*==============================================================*/
/* Table: BANKEMPLOYEE                                          */
/*==============================================================*/
create table BANKEMPLOYEE (
   BANKID               numeric(15)          not null,
   EMPLOYEEID           numeric(5)           not null,
   constraint PK_BANKEMPLOYEE primary key (BANKID, EMPLOYEEID)
)
go

/*==============================================================*/
/* Index: RELATIONSHIP_14_FK                                    */
/*==============================================================*/
create index RELATIONSHIP_14_FK on BANKEMPLOYEE (
BANKID ASC
)
go

/*==============================================================*/
/* Index: RELATIONSHIP_15_FK                                    */
/*==============================================================*/
create index RELATIONSHIP_15_FK on BANKEMPLOYEE (
EMPLOYEEID ASC
)
go

/*==============================================================*/
/* Table: BANKLOAN                                              */
/*==============================================================*/
create table BANKLOAN (
   BANKID               numeric(15)          not null,
   LOANID               numeric(15)          not null,
   constraint PK_BANKLOAN primary key (BANKID, LOANID)
)
go

/*==============================================================*/
/* Index: RELATIONSHIP_10_FK                                    */
/*==============================================================*/
create index RELATIONSHIP_10_FK on BANKLOAN (
BANKID ASC
)
go

/*==============================================================*/
/* Index: RELATIONSHIP_11_FK                                    */
/*==============================================================*/
create index RELATIONSHIP_11_FK on BANKLOAN (
LOANID ASC
)
go

/*==============================================================*/
/* Table: CUSTOMER                                              */
/*==============================================================*/
create table CUSTOMER (
   CUSTOMERID           numeric(15)          not null,
   CUSTOMERNAME         varchar(50)          not null,
   CUSTEMAIL            varchar(50)          null,
   CUSTOMERPHONENO      numeric(15)          null,
   CUSTPASSWORD         varchar(50)          null,
   constraint PK_CUSTOMER primary key nonclustered (CUSTOMERID)
)
go

/*==============================================================*/
/* Table: CUSTOMERACC                                           */
/*==============================================================*/
create table CUSTOMERACC (
   ACCOUNTID            numeric(15)          not null,
   CUSTOMERID           numeric(15)          not null,
   constraint PK_CUSTOMERACC primary key (ACCOUNTID, CUSTOMERID)
)
go

/*==============================================================*/
/* Index: RELATIONSHIP_18_FK                                    */
/*==============================================================*/
create index RELATIONSHIP_18_FK on CUSTOMERACC (
ACCOUNTID ASC
)
go

/*==============================================================*/
/* Index: RELATIONSHIP_19_FK                                    */
/*==============================================================*/
create index RELATIONSHIP_19_FK on CUSTOMERACC (
CUSTOMERID ASC
)
go

/*==============================================================*/
/* Table: CUSTOMERLOAN                                          */
/*==============================================================*/
create table CUSTOMERLOAN (
   CUSTOMERID           numeric(15)          not null,
   LOANID               numeric(15)          not null,
   constraint PK_CUSTOMERLOAN primary key (CUSTOMERID, LOANID)
)
go

/*==============================================================*/
/* Index: RELATIONSHIP_12_FK                                    */
/*==============================================================*/
create index RELATIONSHIP_12_FK on CUSTOMERLOAN (
CUSTOMERID ASC
)
go

/*==============================================================*/
/* Index: RELATIONSHIP_13_FK                                    */
/*==============================================================*/
create index RELATIONSHIP_13_FK on CUSTOMERLOAN (
LOANID ASC
)
go

/*==============================================================*/
/* Table: EMPLOYEE                                              */
/*==============================================================*/
create table EMPLOYEE (
   EMPLOYEEEMAIL        varchar(50)          not null,
   EMPLOYEENAME         varchar(50)          not null,
   EMPLYEEPASSWORD      varchar(50)          not null,
   EMPLOYEEID           numeric(5)           not null,
   BRANCHID             numeric(15)          null,
   ISADMIN              bit                  null,
   constraint PK_EMPLOYEE primary key nonclustered (EMPLOYEEID)
)
go

/*==============================================================*/
/* Index: RELATIONSHIP_20_FK                                    */
/*==============================================================*/
create index RELATIONSHIP_20_FK on EMPLOYEE (
BRANCHID ASC
)
go

/*==============================================================*/
/* Table: LOAN                                                  */
/*==============================================================*/
create table LOAN (
   LOANID               numeric(15)          not null,
   LOANTYPE             varchar(50)          not null,
   LOANAMOUNT           money                not null,
   LOANAPPROVED         bit                  null,
   constraint PK_LOAN primary key nonclustered (LOANID)
)
go

/*==============================================================*/
/* Table: RELATIONSHIP_2                                        */
/*==============================================================*/
create table RELATIONSHIP_2 (
   BANKID               numeric(15)          not null,
   BAN_BANKID           char(10)             null,
   CUSTOMERID           char(10)             null,
   constraint PK_RELATIONSHIP_2 primary key (BANKID)
)
go

/*==============================================================*/
/* Index: RELATIONSHIP_2_FK                                     */
/*==============================================================*/
create index RELATIONSHIP_2_FK on RELATIONSHIP_2 (
BAN_BANKID ASC,
CUSTOMERID ASC
)
go

/*==============================================================*/
/* Table: RELATIONSHIP_3                                        */
/*==============================================================*/
create table RELATIONSHIP_3 (
   CUSTOMERID           numeric(15)          not null,
   BANKID               char(10)             null,
   BAN_CUSTOMERID       char(10)             null,
   constraint PK_RELATIONSHIP_3 primary key (CUSTOMERID)
)
go

/*==============================================================*/
/* Index: RELATIONSHIP_4_FK                                     */
/*==============================================================*/
create index RELATIONSHIP_4_FK on RELATIONSHIP_3 (
BANKID ASC,
BAN_CUSTOMERID ASC
)
go

alter table BANKACC
   add constraint FK_BANKACC_RELATIONS_BANK foreign key (BANKID)
      references BANK (BANKID)
go

alter table BANKACC
   add constraint FK_BANKACC_RELATIONS_ACCOUNT foreign key (ACCOUNTID)
      references ACCOUNT (ACCOUNTID)
go

alter table BANKBRANCH
   add constraint FK_BANKBRAN_RELATIONS_BANK foreign key (BANKID)
      references BANK (BANKID)
go

alter table BANKEMPLOYEE
   add constraint FK_BANKEMPL_RELATIONS_BANK foreign key (BANKID)
      references BANK (BANKID)
go

alter table BANKEMPLOYEE
   add constraint FK_BANKEMPL_RELATIONS_EMPLOYEE foreign key (EMPLOYEEID)
      references EMPLOYEE (EMPLOYEEID)
go

alter table BANKLOAN
   add constraint FK_BANKLOAN_RELATIONS_BANK foreign key (BANKID)
      references BANK (BANKID)
go

alter table BANKLOAN
   add constraint FK_BANKLOAN_RELATIONS_LOAN foreign key (LOANID)
      references LOAN (LOANID)
go

alter table CUSTOMERACC
   add constraint FK_CUSTOMER_RELATIONS_ACCOUNT foreign key (ACCOUNTID)
      references ACCOUNT (ACCOUNTID)
go

alter table CUSTOMERACC
   add constraint FK_CUSTOMER_RELATIONS_CUSTOMER foreign key (CUSTOMERID)
      references CUSTOMER (CUSTOMERID)
go

alter table CUSTOMERLOAN
   add constraint FK_CUSTOMER_RELATIONS_LOAN foreign key (LOANID)
      references LOAN (LOANID)
go

alter table EMPLOYEE
   add constraint FK_EMPLOYEE_RELATIONS_BANKBRAN foreign key (BRANCHID)
      references BANKBRANCH (BRANCHID)
go

alter table RELATIONSHIP_2
   add constraint FK_RELATION_RELATIONS_BANKCUST2 foreign key (BAN_BANKID, CUSTOMERID)
      references BANKCUSTOMER (BANKID, CUSTOMERID)
go

alter table RELATIONSHIP_2
   add constraint FK_RELATION_RELATIONS_BANK foreign key (BANKID)
      references BANK (BANKID)
go

alter table RELATIONSHIP_3
   add constraint FK_RELATION_RELATIONS_BANKCUST foreign key (BANKID, BAN_CUSTOMERID)
      references BANKCUSTOMER (BANKID, CUSTOMERID)
go

alter table RELATIONSHIP_3
   add constraint FK_RELATION_RELATIONS_CUSTOMER foreign key (CUSTOMERID)
      references CUSTOMER (CUSTOMERID)
go


-- Insert data into BANK table
INSERT INTO BANK (BANKID, BANKADDRESS, BANKNAME, BANKPHONENO)
VALUES
(1, '123 Main St', 'Bank A', 1234567890),
(2, '456 Elm St', 'Bank B', 9876543210);

-- Insert data into ACCOUNT table
INSERT INTO ACCOUNT (ACCOUNTID, BALANCE, ACCOUNTTYPE)
VALUES
(1, 1000, 'Savings'),
(2, 5000, 'Checking'),
(3, 20000, 'Savings');


-- Insert data into CUSTOMER table
INSERT INTO CUSTOMER (CUSTOMERID, CUSTOMERNAME, CUSTEMAIL, CUSTOMERPHONENO, CUSTPASSWORD)
VALUES
(1, 'John Doe', 'john@example.com', 5551111111, 'password1'),
(2, 'Jane Smith', 'jane@example.com', 5552222222, 'password2');

-- Insert data into CUSTOMERACC table
INSERT INTO CUSTOMERACC (CUSTOMERID, ACCOUNTID)
VALUES
(1, 1),
(1, 2),
(2, 3);

-- Insert data into LOAN table
INSERT INTO LOAN (LOANID, LOANTYPE, LOANAMOUNT, LOANAPPROVED)
VALUES
(1, 'Personal', 10000, 1),
(2, 'Mortgage', 200000, 0),
(3, 'Auto', 5000, 1);

-- Insert data into CUSTOMERLOAN table
INSERT INTO CUSTOMERLOAN (CUSTOMERID, LOANID)
VALUES
(1, 1),
(1, 2),
(2, 3);

-- Insert data into BANKLOAN table
INSERT INTO BANKLOAN (BANKID, LOANID)
VALUES
(1, 1),
(1, 2),
(2, 3);

-- Insert data into RELATIONSHIP_2 table
INSERT INTO RELATIONSHIP_2 (BANKID)
VALUES
(1),
(2);

-- Insert data into RELATIONSHIP_3 table
INSERT INTO RELATIONSHIP_3 (CUSTOMERID)
VALUES
(1),
(2);

-- Insert data into EMPLOYEE table
INSERT INTO EMPLOYEE (EMPLOYEEEMAIL, EMPLOYEENAME, EMPLYEEPASSWORD, EMPLOYEEID, ISADMIN)
VALUES
('emp1@example.com', 'Employee 1', 'emppass1', 1, 1),
('emp2@example.com', 'Employee 2', 'emppass2', 2, 1),
('emp3@example.com', 'Employee 3', 'emppass3', 3, 0),
('emp4@example.com', 'Employee 3', 'emppass4', 4, 1);

-- Insert data into BANKACC table
INSERT INTO BANKACC (BANKID, ACCOUNTID)
VALUES
(1, 1),
(1, 2),
(2, 3);

-- Insert data into BANKBRANCH table
INSERT INTO BANKBRANCH (BRANCHADDRESS, BRANCHID, BANKID, BRANCHPHONENO)
VALUES
('789 Oak St', 1, 1, 5551234567),
('321 Pine St', 2, 1, 5559876543);

-- Insert data into BANKCUSTOMER table
INSERT INTO BANKCUSTOMER (BANKID, CUSTOMERID, JOINED)
VALUES
(1, 1, '2022-05-30'),
(1, 2, '2022-05-30'),
(2, 1, '2022-05-30');

-- Insert data into BANKEMPLOYEE table
INSERT INTO BANKEMPLOYEE (BANKID, EMPLOYEEID)
VALUES
(1, 1),
(1, 2),
(2, 3);
