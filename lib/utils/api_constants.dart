class ApiConstants {
  static String baseUrl = "https://800cal-backend.vercel.app";
  static String login = "$baseUrl/customer/signin";
  static String register = "$baseUrl/customer/signup";
  static String profile = "$baseUrl/customer/profile";
  static String updateProfile = "$baseUrl/customer/update";
  static String allRestaurant = "$baseUrl/restaurant/all";
  static String restaurantDetails = "$baseUrl/restaurant/profile/";
  static String groupRestaurant = "$baseUrl/restaurant/group";
  static String program = "$baseUrl/program";
  static String meals = "$baseUrl/meal/";
  static String ingredients = "$baseUrl/ingredients/";
  static String fetchTransaction = "$baseUrl/customer-transaction/customer";
  static String createTransaction = "$baseUrl/customer-transaction/create";
  static String discount = "$baseUrl/discount/apply-coupon";
  static String createOrder = "$baseUrl/order/create";
  static String fetchOrder = "$baseUrl/order/user";
  static String updateOrder = "$baseUrl/order/user/";
  static String createCalendar = "$baseUrl/calendar/create";
  static String food = "$baseUrl/food/";
  static String updateCalendar = "$baseUrl/calendar/update/";
}
