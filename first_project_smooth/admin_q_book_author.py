import string_utils
import updateProcedures
import addProcedures
import fetchProcedures
import deleteProcedures

def start(self):
    print("What would you like to do?\n")
    self.choice = input("1) Add/Update/Delete Book\n2) Add/Update/Delete Author\n")
    if self.choice == "1":
        self.choice = input("1) Add Book\n2) Update Book\n3) Delete Book\n")
        if self.choice == "1":
            add_book(self)
        elif self.choice == "2":
            update_book(self)
        elif self.choice == "3":
            delete_book(self)
        else:
            print("Must enter a valid option (ie 1, 2, 3)")
            start(self)
    elif self.choice == "2":
        self.choice = input("1) Add Author\n2) Update Author\n3) Delete Author\n")
        if self.choice == "1":
            add_author(self)
        elif self.choice == "2":
            update_author(self)
        elif self.choice == "3":
            delete_author(self)
        else:
            print("Must enter a valid option (ie 1, 2, 3)")
            start(self)
    else:
        print("Must enter a valid option (ie 1, 2, 3)")
        start(self)

def add_book(self):
    self.store["title"] = input("What is the title of the book you want to add?\n")

    publishers =  fetchProcedures.fetchPublishers()
    publishers = string_utils.build_input_options(self, publishers)
    self.choice = input("And who published this book?\n" + publishers)
    self.store["publisherId"] = self.grabId()

    # CREATE NEW BOOK WITH PUBLISHER
    addProcedures.addBook(self.store["title"], self.store["publisherId"])


def update_book(self):
    books = fetchProcedures.fetchBooks()
    books = string_utils.build_input_options(self, books)
    self.choice = input("Which book do you want to update?\n" + books)
    self.store["bookId"] = self.grabId()

    self.store["new_title"] = input("What do you want the new title to be?\n")
    publishers = fetchProcedures.fetchPublishers()
    publishers = string_utils.build_input_options(self, publishers)
    self.choice = input("Who should the new publisher be?\n")
    self.store["new_pub_id"] = self.grabId()

    # UPDATE BOOK BY ID   (bookId, new_title, new_pub_id)
    updateProcedures.updateBookInfo(self.store["bookId"], self.store["new_title"], self.store["new_pub_id"])
    

def delete_book(self):
    books = fetchProcedures.fetchBooks()
    books = string_utils.build_input_options(self, books)
    self.choice = input("Which book do you want to delete?\n" + books)
    self.store["bookId"] = self.grabId()

    # DELETE BOOK BY ID
    deleteProcedures.deleteBook(self.store["bookId"])

def add_author(self):
    self.store["authorName"] = input("What is the name of the new author?\n")

    # INSERT AUTHOR (authorName)
    addProcedures.addAuthor(self.store["authorName"])

def update_author(self):
    authors = fetchProcedures.fetchAuthors()
    authors = string_utils.build_input_options(self, authors)
    self.choice = input("Which author would you like to update?\n" + authors)
    self.store["authorId"] = self.grabId()

    self.store["authorName"] = input("What would you like to change the author's name to?\n")

    # UPDATE AUTHOR BY ID (authorId, authorName)
    updateProcedures.updateAuthorInfo(self.store["authorId"], self.store["authorName"])

def delete_author(self):
    authors = fetchProcedures.fetchAuthors()
    authors = string_utils.build_input_options(self, authors)
    self.choice = input("Which author would you like to delete?\n" + authors)
    self.store["authorId"] = self.grabId()

    # DELETE AUTHOR BY ID (authorId)
    deleteProcedures.deleteAuthor(self.store["authorId"])
