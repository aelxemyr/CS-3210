import java.io.FileReader;
import java.io.FileWriter;
import java.io.BufferedReader;
import java.io.PrintWriter;
import java.io.IOException;

/**
 * Write a description of class Preprocessor here.
 * 
 * @author Bennett Alex Myers 
 * @version 26 Aug 2016
 */
public class Preprocessor
{
    private Stripper stripper;
    
    public Preprocessor() {
        this.stripper = new Stripper();
    }
    
    public void process(String inFile, String outFile) throws IOException {
        BufferedReader reader = null;
        PrintWriter writer = null;
        
        try {
            reader = new BufferedReader(new FileReader(inFile));
            writer = new PrintWriter(new FileWriter(outFile));
            String line;
            while ((line = reader.readLine()) != null) {
                String strippedLine = this.stripper.strip(line);
                if (!strippedLine.equals("")) {
                    writer.println(strippedLine);    
                }
            }
        } finally {
            if (reader != null) {
                reader.close();
            }
            if (writer != null) {
                writer.close();
            }
        }
    }
}
