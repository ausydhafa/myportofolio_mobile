import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';

class EducationFormPage extends StatefulWidget {
  const EducationFormPage({super.key});

  @override
  State<EducationFormPage> createState() => _EducationFormPageState();
}

class _EducationFormPageState extends State<EducationFormPage> {
  final _formKey = GlobalKey<FormState>();

  String _institution = "";
  String _educationLevel = "S1";
  String _major = "";
  String _startYear = "";
  String _endYear = "";

  // Pilihan jenjang pendidikan.
  final List<String> _educationLevels = [
    'SMA/SMK',
    'D3',
    'D4',
    'S1',
    'S2',
    'S3',
    'Lainnya',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Add Education Form')),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // === Nama Institusi ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Contoh: Universitas Indonesia",
                    labelText: "Nama Institusi",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _institution = value!;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Nama institusi tidak boleh kosong!";
                    }
                    return null;
                  },
                ),
              ),

              // === Jenjang Pendidikan ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: "Jenjang Pendidikan",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  initialValue: _educationLevel,
                  items: _educationLevels
                      .map(
                        (level) =>
                            DropdownMenuItem(value: level, child: Text(level)),
                      )
                      .toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _educationLevel = newValue!;
                    });
                  },
                ),
              ),

              // === Program Studi ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Contoh: Sistem Informasi",
                    labelText: "Program Studi",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _major = value!;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Program studi tidak boleh kosong!";
                    }
                    return null;
                  },
                ),
              ),

              // === Tahun Mulai ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "Contoh: 2024",
                    labelText: "Tahun Mulai",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _startYear = value!;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Tahun mulai tidak boleh kosong!";
                    }

                    if (value.trim().length != 4 ||
                        int.tryParse(value.trim()) == null) {
                      return "Masukkan tahun dengan 4 digit!";
                    }

                    return null;
                  },
                ),
              ),

              // === Tahun Selesai ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "Kosongkan jika masih berlangsung",
                    labelText: "Tahun Selesai (Opsional)",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _endYear = value!;
                    });
                  },
                  validator: (String? value) {
                    // Tahun selesai boleh kosong.
                    if (value == null || value.trim().isEmpty) {
                      return null;
                    }

                    if (value.trim().length != 4 ||
                        int.tryParse(value.trim()) == null) {
                      return "Masukkan tahun dengan 4 digit!";
                    }

                    final startYear = int.tryParse(_startYear.trim());
                    final endYear = int.tryParse(value.trim());

                    if (startYear != null &&
                        endYear != null &&
                        endYear < startYear) {
                      return "Tahun selesai tidak boleh sebelum tahun mulai!";
                    }

                    return null;
                  },
                ),
              ),

              // === Tombol Simpan ===
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(Colors.indigo),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        showDialog(
                          context: context,
                          builder: (dialogContext) {
                            return AlertDialog(
                              title: const Text(
                                'Education berhasil ditambahkan!',
                              ),
                              content: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Nama Institusi: $_institution'),
                                    Text(
                                      'Jenjang Pendidikan: $_educationLevel',
                                    ),
                                    Text('Program Studi: $_major'),
                                    Text('Tahun Mulai: $_startYear'),
                                    Text(
                                      'Tahun Selesai: ${_endYear.trim().isEmpty ? "Masih berlangsung" : _endYear}',
                                    ),
                                  ],
                                ),
                              ),
                              actions: [
                                TextButton(
                                  child: const Text('OK'),
                                  onPressed: () {
                                    Navigator.pop(dialogContext);
                                    _formKey.currentState!.reset();

                                    setState(() {
                                      _institution = "";
                                      _educationLevel = "S1";
                                      _major = "";
                                      _startYear = "";
                                      _endYear = "";
                                    });
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                    child: const Text(
                      "Simpan",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
