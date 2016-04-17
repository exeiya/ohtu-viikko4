package ohtu;

public class Submission {
    private String student_number;
    private Integer week;
    private Integer hours;
    private boolean a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16, a17, a18, a19, a20, a21;

    public String getStudent_number() {
        return student_number;
    }

    public void setStudent_number(String student_number) {
        this.student_number = student_number;
    }

    @Override
    public String toString() {
        return student_number;
    }

    /**
     * @return the week
     */
    public Integer getWeek() {
        return week;
    }

    /**
     * @param week the week to set
     */
    public void setWeek(Integer week) {
        this.week = week;
    }

    /**
     * @return the hours
     */
    public Integer getHours() {
        return hours;
    }

    /**
     * @param hours the hours to set
     */
    public void setHours(Integer hours) {
        this.hours = hours;
    }
    
    public Integer sumExercises(){
        boolean[] done = {a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16, a17, a18, a19, a20, a21};
        int sum = 0;
        for(boolean b : done){
            if(b) sum++;
        }
        return sum;
    }
    
    public boolean[] doneExercises(){
        boolean[] done = {a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16, a17, a18, a19, a20, a21};
        return done;
    }
    
    
    
    
    
}