# PowerPoint-Audio-Transcriber

I built this program when one of my english professors was testing us on information in a PowerPoint he created. The catch was, each slide had an .m4a audio file and no words. 

My code will extract all audio files from a .pptx file (you can alter the code to fit your own needs), combine them, and then output a PDF with the transcription. Details of how it runs, in order, below. 

I will flag every section that requires your intervention with a "STOP HERE! NEED TO CHANGE CODE!" Otherwise, I'll just be writing explanations. 

# It all begins with a bash script... 
You will need to install Homebrew (https://brew.sh/) and Ffmpeg (https://ffmpeg.org/download.html) to run this project. 
You'll need to run: 
>> brew install unzip 
>> brew install libmagic 

You'll also need: 
!pip install -U openai-whisper
pip install git+https://github.com/openai/whisper.git -q
pip install fpdf 

I started by creating prompts to ask the user the name of the file they'd like to use, the type, path, etc. I found this extremely time-consuming. You can uncomment the beginning portions if you'd like to get prompted and comment out my unique code, but otherwise just follow this ReadMe and I'll show you where to input your own information. 

# Halt, sire! Code needs changing!
Change the variable 
>> powerPoint="ppt4.pptx"
to the file you'd like to extract the code from. Do the same for powerPointZip. The audioOutput variable is what you're gonna name the audio file that is the combination of all of the audio files within the PowerPoint. Edit that to name it what you want and also change the extension if you're not using .m4a files. 
Change the textFile variable to the same name as the other 3 variables. 

These will get removed later, so it's just easier to put them in variables so if you want to use the code you don't have to change it everywhere. 

# As you were. And the explanation continues...
First, the bash script zips up your PowerPoint. It prints whether or not it was successful. Then, it unzips it. When you unzip a file normally using your computer's GUI, it hides all of the secret files storing the packaged information necessary for the PowerPoint. Unzipping it this way will allow you to see all of the audio files inside a folder. 

# Stop! Code needs changing!
Now, you should see a variable called file_path. This will be the path to where all of the audio files are kept. You can poke around on your own to see where the system dumped them and write in your own path here. Also change the extension if you're not working with m4as. 

The next line finds all of the audio files, places them in a new folder we created earlier, and then deletes everything else except for the code we need. For some reason, for me, the rm "[Content_Types].xml" wasn't getting removed on this command, so I did it manually. You can comment this line out if necessary. 

# Aaaaaand we're back! 
Alright. Alright alright alright. Then we call the Java program. Our argument we pass to the program is the path to our folder containing all of the audio files. The Java program is only useful if your audio files are numbered or has a number in them. Otherwise you need to write your own Java code to order your files, or write your own text file in the order you want your audio files to be combined. 

In order to combine all of our audio files into 1, we need to use FFmpeg. Ffmpeg requires that we generate a text file listing every audio file we want to combine. That's so much to type if you've got a lot of files! The Java program will write this file for you. 

I create a new text file, "manifest.txt," and an array called "files" with all of the files in our target directory in the bash script and handover control to the Java Gods. 

# Stop right here! Maaaaaybeeee (???) Need to change code?
All of my audio files were listed as media1, media2, media3, and so on. However, when I just wrote them to the manifest.txt file, they were all out of order! The line: 

>> Arrays.sort(files, Comparator.comparing(File::getName, new NumericStringComparator()));

is my method to sort the array of strings based on the number of the file. If yours are numbered, good news. You don't have to change anything! Yaas! 

If not, you're outta luck, kid. Comment out the whole class NumericStringComparator and the line Arrays.sort(files, Comparator.comparing(File::getName, new NumericStringComparator())). Also the code underneath if(files!=null). You'll have to manually write a text file with the format: 

file '/path/to/file1.wav' 

file '/path/to/file2.wav'

file '/path/to/file3.wav'

For more info, look here: https://trac.ffmpeg.org/wiki/Concatenate 

# Back to Bash... 
Hey! Great to see you back! Anyhooo. Back to bash, amiright? Now we're just removing the Java class file and the text file. Manifest? Never heard of her. Don't even know her. 

# Now for the AI takeover >:) ....I need you in the Python script, you may need to make a few changes!
Welcomeeeee to transcription.py! I'm your host Lara-Codes and today we're going to be transcribbbinggggg audio! Woot woot! 

Start off by changing the variable "name" to the name of the file you've been working with. The number is just there because I wanted to include a heading in my PDF file with a number because I was transcribing, like, a billion PowerPoints and kept forgetting to change the number in the code. 

I use the Whisper APIs to load in a model. Change the file extension in the "result" variable if you're not using m4as. 

Then I write the transcription to a txt file. Then it converts it to a PDF. You can change the headings if you want if you don't want my name all up in your bidness. I would like credit for the code if you use it though. :D 

# Havin a bash! 
In the final lines of Bash's life, we remove the text file, the combined audio file, and the zip file to leave you with a neat little transcription. Thanks for reading! 







