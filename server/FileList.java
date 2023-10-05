package server;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.Arrays;
import java.util.Comparator;

public class FileList{
    public static void main(String[] args) throws IOException{

        // bash script passes path to audio_files directory 
        String path = args[0]; 
        String manifest = "manifest.txt"; //Creating new file to put list of files into 
        FileWriter writer = new FileWriter(manifest); //writing to manifest file  
        try{
            File directory = new File(path); 
            File[] files = directory.listFiles(); 

            //Arrays.sort sorts in ascending order based on provided comparator 
            /* Q: Why are we using comparing rather than compare? 
             * Comparing is a static method used to create a comparator based on a key extracted from
             * the elements being compared. 
             * Comparing method returns a comparator object that can be used for comparing elements 
             * based on the extracted key. 
             * 
             * Compare is a method used to compare two objects directly based on custom comparison 
             * logic. 
             * 
             * Comparator.comparing is used here because it allows you to create a comparator based on 
             * the File name extracted using the File::getName reference. 
             * 
             * You've seen: 
             * Arrays.sort(array, comparator.)
             * 
             * Comparing method accepts a sort key Function and returns a Comparator for the type that
             * contains the sort key. 
             * File object -> sort by the Name key 
             */
            Arrays.sort(files, Comparator.comparing(File::getName, new NumericStringComparator()));
            
            if(files!= null){
                for(File file: files){
                    if(file.isFile()){ //This is the format we need the manifest file in if we want to use 
                        //ffmpeg to combine into one single audio file 
                        writer.write("file " + "'" + args[0] + "/" + file.getName() + "'" + "\n"); 
                    }
                }
            }
        }catch(IOException e){
            e.printStackTrace();
        } finally { //Close the file whether we exceuted try or catch 
            if (writer != null) {
                try {
                    writer.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }

    }
    //Static nested class that implements comparator. Will be comparing Strings. 
    static class NumericStringComparator implements Comparator<String> {
        @Override
        public int compare(String str1, String str2) {
            int num1 = extractNumber(str1);
            int num2 = extractNumber(str2);
            return Integer.compare(num1, num2);
        }
        
        // Helper method to extract the numerical part from the string
        private int extractNumber(String str) {
            //Uses the replaceAll method to remove all non-digit characters 
            // from the input string. + sign means one or more. 
            String numStr = str.replaceAll("\\D+", "");
            //Is it empty? Return 0. Else, parse int. 
            return numStr.isEmpty() ? 0 : Integer.parseInt(numStr);
        }
    }
}
