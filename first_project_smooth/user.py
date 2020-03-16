class User:
    def __init__(self, user_role, first_path_question, user_specific_path):
        self.role = user_role
        self.id = ''
        self.track = 0
        self.track_list = []
        self.track_list_glossary = user_specific_path
        self.initial_question = first_path_question
        self.choice = ''
        self.choices_id_matrix = {}
        self.error = ''
        self.complete = False
        self.store = {}


    def next(self):
        self.track += 1

    def prev(self):
        self.track -=  1

    def home(self):
        self.track_list = []
        self.track = 0

    def finish(self):
        self.complete = True

    def grabId(self):
        return self.choices_id_matrix[self.choice]

    def track_switch(self):
        self.initial_question(self)
        if len(self.error) > 0:
            pass
        else:
            self.track_list = self.track_list_glossary[int(self.choice)]

    def __call__(self):
        self.engine()

    def engine(self):
        self.track_switch()
                
        while self.track <= len(self.track_list) - 1:
            self.error = ''
            self.track_list[self.track](self)
        if self.complete == False and len(self.track_list) == 0:
            self.engine()
        self.reset()

    def reset(self):
        self.track = 0
        self.track_list = []
        self.choice = input(f"Continue program as {self.role}?\n1)Yes\n2)No (terminate program)\n")
        if self.choice == "1":
            self.__call__()
        elif self.choice == "2":
            print("Thanks for using Gold Coast Solutions")