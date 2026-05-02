<<<<<<< HEAD
# 🧠 inventro – Smart Inventory Management App

> Find it nearby. Instantly.

---

## 🚀 Quick Start

### Run on Chrome (Web) — RECOMMENDED
```bash
cd inventro
flutter pub get
flutter run -d chrome
```

### Run on Windows Desktop
```bash
cd inventro
flutter pub get
flutter run -d windows
```

### Run on Android (connect phone or use emulator)
```bash
cd inventro
flutter pub get
flutter run -d android
```

---

## 📱 Screens Included

| Screen | Role |
|--------|------|
| Splash Screen | All |
| Login / Signup | All |
| Role Selection | All |
| Customer Home | Customer |
| Product Search | Customer |
| Cart | Customer |
| Order Tracking | Customer |
| Customer Profile | Customer |
| Shop Dashboard | Shopkeeper |
| Inventory Management | Shopkeeper |
| Orders Management | Shopkeeper |
| Shop Profile | Shopkeeper |

---

## 🎨 Design System

| Token | Value |
|-------|-------|
| Primary | `#1A4FE8` |
| Accent | `#FF6B00` |
| Background | `#F4F6FA` |
| Surface | `#FFFFFF` |
| Success | `#22C55E` |
| Error | `#EF4444` |

---

## 📂 Project Structure

```
lib/
├── main.dart                        ← App entry + routes
├── core/
│   └── theme/
│       ├── app_colors.dart
│       ├── app_text_styles.dart
│       └── app_theme.dart
├── features/
│   ├── auth/screens/
│   │   ├── splash_screen.dart
│   │   ├── login_screen.dart
│   │   ├── signup_screen.dart
│   │   └── role_selection_screen.dart
│   ├── customer/screens/
│   │   ├── customer_home_screen.dart
│   │   ├── customer_search_screen.dart
│   │   └── customer_profile_screen.dart
│   ├── shopkeeper/screens/
│   │   ├── shopkeeper_home_screen.dart
│   │   ├── shopkeeper_inventory_screen.dart
│   │   ├── shopkeeper_orders_screen.dart
│   │   └── shopkeeper_profile_screen.dart
│   └── orders/screens/
│       ├── cart_screen.dart
│       └── customer_orders_screen.dart
└── shared/widgets/
    ├── bottom_nav.dart
    ├── k_button.dart
    └── k_text_field.dart
```

---

## ⚙️ Backend (Node.js + MongoDB)

```bash
cd backend
npm install
cp .env.example .env
# Edit .env with your MongoDB URI and keys
npm run dev
```

### API Endpoints
- `POST /api/users/register`
- `POST /api/users/login`
- `GET  /api/users/profile`
- `GET  /api/products/list`
- `POST /api/products/add`
- `PUT  /api/products/update/:id`
- `DELETE /api/products/delete/:id`
- `POST /api/orders/create`
- `GET  /api/orders/history`
- `PUT  /api/orders/:id/status`

---

## 🔧 Tech Stack

- **Flutter 3.x** — UI
- **Node.js + Express** — Backend API
- **MongoDB Atlas** — Database
- **JWT** — Auth tokens
- **Render** — Backend hosting
=======
# Inventro
Inventro is a hyperlocal inventory and price comparison platform that connects customers with nearby shops, enabling real-time product discovery, price comparison and seamless ordering.
>>>>>>> 74fe2872abce524487484bd15b02d7b6dbc22be6
