class ApiEndpoints {
  static const String baseUrl = 'https://app.farmersmarketplace.ng';

  static const String _auth = '$baseUrl/auth';
  static final Uri login = Uri.parse('$_auth/login'); // post
  static final Uri signup = Uri.parse('$_auth/signup'); // post
  static final Uri forgotPassword = Uri.parse('$_auth/forgotPassword'); // post
  static final Uri confirmReset = Uri.parse('$_auth/confirmReset'); // post
  static final Uri sendOtp = Uri.parse('$_auth/sendOtp'); // post
  static final Uri verifyOtp = Uri.parse('$_auth/verifyOtp'); // post

  static const String user = '$baseUrl/user';
  static const editProfile = '$user/editProfile';
  static const delete = '$user/delete';
  static const changePassword = '$user/changePassword';

  static final Uri categories = Uri.parse('$baseUrl/categories');

  static const String address = '$baseUrl/address';
  static const String search = '$baseUrl/search';
  static const String cart = '$baseUrl/cart';
  static const String like = '$baseUrl/like';
  static const String shipping = '$baseUrl/shipping';
  static const String products = '$baseUrl/products';
  static const String orders = '$baseUrl/orders';
  static const String notifications = '$baseUrl/notifications';
}
