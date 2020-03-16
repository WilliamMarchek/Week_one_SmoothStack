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

def addBranch(branchName,branchAddress):
    myCursor.callproc('A_addBranch',[branchName,branchAddress])

def addBorrower(bName,bAddress,bPhone):
    myCursor.callproc('A_addBorrower',[bName,bAddress,bPhone])

def addAuthor(authorName):
    myCursor.callproc('A_addAuthor',[authorName])

def addPublisher(pubName,pubAddress,pubPhone):
    myCursor.callproc('A_addPublisher',[pubName,pubAddress,pubPhone])

def addBook(title,pubId):
    myCursor.callproc('A_addBook',[title,pubId])