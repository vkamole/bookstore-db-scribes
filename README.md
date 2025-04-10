# **Bookstore Database System**

📚 **A relational database for managing bookstore operations**, including books, authors, customers, orders, and shipping.

---

## **📌 Table of Contents**

- [Features](#-features)
- [Database Schema](#-database-schema)
- [Setup Instructions](#-setup-instructions)
- [Sample Queries](#-sample-queries)
- [User Roles & Permissions](#-user-roles--permissions)
- [ER Diagram](#-er-diagram)
- [Contributing](#-contributing)
- [License](#-license)

---

## **✨ Features**

✅ **Book & Author Management** – Track books, authors, and publishers.  
✅ **Customer Orders** – Record purchases, shipping methods, and order history.  
✅ **Address Management** – Store multiple customer addresses.  
✅ **User Access Control** – Secure roles for managers and staff.

---

## **🗄️ Database Schema**

### **Key Tables**

| Table             | Description                                                |
| ----------------- | ---------------------------------------------------------- |
| `book`            | Stores book details (title, ISBN, price).                  |
| `author`          | Contains author information.                               |
| `book_author`     | Junction table for many-to-many book-author relationships. |
| `customer`        | Customer personal details.                                 |
| `cust_order`      | Records customer orders.                                   |
| `order_line`      | Lists books in each order.                                 |
| `shipping_method` | Shipping options (e.g., Standard, Express).                |

**Full Schema:** See [SQL Scripts](/bookstore_setup.sql/) for table definitions.

---

## **⚙️ Setup Instructions**

### **1. Clone the Repository**

```bash
https://github.com/vkamole/bookstore-db-scribes.git
cd bookstore-db-scribes
```

### **2. Database Installation**

- Run the SQL scripts in **MySQL Workbench**:
  1. `schema/create_tables.sql` (Creates tables).
  2. `data/insert_sample_data.sql` (Optional test data).

Here's the updated **User Roles & Permissions** section for your README.md:

---

## **👥 User Roles & Permissions**

### **1. Create Roles & Assign Privileges**

```sql
-- Create roles
CREATE ROLE bookstore_manager, bookstore_staff;

-- Assign privileges
GRANT ALL PRIVILEGES ON bookstore_db.* TO bookstore_manager;  -- Full access
GRANT SELECT, UPDATE ON bookstore_db.* TO bookstore_staff;    -- Read/Edit only
```

### **2. Create Users & Assign Roles**

```sql
-- Admin (Manager role)
CREATE USER 'mary'@'localhost' IDENTIFIED BY '1234';
GRANT bookstore_manager TO 'mary'@'localhost';

-- Staff (Limited access)
CREATE USER 'luke'@'localhost' IDENTIFIED BY '5678';
CREATE USER 'nate'@'localhost' IDENTIFIED BY '91011';
GRANT bookstore_staff TO 'luke'@'localhost', 'nate'@'localhost';
```

### **3. Activate Roles**

```sql
-- For each user, set default role:
SET DEFAULT ROLE ALL TO
  'mary'@'localhost',
  'luke'@'localhost',
  'nate'@'localhost';
```

### **Role Summary**

| Role                | Privileges                     | Assigned Users                 |
| ------------------- | ------------------------------ | ------------------------------ |
| `bookstore_manager` | Full access (`ALL`)            | mary@localhost                 |
| `bookstore_staff`   | Read/Update (`SELECT, UPDATE`) | luke@localhost, nate@localhost |

---

---

## **🔍 Sample Queries**

### **1. Find Books by Author**

```sql
SELECT b.title, a.author_name
FROM book b
JOIN book_author ba ON b.book_id = ba.book_id
JOIN author a ON ba.author_id = a.author_id;
```

### **2. Total Sales per Customer**

```sql
SELECT c.first_name, c.last_name, SUM(ol.price * ol.quantity) AS total_spent
FROM customer c
JOIN cust_order co ON c.customer_id = co.customer_id
JOIN order_line ol ON co.order_id = ol.order_id
GROUP BY c.customer_id;
```

---

## **👥 User Roles & Permissions**

| Role                    | Privileges               | Use Case               |
| ----------------------- | ------------------------ | ---------------------- |
| **`bookstore_manager`** | `ALL`                    | Admin/owner access.    |
| **`bookstore_staff`**   | `SELECT, INSERT, UPDATE` | Staff managing orders. |

---

## **📊 ER Diagram**

![Bookstore ER Diagram](/ERD.png)  
_(Generated using MySql workbench)_

---

## **🤝 Contributing**

1. **Fork** the repository.
2. Create a **new branch** (`git checkout -b feature/new-feature`).
3. Submit a **Pull Request**.

---

## **📜 License**

This project is licensed under the **MIT License**. See [LICENSE](/LICENSE) for details.

---

**🎯 Project Goal**: To build an efficient, scalable database for bookstore operations.  
**🔗 Live Demo**: _[Coming Soon!]_

---

### **🚀 Next Steps**

- [ ] Add indexes for performance.
- [ ] Implement stored procedures.
- [ ] Build a PHP/Python frontend.

---

<p align="center"> 
  <img src="https://img.shields.io/badge/MySQL-8.0-blue" alt="MySQL Version">
  <img src="https://img.shields.io/badge/License-MIT-green" alt="License">
</p>

---

This `README.md` includes:

- Clear **project overview**.
- **Setup instructions**.
- **Sample queries** for testing.
- **Visual ER diagram**.
- **Contributing guidelines**.
