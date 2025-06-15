Nutricore 🥑
Aplikasi mobile berbasis Flutter untuk menganalisis nutrisi makanan menggunakan kombinasi AI (Google Gemini) dan data terverifikasi (Nutritionix).

🚀 Persiapan Awal (Setup)
Sebelum menjalankan proyek ini untuk pertama kali, ada beberapa langkah konfigurasi yang harus dilakukan oleh setiap anggota tim. Ikuti langkah-langkah di bawah ini dengan teliti.

1. Konfigurasi Firebase
Proyek ini menggunakan Firebase untuk autentikasi dan database. Setiap anggota tim harus menghubungkan local environment-nya ke proyek Firebase kita.

A. Hubungkan ke Proyek Firebase
Pastikan kamu sudah diundang sebagai anggota di proyek Firebase kita. Kalo belum, minta Ryan untuk menambahkan emailmu di proyek Firebase.

Setelah itu, jalankan perintah ini di terminal:

flutterfire configure

Pilih proyek Firebase tekber-37847 saat ditanya. Perintah ini akan secara otomatis membuat file lib/firebase_options.dart yang diperlukan.

Catatan: Jika setelah pull kamu menemukan file firebase_options.dart di dalam lib/services/local/, hapus saja file tersebut dan gunakan file baru yang dibuat di lib/ agar path impornya cocok.

B. Tambahkan File google-services.json (Untuk Android)
File konfigurasi ini akan dibagikan di grup chat tim untuk mempermudah proses setup.

Cari file google-services.json yang sudah dibagikan.

Salin dan letakkan file tersebut ke dalam folder android/app/ di proyek Anda.

2. Konfigurasi Kunci API (secrets.json)
File ini berisi semua kunci API rahasia dan akan dibagikan di grup chat tim.

Cari file secrets.json yang sudah dibagikan.

Salin dan letakkan file tersebut ke dalam folder utama (root) proyek Anda.

PENTING: File secrets.json dan google-services.json sudah dimasukkan ke dalam .gitignore dan tidak akan pernah terkirim ke repository.

3. Menjalankan Aplikasi
Karena kita menggunakan compile-time variables untuk memuat kunci API, selalu gunakan perintah berikut untuk menjalankan aplikasi:

flutter run --dart-define-from-file=secrets.json

Tips: Jika Anda menggunakan VS Code, Anda bisa mengaturnya di file .vscode/launch.json agar tidak perlu mengetik ulang setiap saat.

4. Menjalankan Unit Test (Opsional)
Proyek ini menggunakan mockito untuk unit testing. Jika Anda ingin menjalankan test, Anda perlu membuat file mock terlebih dahulu.

Jalankan perintah ini di terminal:

flutter pub run build_runner build --delete-conflicting-outputs

Perintah ini akan membuat file test/unit_test.mocks.dart.

Setelah itu, Anda bisa menjalankan semua test dengan perintah:

flutter test

Terima kasih sudah berkontribusi!
