class AuthRepository {
  Future<Object> login(String? login, String? password) async {
    await Future.delayed(const Duration(seconds: 2));
    if (login == "admin" && password == "admin") {
      return "success";
    } else {
      throw "invalid credentials";
    }
  }
}
