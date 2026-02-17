# 📊 Personal Expense Tracker – Full Stack Application

A **Full Stack Personal Expense Tracker** built using **Flutter** for the frontend and **Laravel** for the backend.
This application allows users to securely manage their daily expenses, view insightful summaries, and track spending patterns through a simple dashboard.

---

## 🚀 Features

### 🔐 Authentication

* User registration
* User login
* JWT-based authentication
* Protected API routes

### 💰 Expense Management

* Add new expenses
* View all expenses
* Edit existing expenses
* Delete expenses
* Each expense includes:

  * Title
  * Amount
  * Category
  * Date

### 📊 Dashboard

* Total expenses
* Monthly expenses
* Category-wise expense breakdown
* Visual chart representation (Pie / Bar chart)

---

## 🛠️ Tech Stack

### Frontend

* **Flutter**
* REST API integration
* JWT token handling
* Responsive UI

### Backend

* **Laravel**
* RESTful API architecture
* JWT Authentication
* MVC pattern

### Database

* MySQL (can be replaced with PostgreSQL)

---

## 📂 Project Structure

### Backend (Laravel)

```
backend/
├── app/
│   ├── Http/
│   │   ├── Controllers/
│   │   ├── Middleware/
│   ├── Models/
├── database/
│   ├── migrations/
├── routes/
│   └── api.php
└── .env.example
```

### Frontend (Flutter)

```
frontend/
├── lib/
│   ├── models/
│   ├── services/
│   ├── screens/
│   ├── widgets/
│   └── main.dart
```

---

## 🔗 API Endpoints

### Authentication

| Method | Endpoint           | Description   |
| ------ | ------------------ | ------------- |
| POST   | /api/auth/register | Register user |
| POST   | /api/auth/login    | Login user    |

### Expenses

| Method | Endpoint           | Description      |
| ------ | ------------------ | ---------------- |
| GET    | /api/expenses      | Get all expenses |
| POST   | /api/expenses      | Add new expense  |
| PUT    | /api/expenses/{id} | Update expense   |
| DELETE | /api/expenses/{id} | Delete expense   |

> All expense routes are **JWT protected**.

---

## 🧑‍💻 Setup Instructions

### Backend (Laravel)

```bash
git clone expense_backend
cd backend
composer install
cp .env.example .env
php artisan key:generate
php artisan migrate
php artisan serve
```

Configure `.env`:

```env
DB_DATABASE=expense_backend
DB_USERNAME=root
DB_PASSWORD=
JWT_SECRET=your_secret_key
```

---

### Frontend (Flutter)

```bash
git clone expense_tracker
cd frontend
flutter pub get
flutter run
```

Update API base URL in Flutter:

```dart
const baseUrl = "http://10.0.2.2:8000/api";
```

---

## 🔐 Authentication Flow

1. User registers or logs in
2. Backend returns JWT token
3. Token stored securely in Flutter
4. Token sent in headers for protected routes

```http
Authorization: Bearer <JWT_TOKEN>
```

---

## 📈 Future Enhancements

* Expense filtering by date range
* Pagination
* Search functionality
* Backend dashboard aggregation
* Deployment (Docker / Cloud)
* Unit & integration testing

---

## 📄 Submission Notes

* Clean REST API design
* Proper commit history
* Scalable architecture
* Clear separation of frontend & backend
* Ready for production enhancement

---

## 👤 Author

**Teshan Wijiewardhana**
Full Stack Mobile & Web Developer
Flutter | Laravel | REST APIs
