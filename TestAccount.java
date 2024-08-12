package assignment3;

import java.util.Scanner;

public class TestAccount {
    private static Scanner scanner = new Scanner(System.in);

    public static void main(String[] args) {
        account.setAnnualInterestRate(4.5);

        cheqingAccount cheqing = createCheqingAccount();
        SavingAccount savings = createSavingAccount();

        while (true) {
            System.out.println("\nChoose an action:");
            System.out.println("1. Withdraw from Cheqing");
            System.out.println("2. Deposit to Cheqing");
            System.out.println("3. Withdraw from Savings");
            System.out.println("4. Deposit to Savings");
            System.out.println("5. Display account information");
            System.out.println("6. Exit");

            int choice = getIntInput("Enter your choice (1-6): ");

            switch (choice) {
                case 1:
                    performWithdrawal(cheqing);
                    break;
                case 2:
                    performDeposit(cheqing);
                    break;
                case 3:
                    performWithdrawal(savings);
                    break;
                case 4:
                    performDeposit(savings);
                    break;
                case 5:
                    displayAccountInfo(cheqing, savings);
                    break;
                case 6:
                    System.out.println("Thank you for using our banking system. Goodbye!");
                    return;
                default:
                    System.out.println("Invalid choice. Please try again.");
            }
        }
    }

    private static cheqingAccount createCheqingAccount() {
        System.out.println("Creating Cheqing Account:");
        int id = getIntInput("Enter account ID: ");
        String firstName = getStringInput("Enter first name: ");
        String lastName = getStringInput("Enter last name: ");
        double balance = getDoubleInput("Enter initial balance: ");
        double overdraftLimit = getDoubleInput("Enter overdraft limit: ");
        return new cheqingAccount(id, firstName, lastName, balance, overdraftLimit);
    }

    private static SavingAccount createSavingAccount() {
        System.out.println("\nCreating Savings Account:");
        int id = getIntInput("Enter account ID: ");
        String firstName = getStringInput("Enter first name: ");
        String lastName = getStringInput("Enter last name: ");
        double balance = getDoubleInput("Enter initial balance: ");
        double transactionFee = getDoubleInput("Enter transaction fee: ");
        return new SavingAccount(id, firstName, lastName, balance, transactionFee);
    }

    private static void performWithdrawal(account account) {
        double amount = getDoubleInput("Enter amount to withdraw: ");
        account.withdraw(amount);
        System.out.println("Current balance: $" + String.format("%.2f", account.getBalance()));
    }

    private static void performDeposit(account account) {
        double amount = getDoubleInput("Enter amount to deposit: ");
        account.deposit(amount);
        System.out.println("Current balance: $" + String.format("%.2f", account.getBalance()));
    }

    private static void displayAccountInfo(cheqingAccount cheqing, SavingAccount savings) {
        System.out.println("\nCheqing Account Information:");
        System.out.println(cheqing);
        System.out.println("Monthly Interest: $" + String.format("%.2f", cheqing.getBalance() * cheqing.getMonthlyInterestRate() / 100));

        System.out.println("\nSavings Account Information:");
        System.out.println(savings);
        System.out.println("Monthly Interest: $" + String.format("%.2f", savings.getBalance() * savings.getMonthlyInterestRate() / 100));
    }

    private static int getIntInput(String prompt) {
        System.out.print(prompt);
        while (!scanner.hasNextInt()) {
            System.out.print("Invalid input. Please enter a number: ");
            scanner.next();
        }
        return scanner.nextInt();
    }

    private static double getDoubleInput(String prompt) {
        System.out.print(prompt);
        while (!scanner.hasNextDouble()) {
            System.out.print("Invalid input. Please enter a number: ");
            scanner.next();
        }
        return scanner.nextDouble();
    }

    private static String getStringInput(String prompt) {
        System.out.print(prompt);
        return scanner.next();
    }
}
