import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// const kAdminEmail = 'acnooteam@gmail.com';
const kAdminEmail = 'duc.dam@htecom.vn';
const String appTitle = 'HTECOM POS';
const String shopSubTitle = 'HTECOM POS ';
const String appNameTitle = 'HTECOM POS ADMIN';

// const kMainColor = Color(0xFF3F8CFF);
const kMainColor = Color(0xFF5BB26E);
const kDarkGreyColor = Color(0xFF2E2E3E);
const kLitGreyColor = Color(0xFFD4D4D8);
const kGreyTextColor = Color(0xFF828282);
const kBorderColorTextField = Color(0xFFE8E7E5);
const kDarkWhite = Color(0xFFF5F5F5);
const kWhiteTextColor = Color(0xFFFFFFFF);
const kRedTextColor = Color(0xFFFE2525);
const kBlueTextColor = Color(0xFF2DB0F6);
const kYellowColor = Color(0xFFFF8C00);
const kGreenTextColor = Color(0xFF15CD75);
const kTitleColor = Color(0xFF2E2E3E);
final kTextStyle = GoogleFonts.manrope(
  color: Colors.white,
);
const kButtonDecoration = BoxDecoration(
  color: kMainColor,
  borderRadius: BorderRadius.all(
    Radius.circular(40.0),
  ),
);

const kInputDecoration = InputDecoration(
  hintStyle: TextStyle(color: kBorderColorTextField),
  filled: true,
  fillColor: Colors.white70,
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(8.0)),
    borderSide: BorderSide(color: kBorderColorTextField, width: 2),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(6.0)),
    borderSide: BorderSide(color: kBorderColorTextField, width: 2),
  ),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(10.0),
    borderSide: const BorderSide(color: kBorderColorTextField),
  );
}

final otpInputDecoration = InputDecoration(
  contentPadding: const EdgeInsets.symmetric(vertical: 5.0),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

List<String> businessCategory = ['Fashion Store', 'Electronics Store', 'Computer Store', 'Vegetable Store', 'Sweet Store', 'Meat Store'];
List<String> language = ['English', 'Bengali', 'Hindi', 'Urdu', 'French', 'Spanish'];

List<String> productCategory = ['Fashion', 'Electronics', 'Computer', 'Gadgets', 'Watches', 'Cloths'];

List<String> userRole = [
  'Super Admin',
  'Admin',
  'User',
];

List<String> paymentType = [
  'Cheque',
  'Deposit',
  'Cash',
  'Transfer',
  'Sales',
];
List<String> posStats = [
  'Daily',
  'Monthly',
  'Yearly',
];
List<String> saleStats = [
  'Weekly',
  'Monthly',
  'Yearly',
];

final currentDate = DateTime.now();
final thirtyDaysAgo = currentDate.subtract(const Duration(days: 30));
final sevenDays = currentDate.subtract(const Duration(days: 7));

final firstDayOfCurrentMonth = DateTime(currentDate.year, currentDate.month, 1);
final firstDayOfCurrentYear = DateTime(currentDate.year, 1, 1);
final firstDayOfPreviousYear = firstDayOfCurrentYear.subtract(const Duration(days: 1));
final lastDayOfPreviousMonth = firstDayOfCurrentMonth.subtract(const Duration(days: 1));
final firstDayOfPreviousMonth = DateTime(lastDayOfPreviousMonth.year, lastDayOfPreviousMonth.month, 1);

