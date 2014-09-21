package teamjava;

import java.util.Random;

public class Model {
    final String delimiter = ",";
    final String lf = "\n";
//    final String article_show = "article_show";
    final String article_read = "article_read";
//    final String article_share = "article_share";
    final String not_read = "null";
    
    public String callRnd(String input) {
        final StringBuilder output = new StringBuilder(input);
        Random rnd = new Random();
        int rndNum = rnd.nextInt(2);
        switch(rndNum) {
            case 0: return output.append(delimiter).append(not_read).append(lf).toString();
            case 1: return output.append(delimiter).append(article_read).append(lf).toString();
        }
        System.err.println("Warning: no random value");
        return input;
    }
}
