import 'package:flutter/material.dart';
import 'package:prueba_64/api/api_models.dart';
import 'package:prueba_64/presentation/screens/create_appointment_page.dart';

class AvailableAppointmentWidget extends StatelessWidget {
  AvailableAppointmentWidget(
      {super.key,
      required this.appointmentResponse,
      required this.token,
      required this.tokenType});
  List<AvailableAppointment> appointmentResponse;
  String token;
  String tokenType;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const ScrollPhysics(),
      child: Column(
        children: <Widget>[
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: appointmentResponse.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: ListTile(
                        title: Text(
                            '${appointmentResponse![index].doctor.specialty.toString()} on ${appointmentResponse![index].date} at ${appointmentResponse![index].timeBlock.startTime}'),
                        subtitle: Text(appointmentResponse![index].doctor.name),
                        trailing: ElevatedButton(
                          style: ButtonStyle(
                            elevation: MaterialStateProperty.all(5),
                            shape: MaterialStateProperty.all(CircleBorder()),
                            backgroundColor: MaterialStateProperty.all(
                                Theme.of(context).colorScheme.primary),
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        CreateAnAppointmentPage(
                                          token: token,
                                          tokenType: tokenType,
                                          doctorId: appointmentResponse[index]
                                              .doctor
                                              .id,
                                          date: appointmentResponse[index].date,
                                          timeBlockId:
                                              appointmentResponse[index]
                                                  .timeBlock
                                                  .id,
                                        )));
                          },
                          child: Icon(Icons.add, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
