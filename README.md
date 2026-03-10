# Study 'N Stack - Flashcard Digital Learning App

Study 'N Stack adalah aplikasi media belajar flashcard digital berbasis Android yang dirancang untuk membantu mahasiswa, khususnya di bidang Teknik Komputer, dalam memahami dan mengingat konsep mata kuliah melalui metode *active recall*

Profil 
Muhammad Ananda Nugroho

Masalah & Solusi
Masalah: Mahasiswa sering kesulitan mengingat konsep mata kuliah yang kompleks dan merasa metode belajar tradisional membosankan[cite: 24, 25].
Solusi: Study 'N Stack menyediakan fitur chat interaktif yang meniru asisten belajar untuk membuat proses menghafal lebih aktif, menarik, dan terarah[cite: 26, 27, 29].

---

Fitur Utama
Chat Interaktif:Antarmuka percakapan sederhana untuk memilih mata kuliah sebelum mulai belajar.
Deck & Card:Pengaturan materi belajar yang terbagi menjadi kartu pertanyaan dan jawaban.
Skor & Level:Memberikan feedback berupa persentase hasil belajar dan tingkat pemahaman pengguna.
Recap Belajar:Menyimpan riwayat dan menampilkan grafik progres nilai harian secara visual.
Database Lokal (Offline):Menggunakan Isar/Room Database agar aplikasi ringan, cepat, dan dapat diakses tanpa koneksi internet.

---
Spesifikasi 
Framework: Flutter 
Bahasa Pemrograman: Dart & JSON 
Database: Isar Database (SQLite-based lokal) 
IDE:VS Code
Hardware Minimum:** Smartphone Android 7.0 (Nougat) dengan RAM 2-3 GB

---

Struktur Data (OOP)
Aplikasi ini mengimplementasikan prinsip Pemrograman Berorientasi Objek (OOP):
Encapsulation: Logika database dipisahkan dalam class `IsarService`.
Abstraction: Menyederhanakan interaksi UI melalui komponen seperti `ChatBubble`.
Polymorphism: Menggunakan `MessageType` untuk menangani berbagai tipe pesan (teks, aksi, typing) dalam satu widget.

---

Demo Aplikasi
Anda dapat melihat demo pengoperasian aplikasi melalui link video berikut:
[Video Run Aplikasi Study 'N Stack](https://youtu.be/c9YOwlUEAks) 
