import 'package:flutter/material.dart';
import 'package:prueba_64/api/graphql_service.dart';
import 'package:prueba_64/utils/graphql_config.dart';

class CancelAppointmentPage extends StatefulWidget {
  final int appointmentId;
  final String token;
  final String tokenType;

  CancelAppointmentPage({
    required this.appointmentId,
    required this.token,
    required this.tokenType,
  });

  @override
  _CancelAppointmentPageState createState() => _CancelAppointmentPageState();
}

class _CancelAppointmentPageState extends State<CancelAppointmentPage> {
  bool _confirmCancel = false;
  bool _isCancelled = false;

  void _cancelAppointment() async {
    if (_confirmCancel) {
      _isCancelled = await GraphQlService().deleteAppointment(
        client: GraphQlConfig.createAuthClient(
          widget.token,
          widget.tokenType,
        ),
        appointmentId: widget.appointmentId,
      );

      // TODO: Add any additional logic after appointment is cancelled
      if (_isCancelled) {
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cancel Appointment'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Are you sure you want to cancel your appointment?'),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('No, go back'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _cancelAppointment();
                setState(() {
                  _confirmCancel = true;
                });
              },
              child: Text('Confirm'),
            ),
            //esto no se si va a funcionar :)
            if (!_isCancelled && _confirmCancel) CircularProgressIndicator()
          ],
        ),
      ),
    );
  }
}
