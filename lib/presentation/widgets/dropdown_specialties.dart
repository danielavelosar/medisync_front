import 'package:flutter/material.dart';
import 'package:prueba_64/api/api_models.dart';

void main() => runApp(const DropdownSpecialties());

class DropdownSpecialties extends StatefulWidget {
  const DropdownSpecialties({super.key});

  @override
  State<DropdownSpecialties> createState() => _DropdownSpecialtiesState();
}

class _DropdownSpecialtiesState extends State<DropdownSpecialties> {
  final TextEditingController colorController = TextEditingController();
  final TextEditingController iconController = TextEditingController();
  Specialty? selectedSpecialty;

  @override
  Widget build(BuildContext context) {
    final List<DropdownMenuEntry<Specialty>> specialtyEntries =
        <DropdownMenuEntry<Specialty>>[];

    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.green,
      ),
      home: Scaffold(
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    DropdownMenu<Specialty>(
                      initialSelection: Specialty.Anesthesiology,
                      controller: colorController,
                      label: const Text('specialty'),
                      dropdownMenuEntries: specialtyEntries,
                      onSelected: (Specialty? specialty) {
                        setState(() {
                          selectedSpecialty = specialty;
                        });
                      },
                    ),
                    const SizedBox(width: 20),
                  ],
                ),
              ),
              if (selectedSpecialty != null)
                Text("selected specialty: $selectedSpecialty")
              else
                const Text('Please select a color and an icon.')
            ],
          ),
        ),
      ),
    );
  }
}
