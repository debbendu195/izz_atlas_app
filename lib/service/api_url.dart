class ApiUrl {
  /// ================= BASE URL =================
  static const String baseUrl = "https://inc-product-solomon-applies.trycloudflare.com/api/v1";
  static const String imageUrl = "";

  /// ================= AUTHENTICATION =================
  static const String signUp = "/users";
  static const String signIn = "/auth/login";

  // === Updated Endpoints based on your screenshots ===
  static const String forgotPassword = "/auth/forgot-password";
  static const String verifyOtp = "/auth/verify-otp";
  static const String resetPassword = "/auth/reset-password";
  static const String termsCondition = "/terms-conditions";
  static const String privacyPolicy = "/policy";
  static const String aboutUs = "/about-us";
  static const String changePassword = "/auth/change-password";
  static const String updateProfile = "/users/update";
  static const String vendorProfile = "/users/my-profile";
  static  String allSports({required String page}) => "/venues/group-by-sports-type?limit=10&page=$page";

  /// ==================== Vendor Profile ===================
  static const String createVenue = "/venues";
  static const String vendorMyVenues = "/venues/my";

}