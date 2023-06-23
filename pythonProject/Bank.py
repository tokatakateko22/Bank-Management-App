class BankBranch:
    def __init__(self, bank: str, branchNumber: str, address: str):
        self.bank: str = bank
        self.branchNumber: str = branchNumber
        self.address: str = address
        self.__customers: list = []

    def addCustomer(self, customer):
        return self.__customers.append(customer)

    def getCustomers(self) -> list:
        return self.__customers


class Bank:
    def __init__(self, name: str, code: str, address: str, phone: str):
        self.name: str = name
        self.code: str = code
        self.address: str = address
        self.phone: str = phone
        self.__branches: list = []

    def getBranches(self) -> list:
        return self.__branches

    def addBranch(self, branch: BankBranch):
        return self.__branches.append(branch)
