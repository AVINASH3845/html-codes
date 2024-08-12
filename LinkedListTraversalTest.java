package week12;

import java.util.LinkedList;
import java.util.ListIterator;

public class LinkedListTraversalTest {

    public static void main(String[] args) {
        int size = 500000;
        LinkedList<Integer> list = new LinkedList<>();

        System.out.println("Populating the linked list...");
        for (int i = 0; i < size; i++) {
            list.add(i);
        }
        System.out.println("Linked list populated with " + size + " elements.");

        System.out.println("Traversing using iterator...");
        long startTime = System.currentTimeMillis();
        ListIterator<Integer> iterator = list.listIterator();
        while (iterator.hasNext()) {
            iterator.next();
        }
        long endTime = System.currentTimeMillis();
        long iteratorTime = endTime - startTime;
        System.out.println("Traversal using iterator completed.");

        System.out.println("Traversing using get(index)...");
        startTime = System.currentTimeMillis();
        for (int i = 0; i < size; i++) {
            if (i % 50000 == 0) { // Print progress every 50000 iterations
                System.out.println("Reached index: " + i);
            }
            list.get(i);
        }
        endTime = System.currentTimeMillis();
        long getIndexTime = endTime - startTime;
        System.out.println("Traversal using get(index) completed.");

        System.out.println("Time taken to traverse using iterator: " + iteratorTime + " milliseconds");
        System.out.println("Time taken to traverse using get(index): " + getIndexTime + " milliseconds");
    }
}
