import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _kLocaleStorageKey = '__locale_key__';

class FFLocalizations {
  FFLocalizations(this.locale);

  final Locale locale;

  static FFLocalizations of(BuildContext context) =>
      Localizations.of<FFLocalizations>(context, FFLocalizations)!;

  static List<String> languages() => ['en', 'ro'];

  static late SharedPreferences _prefs;
  static Future initialize() async =>
      _prefs = await SharedPreferences.getInstance();
  static Future storeLocale(String locale) =>
      _prefs.setString(_kLocaleStorageKey, locale);
  static Locale? getStoredLocale() {
    final locale = _prefs.getString(_kLocaleStorageKey);
    return locale != null && locale.isNotEmpty ? createLocale(locale) : null;
  }

  String get languageCode => locale.toString();
  String? get languageShortCode =>
      _languagesWithShortCode.contains(locale.toString())
          ? '${locale.toString()}_short'
          : null;
  int get languageIndex => languages().contains(languageCode)
      ? languages().indexOf(languageCode)
      : 0;

  String getText(String key) =>
      (kTranslationsMap[key] ?? {})[locale.toString()] ?? '';

  String getVariableText({
    String? enText = '',
    String? roText = '',
  }) =>
      [enText, roText][languageIndex] ?? '';

  static const Set<String> _languagesWithShortCode = {
    'ar',
    'az',
    'ca',
    'cs',
    'da',
    'de',
    'dv',
    'en',
    'es',
    'et',
    'fi',
    'fr',
    'gr',
    'he',
    'hi',
    'hu',
    'it',
    'km',
    'ku',
    'mn',
    'ms',
    'no',
    'pt',
    'ro',
    'ru',
    'rw',
    'sv',
    'th',
    'uk',
    'vi',
  };
}

/// Used if the locale is not supported by GlobalMaterialLocalizations.
class FallbackMaterialLocalizationDelegate
    extends LocalizationsDelegate<MaterialLocalizations> {
  const FallbackMaterialLocalizationDelegate();

  @override
  bool isSupported(Locale locale) => _isSupportedLocale(locale);

  @override
  Future<MaterialLocalizations> load(Locale locale) async =>
      SynchronousFuture<MaterialLocalizations>(
        const DefaultMaterialLocalizations(),
      );

  @override
  bool shouldReload(FallbackMaterialLocalizationDelegate old) => false;
}

/// Used if the locale is not supported by GlobalCupertinoLocalizations.
class FallbackCupertinoLocalizationDelegate
    extends LocalizationsDelegate<CupertinoLocalizations> {
  const FallbackCupertinoLocalizationDelegate();

  @override
  bool isSupported(Locale locale) => _isSupportedLocale(locale);

  @override
  Future<CupertinoLocalizations> load(Locale locale) =>
      SynchronousFuture<CupertinoLocalizations>(
        const DefaultCupertinoLocalizations(),
      );

  @override
  bool shouldReload(FallbackCupertinoLocalizationDelegate old) => false;
}

class FFLocalizationsDelegate extends LocalizationsDelegate<FFLocalizations> {
  const FFLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => _isSupportedLocale(locale);

  @override
  Future<FFLocalizations> load(Locale locale) =>
      SynchronousFuture<FFLocalizations>(FFLocalizations(locale));

  @override
  bool shouldReload(FFLocalizationsDelegate old) => false;
}

Locale createLocale(String language) => language.contains('_')
    ? Locale.fromSubtags(
        languageCode: language.split('_').first,
        scriptCode: language.split('_').last,
      )
    : Locale(language);

bool _isSupportedLocale(Locale locale) {
  final language = locale.toString();
  return FFLocalizations.languages().contains(
    language.endsWith('_')
        ? language.substring(0, language.length - 1)
        : language,
  );
}

