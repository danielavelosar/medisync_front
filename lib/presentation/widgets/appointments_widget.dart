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
                            '${appointmentResponse![index].doctor.specialty.toString().substring(10)} on ${appointmentResponse![index].date} at ${appointmentResponse![index].timeBlock.startTime}',
                            style: TextStyle(
                                fontWeight: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .fontWeight,
                                fontSize: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .fontSize,
                                fontFamily: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .fontFamily,
                                color: Theme.of(context).colorScheme.primary)),
                        subtitle: Text(appointmentResponse![index].doctor.name),
                        trailing: appointmentResponse[index].type == "PENDING"
                            ? ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              CancelAppointmentPage(
                                                appointmentId:
                                                    appointmentResponse![index]
                                                        .id,
                                                token: token,
                                                tokenType: tokenType,
                                              )));
                                },
                                child: Icon(
                                  Icons.delete,
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                ))
                            : null,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  )
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
