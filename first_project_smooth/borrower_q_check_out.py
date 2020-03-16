import string_utils
import fetchProcedures
import updateProcedures


# Selects branch
def question_two(self):
    branches=fetchProcedures.fetchBranchs()
    branches = string_utils.build_input_options(self, branches)
    branch = input("Which branch do you want to check out from?\n" + branches)
    self.choice = branch
    self.store["branchId"] = self.grabId()
    self.next()


# Selects book FROM branch
def question_three(self):
    books = fetchProcedures.fetchBooksByBranchId(self.store["branchId"])
    books = string_utils.build_input_options(self, books)
    self.choice = input("Which book would you like to check out?\n" + books)
    self.store["bookId"] = self.grabId()
    # INSERT NEW BOOK_LOAN (cardNo, bookId)
    self.next()
    



