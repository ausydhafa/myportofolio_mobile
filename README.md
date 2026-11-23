# myportofolio_mobile

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

### Tugas 8

1. Navigator.push() digunakan untuk MEMBUKA halaman tanpa menutup halaman sebelumnya, sehingga pengguna bisa kembali dengan tombol Back. Navigator.pushReplacement() digunakan untuk menggantikan halaman yang sedang dibuka dengan halaman baru. Navigator.pop() digunakan untuk menutup halaman yang sedang aktif. Pada aplikasi ini, Navigator.push() digunakan ketika user memilih Tambah Education dari kartu homepage atau drawer. Sementara itu, menu Home menggunakan pushReplacement() agar pengguna bisa kembali ke halaman utama.

2. Scaffold digunakan sebagai kerangka utama halaman yang berisi AppBar, Drawer, dan konten. AppBar menampilkan judul halaman, sedangkan Drawer memudahkan pengguna berpindah ke halaman lain. Dengan menggunakan struktur yang sama, tampilan setiap halaman menjadi lebih konsisten. Contohnya, warna indigo digunakan pada DrawerHeader dan AppBar di halaman Education Form.

3. Form menggunakan Column untuk menyusun input secara vertikal dari atas ke bawah. Padding digunakan untuk memberikan jarak antarinput agar lebih rapi. SingleChildScrollView digunakan supaya seluruh formulir dapat discroll apabila tinggi konten melebihi ruang layar. Dengan demikian, pengguna tetap dapat mengakses semua field dan tombol Simpan, terutama ketika menggunakan layar ponsel atau ketika muncul keyboard.

4. GlobalKey<FormState> digunakan untuk mengakses kondisi Form dan melakukan validasi terhadap seluruh input. Tiap TextFormField memiliki validator untuk memeriksa apakah input sudah sesuai ketentuan. Ketika tombol Simpan ditekan, _formKey.currentState!.validate() akan menjalankan seluruh validator. Contohnya, nama institusi yang kosong atau hanya spasi akan ditolak. Tahun selesai juga ditolak apabila formatnya bukan 4 digit atau lebih kecil dari tahun mulai. Penggunaan keyboard numerik saja tidak menjamin input valid karena pengguna masih dapat memasukkan data yang tidak sesuai ketentuan.

#### AI Disclosure Tugas 8

Dalam pengerjaan Tugas 8, tidak ada penggunaan AI.