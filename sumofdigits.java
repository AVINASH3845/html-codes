package week4;

import java.util.Scanner;

public class sumofdigits {

    public static void main(String[] args) {
        try (// Create a Scanner object to read input from the user
		Scanner input = new Scanner(System.in)) {
			// Prompt the user to enter an integer
			System.out.print("Enter an integer: ");
			long number = input.nextLong();

			// Call the sumDigits method and display the result
			System.out.println("The sum of the digits is: " + sumDigits(number));
		}
    }

    public static int sumDigits(long n) {
        int sum = 0;
        while (n != 0) {
        	// Extract the last digit and add it to sum
            sum += n % 10;
         // Remove the last digit
            n /= 10;        
        }
        return sum;
    }
}
