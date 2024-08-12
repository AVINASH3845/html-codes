package assignment3;

public class cheqingAccount extends account {
    private final double overdraftLimit;

    public cheqingAccount(int id, String firstName, String lastName, double balance, double overdraftLimit) {
        super(id, firstName, lastName, balance);
        this.overdraftLimit = overdraftLimit;
    }

    @Override
    public void withdraw(double amount) {
        if (getBalance() - amount >= -overdraftLimit) {
            setBalance(getBalance() - amount);
        } else {
            System.out.println("Transaction rejected. Overdraft limit exceeded.");
        }
    }

    @Override
    public String toString() {
        return super.toString() +
               "\nAccount Type: Checking" +
               "\nOverdraft Limit: $" + String.format("%.2f", overdraftLimit);
    }
}
