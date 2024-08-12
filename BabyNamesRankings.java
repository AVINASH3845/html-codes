// Package declaration
package Project1; 

//Import Scanner class
import java.util.Scanner; 
//Import File class
import java.io.File;
//Import IOException class
import java.io.IOException; 

//Class declaration
public class BabyNamesRankings { 
	// Main method
	public static void main(String[] args) { 
		
		// Declare 2D array for boy names
		String[][] boyNames = new String[10][1000];
		// Declare 2D array for girl names
		String[][] girlNames = new String[10][1000]; 
		
		// Load the baby name data from the files
		loadNames(boyNames, girlNames); 
		
		// Prompt the user for input 
		// Create Scanner object
		Scanner input = new Scanner(System.in);
		// Prompt user for year
		System.out.print("Enter the year: ");
		// Read year input
		int year = input.nextInt();
		// Prompt user for gender
		System.out.print("Enter the gender (M/F): ");
		// Read gender input
		char gender = input.next().charAt(0); 
		// Prompt user for name
		System.out.print("Enter the name: "); 
		// Read name input
		String name = input.next(); 

		// Find the ranking for the specified name and gender using findRank
		int rank = findRank(year, gender, name, boyNames, girlNames);
		// Check if rank is found
		if (rank != -1) { 
			// Print ranking
			System.out.printf("%s is ranked #%d in year %d%n", name, rank % 1000, year); 
		} else {
			// Print not found message
			System.out.printf("The name %s is not ranked in year %d%n", name, year); 
		}
	}

	// Load the baby name data from the files
	private static void loadNames(String[][] boyNames, String[][] girlNames) { 
		// Loop through years 2001 to 2010
		for (int year = 2001; year <= 2010; year++) { 
			// Create file name
			String fileName = "C:\\Users\\nutha\\eclipse-workspace\\computer_programming\\Project1\\babynameranking" + year + ".txt"; 
			// Open file
			try (Scanner fileInput = new Scanner(new File(fileName))) {
				// Loop through lines in file
				for (int i = 0; i < 1000; i++) {
					// Read line
					String line = fileInput.nextLine();
					// Split line into parts
					String[] parts = line.split("\\s+");
					// Store boy name
					boyNames[year - 2001][i] = parts[1];
					// Store girl name
					girlNames[year - 2001][i] = parts[3]; 
				}
				// Catch IOException
			} catch (IOException ioException) { 
				 // Print error message
				ioException.printStackTrace();
			}
		}
	}

	// Find the ranking for the specified name and gender
	private static int findRank(int year, char gender, String name, String[][] boyNames, String[][] girlNames) { 
		
		// Choose boy or girl names array
		String[][] names = gender == 'M' ? boyNames : girlNames; 
		// Loop through names
		for (int i = 0; i < 1000; i++) {
			// Check if name is found
			if (names[year - 2001][i].equals(name)) { 
				// Return ranking
				return i + 1 + (year - 2001) * 1000; 
			}
		}
		// Return -1 if not found
		return -1; 
	}
}