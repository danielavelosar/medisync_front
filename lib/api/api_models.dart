class LoginResponse {
  late final String token;
  late final String tokenType;

  LoginResponse({
    required this.token,
    required this.tokenType,
  });

  static LoginResponse fromMap({required Map map}) => LoginResponse(
        token: map['token'],
        tokenType: map['tokenType'],
      );
}

enum Specialty {
  GeneralMedicine,
  Pediatrics,
  Cardiology,
  Orthopedics,
  Dermatology,
  Gastroenterology,
  Neurology,
  Ophtalmology,
  Oncology,
  Otolaryngology,
  Urology,
  Psychiatry,
  Obstetrics,
  Gynecology,
  Anesthesiology,
  Radiology,
  Pathology,
  Emergency,
  FamilyMedicine,
  InternalMedicine,
  Surgery,
  Other
}

class TimeBlock {
  late final String startTime;

  TimeBlock({
    required this.startTime,
  });

  static TimeBlock fromMap({required Map map}) => TimeBlock(
        startTime: map['startTime'],
      );
}

class DoctorDisplay {
  late final int id;
  late final String name;
  late final Specialty specialty;

  DoctorDisplay({
    this.id = 0,
    required this.name,
    required this.specialty,
  });

  static DoctorDisplay fromMap({required Map map}) => DoctorDisplay(
        id: map['id'],
        name: map['name'],
        // specialty is specialty enum
        specialty: Specialty.values.firstWhere(
            (element) => element.toString() == "Specialty.${map['specialty']}"),
      );
}

class AvailableAppointment {
  late final DoctorDisplay doctor;
  late final String date;
  late final TimeBlock timeBlock;

  AvailableAppointment({
    required this.doctor,
    required this.date,
    required this.timeBlock,
  });

  static AvailableAppointment fromMap({required Map map}) =>
      AvailableAppointment(
        doctor: map['doctor'],
        date: map['date'],
        timeBlock: map['timeBlock'],
      );
}

enum AppointmentStatus { PENDING, ASSISTED, CANCELLED, MISSED }

class BookedAppointment {
  late final int id;
  late final DoctorDisplay doctor;
  late final String date;
  late final TimeBlock timeBlock;

  BookedAppointment({
    this.id = 0,
    required this.doctor,
    required this.date,
    required this.timeBlock,
  });

  static BookedAppointment fromMap({required Map map}) => BookedAppointment(
        id: map['id'],
        doctor: DoctorDisplay.fromMap(map: map["doctor"]),
        date: map['date'],
        timeBlock: TimeBlock.fromMap(map: map["timeBlock"]),
      );
}

class MedicalRegistry {
  late final int id;
  late final String symptoms;
  late final String diagnosis;
  late final String treatment;
  late final String observations;
  late final String prescription;

  MedicalRegistry({
    required this.id,
    required this.symptoms,
    required this.diagnosis,
    required this.treatment,
    required this.observations,
    required this.prescription,
  });

  static MedicalRegistry fromMap({required Map map}) => MedicalRegistry(
        id: map['id'],
        symptoms: map['symptoms'],
        diagnosis: map['diagnosis'],
        treatment: map['treatment'],
        observations: map['observations'],
        prescription: map['prescription'],
      );
}

enum AffiliationType { PUBLIC, PRIVATE, INSURANCE }

class PatientData {
  late final int id;
  late final String cardId;
  late final String name;
  late final AffiliationType affiliation;
  late final String affiliationDate;

  PatientData({
    required this.id,
    required this.cardId,
    required this.name,
    required this.affiliation,
    required this.affiliationDate,
  });

  static PatientData fromMap({required Map map}) => PatientData(
        id: map['id'],
        cardId: map['cardId'],
        name: map['name'],
        affiliation: map['affiliation'],
        affiliationDate: map['affiliationDate'],
      );
}
