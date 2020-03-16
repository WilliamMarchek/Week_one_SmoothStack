import string_utils
import updateProcedures
import fetchProcedures

def start(self):
    print("What would you like to do?\n")
    self.choice = input("1) Add Borrower\n2) Update Borrower\n3) Delete Borrower\n")
    if self.choice == "1":
        add_borrower(self)
    elif self.choice == "2":
        update_borrower(self)
    elif self.choice == "3":
        delete_borrower(self)
    else:
        print("Must enter a valid option (ie 1, 2, 3)")
        start(self)

def add_borrower(self):
    self.store["name"] = input("What is the name of your new borrower\n")
    self.store["cardNo"] = input("Enter the desired card number for your borrower\n")
    self.store["address"] = input("What's the address of your borrower\n")
    self.store["phone"] = input("Lastly, what is the phone number of your borrower\n")
    # PROCEDURE TO INSERT NEW BORROWER HERE (name, cardNo, address, phone)

def update_borrower(self):
    borrowers = fetchProcedures.fetchBorrowers()
    borrowers = string_utils.build_input_options(self, borrowers)
    self.choice = input("Which borrower would you like to update?\n" + borrowers)
    self.store["borrowerId"] = self.grabId()

    self.store["name"] = input("What is the new name of your borrower\n")
    self.store["address"] = input("What's the new address of your borrower\n")
    self.store["phone"] = input("Lastly, what is the new phone number of your borrower\n")

    # UPDATE BORROWER BY ID (name, address, phone)

def delete_borrower(self):
    borrowers = fetchProcedures.fetchBorrowers()
    borrowers = string_utils.build_input_options(self, borrowers)
    self.choice = input("Which borrower would you like to delete?\n" + borrowers)
    self.store["borrowerId"] = self.grabId()

    # DELETE BORROWER BY ID (borrowerId)