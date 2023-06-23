import eel
import DatabaseManager as DatabaseManager
import random
import json
from decimal import Decimal
import matplotlib.pyplot as plt
import io
import base64


def generateID():
    return random.randint(10**2, 10**3-1)


dbm = DatabaseManager.DatabaseManager()
eel.init('web')


class Current:
    def __init__(self):
        self.currentCustomer = None
        self.currentEmployee = None


c: Current = Current()


@eel.expose
def isEmployeeLoggedIn():
    if c.currentEmployee is None:
        return False
    return True


@eel.expose
def nullify():
    print("nullifying")
    c.currentCustomer = None
    c.currentEmployee = None


@eel.expose
def isCustomerLoggedIn():
    if c.currentCustomer is None:
        return False
    return True


@eel.expose
def authenticate_user(email, password):
    try:
        if password == dbm.getPassword(email):
            c.currentCustomer = dbm.getUserID(email)
            c.currentEmployee = None
            return True
        return False
    except Exception:
        return False


@eel.expose
def getUserID(email):
    try:
        return dbm.getUserID(email)
    except Exception:
        return False


@eel.expose
def authenticate_employee(email, password):
    try:
        if password == dbm.getEmployeePassword(email):
            c.currentCustomer = None
            c.currentEmployee = dbm.getEmployeeID(email)
            return True
        return False
    except Exception:
        return False


@eel.expose
def create_customer(name, email, password, phone):
    try:
        idr = generateID()
        if len(name) > 10:
            name = name[:10]
        if dbm.insertCustomer(name, email, idr, password, phone):
            c.currentCustomer = idr
            c.currentEmployee = None
            return True
        else:
            return False
    except Exception:
        return False


@eel.expose
def add_customer(name, email, password, phone):
    try:
        idr = generateID()
        return dbm.insertCustomer(name, email, idr, password, phone)
    except Exception:
        return False


@eel.expose
def addCustomer(name, email, password, phone):
    try:
        idr = generateID()
        return dbm.insertCustomer(name, email, idr, password, phone)
    except Exception:
        return False


@eel.expose
def getLoans():
    try:
        rows = dbm.getLoans()
        column_names = ["id", "bankName", "amount", "customername", "customerID"]
        rows_dict = []
        for row in rows:
            row_dict = {}
            for i, column_name in enumerate(column_names):
                value = row[i]
                if isinstance(value, Decimal):
                    # Convert decimal to float
                    row_dict[column_name] = float(value)
                else:
                    row_dict[column_name] = value
            rows_dict.append(row_dict)

        json_data = json.dumps(rows_dict)
        return json_data
    except Exception:
        return False

@eel.expose
def denyLoan(idr):
    try:
        return dbm.deleteLoan(idr)
    except Exception as e:
        return False


@eel.expose
def acceptLoan(idr):
    try:
        return dbm.acceptLoan(idr)
    except Exception:
        return False


@eel.expose
def deleteAccount(idr):
    try:
        return dbm.deleteAccount(idr)
    except Exception:
        return False


@eel.expose
def updateCustomer(name, email, phone):
    try:
        return dbm.updateCustomer(c.currentCustomer, name, email, phone)
        return True
    except Exception:
        return False


@eel.expose
def getCustomerInfo():
    try:
        row = dbm.getCustomerInfo(c.currentCustomer)
        row_dict = {}
        for i, column_name in enumerate(["id", "name", "email", "phone"]):
            value = row[i]
            if isinstance(value, Decimal):
                row_dict[column_name] = float(value)
            else:
                row_dict[column_name] = value
        return json.dumps(row_dict)
    except Exception:
        return False


@eel.expose
def getBanks():
    try:
        rows = dbm.getBanks()
        column_names = ["id", "name", "address", "phone"]
        rows_dict = []
        for row in rows:
            row_dict = {}
            for i, column_name in enumerate(column_names):
                value = row[i]
                if isinstance(value, Decimal):
                    row_dict[column_name] = float(value)
                else:
                    row_dict[column_name] = value
            rows_dict.append(row_dict)
        json_data = json.dumps(rows_dict)
        return json_data
    except Exception:
        return False


@eel.expose
def addBank(name, address, phone):
    try:
        idr = generateID()
        return dbm.addBank(idr, name, address, phone)
    except Exception:
        return False


@eel.expose
def getBranches():
    try:
        rows = dbm.getBranches()
        column_names = ["name", "id", "address", "phoneno"]
        rows_dict = []
        for row in rows:
            row_dict = {}
            for i, column_name in enumerate(column_names):
                value = row[i]
                if isinstance(value, Decimal):
                    # Convert decimal to float
                    row_dict[column_name] = float(value)
                else:
                    row_dict[column_name] = value
            rows_dict.append(row_dict)

        # Serialize the list of dictionaries to JSON
        json_data = json.dumps(rows_dict)
        return json_data
    except Exception:
        return False


@eel.expose
def addBranch(bankid, address, phone):
    try:
        idr = generateID()
        return dbm.addBranch(idr, address, phone, bankid)
    except Exception:
        return False

