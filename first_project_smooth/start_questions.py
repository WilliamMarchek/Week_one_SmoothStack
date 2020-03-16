import fetchProcedures
import subprocess 

def borrower_question_start(self):
    self.store["cardNo"] = input("Enter your card number.\n")
    # Valid card number check here boolean
    result=fetchProcedures.validateCardNo(self.store["cardNo"])
    card = None
    if result is None:
        print("Not a valid ID")
        self.error = "Not valid Id"
    else:
        card=True
    if card == True:
        self.choice = input("1) Check out a book\n2) Return a book\n")
    else:
        pass

def lib_question_start(self):
    self.choice = input("1)Enter Branch you manage\n2)Quit to previous\n" )
    if self.choice == "1":
        print('please select branch')
    else:
        self.choice == "2"
        subprocess.call(["python3", "main.py"])
        self.home()
        pass

