#Connection to DB
import mysql.connector
mydb = mysql.connector.connect(
    host="localhost",
    user="root",
    password="8525",
    auth_plugin='mysql_native_password',
    database="library") 
myCursor= mydb.cursor()

results=[]


#Done
def fetchBranchs():
    myCursor.callproc('sp_showAllBranch')
    for x in myCursor.stored_results():
        results=x.fetchall()
    return results

def validateCardNo(input):
    myCursor.callproc('sp_validateCardNo',[input])
    for x in myCursor.stored_results():
        results=x.fetchone()
    return results

def fetchBorrowerBooks(input):
    myCursor.callproc('sp_fetchBorrowerBooks',[input])
    for x in myCursor.stored_results():
        results=x.fetchall()
    return results

def fetchBranchIdByName(input):
    myCursor.callproc('sp_fetchBranchIdByName',[input])
    for x in myCursor.stored_results():
        results=x.fetchone()
    return results

def fetchBooksByBranchId(input):
    myCursor.callproc('sp_fetchBooksByBranch',[input])
    for x in myCursor.stored_results():
        results=x.fetchall()
    return results

def fetchBookIdByBookName(input):
    myCursor.callproc('sp_fetchBookIdByBookName',[input])
    for x in myCursor.stored_results():
        results=x.fetchone()
    return results

def fetchCopiesByIds(branchId,bookId):
    myCursor.callproc('sp_fetchCopiesByIds',[branchId,bookId])
    for x in myCursor.stored_results():
        results=x.fetchone()
    return results

def fetchBookIdByBkName(branchId, book):
    myCursor.callproc('sp_fetchBookIdByBkName',[branchId, book])
    for x in myCursor.stored_results():
        results=x.fetchone()
    return results

def fetchBookCopiesByBookId(branchId,bookId):
    myCursor.callproc('sp_fetchBookCopiesByBookId',[branchId, bookId])
    for x in myCursor.stored_results():
        results=x.fetchone()
    return results

def fetchBooksByBorrowerId(borrowerId):
    myCursor.callproc('getBorrowedBooks', [borrowerId])
    for x in myCursor.stored_results():
        results=x.fetchall()
    return results

def fetchAuthors():
    myCursor.callproc('fetchAuthors')
    for x in myCursor.stored_results():
        results=x.fetchall()
    return results

def fetchPublishers():
    myCursor.callproc('fetchPublishers')
    for x in myCursor.stored_results():
        results=x.fetchall()
    return results

def fetchBooks():
    myCursor.callproc('fetchBooks')
    for x in myCursor.stored_results():
        results=x.fetchall()
    return results

def fetchBorrowers():
    myCursor.callproc('fetchBorrowers')
    for x in myCursor.stored_results():
        results=x.fetchall()
    return results

def fetchLibraries():
    myCursor.callproc('fetchLibraries')
    for x in myCursor.stored_results():
        results=x.fetchall()
    return results

def w_fetchPublishers():
    myCursor.callproc('sp_fetchPublishers')
    for x in myCursor.stored_results():
        results=x.fetchall()
    return results

def fetchPubIdByName(input):
    myCursor.callproc('sp_fetchPubIdByName',[input])
    for x in myCursor.stored_results():
        results=x.fetchone()
    return results

def w_fetchBooks():
    myCursor.callproc('sp_fetchBooks')
    for x in myCursor.stored_results():
        results=x.fetchall()
    return results

def w_fetchAuthors():
    myCursor.callproc('sp_fetchAuthors')
    for x in myCursor.stored_results():
        results=x.fetchall()
    return results

def fetchAuthorIdByName(input):
    myCursor.callproc('sp_fetchAuthorIdByName',[input])
    for x in myCursor.stored_results():
        results=x.fetchone()
    return results

