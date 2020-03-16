#Connection to DB
import mysql.connector
mydb = mysql.connector.connect(
    host="localhost",
    user="root",
    password="8525",
    auth_plugin='mysql_native_password',
    database="library",
    autocommit=True)
myCursor = mydb.cursor()

results=[]

#Done
def updateBranchInfo(bName,bAdd,bId):
    myCursor.callproc('sp_updateLibraryBranch',[bName,bAdd,bId])
    print("Library branch has been updated")

def updatedBookCopies(branchId,bookId,numCopies):
    myCursor.callproc('sp_updateBookCopies',[numCopies,branchId,bookId])
    print("Book copies has been updated")


def updateBranchName(branchId, curBranch, newBranch):
    myCursor.callproc('sp_updateBranchName', [branchId, curBranch, newBranch])
    print("Branch Name has been changed")

def updateBranchAddress(branchId, newBranchAddress):
    myCursor.callproc("sp_updateBranchAddress",[branchId, newBranchAddress])
    mydb.commit()
    print(f"Branch Address has been changed to {newBranchAddress}")

def updateBookCopiesById(branchId, bookId, newCopies):
    myCursor.callproc("sp_updateBookCopiesById", [branchId, bookId, newCopies])
    mydb.commit()
    print(f"you added {newCopies} new copies")

def updateBorrowerInfo(cardNum,newName,newAddress,newPhone):
    myCursor.callproc('A_updateBorrower',[cardNum,newName,newAddress,newPhone])

def updatePublisherInfo(pubId,pubName,pubAddress,pubPhone):
    myCursor.callproc('A_updatePublisher',[pubId,pubName,pubAddress,pubPhone])

def updateBookInfo(bookId,title,pubId):
    myCursor.callproc('A_updateBook',[bookId,title,pubId])

def updateAuthorInfo(authorId,newName):
    myCursor.callproc('A_updateAuthor',[authorId,newName])

#Not done
