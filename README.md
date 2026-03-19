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

* Flutter SDK (disarankan versi terbaru)
* Dart
* Android Studio / VS Code
* Emulator / Device fisik

Cek instalasi dengan:

```bash
flutter doctor
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

## 🛠️ Catatan

* Tidak menggunakan API (offline/local database)
* Data tersimpan langsung di perangkat
* Cocok untuk aplikasi sederhana atau prototype

---

## 👨‍💻 Author

**Alexander Evan**

---

## 📄 License

Project ini digunakan untuk keperluan test.

---
