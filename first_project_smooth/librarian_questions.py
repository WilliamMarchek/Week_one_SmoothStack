import fetchProcedures
import updateProcedures
import start_questions
import string_utils
import questions

def lib_question_one(self):
        res = (fetchProcedures.fetchBranchs())
        out = string_utils.build_input_options(res)
        self.choice = input("Select Branch Number or q to quit to previous:\n" + out)
        if self.choice == "q":
            self.home()
        else:
            self.next()

def lib_update_branch(self):
    int_choice = int(self.choice) - 1
    branches = (fetchProcedures.fetchBranchs())
    str_branch = (''.join(branches[int_choice]))
    self.id = fetchProcedures.fetchBranchIdByName(str_branch)
    self.choice = input("Press 1) Update the details of the Library\nPress 2) Add copies of Book to the Branch\nPress 3) To Quit to Previous\n: ")
    if self.choice == "1":
        print(f'You have chosen to update the Branch with Branch Id: {self.id} and Branch Name: {str_branch}.')
        new_branch_name = input(f"Please Enter New Branch Name for {str_branch}\n or enter N/A for no change:")
        if len(new_branch_name) > 0:
            updateProcedures.updateBranchName(f"{self.id[0]}",f"{str_branch}",new_branch_name)
        else:
             print('No Changes for Branch Name')
        pass
        new_address = input(f'Please enter new branch address for {new_branch_name} or enter N/A for no change:\n')
        if len(new_address) > 0:
            updateProcedures.updateBranchAddress(f"{self.id[0]}",new_address)
            self.home()
        else:
            print('No Changes for Branch Address')
    elif self.choice == "2":
        self.next()
    else: 
        self.choice == "3"
        self.prev()

def lib_update_books(self):
    books = fetchProcedures.fetchBooksByBranchId(self.id[0])
    out = ""
    for i, val in enumerate(books):
        output = f"{i}) {val}\n"
        out += output
    self.choice = input("Select Book Number or q to quit to previous:\n" + out)
    int_choice = int(self.choice)
    book = ''.join(books[int_choice])
    book_id = fetchProcedures.fetchBookIdByBkName(self.id[0],book)
    int_book_id = int(book_id[0])
    copies = fetchProcedures.fetchBookCopiesByBookId(self.id[0], int_book_id)
    num_of_copies = input(f'There are {copies} copies please add\n:')
    updateProcedures.updateBookCopiesById(self.id[0], int_book_id, num_of_copies)
    self.home()
