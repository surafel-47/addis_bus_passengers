// ignore_for_file: file_names

import 'package:flutter/material.dart';

// Define a class to manage translations
class LocalizationManager with ChangeNotifier {
  String currentLanguage = 'en';

  final Map<String, Map<String, String>> _translations = {
    'welcome_message': {
      'en': 'Welcome to Addis City Bus App',
      'am': 'እንኳን ወደ አዲስ ከተማ የአዉቶቡስ መጠቀሚያ App በደህና መጡ',
    },
    'submit_button': {
      'en': 'Submit',
      'am': 'አስገባ',
    },
    'onBoarding_slide_1_top': {
      'en': 'Welcome Addis City Bus Passengers App!',
      'am': 'እንኳን ወደ አዲስ ከተማ የአዉቶቡስ መጠቀሚያ በደህና መጡ።',
    },
    'onBoarding_slide_1_bottom': {
      'en': 'Welcome to the Addis City Bus Transport App Where You can book your digital city bus ticket Instantly',
      'am': 'እንኳን ወደ አዲስ ከተማ አውቶቡስ ትራንስፖርት መተግበሪያ በደህና መጡ ዲጂታል የከተማ አውቶብስ ትኬት መመዝገብ ይችላሉ።',
    },
    'onBoarding_slide_2_top': {
      'en': 'Join Us for Safe and Reliable Transport In Addis',
      'am': 'በአዲስ አበባ ደህንነቱ የተጠበቀ እና አስተማማኝ ትራንስፖርትን ይቀላቀሉ።',
    },
    'onBoarding_slide_2_bottom': {
      'en': 'Our app lets you yout tickets be Scanned Digitally and Instantly',
      'am': 'የእኛ መተግበሪያ ቲኬቶችን በዲጂታል እና በቅጽበት እንዲቃኙ ያስችልዎታል',
    },
    'onBoarding_slide_3_top': {
      'en': 'Effortless Booking of Buses',
      'am': 'ያለ ልፋት አውቶቡሶች ቦታ ማስያዝ',
    },
    'onBoarding_slide_3_bottom': {
      'en': 'Easily book rides and  and view stations.',
      'am': 'በቀላሉ ጉዞዎችን ይያዙ እና ጣቢያዎችን ይመልከቱ።',
    },
    'onBoarding_bottom_text': {
      'en': 'If you would like to know more about us and our services we provide, ',
      'am': 'ስለእኛ እና ስለምናቀርበው አገልግሎት የበለጠ ማወቅ ከፈለጉ፣ ',
    },
    'onBoarding_bottom_text_site_link': {
      'en': 'Click here.',
      'am': 'ይጫኑ.',
    },
    'login_btn': {
      'en': 'Login',
      'am': 'ግባ',
    },

    //Login Page
    'welcome_back_message': {
      'en': 'Glad To Have You Back!',
      'am': 'እንኳን በደህና ተመለስክ፥ ደስ ብሎናል!',
    },

    'phone_number_text': {
      'en': 'Phone Number',
      'am': 'ስልክ ቁጥር',
    },

    'pin_code': {
      'en': 'Pin Code',
      'am': 'የይለፍ ኮድ',
    },

    'new_here': {
      'en': 'New Here?',
      'am': 'አዲስ ነዎት?',
    },

    'create_account': {
      'en': 'Create Account',
      'am': 'አካውንት ይፍጠሩ',
    },

    'login_in_page_bottom_text': {
      'en': 'Login to your Account Driver or Cashier Account with your Phone-No',
      'am': 'ሹፌር ወይም ገንዘብ ተቀባይ ከሆኑ ስልክ ቁጥሮትን በመጠቀም ወደ አካውንቶ ይግቡ።',
    },

    'login_in_page_bottom_text_passenger': {
      'en': 'Login to your Passengers Account with your Phone-No',
      'am': 'ተገልጋያችን ስልክ ቁጥሮትን በመጠቀም ወደ አካውንቶ ይግቡ።',
    },

    'create_account_text': {
      'en': 'Create Your Account and Start Traveling with us',
      'am': 'መለያዎን ይፍጠሩ እና ከእኛ ጋር መጓዝ ይጀምሩ።',
    },

    'proceed_text': {
      'en': 'Proceed',
      'am': 'ቀጣል',
    },

    'welcome_sign_up_text': {
      'en': 'Welcome! Sign up',
      'am': 'እንኳን በደህና መጣህ! ይመዝገቡ',
    },

    'full_name_text': {
      'en': 'Full Name',
      'am': 'ሙሉ ስም',
    },

    'driver_id': {
      'en': 'Driver ID',
      'am': 'የሹፌር መታወቂያ ቁጥር',
    },
    'cashier_id': {
      'en': 'Cashier ID',
      'am': 'የገንዘብ ያዥ መታወቂያ ቁጥር',
    },

    'customer_id': {
      'en': 'Customer ID',
      'am': 'የተገልጋይ የመታወቂያ ቁጥር',
    },

    'bus_id': {
      'en': 'Assigned Bus ID',
      'am': 'የተሰየመ የአውቶቡስ መታወቂያ ቁጥር',
    },

    'already_have_account_text': {
      'en': 'Already have an account?',
      'am': 'ተመዝግበዋል?',
    },
    'enter_confirmation_code_text': {
      'en': 'Enter Login Pin Code for the number to access your account',
      'am': 'በተመዝገቡበት ቁጥር SMS ላይ የተላከልዎትን ፒን ያስገቡ',
    },
    'forgot_your_pincode': {
      'en': "Forgot Your PinCode?",
      'am': 'ፒን ረስተዋል?',
    },
    'click_here': {
      'en': 'Click here.',
      'am': 'እዚህ ጋር ይጫኑ.',
    },
    'forgot_password_instructions': {
      'en': 'Contact Our Office Adminstrator with your appropritate documents to reset password',
      'am': 'የይለፍ ቃል ዳግም ለማስጀመር የኛን የቢሮ ሰራተኞች ከተገቢ ሰነዶች ጋር ሆነዉ ይደውሉልን',
    },
    'my_account': {
      'en': 'My Account',
      'am': 'የኔ አካዉንት',
    },

    'account_details': {
      'en': 'Account Details',
      'am': 'አካዉንት ዝርዝር',
    },
    'current_route': {
      'en': 'Current Route',
      'am': 'አሁን ያሉበት መንገድ',
    },
    'account_balance': {
      'en': 'Balance',
      'am': 'ቀሪ ሂሳብ',
    },
    'birr': {
      'en': 'Birr',
      'am': 'ብር',
    },
    'route_history': {
      'en': 'Route History',
      'am': 'የመንገድ ታሪክ ',
    },

    'ticket_history': {
      'en': 'Ticket History',
      'am': 'የተቆረጡ ትኬቶች ዝርዝር ',
    },

    'booked_time': {
      'en': 'Booked Time',
      'am': 'ቦታ የያዙበት ሰአት',
    },
    'language': {
      'en': 'Language',
      'am': 'ቋንቋ',
    },
    'log_out': {
      'en': 'Log Out',
      'am': 'ይውጡ',
    },
    'addis_bus_drivers': {
      'en': 'Addis Bus Drivers',
      'am': 'ሹፌር',
    },
    'addis_bus_cashiers': {
      'en': 'Addis Bus Cashiers',
      'am': 'ካሼር',
    },
    'addis_bus_passengers': {
      'en': 'Addis Bus Passenger',
      'am': 'ተጓዥ',
    },
    'view_map': {
      'en': 'View Map',
      'am': 'ካርታውን ይመልከቱ',
    },
    'view': {
      'en': 'View',
      'am': 'ይመልከቱ',
    },
    'change_pin': {
      'en': 'Change Pin',
      'am': 'ፒን ይቀይሩ',
    },
    'start_driving': {
      'en': 'Start Driving',
      'am': 'መንዳት ይጀምሩ',
    },
    'mark_as_completed': {
      'en': 'Mark As Completed',
      'am': 'ጨርስ',
    },
    'change_route': {
      'en': 'Change Route',
      'am': 'መንገድ ቀይር',
    },
    'num_requests': {
      'en': 'Number of Requests',
      'am': 'የመጠይቅ ቁጥር',
    },
    'route_name': {
      'en': 'Route Name',
      'am': 'የመንገድ ስም',
    },
    'route_details': {
      'en': 'Requested Route Details',
      'am': 'የተጠየቀው መንገድ ዝርዝር',
    },
    'route_path': {
      'en': 'Route Path',
      'am': 'የመንገድ አማራጮች',
    },
    'station': {
      'en': 'Station',
      'am': 'የባስ መሳፈሪያ',
    },
    'route_stations': {
      'en': 'Route Station',
      'am': 'የመንገድ-መሳፈሪያ',
    },
    'start_time': {
      'en': 'Start Time',
      'am': 'የጀመሩበት ሰዓት',
    },
    'scanned_ticket_count': {
      'en': 'Scanned Ticket Count',
      'am': 'የተቆረጡ ቲኬቶች ቁጥር',
    },
    'end_time': {
      'en': 'End Time',
      'am': 'የደረሱበት ሰዓት',
    },
    'current_assigned_route': {
      'en': 'Current Assigned Route',
      'am': 'አሁኑ የተመደቡበት መንገድ',
    },
    'requested_routes': {
      'en': 'Requested Routes',
      'am': 'የተጠየቁ መንገዶች',
    },
    'routes_completed': {
      'en': 'Routes Completed',
      'am': 'የተጠናቀቁ መንገዶች',
    },

    'active_tickets': {
      'en': 'Active Ticket',
      'am': 'የሚያገለግሉ ትኬት',
    },

    'route_id': {
      'en': 'Routes ID(Bus Number)',
      'am': 'የመንገድ መለያ ቁጥር',
    },

    'home': {
      'en': 'Home',
      'am': 'ሆም',
    },

    'book_ticket': {
      'en': 'Book Ticket',
      'am': 'ቲኬት ቁረጥ',
    },
    'scan_me': {
      'en': 'Scan Me',
      'am': 'በካሜራ ይቃኙ',
    },
    'view_tickets': {
      'en': 'View Tickets',
      'am': 'ቲኬቶችን ይመልከቱ',
    },

    'bus_num': {
      'en': 'Bus ID(Num)',
      'am': 'የአውቶቡስ መታወቂያ ቁጥር',
    },
    'return': {
      'en': 'Return',
      'am': 'ተመለስ',
    },
    'confirm': {
      'en': 'Confirm',
      'am': 'አረጋግጥ',
    },
    'cancel': {
      'en': 'Cancel',
      'am': 'ሰርዝ',
    },
    'select': {
      'en': 'Select',
      'am': 'ምረጥ',
    },
    'confirm_action': {
      'en': 'Confirm Action',
      'am': 'ተግባሮን ያረጋግጡ',
    },
    'travel_confrim_text': {
      'en': 'If you\'ve Traveled To the Final Station, Press Confirm',
      'am': 'ወደ መጨረሻው ጣቢያ ከተጓዝክ አረጋግጠው ይጫኑ',
    },

    'new_pin_code': {
      'en': 'New Pin-Code',
      'am': 'አዲስ ፒን',
    },
    'scan_ticket': {
      'en': 'Scan Ticket',
      'am': 'ሰካን ትኬት',
    },

    'start_station': {
      'en': 'Start Station',
      'am': 'መነሻ',
    },

    'final_station': {
      'en': 'Final Station',
      'am': 'መዳረሻ',
    },

    'amount': {
      'en': 'Amount Owed',
      'am': 'ያለበት ዕዳ መጠን',
    },

    'history': {
      'en': 'History',
      'am': 'የጉዞ ታሪክ',
    },

    'qr_code_scanner': {
      'en': 'QR Code Ticket Scanner',
      'am': 'ኪው-አር ኮድ ስካነር',
    },
  };

  String getText(String key) {
    if (_translations.containsKey(key)) {
      return _translations[key]?[currentLanguage] ?? key;
    } else {
      return key;
    }
  }

  void changeLanguage(String language) {
    currentLanguage = language;
    notifyListeners();
  }
}
