package assignment3;

public class SavingAccount extends account {
    private final double transactionFee;

    public SavingAccount(int id, String firstName, String lastName, double balance, double transactionFee) {
        super(id, firstName, lastName, balance);
        this.transactionFee = transactionFee;
    }

    @Override
    public void withdraw(double amount) {
        if (getBalance() >= amount + transactionFee) {
            setBalance(getBalance() - amount - transactionFee);
        } else {
            System.out.println("Transaction rejected. Insufficient funds.");
        }
    }

    @Override
    public void deposit(double amount) {
        super.deposit(amount - transactionFee);
    }

    @Override
    public String toString() {
        return super.toString() +
               "\nAccount Type: Savings" +
               "\nTransaction Fee: $" + String.format("%.2f", transactionFee);
    }
}
