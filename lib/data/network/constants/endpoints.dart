class Endpoints {
  Endpoints._();

  // base url
  static const String baseUrl = "http://jsonplaceholder.typicode.com";
  static const String baseUrl1 = "http://51.15.23.9:8085/api/";

  // receiveTimeout
  static const int receiveTimeout = 15000;

  // connectTimeout
  static const int connectionTimeout = 30000;

  // booking endpoints
  static const String getPosts = baseUrl + "posts";
  static const String getCategories = baseUrl1 + "IncidentCategories";
  static const String getSubCategories = baseUrl1 + "IncidentSubCategories";
  static const String getIncidents = baseUrl1 + "Incidents/Get/";
  static const String getIncident = baseUrl1 + "Incidents/";
  static const String saveIncident = baseUrl1 + "Incidents/";
  static const String getPriorities=baseUrl1+"PriorityLevels";

  static const String doneInitially = baseUrl1 + "Incidents/DoneInitially";

  static const String finallyDone = baseUrl1 + "Incidents/FinallyDone";

  static const String taseed = baseUrl1 + "Incidents/Taseed";


  static const String login = baseUrl1 + "Account/login";
  static const String signUp = baseUrl1 + "Account/SignUp";
  static const String changePassword = baseUrl1 + "Account/Change";

  static const String forgetPasswordLink = baseUrl1 + "Account/Forgot";
  static const String resetPassword = baseUrl1 + "Account/Reset";



}