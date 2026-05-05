class AppConstants {
  // Default Southend map centre
  static const double defaultLat = 51.5450;
  static const double defaultLng = 0.7070;

  // Collections
  static const String usersCollection = "users";
  static const String reportsCollection = "reports";
  static const String sosAlertsCollection = "sos_alerts";
  static const String patrolStatusCollection = "patrol_status";

  // Roles
  static const String roleParent = "Parent";
  static const String roleTeen = "Teen";
  static const String roleVolunteer = "Volunteer";

  // Report types
  static const List<String> reportTypes = [
    "Suspicious Activity",
    "Anti-social Behaviour",
    "Vandalism",
    "Noise Disturbance",
    "Harassment",
    "Other",
  ];
}
