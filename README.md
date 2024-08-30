# AR Furnitue Admin Panel

## Overview

The Admin Panel is a dashboard tailored for administrators to oversee and control various aspects of the furniture application. It provides a seamless experience for managing furniture inventory, handling customer orders, and analyzing sales performance. Whether you're adding new products, updating existing information, or reviewing customer feedback, the admin panel offers a user-friendly interface to streamline these tasks.

### Key Features

### Authentication
- **Login/Logout:** Allows admins to securely log in and out of the application using Firebase Authentication.

### Furniture Management
- **Add Furniture:** Input and submit new furniture details including:
  - Name
  - Category
  - Description
  - Price
  - Image
  - Quantity
  - Color
  - 3D Models (GLB format)
- **Modify Furniture:** Edit existing furniture details.
- **View Furniture:** Access detailed information about each furniture item, including customer reviews and ratings.
- **Delete Furniture:** Remove furniture items from the inventory.

### Category Management
- **Add Category:** Create new categories with a name and image.
- **Edit Category:** Modify the name and image of existing categories.
- **Delete Category:** Remove categories from the system.
- **View Categories:** List and browse all categories and associated furniture.

### Order Management
- **View Orders:** Access a list of all customer orders with basic details.
- **Order Details:** View detailed information for each order, including customer data, items ordered, and quantities.
- **Search Orders:** Search and filter orders based on criteria such as date, customer name, or order number.

### Offer Management
- **Add Offers:** Create special offers or discounts for specific furniture items.
- **Modify Offers:** Update existing offers, including discount amounts and applicable items.
- **Search and Apply Offers:** Find furniture items and apply offers to boost sales.

### Statistics and Reporting
- **View Statistics:** Access annual and monthly statistics on orders and income.
- **Data Visualization:** Display graphs and charts showing order trends, category performance, and income distribution.

### Data Storage and Retrieval
- **Firebase Integration:** Use Firebase Firestore for storing and retrieving data related to furniture, categories, orders, and offers.
- **File Storage:** Use Firebase Storage for managing images and 3D models associated with furniture.

### User Interface and Experience
- **Responsive Design:** Ensure the application is user-friendly and responsive on various devices.
- **Search and Filter:** Implement search and filtering capabilities across furniture, orders, and categories for ease of navigation.

## Git Commands for Cloning and Working with the Project

1. **Clone the Repository:**
   ```bash
   git clone https://github.com/amrmohamed25/AR_Furniture_Admin_Panel.git
   ```

2. **Navigate to the Project Directory:**
   ```bash
   cd AR_Furniture_Admin_Panel
   ```

## Flutter Setup

### Flutter Version
```yaml
environment:
  sdk: '>=2.18.5 <3.0.0'
```


### Flutter Commands
1. **Ensure Flutter SDK is installed and up-to-date:**
   ```bash
   flutter upgrade
   ```

2. **Install the dependencies:**
   ```bash
   flutter pub get
   ```

3. **Run the Flutter application on the web:**
   ```bash
   flutter run -d chrome
   ```

### Admin Demo
https://github.com/user-attachments/assets/9d24697e-cf03-4091-91c1-cfe241a0b94a



