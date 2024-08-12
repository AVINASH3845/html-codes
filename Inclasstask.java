package week10;

public class Inclasstask {

    public static void main(String[] args) {
        try {
            // Original rectangle
            Rectangleclass myRectangle = new Rectangleclass(10, 20, "Red");

            // Using assignment
            Rectangleclass myNewRectangle = myRectangle;
            myNewRectangle.setColor("Blue");

            System.out.println("Assignment:");
            System.out.println("myRectangle color: " + myRectangle.getColor());
            System.out.println("myNewRectangle color: " + myNewRectangle.getColor());

            // Reset color of original rectangle
            myRectangle.setColor("Red");

            // Using cloning
            Rectangleclass myClonedRectangle = (Rectangleclass) myRectangle.clone();
            myClonedRectangle.setColor("Blue");

            System.out.println("\nCloning:");
            System.out.println("myRectangle color: " + myRectangle.getColor());
            System.out.println("myClonedRectangle color: " + myClonedRectangle.getColor());

        } catch (CloneNotSupportedException e) {
            e.printStackTrace();
        }
    }
}
