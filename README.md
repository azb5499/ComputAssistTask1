# ComputAssist Task 1 – TheStockMan-ager

A desktop stock management application developed for ComputAssist to demonstrate the ability to build a functional system using **Delphi**, **Firebird**, and **ReportBuilder**.  
The system is built for a small wholesale business to manage inventory, record sales, and generate reports.

---

## ✅ Features

- Track stock.
- Add, update, and manage product information.
- View real-time stock levels and total stock value.
- Generate printable reports using ReportBuilder.
- Admin and Staff roles with appropriate access permissions.

---

## 😥 Notable experience differences

- Windows resizing has been disabled since forms are not yet responsive.
- Validation works but can be improved into a utilities class.
- Fonts are not consistent throughout the entire application. `Sans serif collection` was supposed to be the default of choice.
- Some text positioning seems is not centered and aligned.
- Some internal code structures can be refactored to align with SOLID,KISS and DRY principles. Will be a future refactor.
- There are noticeable lack of features in terms of deleting records. The feature is simple to implement but this was mainly to align with requirements. Possible future inclusion.


---

## ⚙️ Requirements

Before running the application, ensure the following are installed on your system:

- **Embarcadero Delphi** (compatible version)
- **ReportBuilder** (by Digital Metaphors)

> ℹ️ The application uses a Firebird database that will automatically initialize and be created when the application is run for the first time.

---

## 🔐 Default Credentials

Two default user roles are available for testing:

### Admin
- **Username**: `admin`  
- **Password**: `admin`

### Staff
- **Username**: `staff`  
- **Password**: `staffLogin`

---

## 📦 Installation & Running

1. Clone or download this repository to your local machine.
2. Open the project in Delphi.
3. Build and run the application.
4. The database will auto-create and initialize on first launch.
5. Log in using one of the default credentials.

---

## 📝 Notes

- The app includes all required base functionality as per the project brief.
- It is designed for ease of use, especially by non-technical staff.
- All data is stored locally and persists between sessions.

---

## 📁 Technologies Used

- **Delphi** – Primary development environment
- **Firebird** – Lightweight, embedded database engine
- **ReportBuilder** – For report generation and print-ready output

---
## 👨‍💻 Created By

**Ahmed Banoo**  
GitHub: [@azb5499](https://github.com/azb5499)

---