final kTranslationsMap = <Map<String, Map<String, String>>>[
  // HomeScreen
  {
    'x9q2m7nf': {
      'en': 'Hello 👋🏻',
      'ro': '',
    },
    'nhf9yk6j': {
      'en': 'Explore',
      'ro': '',
    },
    'ujegbdrr': {
      'en': 'Scan',
      'ro': '',
    },
    '8woh7s4n': {
      'en': 'Analyze products \nquickly.',
      'ro': '',
    },
    '4dsnt882': {
      'en': 'Search',
      'ro': '',
    },
    '6k9wcww2': {
      'en': 'Find product info\nfast.',
      'ro': '',
    },
    'ba1vcuow': {
      'en': 'Additives',
      'ro': '',
    },
    'nsdcps41': {
      'en': 'Learn what’s inside.',
      'ro': '',
    },
    'sg8ho7tf': {
      'en': 'Bad Ingredients',
      'ro': '',
    },
    'ga6umnbw': {
      'en': 'Spot harmful items.',
      'ro': '',
    },
    'hine2wdn': {
      'en': 'Popular scans',
      'ro': '',
    },
    'o9egt2id': {
      'en': 'Apa plata minerala',
      'ro': '',
    },
    'qr0pztpu': {
      'en': 'Apa plata minerala San Benedetto, 1.5 l',
      'ro': '',
    },
    'xxm73s21': {
      'en': 'Home',
      'ro': '',
    },
  },
  // ProductDetails
  {
    'csb60u23': {
      'en': '10/100',
      'ro': '',
    },
    '5w5p2hq1': {
      'en': 'Bad',
      'ro': '',
    },
    'w7316efl': {
      'en': 'Coca Cola 0.33ml',
      'ro': '',
    },
    'j1uqflfd': {
      'en': 'Coca Cola ',
      'ro': '',
    },
    '9bs48st0': {
      'en': 'Ingredients',
      'ro': '',
    },
    '6mn4fkqn': {
      'en': 'See All',
      'ro': '',
    },
    'g89e5ay9': {
      'en': 'Sugars 36g',
      'ro': '',
    },
    'xf9cuelz': {
      'en': 'High Risk',
      'ro': '',
    },
    '6twifr03': {
      'en': '10 more no risk ingredients',
      'ro': '',
    },
    'xme295my': {
      'en': 'Recommendations',
      'ro': '',
    },
    '4h3ql1fs': {
      'en': 'See All',
      'ro': '',
    },
    'whclgaz0': {
      'en': 'Looking for a healthier alternative?',
      'ro': '',
    },
    't0jrl3ay': {
      'en': 'Scoring Method',
      'ro': '',
    },
    'pus9jfji': {
      'en': 'Learn how products are rated',
      'ro': '',
    },
    'muer1xqs': {
      'en': 'Product Details',
      'ro': '',
    },
    'y2phi0yl': {
      'en': 'Home',
      'ro': '',
    },
  },
  // History
  {
    'rjf2e2ze': {
      'en': 'Recent',
      'ro': '',
    },
    'lmr83e28': {
      'en': 'Favourites',
      'ro': '',
    },
    '1djzthz8': {
      'en': 'Your scan list is empty.',
      'ro': '',
    },
    'rgp2q0f4': {
      'en': 'No Favorites Yet',
      'ro': '',
    },
    'eweoeg3t': {
      'en': 'Save your favorite items to find them here \neasily next time!',
      'ro': '',
    },
    'ymharo6a': {
      'en': 'History',
      'ro': '',
    },
    '2eh5zqds': {
      'en': 'Home',
      'ro': '',
    },
  },
  // ScoringMethod
  {
    'phlmlqxs': {
      'en': 'How we rate products',
      'ro': '',
    },
    'gesjt8gj': {
      'en':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat ',
      'ro': '',
    },
    '0v9l0jca': {
      'en': 'Your Guide to Health Scores',
      'ro': '',
    },
    'dhiqoov1': {
      'en': 'Healthy choice(76-100)  ',
      'ro': '',
    },
    '7gdp9rht': {
      'en': 'Caution(51-75)  ',
      'ro': '',
    },
    'ope4bahm': {
      'en': 'Think twice (26-50)  ',
      'ro': '',
    },
    'l8mpi7mm': {
      'en': 'High risk (0-26)  ',
      'ro': '',
    },
    'cqbbguuu': {
      'en':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat ',
      'ro': '',
    },
    'yrfua5cu': {
      'en': 'Scoring Method',
      'ro': '',
    },
    'jyz6u2dm': {
      'en': 'Home',
      'ro': '',
    },
  },
  // ProfileSettings
  {
    'pjqxy9ew': {
      'en': 'Shambhavi Mishra',
      'ro': '',
    },
    'gt9wxaso': {
      'en': 'mishra@gmail.com',
      'ro': '',
    },
    'y2pb74w6': {
      'en': 'Follow Us',
      'ro': '',
    },
    'rtu0e8fr': {
      'en': 'Home',
      'ro': '',
    },
  },
  // EditProfile
  {
    'c4vorr30': {
      'en': 'Sign Out',
      'ro': '',
    },
    't9wjo91d': {
      'en': 'Delete Account',
      'ro': '',
    },
    'fh8utk4t': {
      'en': 'Edit Profile',
      'ro': '',
    },
    'z2p5qx00': {
      'en': 'Home',
      'ro': '',
    },
  },
  // PrivacyPolicy
  {
    'knioxvpt': {
      'en':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.  Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.  Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.  Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea ',
      'ro': '',
    },
    'hi6tahx5': {
      'en': 'Privacy Policy',
      'ro': '',
    },
    'j2qs7d34': {
      'en': 'Home',
      'ro': '',
    },
  },
  // TermsOfUse
  {
    'spyekk13': {
      'en':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.  Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.  Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.  Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea ',
      'ro': '',
    },
    '7m87t0no': {
      'en': 'Terms of Use',
      'ro': '',
    },
    '0hkv4ddf': {
      'en': 'Home',
      'ro': '',
    },
  },
  // Notifications
  {
    'slf2ttsv': {
      'en': 'Allow Notifications',
      'ro': '',
    },
    '34tdq6vv': {
      'en':
          'Stay updated with the latest from Purio! Turn on notifications to never miss:  \t•\tImportant updates\n\t•\tPersonalized tips\n\t•\tExclusive features',
      'ro': '',
    },
    '56c3uq32': {
      'en': '1. Open Settings',
      'ro': '',
    },
    'ohkg5sd0': {
      'en': '2. Tap Notifications',
      'ro': '',
    },
    'eho3lknd': {
      'en': '3. Allow Purio to end you notifications.',
      'ro': '',
    },
    'se2g3ybz': {
      'en': 'Notifications',
      'ro': '',
    },
    '4ddf29yt': {
      'en': 'Home',
      'ro': '',
    },
  },
  // SingUp-LogIn
  {
    '4pwlcxs5': {
      'en': 'Choose better, live healthier.',
      'ro': '',
    },
    'wn1wwzvk': {
      'en': 'Continue with Email',
      'ro': '',
    },
    '8wzpehyg': {
      'en': 'Continue with Apple',
      'ro': '',
    },
    'jc8728go': {
      'en': 'Continue with Google',
      'ro': '',
    },
    '7pm2vkyn': {
      'en': 'Home',
      'ro': '',
    },
  },
  // ContinueEmail
  {
    'iwrt97yc': {
      'en': 'What\'s your email?',
      'ro': '',
    },
    'on87fhzu': {
      'en': 'E-mail',
      'ro': '',
    },
    '6iwy3c8t': {
      'en': 'E-mail is required',
      'ro': '',
    },
    'dl11rfgt': {
      'en': 'Wrong email format!',
      'ro': '',
    },
    '8eys0fci': {
      'en': 'Please choose an option from the dropdown',
      'ro': '',
    },
    'uifyvl16': {
      'en': 'Continue ',
      'ro': '',
    },
    'orsn8sc6': {
      'en': 'Home',
      'ro': '',
    },
  },
  // ContinuePassword
  {
    'vg0xbsod': {
      'en': 'Now choose a password',
      'ro': '',
    },
    'p6q6bvub': {
      'en': 'You are creating an account with ',
      'ro': '',
    },
    'd0ornpmi': {
      'en': 'Change.',
      'ro': '',
    },
    '6dgk7ipy': {
      'en': 'Password',
      'ro': '',
    },
    '0d1j2jtl': {
      'en': 'Password is required',
      'ro': '',
    },
    'j4ti1s0e': {
      'en': 'Password must be at least 6 characters',
      'ro': '',
    },
    'k3xsvd36': {
      'en': 'Please choose an option from the dropdown',
      'ro': '',
    },
    '2ise810c': {
      'en': 'Confirm Password',
      'ro': '',
    },
    '0uaflaan': {
      'en': 'Password is required',
      'ro': '',
    },
    'dd4k10ok': {
      'en': 'Password must be at least 6 characters',
      'ro': '',
    },
    'lhn7bjoe': {
      'en': 'Please choose an option from the dropdown',
      'ro': '',
    },
    'vb2ld97q': {
      'en': 'I agree to ',
      'ro': '',
    },
    'emiap6x0': {
      'en': 'Terms & Conditions',
      'ro': '',
    },
    '1owv5d59': {
      'en': ' and ',
      'ro': '',
    },
    '8fble3n3': {
      'en': 'Privacy Policy',
      'ro': '',
    },
    'gnsgggcs': {
      'en': '',
      'ro': '',
    },
    'ott5beqb': {
      'en': 'Continue',
      'ro': '',
    },
    '2yx8mst8': {
      'en': 'Home',
      'ro': '',
    },
  },
  // ContinueAccountDetails
  {
    'o0u1599y': {
      'en': 'Account Details',
      'ro': '',
    },
    'q0c6t28l': {
      'en': 'We\'d love to refer to you by name',
      'ro': '',
    },
    '1iym6wsx': {
      'en': 'First name',
      'ro': '',
    },
    '7lzk8ecf': {
      'en': 'Last name',
      'ro': '',
    },
    'rsh3njnz': {
      'en': 'Continue',
      'ro': '',
    },
    '0wyvrb0v': {
      'en': 'Home',
      'ro': '',
    },
  },
  // Continue1stQuestion
  {
    '6c55y8ef': {
      'en': '2 quick questions',
      'ro': '',
    },
    'mgmbqkym': {
      'en': '*1: How do you choose your products?',
      'ro': '',
    },
    'o63c9mmp': {
      'en': 'Continue ',
      'ro': '',
    },
    'y51rmo0v': {
      'en': 'Terms & Conditions',
      'ro': '',
    },
    'fb2r6np3': {
      'en': 'Home',
      'ro': '',
    },
  },
  // Continue2ndQuestion
  {
    'd0ty1i2e': {
      'en': '2 quick questions',
      'ro': '',
    },
    '49mr6z1h': {
      'en': '*2: What do you want Purio to help you with?',
      'ro': '',
    },
    'vdrxnj9r': {
      'en': 'Done',
      'ro': '',
    },
    'o4toanfy': {
      'en': 'Terms & Conditions',
      'ro': '',
    },
    'n8yersm9': {
      'en': 'Home',
      'ro': '',
    },
  },
  // PurioProScreen
  {
    '0gcv45ml': {
      'en': 'FREE PRO\n7-days trial',
      'ro': '',
    },
    'olj1knz7': {
      'en':
          'No payment now. Cancel any time. Then \n139.99 RON/year (11,66 RON/month).',
      'ro': '',
    },
    'tzfzejzp': {
      'en': 'Continue ',
      'ro': '',
    },
    '6gezjcuo': {
      'en': 'Terms & Conditions',
      'ro': '',
    },
    '5lhkthck': {
      'en': 'Purio ',
      'ro': '',
    },
    '2o4n27pd': {
      'en': 'Pro',
      'ro': '',
    },
    'ine7hd05': {
      'en': 'Home',
      'ro': '',
    },
  },
  // IncorrectPassword
  {
    'ku9srp21': {
      'en': 'Welcome back! Log In in \nto your Purio account ',
      'ro': '',
    },
    'lkdgd0je': {
      'en': 'Email',
      'ro': '',
    },
    '9ksxi6ui': {
      'en': 'Password',
      'ro': '',
    },
    'qf0w5nzs': {
      'en':
          'Password is incorrect. Try again or use the link to get an \nemail with log-in informations.',
      'ro': '',
    },
    'l3wjlhe6': {
      'en': 'Log In',
      'ro': '',
    },
    'iux3zrs3': {
      'en': 'Email me a link to log in',
      'ro': '',
    },
    'zxw8kqmd': {
      'en': 'or',
      'ro': '',
    },
    'lp3q6x8y': {
      'en': 'Continue with Apple',
      'ro': '',
    },
    '6ux8sd2f': {
      'en': 'Continue with Google',
      'ro': '',
    },
    '1mz4wwxe': {
      'en': 'Log in',
      'ro': '',
    },
    '4b5a03ur': {
      'en': 'Home',
      'ro': '',
    },
  },
  // PasswordRecovery
  {
    'ibq84nqr': {
      'en': 'Check your email!',
      'ro': '',
    },
    '6e8v1ttz': {
      'en': 'We send an email with a link that will log \nyou in to ',
      'ro': '',
    },
    'pvix1n9k': {
      'en': 'name@yahoo.com',
      'ro': '',
    },
    'czibjxvt': {
      'en': '.',
      'ro': '',
    },
    'xhnu7gl3': {
      'en': 'Remember to check the spam folder..',
      'ro': '',
    },
    'nxzoe4v2': {
      'en': 'I didn’t get an email.',
      'ro': '',
    },
    'ev3u6i5n': {
      'en': 'Log in',
      'ro': '',
    },
    '7262nuur': {
      'en': 'Home',
      'ro': '',
    },
  },
  // Feedback
  {
    'd96v3xf6': {
      'en': 'ISSUE, QUESTION OR SUGGESTION',
      'ro': '',
    },
    'pkpdfk4m': {
      'en': 'Your Message to Our Team',
      'ro': '',
    },
    'fxp8nvjw': {
      'en': 'Send',
      'ro': '',
    },
    'wvrb7mdi': {
      'en': 'Privacy Policy',
      'ro': '',
    },
    'v6sjhyxb': {
      'en': 'Home',
      'ro': '',
    },
  },
  // LogIn
  {
    'zxstwbxi': {
      'en': 'Welcome back! Log In in \nto your Purio account ',
      'ro': '',
    },
    'efelxctk': {
      'en': 'Email',
      'ro': '',
    },
    '5vvgj7nm': {
      'en': 'Password',
      'ro': '',
    },
    'bd1tkpa2': {
      'en': 'Log In',
      'ro': '',
    },
    '4cnlg5zd': {
      'en': 'Email me a link to log in',
      'ro': '',
    },
    'ek1imcbd': {
      'en': 'or',
      'ro': '',
    },
    'gbe4649w': {
      'en': 'Continue with Apple',
      'ro': '',
    },
    'tyg9wgvo': {
      'en': 'Continue with Google',
      'ro': '',
    },
    'md54mxa9': {
      'en': 'Log in',
      'ro': '',
    },
    'ze3xnff9': {
      'en': 'Home',
      'ro': '',
    },
  },
  // Search
  {
    '7iabb8r4': {
      'en': 'e.g. Paine Vel Pitar ',
      'ro': '',
    },
    'p59vvkdz': {
      'en': 'Find Your Product',
      'ro': '',
    },
    'orieo052': {
      'en':
          'Search by product name or brand and discover detailed insights instantly. 🛒',
      'ro': '',
    },
    'cnw6hi6r': {
      'en': 'Search',
      'ro': '',
    },
    '6rmudlhy': {
      'en': 'Home',
      'ro': '',
    },
  },
  // Navbar
  {
    'gymm28kd': {
      'en': 'Cancel',
      'ro': '',
    },
  },
  // ProductCard
  {
    'y3i8j1fq': {
      'en': 'Lorem',
      'ro': '',
    },
    'b17hfra4': {
      'en': 'Orange Juice 1l',
      'ro': '',
    },
    '32gmewo5': {
      'en': 'Safety:',
      'ro': '',
    },
    '43xscjca': {
      'en': '100/100',
      'ro': '',
    },
  },
  // RecoveryEmailPopup
  {
    'xj8l6u3y': {
      'en': 'Didn’t get the email?',
      'ro': '',
    },
    'u94e2ug8': {
      'en': 'Send the email again',
      'ro': '',
    },
    '8uzxzp8n': {
      'en': 'Contact support',
      'ro': '',
    },
  },
  // DeleteAccountPopUp
  {
    'sup7de9p': {
      'en': 'Are You Sure?',
      'ro': '',
    },
    'qp8tp30w': {
      'en': 'All your data will be gone. \nSure about this?',
      'ro': '',
    },
    'rh4mxwuv': {
      'en': 'Keep My Account',
      'ro': '',
    },
    'h0ea7x3j': {
      'en': 'Delete It Anyway',
      'ro': '',
    },
  },
  // FirstQuestion
  {
    '4nrmy9zk': {
      'en': '',
      'ro': '',
    },
  },
  // SearchProduct
  {
    'vhfv4iac': {
      'en': 'Lorem ipsum',
      'ro': '',
    },
    'g03001l8': {
      'en': 'Lorem',
      'ro': '',
    },
    'pbz85v9t': {
      'en': '100/100',
      'ro': '',
    },
  },
  // Additives
  {
    '5wsh581s': {
      'en': 'E101',
      'ro': '',
    },
    'b3x4k9h3': {
      'en': 'Risk Free',
      'ro': '',
    },
  },
  // Miscellaneous
  {
    'fciqtn4z': {
      'en': '',
      'ro': '',
    },
    'j92ogu64': {
      'en': 'permission',
      'ro': '',
    },
    'n6zl877e': {
      'en': 'permission',
      'ro': '',
    },
    '9ih5ljdi': {
      'en': 'permission',
      'ro': '',
    },
    'mllrcky2': {
      'en': 'permission',
      'ro': '',
    },
    'sgr8p66f': {
      'en': 'Authentication Error: [error]',
      'ro': '',
    },
    't1bp0k5q': {
      'en': '',
      'ro': '',
    },
    'gr7jtz6h': {
      'en': '',
      'ro': '',
    },
    'l3xncwkf': {
      'en': '',
      'ro': '',
    },
    '2xtfjgna': {
      'en': '',
      'ro': '',
    },
    'fq1yxg14': {
      'en': '',
      'ro': '',
    },
    'glsgh6rb': {
      'en': '',
      'ro': '',
    },
    'f0d1o742': {
      'en': '',
      'ro': '',
    },
    'zznsk8mr': {
      'en': '',
      'ro': '',
    },
    'xnpah5j0': {
      'en': 'Email already in used',
      'ro': '',
    },
    'kpv8b6vx': {
      'en': 'Invalid credentials',
      'ro': '',
    },
    'lxefse5u': {
      'en': '',
      'ro': '',
    },
    'nz7rfv72': {
      'en': '',
      'ro': '',
    },
    '63q9zpc4': {
      'en': '',
      'ro': '',
    },
    'j5od5yrg': {
      'en': '',
      'ro': '',
    },
    'h2mfapf7': {
      'en': '',
      'ro': '',
    },
    'b6e1quzb': {
      'en': '',
      'ro': '',
    },
    's03a2qg5': {
      'en': '',
      'ro': '',
    },
    'dkgle5ca': {
      'en': '',
      'ro': '',
    },
    'svncycwe': {
      'en': '',
      'ro': '',
    },
    'el5kbqh2': {
      'en': '',
      'ro': '',
    },
    '3icp9meg': {
      'en': '',
      'ro': '',
    },
    'jfpuurub': {
      'en': '',
      'ro': '',
    },
    'ba35ebib': {
      'en': '',
      'ro': '',
    },
    '2cpeltt8': {
      'en': '',
      'ro': '',
    },
  },
].reduce((a, b) => a..addAll(b));