@eel.expose
def getCustomers():
    try:
        rows = dbm.getCustomers()
        column_names = ["id", "name", "email", "phone"]
        rows_dict = []
        for row in rows:
            row_dict = {}
            for i, column_name in enumerate(column_names):
                value = row[i]
                if isinstance(value, Decimal):
                    # Convert decimal to float
                    row_dict[column_name] = float(value)
                else:
                    row_dict[column_name] = value
            rows_dict.append(row_dict)

        json_data = json.dumps(rows_dict)
        return json_data
    except Exception:
        return False

@eel.expose
def create_employee(name, email, password, isAdmin):
    try:
        idr = generateID()
        if len(name) > 10:
            name = name[:10]
        if dbm.insertEmployee(name, email, idr, password, isAdmin):
            c.currentEmployee = idr
            c.currentCustomer = None
            return True
        return False
    except Exception:
        return False


@eel.expose
def get_customer_account():
    try:
        rows = dbm.getCustomerAccounts(c.currentCustomer)
        column_names = ["id", "balance", "type", "bank"]
        rows_dict = []
        for row in rows:
            row_dict = {}
            for i, column_name in enumerate(column_names):
                value = row[i]
                if isinstance(value, Decimal):
                    # Convert decimal to float
                    row_dict[column_name] = float(value)
                else:
                    row_dict[column_name] = value
            rows_dict.append(row_dict)

        # Serialize the list of dictionaries to JSON
        json_data = json.dumps(rows_dict)
        return json_data
    except Exception:
        return False


@eel.expose
def get_customer_loans():
    try:
        rows = dbm.getCustomerLoans(c.currentCustomer)
        column_names = ["id", "loantype", "amount", "approved", "name"]
        rows_dict = []
        for row in rows:
            row_dict = {}
            for i, column_name in enumerate(column_names):
                value = row[i]
                if isinstance(value, Decimal):
                    row_dict[column_name] = float(value)
                else:
                    row_dict[column_name] = value
            rows_dict.append(row_dict)

        json_data = json.dumps(rows_dict)
        return json_data
    except Exception:
        return False


@eel.expose
def requestLoan(bankid: int, amount: int, loanType: str):
    try:
        idr = generateID()
        return dbm.insertLoan(idr, amount, loanType, c.currentCustomer, bankid)
    except Exception:
        return False


@eel.expose
def createAccount(atype, bankId):
    if(atype not in ["Savings", "Checking", "Business"]):
        return False
    try:
        idr = generateID()
        dbm.addAccount(0, atype, idr, c.currentCustomer, bankId)
        return True
    except Exception:
        return False


@eel.expose
def update_loan(loan, amount, accountID):
    try:
        if amount > dbm.getCustomerAccounts(accountID) or amount > dbm.getLoanAmount(loan):
            return False
        dbm.updateAccountBalance(accountID, amount)
        dbm.updateLoan(loan)
        if dbm.getLoanAmount(loan) == 0:
            dbm.deleteLoan(loan)
        return True
    except Exception:
        return False


@eel.expose
def sendMoney(amount: int, accountID: int, accountID2: int):
    try:
        if not dbm.checkCustomerAccount(c.currentCustomer, accountID):
            return False
        if amount > dbm.getAccountBalance(accountID):
            return False
        dbm.updateAccountBalance(accountID, -amount)
        dbm.updateAccountBalance(accountID2, amount)
        return True
    except Exception:
        return False


@eel.expose
def getPlotData():
    try:
        bank_data = dbm.getBanksByAccountBalanceSum()
        bank_names = [data[1] for data in bank_data]
        bank_balances = [float(data[2]) for data in bank_data]
        plt.bar(bank_names, bank_balances)
        plt.xlabel("Bank")
        plt.ylabel("Total Balance")
        plt.title("Total Balance by Bank")
        plt.xticks(rotation=90)
        plt.tight_layout()
        buffer = io.BytesIO()
        plt.savefig(buffer, format='png')
        return base64.b64encode(buffer.getvalue()).decode('utf-8')
    except Exception:
        return False

@eel.expose
def getEmployees():
    try:
        rows = dbm.getEmployee()
        column_names = ["name", "isAdmin", "email", "id"]
        rows_dict = []
        for row in rows:
            row_dict = {}
            for i, column_name in enumerate(column_names):
                value = row[i]
                if isinstance(value, Decimal):
                    # Convert decimal to float
                    row_dict[column_name] = float(value)
                else:
                    row_dict[column_name] = value
            rows_dict.append(row_dict)

        json_data = json.dumps(rows_dict)
        return json_data
    except Exception:
        return False


@eel.expose
def addEmployee(name, email, password, isAdmin, bankId):
    try:
        idr = generateID()
        if dbm.insertEmployee(name, email, idr, password, isAdmin, bankId):
            return True
        return False
    except Exception:
        return False


def main():
    eel.start('index.html', size=(1200, 800))


if __name__ == '__main__':
    main()

