package ohtu;

import com.google.gson.Gson;
import java.io.IOException;
import java.io.InputStream;
import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.methods.GetMethod;
import org.apache.commons.io.IOUtils;

public class Main {

    public static void main(String[] args) throws IOException {
        String studentNr = "012345678";
        if (args.length > 0) {
            studentNr = args[0];
        }

        String url = "http://ohtustats2016.herokuapp.com/students/" + studentNr + "/submissions";

        HttpClient client = new HttpClient();
        GetMethod method = new GetMethod(url);
        client.executeMethod(method);

        InputStream stream = method.getResponseBodyAsStream();

        String bodyText = IOUtils.toString(stream);

        /*System.out.println("json-muotoinen data:");
        System.out.println(bodyText);*/

        Gson mapper = new Gson();
        Submission[] subs = mapper.fromJson(bodyText, Submission[].class);

        /*System.out.println("Oliot:");
        for (Submission submission : subs) {
            System.out.println(submission);
            System.out.println(submission.getWeek());
        }*/

        printStudentStats(subs);
    }
    
    public static void printStudentStats(Submission[] subs){
        System.out.println("Opiskelijanumero " + subs[0].getStudent_number());
        
        int hours = 0;
        int exercises = 0;
        
        for (Submission submission : subs) {
            System.out.print("viikko " + submission.getWeek() + ": "
                    + "tehtyjä tehtäviä yhteensä: " + submission.sumExercises()
                    + ", aikaa kului " + submission.getHours() + " tuntia, tehdyt tehtävät:");
            
            for (int i = 0; i < 21; i++) {
                if(submission.doneExercises()[i]){
                    System.out.print(" " + (i+1));
                }
            }
            System.out.println("");
            hours += submission.getHours();
            exercises += submission.sumExercises();
        }
        
        System.out.println("yhteensä: " + exercises + " tehtävää, " + hours + " tuntia");
    }
}
