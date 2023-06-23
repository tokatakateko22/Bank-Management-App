import pyodbc


class DatabaseManager:
    def __init__(self):
        self.__conn_str = (
            "Driver={ODBC Driver 18 for SQL Server};"
            "Server=tcp:databaseprojec.database.windows.net,1433;"
            "Database=main;"
            "UID=main;"
            "PWD=qabSa3-gydjyq-syxnap;"
            "Connection Timeout=30;"
        )
        self.conn = pyodbc.connect(self.__conn_str, autocommit=False)

    def getPassword(self, email: str):
        cursor = self.conn.cursor()
        row = cursor.execute(f"SELECT CUSTPASSWORD FROM CUSTOMER WHERE CUSTEMAIL = '{email}';").fetchone()
        cursor.close()
        return row[0]

    def getUserID(self, email: str):
        cursor = self.conn.cursor()
        row = cursor.execute(f"SELECT CUSTOMERID FROM CUSTOMER WHERE CUSTEMAIL = '{email}';").fetchone()
        cursor.close()
        return row[0]

    def getEmployeeID(self, email: str):
        cursor = self.conn.cursor()
        row = cursor.execute(f"SELECT EMPLOYEEID FROM EMPLOYEE WHERE EMPLOYEEEMAIL = '{email}';").fetchone()
        cursor.close()
        return row[0]

    def getEmployeePassword(self, email: str):
        cursor = self.conn.cursor()
        row = cursor.execute(f"SELECT EMPLYEEPASSWORD FROM EMPLOYEE WHERE EMPLOYEEEMAIL = '{email}';").fetchone()
        cursor.close()
        return row[0]

    def insertCustomer(self, customerName: str, customerEmail: str, customerId: int, customerPassword: int, customerPhone: int):
        cursor = self.conn.cursor()
        cursor.execute(f"INSERT INTO CUSTOMER (CUSTOMERID, CUSTEMAIL, CUSTOMERNAME, CUSTPASSWORD, CUSTOMERPHONENO) VALUES ({customerId}, '{customerEmail}', '{customerName}', '{customerPassword}', {customerPhone});")
        cursor.close()
        return True

    def insertEmployee(self, employeeName: str, employeeEmail: str, employeeID: int, employeePassword: str, isAdmin: bool, bankID: int):
        cursor = self.conn.cursor()
        val = 1 if isAdmin else 0
        cursor.execute(f"INSERT INTO EMPLOYEE (EMPLOYEENAME, EMPLOYEEEMAIL, EMPLOYEEID, EMPLYEEPASSWORD, ISADMIN) VALUES ('{employeeName}', '{employeeEmail}', {employeeID}, '{employeePassword}', {val});")
        cursor.execute(f"INSERT INTO BANKEMPLOYEE (BANKID, EMPLOYEEID) VALUES ({bankID}, {employeeID});")
        cursor.close()
        return True

    def getCustomerAccounts(self, accountId: int):
        cursor = self.conn.cursor()
        query = f"SELECT A.*, B.BANKNAME FROM ACCOUNT A " \
                f"INNER JOIN BANKACC BA ON A.ACCOUNTID = BA.ACCOUNTID " \
                f"INNER JOIN BANK B ON BA.BANKID = B.BANKID " \
                f"WHERE A.ACCOUNTID IN (SELECT ACCOUNTID FROM CUSTOMERACC WHERE CUSTOMERID = {accountId})"
        cursor.execute(query)
        rows = cursor.fetchall()
        cursor.close()
        return rows

    def getCustomers(self):
        cursor = self.conn.cursor()
        row = cursor.execute(f"SELECT CUSTOMERID, CUSTOMERNAME, CUSTEMAIL, CUSTOMERPHONENO  FROM CUSTOMER;").fetchall()
        cursor.close()
        return row

    def getAccountBalance(self, accountID: int):
        cursor = self.conn.cursor()
        row = cursor.execute(f"SELECT BALANCE FROM ACCOUNT WHERE ACCOUNTID = {accountID};").fetchone()
        cursor.close()
        return row[0]

    def updateAccountBalance(self, accountID: int, amount: float):
        update = self.getAccountBalance(accountID) + amount
        cursor = self.conn.cursor()
        cursor.execute(f"UPDATE ACCOUNT SET BALANCE = {update} WHERE ACCOUNTID = {accountID};")
        cursor.close()
        return True

    def getCustomerLoans(self, customerID: int):
        cursor = self.conn.cursor()
        query = f"SELECT L.*, B.BANKNAME FROM LOAN L " \
                f"INNER JOIN CUSTOMERLOAN CL ON L.LOANID = CL.LOANID " \
                f"INNER JOIN BANKLOAN BL ON L.LOANID = BL.LOANID " \
                f"INNER JOIN BANK B ON BL.BANKID = B.BANKID " \
                f"WHERE CL.CUSTOMERID = {customerID}"
        cursor.execute(query)
        rows = cursor.fetchall()
        cursor.close()
        return rows
    def updateLoan(self, loanAmount: int, loanID: int):
        cursor = self.conn.cursor()
        cursor.execute(f"UPDATE LOAN SET LOANAMOUNT = {loanAmount} WHERE LOANID = {loanID};")
        cursor.close()
        return True

    def acceptLoan(self, loanID):
        cursor = self.conn.cursor()
        cursor.execute(f"UPDATE LOAN SET LOANAPPROVED = 1 WHERE LOANID = {loanID};")
        cursor.close()
        return True

    def getLoanAmount(self, loanID: int):
        cursor = self.conn.cursor()
        row = cursor.execute(f"SELECT LOANAMOUNT FROM LOAN WHERE LOANID = {loanID};").fetchone()
        cursor.close()
        return row[0]

    def deleteLoan(self, loanId: int):
        cursor = self.conn.cursor()
        cursor.execute(f"DELETE FROM BANKLOAN WHERE LOANID = {loanId};")
        cursor.execute(f"DELETE FROM CUSTOMERLOAN WHERE LOANID = {loanId};")
        cursor.execute(f"DELETE FROM LOAN WHERE LOANID = {loanId};")
        cursor.close()
        return True



    def insertLoan(self, loanID: int, loanAmount: int, loanType: str, customerID: int, bankID: int):
        cursor = self.conn.cursor()
        cursor.execute(
            f"INSERT INTO LOAN (LOANID, LOANTYPE, LOANAMOUNT, LOANAPPROVED) VALUES ({loanID}, '{loanType}', {loanAmount}, 0);")
        cursor.execute(f"INSERT INTO CUSTOMERLOAN (CUSTOMERID, LOANID) VALUES ({customerID}, {loanID});")
        cursor.execute(f"INSERT INTO BANKLOAN (BANKID, LOANID) VALUES ({bankID}, {loanID});")  # Insert into BANKLOAN
        cursor.close()
        return True

    def addAccount(self, accountBalance: int, accountType: str, accountID: int, customer_id: int, bankID: int):
        cursor = self.conn.cursor()
        cursor.execute(
            f"INSERT INTO ACCOUNT (ACCOUNTID, BALANCE, ACCOUNTTYPE) VALUES ({accountID}, {accountBalance}, '{accountType}');")
        cursor.execute(f"INSERT INTO CUSTOMERACC (CUSTOMERID, ACCOUNTID) VALUES ({customer_id}, {accountID});")
        cursor.execute(
            f"INSERT INTO BANKACC (BANKID, ACCOUNTID) VALUES ({bankID}, {accountID});")
        cursor.close()
        return True

    def deleteAccount(self, accountID: int):
        cursor = self.conn.cursor()
        cursor.execute(f"DELETE FROM BANKACC WHERE ACCOUNTID = {accountID};")
        cursor.execute(f"DELETE FROM CUSTOMERACC WHERE ACCOUNTID = {accountID};")
        cursor.execute(f"DELETE FROM ACCOUNT WHERE ACCOUNTID = {accountID};")
        cursor.close()
        return True

    def updateAccount(self, accountID: int, accountBalance: int):
        cursor = self.conn.cursor()
        cursor.execute(f"UPDATE ACCOUNT SET BALANCE = {accountBalance} WHERE ACCOUNTID = {accountID};")
        cursor.close()
        return True

    def getBanks(self):
        cursor = self.conn.cursor()
        row = cursor.execute(f"SELECT BANKID, BANKNAME, BANKADDRESS, BANKPHONENO FROM BANK;").fetchall()
        cursor.close()
        return row

    def addBank(self, bankID, bankName, bankAddress, bankPhone):
        cursor = self.conn.cursor()
        cursor.execute(f"INSERT INTO BANK (BANKNAME, BANKADDRESS, BANKID, BANKPHONENO) VALUES ('{bankName}', '{bankAddress}', {bankID}, {bankPhone});")
        cursor.close()
        return True

    def getBranches(self):
        cursor = self.conn.cursor()
        row = cursor.execute(f"SELECT B.BANKNAME, BB.BRANCHADDRESS,BB.BRANCHID, BB.BRANCHPHONENO FROM BANK B JOIN BANKBRANCH BB ON B.BANKID = BB.BANKID;").fetchall()
        cursor.close()
        return row

    def getBankCustomers(self, bankID: int):
        cursor = self.conn.cursor()
        row = cursor.execute(f"SELECT C.* FROM CUSTOMER C JOIN BANKCUSTOMER BC ON C.CUSTOMERID = BC.CUSTOMERID WHERE BC.BANKID = {bankID};")
        cursor.close()
        return row

    def addBranch(self, branchID: int, bankBranchAddress: str, bankBranchPhone: str, bankID: int):
        cursor = self.conn.cursor()
        cursor.execute(f"INSERT INTO BANKBRANCH (BRANCHID, BRANCHPHONENO, BRANCHADDRESS, BANKID) VALUES ({branchID}, {bankBranchPhone}, '{bankBranchAddress}', {bankID});")
        cursor.close()
        return True

    def getLoans(self):
        cursor = self.conn.cursor()
        row = cursor.execute(f"SELECT L.LOANID, B.BANKNAME, L.LOANAMOUNT, C.CUSTOMERNAME, C.CUSTOMERID FROM LOAN L JOIN BANKLOAN BL ON L.LOANID = BL.LOANID JOIN BANK B ON B.BANKID = BL.BANKID JOIN CUSTOMERLOAN CL ON L.LOANID = CL.LOANID JOIN CUSTOMER C ON C.CUSTOMERID = CL.CUSTOMERID WHERE L.LOANAPPROVED = 0;").fetchall()
        cursor.close()
        return row



    def updateCustomer(self, customerID: int, customerName: str, customerEmail: str, customerPhone: str):
        cursor = self.conn.cursor()
        cursor.execute(f"UPDATE CUSTOMER SET CUSTOMERNAME = '{customerName}', CUSTEMAIL = '{customerEmail}', CUSTOMERPHONENO = {customerPhone} WHERE CUSTOMERID = {customerID};")
        cursor.close()
        return True

    def getEmployee(self):
        cursor = self.conn.cursor()
        row = cursor.execute("SELECT EMPLOYEENAME, ISADMIN, EMPLOYEEEMAIL, EMPLOYEEID FROM EMPLOYEE;").fetchall()
        cursor.close()
        return row

    def __del__(self):
        self.conn.close()


    def getCustomerInfo(self,customerID: int):
        cursor = self.conn.cursor()
        row = cursor.execute(f"SELECT CUSTOMERID, CUSTOMERNAME, CUSTEMAIL, CUSTOMERPHONENO FROM CUSTOMER WHERE CUSTOMERID = {customerID};").fetchone()
        cursor.close()
        return row

    def checkCustomerAccount(self, customerID: int, accountID: int):
        cursor = self.conn.cursor()
        row = cursor.execute(f"SELECT * FROM CUSTOMERACC WHERE CUSTOMERID = {customerID} and ACCOUNTID = {accountID};").fetchone()
        cursor.close()
        if row is None:
            return False
        else:
            return True

    def getBanksByAccountBalanceSum(self):
        cursor = self.conn.cursor()
        query = """
            SELECT B.BANKID, B.BANKNAME, SUM(A.BALANCE) AS TOTAL_BALANCE
            FROM BANK B
            INNER JOIN BANKACC BA ON B.BANKID = BA.BANKID
            INNER JOIN ACCOUNT A ON BA.ACCOUNTID = A.ACCOUNTID
            GROUP BY B.BANKID, B.BANKNAME
        """
        cursor.execute(query)
        rows = cursor.fetchall()
        cursor.close()
        return rows

