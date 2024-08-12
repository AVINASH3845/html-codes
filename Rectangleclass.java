package week10;

public class Rectangleclass implements Cloneable {
    private int width;
    private int height;
    private String color;

    public Rectangleclass(int width, int height, String color) {
        this.width = width;
        this.height = height;
        this.color = color;
    }

    public void setColor(String color) {
        this.color = color;
    }

    public String getColor() {
        return color;
    }

    @Override
    protected Object clone() throws CloneNotSupportedException {
        return super.clone();
    }

    @Override
    public String toString() {
        return "Rectangleclass [width=" + width + ", height=" + height + ", color=" + color + "]";
    }
}
