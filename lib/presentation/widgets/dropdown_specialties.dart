import 'package:flutter/material.dart';
import 'package:prueba_64/api/api_models.dart';
import 'package:prueba_64/presentation/screens/search_page.dart';

class DropdownSpecialties extends StatefulWidget {
  const DropdownSpecialties(
      {super.key, required this.token, required this.tokenType});
  final String token;
  final String tokenType;
  @override
  State<DropdownSpecialties> createState() => _DropdownSpecialtiesState();
}

class _DropdownSpecialtiesState extends State<DropdownSpecialties> {
  final TextEditingController specialtyController = TextEditingController();
  Specialty? selectedSpecialty;

  @override
  Widget build(BuildContext context) {
    final List<DropdownMenuEntry<Specialty>> specialtyEntries =
        <DropdownMenuEntry<Specialty>>[
      for (Specialty specialty in Specialty.values)
        DropdownMenuEntry<Specialty>(
            value: specialty, label: specialty.toString().split(".")[1]),
    ];

    return SizedBox(
      child: MediaQuery.of(context).size.width > 1100
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SafeArea(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            DropdownMenu<Specialty>(
                              initialSelection: Specialty.Anesthesiology,
                              controller: specialtyController,
                              label: Text('specialty',
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary)),
                              inputDecorationTheme: Theme.of(context)
                                  .inputDecorationTheme
                                  .copyWith(
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          borderSide:
                                              BorderSide(color: Colors.black)),
                                      fillColor: Colors.white),
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
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 2,
                        fixedSize: MediaQuery.of(context).size.width > 800
                            ? const Size(300, 50)
                            : const Size(200, 50),
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        textStyle: Theme.of(context).textTheme.titleSmall,
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SearchResultsPage(
                                    specialty: Specialty.Anesthesiology,
                                    token: widget.token,
                                    tokenType: widget.tokenType)));
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Search by Specialty",
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(width: 10),
                          Icon(
                            Icons.search,
                            color: Colors.white,
                          )
                        ],
                      )),
                ),
              ],
            )
          : SizedBox(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: DropdownMenu<Specialty>(
                        initialSelection: Specialty.Anesthesiology,
                        controller: specialtyController,
                        label: Text('specialty',
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.primary)),
                        inputDecorationTheme: Theme.of(context)
                            .inputDecorationTheme
                            .copyWith(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide:
                                        BorderSide(color: Colors.black)),
                                fillColor: Colors.white),
                        dropdownMenuEntries: specialtyEntries,
                        onSelected: (Specialty? specialty) {
                          setState(() {
                            selectedSpecialty = specialty;
                          });
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 2,
                            fixedSize: MediaQuery.of(context).size.width > 800
                                ? const Size(300, 50)
                                : const Size(220, 50),
                            backgroundColor:
                                Theme.of(context).colorScheme.primary,
                            textStyle: Theme.of(context).textTheme.titleSmall,
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SearchResultsPage(
                                        specialty: Specialty.Anesthesiology,
                                        token: widget.token,
                                        tokenType: widget.tokenType)));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Search by Specialty",
                                style: TextStyle(color: Colors.white),
                              ),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width > 800
                                      ? 10
                                      : 5),
                              SizedBox(
                                width: MediaQuery.of(context).size.width > 800
                                    ? 10
                                    : 5,
                                child: Icon(
                                  Icons.search,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          )),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
