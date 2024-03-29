# PowerPoint-Audio-Transcriber

This project is an accessibility tool. I built this program when one of my english professors was testing us on information in a PowerPoint he created. The catch was, each slide had an .m4a audio file and no words. Many of the students in this class, including myself, have difficulty retaining information when presented in an entirely auditory manner.  

My code will extract all audio files from a .pptx file (you can alter the code to fit your own needs), combine them, and then output a PDF with the transcription. This was incredibly useful to me and my classmates so when the professor sent us a PowerPoint, with a click of a button, we had access to the whole transcription in PDF format so we can read along with his audio. 

We will be using the tiny.en model for our audio transcription. You can download it here: https://github.com/openai/whisper/discussions/63
Make sure to put the model in your project directory. 

# Future Work 
As it stands, this project does not have a UI component. It runs using a bash script and the user has to manually edit the script to specify the PowerPoint's location on their machine. Details on how to do this below. Hopefully in the future, the user can simply upload the PowerPoint to a web application and have the option to download the PDF without having to open the terminal. 


# Dependencies
You will need to install Homebrew (https://brew.sh/) and Ffmpeg (https://ffmpeg.org/download.html) to run this project. 
You'll need to run: 
>> brew install unzip 
>> brew install libmagic 

You'll also need: 
!pip install -U openai-whisper
pip install git+https://github.com/openai/whisper.git -q
pip install fpdf 

# Where to change the code 
- Change the variable 
>> powerPoint="ppt4.pptx"
to the file you'd like to extract the code from. Do the same for powerPointZip. The audioOutput variable is what you're gonna name the audio file that is the combination of all of the audio files within the PowerPoint. Edit that to name it what you want and also change the extension if you're not using .m4a files. 
Change the textFile variable to the same name as the other 3 variables. 

These will get removed later, so it's just easier to put them in variables so if you want to use the code you don't have to change it everywhere. 

- Now, you should see a variable called file_path. This will be the path to where all of the audio files are kept. You can poke around on your own to see where the system dumped them and write in your own path here. Also change the extension if you're not working with .m4as. 

The next line finds all of the audio files, places them in a new folder we created earlier, and then deletes everything else except for the code we need. For some reason, for me, the rm "[Content_Types].xml" wasn't getting removed on this command, so I did it manually. You can comment this line out if necessary. 

# Explanation
First, the bash script zips up your PowerPoint. It prints whether or not it was successful. Then, it unzips it. When you unzip a file normally using your computer's GUI, it hides all of the secret files storing the packaged information necessary for the PowerPoint. Unzipping it this way will allow you to see all of the audio files inside a folder. 

Then we call the Java program. Our argument we pass to the program is the path to our folder containing all of the audio files. The Java program is only useful if your audio files are numbered or has a number in them. Otherwise you need to write your own Java code to order your files, or write your own text file in the order you want your audio files to be combined. 

In order to combine all of our audio files into 1, we need to use FFmpeg. Ffmpeg requires that we generate a text file listing every audio file we want to combine. That's so much to type if you've got a lot of files! The Java program will write this file for you. 

I create a new text file, "manifest.txt," and an array called "files" with all of the files in our target directory in the bash script and handover control to the Java Gods. 

All of my audio files were listed as media1, media2, media3, and so on. However, when I just wrote them to the manifest.txt file, they were all out of order! The line: 

>> Arrays.sort(files, Comparator.comparing(File::getName, new NumericStringComparator()));

is my method to sort the array of strings based on the number of the file. If yours are numbered, good news. You don't have to change anything! 

Comment out the whole class NumericStringComparator and the line Arrays.sort(files, Comparator.comparing(File::getName, new NumericStringComparator())). Also the code underneath if(files!=null). You'll have to manually write a text file with the format: 

file '/path/to/file1.wav' 

file '/path/to/file2.wav'

file '/path/to/file3.wav'

For more info, look here: https://trac.ffmpeg.org/wiki/Concatenate 

I use the Whisper APIs to load in a model. Change the file extension in the "result" variable if you're not using m4as. 







