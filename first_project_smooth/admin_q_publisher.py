import string_utils
import updateProcedures
import addProcedures
import fetchProcedures
import deleteProcedures

def start(self):
    print("What would you like to do?\n")
    self.choice = input("1) Add \n2) Update\n3) Delete Publisher\n")
    if self.choice == "1":
        add_publisher(self)
    elif self.choice == "2":
        update_publisher(self)
    elif self.choice == "3":
        delete_publisher(self)
    else:
        print("Must enter a valid option (ie 1, 2, 3)")
        start(self)


def add_publisher(self):
    self.store["name"] = input("What is the name of the publisher you wish to add?\n")
    self.store["address"] = input("What is the address of this publisher?")
    self.store["phone"] = input("What is the phone number of this publisher?")

    # Build function to display what they have written, so we can them confirm it is good
    self.choice = input("Does that look right to you?\n1)Yes\n2)No")
    if self.choice == "1":
        print("Added new publisher")
    elif self.choice == "2":
        add_publisher()

    addProcedures.addPublisher(self.store["name"],self.store["address"],self.store["phone"])
    

def update_publisher(self):
    publishers = fetchProcedures.fetchPublishers()
    publishers = string_utils.build_input_options(self, publishers)
    self.choice = input("Which publisher would you like to update?\n" + publishers)
    self.store["pubId"] = self.grabId()

    self.store["name"] = input("What is the name of the publisher you wish to add?\n")
    self.store["address"] = input("What is the address of this publisher?")
    self.store["phone"] = input("What is the phone number of this publisher?")

    # UPDATE PUBLISHER (name, address, phone)
    updateProcedures.updatePublisherInfo(self.store["pubId"],self.store["name"],self.store["address"],self.store["phone"])
    print("Updated publisher")

def delete_publisher(self):
    publishers = fetchProcedures.fetchPublishers()
    publishers = string_utils.build_input_options(self, publishers)
    self.choice = input("Which publisher would you like to delete?\n" + publishers)
    self.store["pubId"] = self.grabId()

    # DELETE PUBLISHER BY ID HERE
    deleteProcedures.deletePublisher(self.store["pubId"])
    print("Deleted publisher")
