package week7;

import java.util.Scanner;

class Time implements Comparable<Time>, Cloneable {
    private long elapsedTime; // Elapsed time in seconds

    // No-arg constructor for the current time
    public Time() {
        this(System.currentTimeMillis() / 1000);
    }

    // Constructor with specified hour, minute, and second
    public Time(int hour, int minute, int second) {
        this.elapsedTime = hour * 3600 + minute * 60 + second;
    }

    // Constructor with specified elapsed time in seconds
    public Time(long elapsedTime) {
        this.elapsedTime = elapsedTime;
    }

    // Getters for hour, minute, and second
    public int getHour() {
        return (int) (elapsedTime / 3600) % 24;
    }

    public int getMinute() {
        return (int) (elapsedTime / 60) % 60;
    }

    public int getSecond() {
        return (int) (elapsedTime % 60);
    }

    // Get elapsed total seconds
    public long getSeconds() {
        return elapsedTime;
    }

    // Override toString method
    @Override
    public String toString() {
        int hours = getHour();
        int minutes = getMinute();
        int seconds = getSecond();
        return hours + " hours " + minutes + " minutes " + seconds + " seconds";
    }

    // Implement Comparable interface
    @Override
    public int compareTo(Time other) {
        return Long.compare(this.elapsedTime, other.elapsedTime);
    }

    // Implement Cloneable interface
    @Override
    public Time clone() {
        try {
            return (Time) super.clone();
        } catch (CloneNotSupportedException e) {
            return null;
        }
    }

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);

        while (true) {
            try {
                System.out.println("\nEnter 'exit' to quit the program.");
                
                // Get time1 input
                System.out.print("Enter time1 (hour minute second): ");
                String input = scanner.nextLine();
                
                if (input.trim().equalsIgnoreCase("exit")) {
                    break;
                }

                String[] time1Parts = input.split(" ");
                if (time1Parts.length == 3) {
                    int hour1 = Integer.parseInt(time1Parts[0]);
                    int minute1 = Integer.parseInt(time1Parts[1]);
                    int second1 = Integer.parseInt(time1Parts[2]);
                    Time time1 = new Time(hour1, minute1, second1);

                    System.out.println(time1);
                    System.out.println("Elapsed seconds in time1: " + time1.getSeconds());

                    // Get time2 input
                    System.out.print("Enter time2 (elapsed time in seconds): ");
                    long elapsedSeconds2 = Long.parseLong(scanner.nextLine());

                    Time time2 = new Time(elapsedSeconds2);

                    System.out.println(time2);
                    System.out.println("Elapsed seconds in time2: " + time2.getSeconds());

                    int comparisonResult = time1.compareTo(time2);
                    System.out.println("time1.compareTo(time2)? " + comparisonResult);
                    System.out.println("Difference in seconds: " + (time1.getSeconds() - time2.getSeconds()));

                    Time time3 = time1.clone();
                    System.out.println("time3 is created as a clone of time1");
                    System.out.println("time1.compareTo(time3)? " + time1.compareTo(time3));

                } else {
                    System.out.println("Invalid input format. Please enter hour, minute, and second.");
                }
            } catch (NumberFormatException e) {
                System.out.println("Invalid number format. Please enter valid numbers.");
            } catch (Exception e) {
                System.out.println("An unexpected error occurred: " + e.getMessage());
            }
        }

        scanner.close();
    }
}
