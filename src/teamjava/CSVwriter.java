package teamjava;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

public class CSVwriter {
    public void write(ArrayList<String> lines, String filename) {
        try {
            BufferedWriter writer = new BufferedWriter(new OutputStreamWriter(
                    new FileOutputStream(filename)));
            for(String line : lines) {
                writer.write(line);
            }
        } catch (IOException ex) {
            Logger.getLogger(CSVwriter.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
