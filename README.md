# DIY Holiday: Enterprise Booking & Reservation Database ✈️🏨

## 📌 Project Overview
An enterprise relational database system built with Oracle SQL and PL/SQL to manage tourism bookings, service reservations, and automated financial processing. Designed for "DIY Holiday," this centralized system streamlines travel operations by integrating tour package logistics with multi-vendor flight, hotel, and transport services.

## 💼 Business Impact
This database architecture ensures data integrity across complex, multi-vendor travel bookings. By automating payment validations and generating real-time revenue analytics, it reduces manual data entry errors and provides actionable business intelligence for tourism management.

## 🛠️ Tech Stack & Skills
* **Languages:** Oracle SQL, PL/SQL
* **Concepts:** Relational Database Design, Entity-Relationship Modeling (ERD/EER), Data Normalization, ACID Transactions
* **Database Objects:** Tables, Views, Advanced Queries, Stored Procedures, User-Defined Functions

## 📊 Database Architecture
![ER Diagram](./assets/ER_Diagram.png)
![EER Diagram](./assets/EER_Diagram.png)

## ✨ Features

- Customer Management
- Package Booking
- Flight Reservation
- Hotel Reservation
- Transportation Booking
- Payment Processing
- Revenue Reporting
- Customer Spending Analysis

## 💡 My Contributions
As a core database designer and developer on this project, my specific focus was on building the **Financial Processing and Revenue Analysis modules**:
* **Automated Transaction Logic:** Developed PL/SQL stored procedures ([`add_payment.sql`](./sql_scripts/procedures/add_payment.sql)) with multi-branch validation to enforce business rules and prevent orphaned financial records.
* **Revenue & Spending Analysis:** Engineered PL/SQL functions ([`get_total_package_revenue.sql`](./sql_scripts/functions/get_total_package_revenue.sql), [`get_customer_spending_level.sql`](./sql_scripts/functions/get_customer_spending_level.sql)) to aggregate financial data and automate customer segmentation.
* **Advanced Data Retrieval:** Wrote complex SQL queries ([`customer_revenue_queries.sql`](./sql_scripts/queries/customer_revenue_queries.sql)) utilizing subqueries and relational filtering to extract verified, high-priority revenue data for business intelligence reporting.

## 🚀 Future Improvements

- Online booking API integration
- Trigger-based payment notifications
- Role-based access control
- Booking cancellation workflow
- Dashboard reporting

## 📚 Documentation

The complete technical documentation, including the database schema, SQL implementation, business rules, and testing results, is available below:

📄 [DIY Holiday Technical Report](./docs/diy_holiday.pdf)

## Author

**Boon Jia Xuan**

Bachelor of Computer Science (Honours)

Universiti Tunku Abdul Rahman (UTAR)
