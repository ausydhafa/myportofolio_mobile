# myportofolio_mobile

### Tugas 7

### Tugas 7

1. Widget tree adalah susunan widget secara hierarkis yang membentuk tampilan aplikasi Flutter. Setiap widget bisa memiliki widget lain sebagai child. Contohnya, MaterialApp menjadi root widget, kemudian menampilkan MyHomePage yang berisi Scaffold, AppBar, dan berbagai widget untuk menyusun konten halaman.Dengan struktur ini, tampilan aplikasi dapat dibangun dari komponen-komponen kecil yang saling terhubung.

2. SingleChildScrollView: Memungkinkan halaman digulir.
Column dan Row: Menyusun widget secara vertikal dan horizontal.
Center: Menempatkan konten di tengah.
Card dan Container: Membentuk kartu informasi.
Text: Menampilkan teks.
SizedBox: Memberikan jarak antar-widget.
GridView.count: Menampilkan menu dalam bentuk grid.
Material: Memberikan warna dan bentuk dasar kartu menu.
InkWell: Membuat kartu dapat ditekan.
Icon: Menampilkan ikon menu.
SnackBar: Menampilkan pesan ketika tombol ditekan.

3. MaterialApp merupakan widget utama yang mengatur konfigurasi aplikasi Flutter, seperti tema, judul, dan halaman awal. Widget ini digunakan sebagai root karena menyediakan dasar untuk menggunakan komponen Material Design di seluruh aplikasi. Di proyek ini, MaterialApp mengatur tema MyPortfolio Mobile dan menampilkan MyHomePage sebagai halaman utama.

4. StatelessWidget digunakan untuk tampilan yang tidak membutuhkan perubahan state secara langsung. Sementara itu, StatefulWidget digunakan ketika tampilan perlu berubah berdasarkan state yang diperbarui, misalnya melalui setState().Proyek ini menggunakan StatelessWidget karena informasi profil dan daftar menu bersifat tetap. 

5. BuildContext menunjukkan posisi sebuah widget di dalam widget tree. Dengan context, widget dapat mengakses informasi dari lingkungan widget-nya. Dalam proyek ini dipakai untuk mengakses tema melalui Theme.of(context), ukuran layar melalui MediaQuery.of(context), dan menampilkan SnackBar melalui ScaffoldMessenger.of(context).

6. Hot reload memungkinkan perubahan kode ditampilkan tanpa memulai ulang aplikasi dari awal, sehingga state yang sedang berjalan biasanya tetap dipertahankan.

Hot restart memulai ulang aplikasi Dart sehingga state sebelumnya direset. Hot reload cocok untuk perubahan tampilan atau teks, sedangkan hot restart diperlukan ketika perubahan membutuhkan inisialisasi ulang. Untuk perubahan pada konfigurasi native atau plugin, terkadang diperlukan full restart atau build ulang.

#### AI Disclosure
Dalam pengerjaan Tugas 7, saya menggunakan ChatGPT (OpenAI) sebagai alat bantu. AI membantu saya menjelaskan lebih lanjut mengenai checklist yang perlu dilakukan untuk tugas 7 ini dan merekomendasikan penggunaan SingleChildScrollView. Selain itu, AI membantu saya membantu saya memahami beberapa pertanyaan refleksi yang awalnya tidak bisa saya jawab sendiri.
