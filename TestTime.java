package assignment4;

import java.util.Scanner;

public class TestTime {
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