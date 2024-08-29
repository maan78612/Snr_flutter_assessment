# Mobile Recharge App (Technical Assessment)

**Welcome to the Mobile Recharge Assessment repository!**

This app allows users to manage beneficiaries, top-up balances, and view transaction histories
efficiently.

---

## Features

- **User Authentication**: Secured login system for user access.
- **Mobile Recharge**: Recharge mobile numbers quickly and easily.
- **Transaction History**: View detailed past transactions, including amounts, beneficiaries, and
  purposes.
- **Beneficiary Management**: Add, delete, and manage beneficiaries with a simple user interface.
- **Monthly Limits**: Check the remaining monthly limit for each beneficiary.
- **Service Charges**: See service charges for each transaction, clearly summarized in an invoice
  format.

---

## Screens

1. **Login Screen**

    - The login page allows users to authenticate their accounts.
    - ![login.png](..%2F..%2F..%2F..%2FDownloads%2Fjpg2png%2Flogin.png)

2. **Mobile Recharge Screen**

    - Displays a list of active beneficiaries.
    - Navigate to the top-up screen.
    - Delete beneficiary button.
    - Shows user info and account limitations.

3. **Delete Beneficiary Confirmation**

    - A confirmation dialog when attempting to delete a beneficiary.
    - Shows a "Beneficiary deleted successfully" dialog.

4. **Add Beneficiary**

    - Add a beneficiary by providing their name and number.
    - Displays a "Beneficiary added successfully" dialog.

5. **Transaction History Screen**

    - Displays beneficiaries and their respective transactions.
    - Shows transaction purposes, amounts, and dates.

6. **Transaction Screen**

    - Displays beneficiary and user details.
    - Select top-up amount and purpose.
    - Option to add notes for the transaction.

7. **Top-up Invoice Screen Dialog**

    - Provides a summary of the total recharge amount, including service charges.
    - Shows a "Transaction completed successfully" dialog.

---

## Tech Stack

- **Frontend**: Flutter
- **State Management**: Riverpod
- **Backend**: Node.js (with a free server deployment)

---

## Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/maan78612/Snr_flutter_assessment.git

2. Navigate to the project directory:
   ```bash
   cd your-project-directory
   ```

3. Install dependencies:
   ```bash
   flutter pub get
   ```

4. Run the app:
   ```bash
   flutter run
