import string_utils
import updateProcedures
import fetchProcedures

def start(self):
    print("What would you like to do?\n")
    self.choice = input("1) Add Library Branch\n2) Update Library Branch\n3) Delete Library Branch\n")
    if self.choice == "1":
        add_library(self)
    elif self.choice == "2":
        update_library(self)
    elif self.choice == "3":
        delete_library(self)
    else:
        print("Must enter a valid option (ie 1, 2, 3)")
        start(self)

def add_library(self):
    self.store["branchName"] = input("What is the name of this new library branch")
    self.store["branchAddress"] = input("What is the address for this new branch")
    # PROCEDURE TO INSERT NEW BRANCH HERE (branchName, branchAddress)

def update_library(self):
    libraries = fetchProcedures.fetchLibraries()
    libraries = string_utils.build_input_options(self, libraries)
    self.choice = input("Which library would you like to update?\n" + libraries)
    self.store["branchId"] = self.grabId()

    self.store["branchName"] = input("What is the new name of your borrower\n")
    self.store["branchAddress"] = input("What's the new address of your borrower\n")
    # UPDATE LIBRARY BY ID (branchName, branchAddress)

def delete_library(self):
    libraries = fetchProcedures.fetchLibraries()
    libraries = string_utils.build_input_options(self, libraries)
    self.choice = input("Which library would you like to delete?\n" + libraries)
    self.store["branchId"] = self.grabId()
    # DELETE LIBRARY BY ID (branchId)
