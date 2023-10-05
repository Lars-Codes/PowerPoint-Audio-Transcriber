#This is the module for converting your final m4a file into text. DO NOT NAME WHISPER.PY. Will get an error. 
import whisper
from fpdf import FPDF
name = "ppt4" #name of file you're working with 
number = "4"; #Number used for heading of eventual PDF file. (ex. Powerpoint #4)
model = whisper.load_model("base") #Loads whisper model into your Python application 
#verbose = True allows you to see transcription process; 
result = model.transcribe("./" + name + ".m4a", verbose = True)

"""
#With open as is a context manager. This automatically takes care of closing the file after writing. 
#With statement creates a block where the file is opened and assigned to the variable txt. 
# Provides a safer and more robust approach for file handling. 
"""
text = result["text"] #result of text 

# with open("ppt4.txt", "w", encoding="utf-8") as txt_file:
#     txt_file.write(text)
with open(name + ".txt", "w", encoding="utf-8") as txt_file:
    txt_file.write(text)
    
pdf = FPDF() #Creates PDF 
pdf.add_page() #Adds a page 
pdf.set_font("Times", size=12) #Sets font 
line_height = 6.5
pdf.cell(pdf.w - 2 * pdf.l_margin, txt = "PowerPoint " + number, align = 'C')
pdf.ln(line_height)
pdf.cell(pdf.w - 2 * pdf.l_margin, txt = "Transcription code by Lara Palombi", align = 'C')
pdf.ln(line_height)

with open(name + ".txt", "r", encoding="utf-8") as txt_file:
    content = txt_file.read() #Reads text file and puts values in content 
    
# Split the content into words
words = content.split() #Splits based on white spaces. 
"""
    -pdf.cell() creates a cell in the PDF with a width of 0 (expands to right end of page) and a height of 10. 
    -Word represents the text to be added to the cell. 
    -pdf.get_string_width(...) calculates the width of the text that would be contained within the cell
    -pdf.w - 2 * pdf.l_margin: This calculates the available width on the current line in the PDF. 
    pdf.w represents the total width of the page, and pdf.l_margin represents the left margin (empty space) 
    on the page. By subtracting twice the left margin from the total width, we get the available width for the 
    content.
"""
max_line_width = pdf.w - 2 * pdf.l_margin
current_line_width = 0
for word in words:
    word_width = pdf.get_string_width(word + " ")
    if current_line_width + word_width > max_line_width:
        pdf.ln(line_height)
        current_line_width = 0
    pdf.cell(word_width, 10, word + " ", ln=False)
    current_line_width += word_width
       
pdf.output(name + ".pdf")
