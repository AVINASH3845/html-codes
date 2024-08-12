package week4;

import java.util.Scanner;

public class inclasstask2 {

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        
        double waterWeight = getWaterWeight(scanner);
        
        if (waterWeight < 0) {
            System.out.println("Water amount cannot be negative number!");
        } else {
            double initialTemperature = getTemperature(scanner, "initial");
            double finalTemperature = getTemperature(scanner, "final");
            
            if (finalTemperature <= initialTemperature) {
                System.out.println("Final temperature must be greater than initial temperature!");
            } else {
                double energyNeeded = calculateEnergy(waterWeight, initialTemperature, finalTemperature);
                System.out.println("The energy needed is: " + energyNeeded);
            }
        }
        
        scanner.close();
    }

    private static double getWaterWeight(Scanner scanner) {
        System.out.print("Enter the amount of water in kilograms: ");
        return scanner.nextDouble();
    }

    private static double getTemperature(Scanner scanner, String tempType) {
        System.out.print("Enter the " + tempType + " temperature: ");
        return scanner.nextDouble();
    }

    private static double calculateEnergy(double waterWeight, double initialTemperature, double finalTemperature) {
        double temperatureDifference = finalTemperature - initialTemperature;
        return waterWeight * temperatureDifference * 4184;
    }
}
