package teamjava;

import java.util.ArrayList;

public class Main {
    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        final String homeDir = System.getProperty("user.home");
        final String dataPrefix = homeDir + "/Downloads/kamelio_hackathon_data/";
        // Get submission CSV
        CSVreader csvReader = new CSVreader();
        
        Model rndMethod = new Model();
        ArrayList<String> submissionData = csvReader.read(dataPrefix + "submission_data.csv");
        ArrayList<String> outputData = new ArrayList<>();
        for(String line : submissionData) {
            outputData.add(rndMethod.callRnd(line));
        }

        // Get submission CSV
        CSVwriter csvWriter = new CSVwriter();
        csvWriter.write(outputData, homeDir + "/submission_data_out.csv");
    }
}
