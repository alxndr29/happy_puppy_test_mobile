# 📱 Flutter App - Happy Puppy

Repository ini merupakan aplikasi mobile berbasis **Flutter** yang menggunakan **SQLite (sqflite)** untuk penyimpanan lokal dan **SharedPreferences** untuk manajemen sesi/login.

---

## 🚀 Tech Stack

* **Flutter (Dart)**
* **SQLite (sqflite)** – penyimpanan database lokal
* **SharedPreferences** – menyimpan data sesi/login
* **Material Design** – UI/UX standar Flutter

---

## 📋 Persyaratan

Pastikan sudah menginstall:

* Flutter SDK
* Dart
* Android Studio / VS Code
* Emulator / Device fisik

---

## 🔍 Versi yang Digunakan

Project ini dikembangkan menggunakan:

* **Flutter**: `3.41.4` (Stable)
* **Dart SDK**: `3.11.1`
* **DevTools**: `2.54.1`

Cek versi di lokal dengan:

```bash
flutter --version
```

---

## ⚙️ Cara Menjalankan Project

1. **Clone Repository**

2. **Install Dependencies**

```bash
flutter pub get
```

3. **Jalankan Aplikasi**

```bash
flutter run
```

4. (Opsional) Jika ada error build:

```bash
flutter clean
flutter pub get
```

---

## 🔐 Login Aplikasi

Gunakan akun berikut untuk masuk:

* **Username:** `admin`
* **Password:** `123456`

---

## 🔄 Alur Aplikasi

1. **Splash Screen**

   * Aplikasi melakukan pengecekan login dari `SharedPreferences`

2. **Login Page**

   * User memasukkan username & password
   * Data disimpan ke `SharedPreferences` jika berhasil login

3. **Home Page**

   * Menampilkan data dari database lokal (SQLite)
   * User dapat melakukan CRUD (Create, Read, Update, Delete)

4. **Logout**

   * Menghapus sesi dari `SharedPreferences`
   * Kembali ke halaman login

---

## 🗄️ Penyimpanan Data

* **SQLite (sqflite)**

  * Digunakan untuk menyimpan data utama aplikasi
* **SharedPreferences**

  * Menyimpan status login user

---

## 👨‍💻 Author

**Alexander Evan**

---

## 📄 License

Project ini digunakan untuk keperluan test

---
