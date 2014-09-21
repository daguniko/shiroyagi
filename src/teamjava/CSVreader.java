package teamjava;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

public class CSVreader {
    public ArrayList<String> read(String fileName) {
        File csvFile = new File(fileName);
        ArrayList<String> lines = new ArrayList<>();
        try (BufferedReader reader = new BufferedReader(new FileReader(csvFile))) {
            String line;
            while ((line = reader.readLine())!=null) {
                lines.add(line);
            }
        } catch (IOException ex) {
            Logger.getLogger(CSVreader.class.getName()).log(Level.SEVERE, null, ex);
        }
        return lines;
    }
}
