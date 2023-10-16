import 'package:flutter/material.dart';
import 'package:prueba_64/api/api_models.dart';
import 'package:prueba_64/presentation/screens/create_appointment_page.dart';

class AvailableAppointmentWidget extends StatelessWidget {
  AvailableAppointmentWidget({super.key, required this.appointmentResponse, required this.token, required this.tokenType});
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
              return Container(
                child: ListTile(
                  title: Text(
                      '${appointmentResponse![index].doctor.specialty.toString()} on ${appointmentResponse![index].date} at ${appointmentResponse![index].timeBlock.startTime}'),
                  subtitle: Text(appointmentResponse![index].doctor.name),
                  trailing: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CreateAnAppointmentPage(
                                    token: token,
                                    tokenType: tokenType,
                                    doctorId: appointmentResponse[index]
                                        .doctor
                                        .id,
                                    date: appointmentResponse[index].date,
                                    timeBlockId: appointmentResponse[index]
                                        .timeBlock.id,
                                  )));
                    },
                    child: Icon(Icons.add, color: Colors.white),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
