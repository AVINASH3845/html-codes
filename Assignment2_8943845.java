
package assignment2_8943845;

public class Assignment2_8943845 {

	public static void main(String[] args) {
		// Initialize an array of 100 boolean elements, all set to false (closed)
		boolean[] lockers = new boolean[100];

		// Iterate over each student
		for (int student = 1; student <= 100; student++) {
			// Iterate over each locker that the student will change
			for (int locker = student - 1; locker < 100; locker += student) {
				// Toggle the locker's state (open or closed)
				lockers[locker] = !lockers[locker];
			}
		}

		// Print the open lockers
		for (int i = 0; i < lockers.length; i++) {
			if (lockers[i]) {
				System.out.println("Locker " + (i + 1) + " is open");
			}
		}
	}

}