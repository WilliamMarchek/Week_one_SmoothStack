import string_utils
import updateProcedures
import fetchProcedures

def start(self):
    self.store["cardNo"] = input("Enter the borrower Card Number you want to update the due date for?\n")
    books = fetchProcedures.fetchBooksByBorrowerId(self.store["cardNo"])
    books = string_utils.build_input_options(self, books)
    self.choice = input("Which book do you want to update the due date for?\n" + books)
    self.store["bookId"] = self.grabId()

    self.store["dueDate"] = input("Input the desired dueDate (In DATETIME format)\n")
    # UPDATE BOOK_LOAN BY ID (cardNo, bookId, dueDate)