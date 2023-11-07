import 'package:eight_hundred_cal/model/calendar/calendar_model.dart';
import 'package:eight_hundred_cal/model/food/food_model.dart';
import 'package:eight_hundred_cal/model/restaurant/restaurant_model.dart';
import 'package:eight_hundred_cal/model/subscription/subscription_model.dart';
import 'package:flutter/material.dart';
import 'package:eight_hundred_cal/screens/dashboard/contact_us_page.dart';
import 'package:eight_hundred_cal/screens/dashboard/dashboard_page.dart';
import 'package:eight_hundred_cal/screens/dashboard/setting_page.dart';
import 'package:eight_hundred_cal/screens/dashboard/wallet_screen.dart';
import 'package:eight_hundred_cal/screens/dashboard/your_orders__page.dart';
import 'package:eight_hundred_cal/screens/home/dish_info_page.dart';
import 'package:eight_hundred_cal/screens/home/find_your_restaurants.dart';
import 'package:eight_hundred_cal/screens/home/home_screen.dart';
import 'package:eight_hundred_cal/screens/home/popular_menu_list.dart';
import 'package:eight_hundred_cal/screens/home/restaurant_detail_page.dart';
import 'package:eight_hundred_cal/screens/home/subscribed_home_screen.dart';
import 'package:eight_hundred_cal/screens/profile/fill_your_bio_screen.dart';
import 'package:eight_hundred_cal/screens/profile/profile_screen.dart';
import 'package:eight_hundred_cal/screens/profile/update_profile.dart';
import 'package:eight_hundred_cal/screens/profile/upload_profile_photo.dart';
import 'package:eight_hundred_cal/screens/programs/suited_program.dart';
import 'package:eight_hundred_cal/screens/subscription/calendar_page_confirm.dart';
import 'package:eight_hundred_cal/screens/subscription/cancel_subscription_page.dart';
import 'package:eight_hundred_cal/screens/subscription/check_out_page.dart';
import 'package:eight_hundred_cal/screens/subscription/choose_your_meals_page.dart';
import 'package:eight_hundred_cal/screens/subscription/group_restaurant.dart';
import 'package:eight_hundred_cal/screens/subscription/meals_per_day.dart';
import 'package:eight_hundred_cal/screens/subscription/pick_restaurant_screen.dart';
import 'package:eight_hundred_cal/screens/subscription/program_details_page.dart';
import 'package:eight_hundred_cal/screens/subscription/subscription_detail_page.dart';
import 'package:eight_hundred_cal/screens/bottom_bar/calendar_page.dart';
import 'package:eight_hundred_cal/screens/bottom_bar/subscription_page.dart';

height(BuildContext context) => MediaQuery.of(context).size.height;
width(BuildContext context) => MediaQuery.of(context).size.width;

heightBox(double height) => SizedBox(height: height);
widthBox(double width) => SizedBox(width: width);

double horizontalPadding = 20.0;

List mealList = [
  {
    "name": "1 Meal",
    "description": "Main Dish",
  },
  {
    "name": "2 Meals",
    "description": "Main Dish, BreakFast",
  },
  {
    "name": "3 Meals",
    "description": "Main Dish, BreakFast,\nSoup",
  }
];

RestaurantModel dummyModel = RestaurantModel(
  category: {},
  closed: false,
  createdAt: "",
  id: "1",
  description: "",
  email: "",
  enabled: false,
  logo:
      "https://www.freepnglogos.com/uploads/chilis-png-logo/chilis-restaurant-logo-png-4.png",
  rating: 4,
  title: "Test",
  role: "",
  tags: [],
  username: "",
  verified: false,
);

List<String> subscriptionWeekListEn = [
  '1 Week',
  '2 Week',
  '3 Week',
  '4 Week',
];
List<String> subscriptionWeekListAr = [
  'أسبوع 1',
  '2 اسبوع',
  '3 اسابيع',
  '4 اسبوع',
];

SubscriptionModel subscriptionModel = SubscriptionModel();

List<String> allergies = [
  'Milk',
  'Nut',
  'Cow',
];

String playStoreUrl =
    "https://play.google.com/store/apps/details?id=com.connectia.800cal";
String appStoreUrl = "https://apps.apple.com/us/app/app-name/id123456789";

List widgetList = [
  HomeScreen(),
  SuitedProgramPage(),
  SubscriptionPage(),
  CalendarPage(),
  DashboardPage(),
  // ChooseYourPackageMealScreen(),
  FindYourRestaurantsScreen(),
  MealsPerDayScreen(),
  GroupRestaurantPage(),
  RestaurantDetailPage(),
  DishInfoPage(),
  ProfileScreen(),
  UpdateProfileScreen(),
  UploadProfilePhoto(),
  SubscriptionDetailPage(),
  CheckOutPage(),
  ProgramDetailsPage(),
  CalendarConfirmPage(),
  ChooseYourMealsPage(),
  WalletScreen(),
  YourOrdersPage(),
  CancelSubscriptionPage(),
  FillYourBioScreen(),
  SettingPage(),
  PopularMenuList(),
  ContactUsPage(),
  PickRestaurantScreen(),
];

List subWidgetList = [
  SubscribedHomeScreen(),
  SuitedProgramPage(),
  SubscriptionPage(),
  CalendarPage(),
  DashboardPage(),
  // ChooseYourPackageMealScreen(),
  FindYourRestaurantsScreen(),
  MealsPerDayScreen(),
  GroupRestaurantPage(),
  RestaurantDetailPage(),
  DishInfoPage(),
  ProfileScreen(),
  UpdateProfileScreen(),
  UploadProfilePhoto(),
  SubscriptionDetailPage(),
  CheckOutPage(),
  ProgramDetailsPage(),
  CalendarConfirmPage(),
  ChooseYourMealsPage(),
  WalletScreen(),
  YourOrdersPage(),
  CancelSubscriptionPage(),
  FillYourBioScreen(),
  SettingPage(),
  PopularMenuList(),
  ContactUsPage(),
  PickRestaurantScreen(),
];

CalendarModel dummyCalendarModel = CalendarModel(
    id: "",
    timestamp: 0,
    customer: {},
    startDate: 0,
    endDate: 0,
    duration: 0,
    includeFridays: true,
    discount: "",
    subtotal: 0,
    shippingCost: 0,
    total: 0,
    restaurantCategory: {},
    email: "",
    phone: "",
    name: "",
    address: "",
    paymentStatus: "",
    orderStatus: "",
    program: {},
    meals: {},
    v: 0,
    calendar: []);

FoodModel dummyFoodModel = FoodModel(
    id: '',
    popular: false,
    description: '',
    featured: false,
    name: '',
    image:
        'https://images.unsplash.com/photo-1565299543923-37dd37887442?auto=format&fit=crop&q=60&w=800&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cGFuY2FrZXxlbnwwfHwwfHx8MA%3D%3D',
    restaurant: {},
    badge: '',
    ingredients: [],
    protien: '',
    fat: '',
    carbs: '',
    calories: '',
    category: '');
