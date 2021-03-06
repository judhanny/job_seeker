

enum ApplicationStatus{
  IN_PROGRESS,
  ABANDONED,
  SUCCESSFUL,
  UNSUCCESSFUL,
  ERROR,
  DELETE
}

class ApplicationStatusHelper {

  static String getValue(ApplicationStatus status){
    switch(status){
      case ApplicationStatus.IN_PROGRESS : return "IN_PROGRESS";
      case ApplicationStatus.ABANDONED : return "ABANDONED";
      case ApplicationStatus.SUCCESSFUL : return "SUCCESSFUL";
      case ApplicationStatus.UNSUCCESSFUL : return "UNSUCCESSFUL";
      case ApplicationStatus.ERROR : return "ERROR";
      case ApplicationStatus.DELETE : return "DELETE";
    }
  }

  static ApplicationStatus getStatusFromString(String statusAsString) {
    switch(statusAsString){
      case "IN_PROGRESS" : return ApplicationStatus.IN_PROGRESS;
      case "ABANDONED" : return  ApplicationStatus.ABANDONED;
      case "SUCCESSFUL": return ApplicationStatus.SUCCESSFUL;
      case "UNSUCCESSFUL"  : return ApplicationStatus.UNSUCCESSFUL;
      case "DELETE"  : return ApplicationStatus.DELETE;
    }

    return ApplicationStatus.ERROR;
  }
}