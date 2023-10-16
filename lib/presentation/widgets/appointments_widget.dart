import 'package:flutter/material.dart';
import 'package:prueba_64/api/api_models.dart';
import 'package:prueba_64/presentation/screens/cancel_appointment_page.dart';
import 'package:prueba_64/presentation/screens/login_page.dart';

class AppointmentWidget extends StatelessWidget {
  var token;
  var tokenType;

  AppointmentWidget(
      {super.key,
      required this.appointmentResponse,
      required this.token,
      required this.tokenType});
  List<BookedAppointment> appointmentResponse;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: ScrollPhysics(),
      child: Column(
        children: <Widget>[
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: appointmentResponse!.length,
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
                              builder: (context) => CancelAppointmentPage(
                                    appointmentId:
                                        appointmentResponse![index].id,
                                    token: token,
                                    tokenType: tokenType,
                                  )));
                    },
                    child: Icon(Icons.delete, color: Colors.white),
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
