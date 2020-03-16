import string_utils
import fetchProcedures
import updateProcedures


# Selects book to return
def question_one(self):
    books = fetchProcedures.fetchBooksByBorrowerId(self.store['cardNo'])
    books = string_utils.build_input_options(self, books)
    self.choice = input("Which book would you like to return?\n" + books)
    self.store["bookId"] = self.grabId()

    # DELETE BOOK_LOAN (cardNo, bookId)
    self.next()