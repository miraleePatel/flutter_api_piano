// ignore_for_file: constant_identifier_names

import 'dart:io';
import 'package:get/get.dart';
import 'package:piano_project/Routes/routes.dart';
import 'package:piano_project/Screen/Authetication/forgot_password_screen.dart';
import 'package:piano_project/Screen/Authetication/login_screen.dart';
import 'package:piano_project/Screen/Authetication/registration_screen.dart';
import 'package:piano_project/Screen/Dashboard/MyActivityScreen/book_activity_details_screen.dart';
import 'package:piano_project/Screen/Dashboard/MyActivityScreen/enquire_activity_details_screen.dart';
import 'package:piano_project/Screen/Dashboard/ProfileScreen/terms_conditions_screen.dart';
import 'package:piano_project/Screen/Dashboard/ProfileScreen/wallent_balance_screen.dart';
import 'package:piano_project/Screen/Dashboard/WelcomeScreen/Booking/schedule_screen.dart';
import 'package:piano_project/Screen/Dashboard/WelcomeScreen/EventConcert/event_book_user_details_screen.dart';
import 'package:piano_project/Screen/Dashboard/WelcomeScreen/EventConcert/event_concert_booked_screen.dart';
import 'package:piano_project/Screen/Dashboard/WelcomeScreen/EventConcert/upcoming_event_details_screen.dart';
import 'package:piano_project/Screen/Dashboard/WelcomeScreen/StudioRentals/cancel_booked_studio_screen.dart';
import 'package:piano_project/Screen/Dashboard/WelcomeScreen/StudioRentals/studio_rental_booked_screen.dart';
import 'package:piano_project/Screen/Onboarding/splash_screen.dart';
import 'package:piano_project/Screen/Dashboard/MyActivityScreen/my_activity_screen.dart';
import 'package:piano_project/Screen/Dashboard/ProfileScreen/about_us_screen.dart';
import 'package:piano_project/Screen/Dashboard/WelcomeScreen/notification_screen.dart';
import 'package:piano_project/Screen/Dashboard/dashboard_screen.dart';
import '../Screen/Authetication/otp_screen.dart';
import '../Screen/Dashboard/FaqScreen/faq_screen.dart';
import '../Screen/Dashboard/ProfileScreen/contact_us_screen.dart';
import '../Screen/Dashboard/ProfileScreen/profile_screen.dart';
import '../Screen/Dashboard/WelcomeScreen/Booking/apple_failed_screen.dart';
import '../Screen/Dashboard/WelcomeScreen/Booking/apple_sucessful_screen.dart';
import '../Screen/Dashboard/WelcomeScreen/Booking/booking_screen.dart';
import '../Screen/Dashboard/WelcomeScreen/Booking/concert_payment_info_screen.dart';
import '../Screen/Dashboard/WelcomeScreen/Booking/event_concert_payment_info.dart';
import '../Screen/Dashboard/WelcomeScreen/Booking/payment_screen.dart';
import '../Screen/Dashboard/WelcomeScreen/Booking/studio_payment_info_screen.dart';
import '../Screen/Dashboard/WelcomeScreen/ConcertHallRentals/cancel_booked_concert_screen.dart';
import '../Screen/Dashboard/WelcomeScreen/ConcertHallRentals/concert_hall_booked_screen.dart';
import '../Screen/Dashboard/WelcomeScreen/ConcertHallRentals/concert_hall_rentals_detailes_screen.dart';
import '../Screen/Dashboard/WelcomeScreen/ConcertHallRentals/concert_hall_rentals_screen.dart';
import '../Screen/Dashboard/ProfileScreen/edit_profile_screen.dart';
import '../Screen/Dashboard/WelcomeScreen/EventConcert/event_concert_screen.dart';
import '../Screen/Dashboard/WelcomeScreen/EventConcert/past_event_details_screen.dart';
import '../Screen/Dashboard/WelcomeScreen/FindPianoTeacher/find_piano_teacher.dart';
import '../Screen/Dashboard/WelcomeScreen/PianoRentals/piano_rentals_detailes_screen.dart';
import '../Screen/Dashboard/WelcomeScreen/PianoRentals/piano_rentals_screen.dart';
import '../Screen/Dashboard/WelcomeScreen/PianoServices/piano_services_detailes_screen.dart';
import '../Screen/Dashboard/WelcomeScreen/PianoServices/piano_services_screen.dart';
import '../Screen/Dashboard/WelcomeScreen/StudioRentals/studio_rentals_detailes_screen.dart';
import '../Screen/Dashboard/WelcomeScreen/StudioRentals/studio_rentals_screen.dart';
import '../Screen/Dashboard/WelcomeScreen/package_screen.dart';
import '../Screen/Dashboard/WelcomeScreen/welcome_screen.dart';

