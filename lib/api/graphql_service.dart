import 'dart:async';

import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:prueba_64/api/api_models.dart';
import 'package:prueba_64/utils/graphql_config.dart';

class GraphQlService {
  static GraphQlConfig graphQlConfig = GraphQlConfig();
  GraphQLClient client = graphQlConfig.client;

  FutureOr<LoginResponse> login(
      {required String cardId, required String password}) async {
    try {
      QueryResult result = await client.mutate(MutationOptions(
        fetchPolicy: FetchPolicy.noCache,
        document: gql(''' 
              mutation Login(\$cardId: String!, \$password: String!){
                login(cardId: \$cardId, password: \$password)
                  {
                    token,
                    tokenType
                  }
                } 
            '''),
        variables: {"cardId": cardId, "password": password},
      ));

      if (result.hasException) {
        print("una excepcion");
        if (result.exception!.graphqlErrors[0].message ==
            "Invalid credentials") {
          return LoginResponse(token: "", tokenType: "");
        }
        throw result.exception!;
      }

      LoginResponse response =
          LoginResponse.fromMap(map: result.data!['login']);
      print("hay respuesta");
      return response;
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }

  FutureOr<List<BookedAppointment>> getBookedAppointments(
      {required GraphQLClient client}) async {
    try {
      QueryResult result = await client.query(QueryOptions(
        fetchPolicy: FetchPolicy.noCache,
        document: gql(''' 
              query bookedAppointments {
                myAppointments(types:[PENDING]){
                  id
                  doctor{
                    id
                    name
                    specialty
                  }
                  date
                  timeBlock{
                    id
                    startTime
                  }
                  type
                }
}
            '''),
      ));

      if (result.hasException) {
        throw result.exception!;
      }

      List<BookedAppointment> response = [];
      for (var appointment in result.data!['myAppointments']) {
        response.add(BookedAppointment.fromMap(map: appointment));
      }
      return response;
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }

  FutureOr<List<BookedAppointment>> getAppointmentsHistory(
      {required GraphQLClient client}) async {
    try {
      QueryResult result = await client.query(QueryOptions(
        fetchPolicy: FetchPolicy.noCache,
        document: gql(''' 
              query appointmentsHistory {
                myAppointments(types:[ASSISTED,CANCELLED,PENDING,MISSED]){
                  id
                  doctor{
                    id
                    name
                    specialty
                  }
                  date
                  timeBlock{
                    id
                    startTime
                  }
                  type
                }
}
            '''),
      ));

      if (result.hasException) {
        throw result.exception!;
      }

      List<BookedAppointment> response = [];
      for (var appointment in result.data!['myAppointments']) {
        response.add(BookedAppointment.fromMap(map: appointment));
      }
      return response;
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }

  FutureOr<List<AvailableAppointment>> getAvailableAppointments(
      {required GraphQLClient client,
      required String specialty,
      required String startDate,
      required String endDate}) async {
    try {
      print(specialty);
      QueryResult result = await client.query(QueryOptions(
          fetchPolicy: FetchPolicy.noCache,
          document: gql('''
  query allAvailableAppointments(\$specialty: Specialty!, \$startDate: LocalDate!, \$endDate: LocalDate!) {
    availableAppointments(specialty: \$specialty, startDate: \$startDate, endDate: \$endDate) {
      doctor {
        id,
        name,
        specialty
      },
      date,
      timeBlock {
        id,
        startTime
      },
    }
  }
'''),
          variables: {
            "specialty": specialty,
            "startDate": startDate,
            "endDate": endDate
          }));

      if (result.hasException) {
        throw result.exception!;
      }
      List<AvailableAppointment> response = [];
      for (var appointment in result.data!['availableAppointments']) {
        response.add(AvailableAppointment.fromMap(map: appointment));
      }
      return response;
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }

  FutureOr<bool> createAppointment(
      {required GraphQLClient client,
      required int doctorId,
      required String date,
      required int timeBlockId}) async {
    try {
      QueryResult result = await client.mutate(MutationOptions(
        fetchPolicy: FetchPolicy.noCache,
        document: gql(''' 
              mutation BookAppointment(\$doctorId: Int!, \$date: LocalDate! , \$timeBlockId: Int!){
                bookAppointment(doctorId: \$doctorId, date:\$date, timeBlockId:\$timeBlockId  )
                } 
            '''),
        variables: {
          "doctorId": doctorId,
          "date": date,
          "timeBlockId": timeBlockId
        },
      ));
      print(result);
      if (result.hasException) {
        print("una excepcion");
        throw result.exception!;
      }

      bool response = result.data!['bookAppointment'];
      print("hay respuesta");
      if (response == true) {
        return response;
      } else if (response == false) {
        return response;
      } else {
        throw Exception(result.exception);
      }
    } catch (e) {
      print(e);
      throw Exception(e.toString());
    }
  }

  FutureOr<bool> deleteAppointment({
    required GraphQLClient client,
    required int appointmentId,
  }) async {
    try {
      QueryResult result = await client.mutate(MutationOptions(
        fetchPolicy: FetchPolicy.noCache,
        document: gql(''' 
              mutation DeleteMyAppointment(\$appointmentId: Int!){
                cancelAppointment(appointmentId: \$appointmentId  )
                } 
            '''),
        variables: {"appointmentId": appointmentId},
      ));

      if (result.hasException) {
        print("una excepcion");
        throw result.exception!;
      }

      bool response = result.data!['cancelAppointment'];
      print("hay respuesta");
      if (response == true) {
        return response;
      } else {
        throw Exception("Error deleting appointment");
      }
    } catch (e) {
      print(e);
      throw Exception(e.toString());
    }
  }
}
