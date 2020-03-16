import admin_q_book_author
import admin_q_borrower
import admin_q_due_date
import admin_q_publisher
import admin_q_library

class Admin:
    def __init__(self):
        self.choice = ''
        self.choices_id_matrix = {}
        self.error_message = ''
        self.error = False
        self.complete = False
        self.store = {}

    def grabId(self):
        return self.choices_id_matrix[self.choice]

    def __call__(self):
        self.complete = False
        print("What would you like to do?\n")
        self.choice = input("1) Add/Update/Delete Book and Author\n2) Add/Update/Delete Publishers\n3) Add/Update/Delete Library Branches\n4) Add/Update/Delete Borrowers\n5) Over-ride Due Date for a Book loan\n")
        self.engine()
    
    def engine(self):
        if self.complete == False and self.error == False:
            if self.choice == "1":
                admin_q_book_author.start(self)
            elif self.choice == "2":
                admin_q_publisher.start(self)
            elif self.choice == "3":
                admin_q_library.start(self)
            elif self.choice == "4":
                admin_q_borrower.start(self)
            elif self.choice == "5":
                admin_q_due_date.start(self)
        self.reset()

    def reset(self):
        self.choice = input("Continue program as Administrator?\n1) Yes\n2)No (terminate program)\n")
        if self.choice == "1":
            self.__call__()
        elif self.choice == "2":
            print("Thanks for using Gold Coast Solutions")