Transition transition =
    Platform.isAndroid ? Transition.noTransition : Transition.cupertino;

class AppPages {
  static const INITIAL_ROUTE = Routes.SPLASH_SCREEN;

  static final routes = [
    GetPage(
      name: Routes.SPLASH_SCREEN,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: Routes.REGISTRATION_SCREEN,
      page: () => const RegistrationScreen(),
      transition: transition,
    ),
    GetPage(
      name: Routes.LOGIN_SCREEN,
      page: () => const LoginScreen(),
      transition: transition,
    ),
    GetPage(
      name: Routes.FORGOT_PASSWORD_SCREEN,
      page: () => const ForgotPassScreen(),
      transition: transition,
    ),
    GetPage(
      name: Routes.DASHBOARD_SCREEN,
      page: () => const DashboardScreen(),
      transition: transition,
    ),
    GetPage(
      name: Routes.WELCOME_SCREEN,
      page: () => const WelcomeScreen(),
      transition: transition,
    ),
    GetPage(
      name: Routes.NOTIFICATION_SCREEN,
      page: () => const NotificationScreen(),
      transition: transition,
    ),
    GetPage(
      name: Routes.PIANO_RENTALS_SCREEN,
      page: () => const PianoRentalScreen(),
      transition: transition,
    ),
    GetPage(
      name: Routes.PIANO_RENTALS_DETAIL_SCREEN,
      page: () => const PianoRentalsDetailesScreen(),
      transition: transition,
    ),
    GetPage(
      name: Routes.STUDIO_RENTALS_SCREEN,
      page: () => const StudioRentalsScreen(),
      transition: transition,
    ),
    GetPage(
      name: Routes.STUDIO_RENTALS_DETAIL_SCREEN,
      page: () => const StudioRentalsDetailesScreen(),
      transition: transition,
    ),
    GetPage(
      name: Routes.CONSERT_HALL_RENTALS_SCREEN,
      page: () => const ConsertHallRentalsScreen(),
      transition: transition,
    ),
    GetPage(
      name: Routes.CONSERT_HALL_RENTALS_DETAIL_SCREEN,
      page: () => const ConsertHallRentalsDetailesScreen(),
      transition: transition,
    ),
    GetPage(
      name: Routes.EVENT_CONSERT_BOOK_SCREEN,
      page: () => const EventConcertBookScreen(),
      transition: transition,
    ),
    GetPage(
      name: Routes.EVENT_CONSERT_SCREEN,
      page: () => const EventConcertScreen(),
      transition: transition,
    ),
    GetPage(
      name: Routes.UPCOMING_EVENT_DETAILS_SCREEN,
      page: () => const UpcomingEventDetailsScreen(),
      transition: transition,
    ),
    GetPage(
      name: Routes.PAST_EVENT_DETAILS_SCREEN,
      page: () => const PastEventDetailsScreen(),
      transition: transition,
    ),
    GetPage(
      name: Routes.EVENT_BOOK_USER_DETAILS_SCREEN,
      page: () => const EventBookUserDetailsScreen(),
      transition: transition,
    ),
    GetPage(
      name: Routes.EDIT_PROFILE_SCREEN,
      page: () => const EditProfile(),
      transition: transition,
    ),
    GetPage(
      name: Routes.PIANO_SERVICES_SCREEN,
      page: () => const PianoServicesScreen(),
      transition: transition,
    ),
    GetPage(
      name: Routes.PIANO_SERVICES_DETAIL_SCREEN,
      page: () => const PianoServicesDetailesScreen(),
      transition: transition,
    ),
    GetPage(
      name: Routes.PIANO_TEACHER_SCREEN,
      page: () => const FindPianoTeacher(),
      transition: transition,
    ),
    GetPage(
      name: Routes.BOOKING_SCREEN,
      page: () => const BookingScreen(),
      transition: transition,
    ),
    GetPage(
      name: Routes.PAYMENT_SCREEN,
      page: () => const PaymentScreen(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: Routes.PROFILE_SCREEN,
      page: () => const ProfileScreen(),
      transition: transition,
    ),
    GetPage(
      name: Routes.ABOUT_SCREEN,
      page: () => const AboutUsScreen(),
      transition: transition,
    ),
    GetPage(
      name: Routes.CONTACT_SCREEN,
      page: () => const ContactUsScreen(),
      transition: transition,
    ),
    GetPage(
      name: Routes.MM_ACTIVITY_SCREEN,
      page: () => const MyActivityScreen(),
      transition: transition,
    ),
    GetPage(
      name: Routes.FAQ_SCREEN,
      page: () => FaqScreen(isSelected: true),
      transition: transition,
    ),
    GetPage(
      name: Routes.DASHBOARD_SCREEN,
      page: () => const DashboardScreen(),
      transition: transition,
    ),
    GetPage(
      name: Routes.SHEDULE_SCREEN,
      page: () => const ScheduleScreen(),
      transition: transition,
    ),
    GetPage(
      name: Routes.OTP_SCREEN,
      page: () => const OtpScreen(),
      transition: transition,
    ),
    GetPage(
      name: Routes.TERMS_CONDITIONS_SCREEN,
      page: () => const TermsConditionsScreen(),
      transition: transition,
    ),
    GetPage(
      name: Routes.BOOK_ACTIVITY_DETAILS_SCREEN,
      page: () => const BookActivityDetailsScreen(),
      transition: transition,
    ),
    GetPage(
      name: Routes.ENQUIRE_ACTIVITY_DETAILS_SCREEN,
      page: () => const EnquireActivityDetailsScreen(),
      transition: transition,
    ),
    GetPage(
      name: Routes.STUDIO_PAYMENT_INFO_SCREEN,
      page: () => const StudioPaymentInfo(),
      transition: transition,
    ),
    GetPage(
      name: Routes.CONCERT_PAYMENT_INFO_SCREEN,
      page: () => const ConcerPaymentInfo(),
      transition: transition,
    ),
    GetPage(
      name: Routes.APPLE_SUCCESSFULL_SCREEN,
      page: () => const AppleSuccessfullScreen(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: Routes.APPLE_FAILED_SCREEN,
      page: () => const AppleFailedScreen(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: Routes.EVENT_CONCERT_PAYMENT_INFO_SCREEN,
      page: () => const EventConcertPaymentInfo(),
      transition: transition,
    ),
    GetPage(
      name: Routes.PACKAGE_SCREEN,
      page: () => const PackageScreen(),
      transition: transition,
    ),
    GetPage(
      name: Routes.STUDIO_RENTAL_BOOK_SCREEN,
      page: () => const StudioRentalBookScreen(),
      transition: transition,
    ),
    GetPage(
      name: Routes.CANCEL_BOOKED_STUDIO_SCREEN,
      page: () => const CancelBookedStudioScreen(),
      transition: transition,
    ),
    GetPage(
      name: Routes.CONCERT_HALL_BOOK_SCREEN,
      page: () => const ConcertHallBookScreen(),
      transition: transition,
    ),
    GetPage(
      name: Routes.CANCEL_BOOKED_CONCERT_SCREEN,
      page: () => const CancelBookedConcertScreen(),
      transition: transition,
    ),
    GetPage(
      name: Routes.WALLENT_BALANCE_SCREEN,
      page: () => const WallentBalanceScreen(),
      transition: transition,
    ),
  ];
}
