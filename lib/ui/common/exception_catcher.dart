class ErrorMessageCatcher {
  static String fromException(Object object) {
    return object.toString().replaceAll("Exception: ", "");
  }
}
