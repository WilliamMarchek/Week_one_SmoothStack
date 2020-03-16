import borrower_q_check_out
import borrower_q_return
import librarian_questions
import start_questions

# "start" carries starting questions
question_bank = {
    "start": {
        "borrower": start_questions.borrower_question_start,
        "librarian": start_questions.lib_question_start,
    },
    # 
    "borrower": {
        # check_out
        1: [],
        # return
        2: [],
    },
    "librarian": {
        1: [],
        2: [],
    },
}



# For loop for each "line of questioning"
for name, val in borrower_q_check_out.__dict__.items():
    if callable(val):
        question_bank["borrower"][1].append(val)

for name, val in borrower_q_return.__dict__.items():
    if callable(val):
        question_bank["borrower"][2].append(val)

for name, val in librarian_questions.__dict__.items():
    if callable(val):
        question_bank["librarian"][1].append(val)


