package assignment3;

import java.util.Date;

abstract class account {
    private int id;
    private String firstName;
    private String lastName;
    private double balance;
    private static double annualInterestRate = 0;
    private final Date dateCreated;

    public account() {
        dateCreated = new Date();
    }

    public account(int id, String firstName, String lastName, double balance) {
        this.id = id;
        this.firstName = firstName;
        this.lastName = lastName;
        this.balance = balance;
        this.dateCreated = new Date();
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public double getBalance() {
        return balance;
    }

    public void setBalance(double balance) {
        this.balance = balance;
    }

    public static double getAnnualInterestRate() {
        return annualInterestRate;
    }

    public static void setAnnualInterestRate(double rate) {
        annualInterestRate = rate;
    }

    public Date getDateCreated() {
        return dateCreated;
    }

    public double getMonthlyInterestRate() {
        return annualInterestRate / 12;
    }

    public abstract void withdraw(double amount);

    public void deposit(double amount) {
        balance += amount;
    }

    @Override
    public String toString() {
        return "Account ID: " + id +
               "\nName: " + firstName + " " + lastName +
               "\nBalance: $" + String.format("%.2f", balance) +
               "\nAnnual Interest Rate: " + String.format("%.2f", annualInterestRate) + "%" +
               "\nDate Created: " + dateCreated;
    }
}
