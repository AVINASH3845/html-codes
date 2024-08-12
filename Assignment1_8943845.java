package assignment1_8943845;

import java.util.Scanner;

class Assignment1_8943845 {

	    public static void main(String[] args) {
	            try (Scanner scanner = new Scanner(System.in)) {
	            
	        	// Prompting user to enter the amount of water in kilograms
	            System.out.print("Enter the amount of water in kilograms: ");
	            double waterWeight = scanner.nextDouble();
	            
	            // Checking if water weight is negative
	            if (waterWeight < 0) {
	                System.out.println("Water amount cannot be negative number!");
	            } else {
	                
	            	// Prompting user to enter the initial temperature
	    
	            	System.out.print("Enter the initial temperature: ");
	                double initialTemperature = scanner.nextDouble();
	                
	                // Prompting user to enter the final temperature
	                System.out.print("Enter the final temperature: ");
	                double finalTemperature = scanner.nextDouble();
	                
	                // Calculating the energy needed
	                double result = waterWeight * (finalTemperature - initialTemperature) * 4184;

	                // Displaying the calculated energy
	                System.out.println("The energy needed is: " + result);
	            }
	        }
	    }
	}
