class Loan:
    def __init__(self, loanNumber: int, loanType: str, loanAmount: float):
        self.loanNumber: int = loanNumber
        self.loanType: str = loanType
        self.loanAmount: float = loanAmount


class Account:
    def __init__(self, accountType: str, balance: int, id:int):
        self.accountType: str = accountType
        self.balance: int = balance
        self.accountId: int = id

    def shiftBalance(self, val: int):
        self.balance += val

    def getBalance(self) -> int:
        return self.balance

    def getAccountType(self) -> str:
        return self.accountType


class Customer:
    def __init__(self, customerId: int, bank: str, branchId: int, customerName: str, customerNumber: str):
        self.customerId: int = customerId
        self.bank: str = bank
        self.branchId: int = branchId
        self.customerName: str = customerName
        self.customerNumber: str = customerNumber
        self.__accounts: list = []
        self.__loans: list = []

    def addLoan(self, loan: Loan):
        return self.__loans.append(loan)

    def addAccount(self, account: Account):
        return self.__accounts.append(account)

    def getAccounts(self) -> list:
        return self.__accounts

    def getLoans(self) -> list:
        return self.__loans
