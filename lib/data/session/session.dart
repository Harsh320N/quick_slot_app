class Session {
  static String? userId;
  static String? userName;

  static void set(String id, String name) {
    userId = id;
    userName = name;
  }

  static void clear() {
    userId = null;
    userName = null;
  }
}
