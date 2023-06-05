# PowerPoint-Audio-Transcriber

I built this program when one of my english professors was testing us on information in a PowerPoint he created. The catch was, each slide had an .m4a audio file and no words. 

My code will extract all audio files from a .pptx file (you can alter the code to fit your own needs), combine them, and then output a PDF with the transcription. Details of how it runs, in order, below. 

I will flag every section that requires your intervention with a "STOP HERE! NEED TO CHANGE CODE!" Otherwise, I'll just be writing explanations. 

# It all begins with a bash script... 
You will need to install Homebrew (https://brew.sh/) and Ffmpeg (https://ffmpeg.org/download.html) to run this project. 
You'll need to run: 
>> brew install unzip 
>> brew install libmagic 

I started by creating prompts to ask the user the name of the file they'd like to use, the type, path, etc. I found this extremely time-consuming. You can uncomment the beginning portions if you'd like to get prompted and comment out my unique code, but otherwise just follow this ReadMe and I'll show you where to input your own information. 

# STOP RIGHT HERE! NEED TO CHANGE CODE!
Change the variable 
>> powerPoint="ppt4.pptx"
to the file you'd like to extract the code from. Do the same for powerPointZip. The audioOutput variable is what you're gonna name the audio file that is the combination of all of the audio files within the PowerPoint. Edit that to name it what you want and also change the extension if you're not using .m4a files. 
Change the textFile variable to the same name as the other 3 variables. 

These will get removed later, so it's just easier to put them in variables so if you want to use the code you don't have to change it everywhere. 

# As you were. And the explanation continues...
First, the bash script zips up your PowerPoint. It prints whether or not it was successful. Then, it unzips it. When you unzip a file normally using your computer's GUI, it hides all of the secret files storing the packaged information necessary for the PowerPoint. Unzipping it this way will allow you to see all of the audio files inside a folder. 

# STOP RIGHT HERE! NEED TO CHANGE CODE!
Now, you should see a variable called file_path. This will be the path to where all of the audio files are kept. You can poke around on your own to see where the system dumped them and write in your own path here. Also change the extension if you're not working with m4as. 

The next line finds all of the audio files, places them in a new folder we created earlier, and then deletes everything else except for the code we need. For some reason, for me, the rm "[Content_Types].xml" wasn't getting removed on this command, so I did it manually. You can comment this line out if necessary. 

# Aaaaaand we're back! 
Alright. Alright alright alright. Then we call the Java program. Our argument we pass to the program is the path to our folder containing all of the audio files.

In order to combine all of our audio files into 1, we need to use FFmpeg. Ffmpeg requires that we generate a text file listing every audio file we want to combine. That's so much to type if you've got a lot of files! 

I create a new text file, "manifest.txt," and an array called "files" with all of the files in our target directory. 

# STOP RIGHT HERE! Maaaaaybeeee (???) NEED TO CHANGE CODE??
All of my audio files were listed as media1, media2, media3, and so on. However, when I just wrote them to the manifest.txt file, they were all out of order! The line: 

>> Arrays.sort(files, Comparator.comparing(File::getName, new NumericStringComparator()));

is my method to sort the array of strings based on the number of the file. If yours are numbered, good news. You don't have to change anything! Yaas! 

If not, you're outta luck, kid. Comment out the whole class NumericStringComparator and the line Arrays.sort(files, Comparator.comparing(File::getName, new NumericStringComparator())). You'll have to manually write a text file 



