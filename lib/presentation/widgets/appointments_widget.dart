import 'package:flutter/material.dart';
import 'package:prueba_64/api/api_models.dart';

class AppointmentWidget extends StatelessWidget {
  AppointmentWidget({super.key, required this.appointmentResponse});
  List<BookedAppointment> appointmentResponse;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: ScrollPhysics(),
      child: Column(
        children: <Widget>[
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: appointmentResponse!.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  title: Text(
                      '${appointmentResponse![index].doctor.specialty.toString()} on ${appointmentResponse![index].date} at ${appointmentResponse![index].timeBlock.startTime}'),
                  subtitle: Text(appointmentResponse![index].doctor.name),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
