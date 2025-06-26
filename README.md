# Nutricore: Aplikasi Health Tracker

Nutricore membantu pengguna melacak nutrisi, memantau BMI, dan mengelola tujuan kesehatan pribadi. Aplikasi ini memiliki fitur autentikasi pengguna, proses onboarding untuk pengaturan profil awal, perhitungan BMI dengan rencana kesehatan yang dipersonalisasi, dasbor utama untuk memantau kalori dan makro-nutrisi, pelacakan asupan air, pencarian informasi nutrisi makanan melalui API, dan notifikasi pengingat.

## Anggota Kelompok

* **Tommy Gunawan** - NRP: 5026221037
* **Mutiara Noor Fauzia** - NRP: 5026221045
* **Ryan Adi Putra Pratama** - NRP: 5026221161
* **Mohammad Geresidi Rachmadi** - NRP: 5026221163
* **Aryathama Raditya Agung** - NRP: 5026221182

## Cara Menjalankan Program

Ikuti langkah-langkah di bawah ini untuk menjalankan aplikasi di lingkungan lokal Anda:

### Prasyarat

* Pastikan Anda sudah menginstal **Flutter SDK**.
* Pastikan Anda sudah menginstal **Firebase CLI**.

### Langkah-langkah Instalasi dan Menjalankan Aplikasi

1.  **Kloning repositori:**
    ```bash
    git clone https://github.com/Aryathama/FP-Tekber-Kel4.git
    cd health_tracker_app
    ```
2.  **Dapatkan dependensi Flutter:**
    ```bash
    flutter pub get
    ```
3.  **Siapkan Firebase:**
    * Buat proyek di [Firebase Console](https://console.firebase.google.com/).
    * Tambahkan aplikasi Android, iOS, dan Web ke proyek Firebase Anda.
    * Unduh file konfigurasi Firebase (`google-services.json` untuk Android, `GoogleService-Info.plist` untuk iOS) dan letakkan di lokasi yang sesuai (misalnya, `android/app/` dan `ios/Runner/`).
    * Jalankan perintah ini di terminal untuk menghasilkan opsi Firebase untuk Flutter:
        ```bash
        flutterfire configure
        ```
4.  **Jalankan aplikasi:**
    ```bash
    flutter run
    ```
    Jika Anda ingin menjalankan di browser Chrome, gunakan:
    ```bash
    flutter run -d chrome
    ```
