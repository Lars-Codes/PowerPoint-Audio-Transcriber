#!/bin/bash
#brew install unzip
#brew install libmagic
: '
    Use this if you would prefer to take user input 
'
# read -p "Enter the name of the file you would like to extract your audio files from. Don't include the extension: " source_file
# read -p "Enter the extension of your file without periods: " extension 

# zip_file="${source_file}.zip" #Creating name of zip file 
# initial_file="${source_file}.${extension}" #Reconstructing original file with original extension 
# mv "${initial_file}" "$zip_file" #Converting input file into a zip file 

: ' This is for personal use. Feel free to pull and replace my code with your own files. 
'
powerPoint="ppt4.pptx"
powerPointZip="ppt4.zip"
audioOutput="ppt4.m4a"
textFile="ppt4.txt"

mv $powerPoint $powerPointZip #Converting input file into a zip file 


#$? represents exit status of previous command. 0 is success, 1, is unsuccessful. -eq is comparison operator. 
if [ $? -eq 0 ]; then #Checking to see if zip was complete 
    echo "File zipped successfully: $zip_file"
else
    echo "An error occurred while creating the zip file."
fi

: '
    Do this for user input 
'
# unzip "${zip_file}" #Unzipping file 

: ' Personal use 
'
unzip $powerPointZip 

mkdir "audio_files" #Creating new folder to put your audio files in 

: '
    User input 
'
#Getting user input 
# read -p "What is the file path of your audio files? Only include name/name and we will add the dots and slashes: " source_directory
# read -p "What extension do your audio files have? Don't include the dot: " audio 
# read -p "Where do you want your files to end up? : " destination_directory 

# file_path="./${source_directory}"
# extension="*.${audio}"

# # Finding all files with desired extension and moving them to the audio_files folder 
# find "${file_path}" -name "${extension}" -exec bash -c 'mv "$0" "$1"' {} "$destination_directory" \;
# find . -type f ! -name 'worksmarterinator.zip' ! -name "$zip_file" -o -type d ! -name 'audio_files' -exec rm -rf {} +

: '
    Personal use: 
'
# destination_directory="./audio_files"
file_path="./ppt/media"
extension="*.m4a"
destination_directory="audio_files"
find "${file_path}" -name "${extension}" -exec bash -c 'mv "$0" "$1"' {} "$destination_directory" \;
find . -type f \( ! -name 'worksmarterinator.zip' ! -name "$powerPointZip" ! -name "FileList.java" \) -o \( -type d ! -name 'audio_files' \) -exec rm -rf {} +

    # You can write code to ask if a user would like to remove any other files here. Below is the file I am 
    # removing that wasn't removed by the above command.
rm "[Content_Types].xml"

#Running Java program (FileList.java)
javac FileList.java 
arg="./audio_files"
java FileList "$arg"

#Removing the class file to clean up 
rm FileList.class
rm FileList\$NumericStringComparator.class

#Concatenates all of the audio files 
ffmpeg -f concat -safe 0 -i manifest.txt -c copy $audioOutput

rm -rf audio_files
rm manifest.txt

echo "You've successfully created a single m4a audio file from a bajillion! Now for the AI takeover >:)"
#AMAZING!!!! YOU'VE SUCCESSFULLY CREATED A SINGLE M4A FILE!! 

#Now to transcribe: 
python3 transcription.py

rm $textFile
rm $audioOutput
rm $powerPointZip

#!pip install -U openai-whisper
#pip install git+https://github.com/openai/whisper.git -q
#pip install fpdf 

#mv ppt3.zip ppt3.pptx  --> testing 
