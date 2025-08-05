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
      'en': '''Privacy Policy – Purio App (Beta Version)
Last updated: [01.09.2025]

1. What data do we collect?
In the beta version of the app, we collect the following personal data:

- Email address – for account creation and app-related communications;
- First name and last name – to personalize the experience and for identification during feedback/testing.

2. How do we use this data?
Your data is used exclusively to:
- Provide access to the app;
- Improve the user experience;
- Offer technical support or communications related to beta testing;
- Understand general usage behavior (anonymized or pseudonymized) to optimize the product.

3. Who has access to this data?
Access to your data is limited to the Purio team members directly involved in app development.

- We do not share, sell, or disclose your data to third parties;
- We may use external services (e.g., cloud storage) to securely process the data.

4. Where and how long do we store the data?
- Data is stored in secure environments (e.g., databases managed via Supabase);
- This data will be retained after the beta phase to ensure continuity in the official release of the app;
- You may request deletion of your account and personal data at any time, according to the rights described below.

5. What are your rights?
Under applicable laws (e.g., GDPR), you have the following rights:
- Right to access your data;
- Right to correct inaccurate data;
- Right to deletion ("right to be forgotten");
- Right to withdraw your consent at any time;
- Right to data portability.

For any of these requests, you can contact us at hello@purio.io.

6. Data Security
We implement technical and organizational measures to protect your data from unauthorized access, loss, or destruction. While we strive to ensure data security, no system is 100% secure.

7. Policy Updates
We reserve the right to modify this policy. Any relevant updates will be announced in the app or by email. Continued use of the app implies acceptance of the updated policy.

8. Contact
For questions related to data protection, you can reach us at:
hello@purio.io''',
      'ro': '''Politica de Confidențialitate – Aplicația Purio (versiune Beta)
Ultima actualizare: [01.09.2025]

1. Ce date colectăm?
În versiunea beta a aplicației colectăm următoarele date:

- Adresa de email – pentru crearea contului și comunicări legate de aplicație;
- Prenume și nume – pentru personalizarea experienței și identificarea în feedback/testare.

2. Cum folosim aceste date?
Datele tale sunt utilizate exclusiv în scopul de a:
- Permite accesul la aplicație;
- Îmbunătăți experiența utilizatorului;
- Oferi suport tehnic sau comunicări legate de testarea aplicației;
- Înțelege comportamentul general de utilizare (anonim/pseudonimizat) pentru a optimiza produsul.

3. Cine are acces la aceste date?
Accesul la datele tale este limitat la membrii echipei Purio implicați direct în dezvoltarea aplicației.

- Nu partajăm, vindem sau cedăm datele tale către terți;
- Putem folosi servicii externe (ex: stocare în cloud) pentru procesarea securizată a datelor.

4. Unde și cât timp stocăm datele?
- Datele sunt stocate în medii securizate (ex: baze de date gestionate prin Supabase);
- Acestea vor fi păstrate și după finalul versiunii beta, pentru a asigura continuitatea experienței în versiunea oficială a aplicației;
- Poți solicita oricând ștergerea contului și a datelor tale, conform drepturilor descrise mai jos.

5. Ce drepturi ai?
Conform legislației în vigoare (ex. GDPR), ai următoarele drepturi:
- Dreptul de acces la datele tale;
- Dreptul de rectificare a datelor incorecte;
- Dreptul de ștergere ("dreptul de a fi uitat");
- Dreptul de a-ți retrage consimțământul în orice moment;
- Dreptul de a solicita portarea datelor.

Pentru oricare dintre aceste solicitări, ne poți contacta la hello@purio.io.

6. Securitatea datelor
Luăm măsuri tehnice și organizatorice pentru a proteja datele tale împotriva accesului neautorizat, pierderii sau distrugerii. Deși facem tot posibilul pentru protecția informațiilor, reține că niciun sistem nu este 100% sigur.

7. Actualizări ale politicii
Ne rezervăm dreptul de a modifica această politică. Vom anunța în aplicație sau prin email orice modificare relevantă. Continuarea utilizării aplicației implică acceptarea versiunii actualizate.

8. Contact
Pentru întrebări legate de protecția datelor, ne poți scrie la:
hello@purio.io''',
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
      'en': '''Terms and Conditions – Purio App (Beta Version)
Last updated: [01.09.2025]

1. About the Beta Version
The Purio app is currently in its beta testing phase. This version is made available to a limited number of users selected to help test and validate core functionalities.

- The main goal is to improve the app based on user feedback;
- Occasional bugs, errors, or incomplete data may occur;
- The team makes every effort to provide accurate information, but some inaccuracies or omissions may be present during this stage of development.

2. No Legal Entity
The app is developed by an independent team in the early stages of product validation, and no legal entity is associated with the project at this time.

- No commercial or contractual services are provided;
- The app is offered free of charge and strictly for testing purposes.

3. Purpose of the App
Purio is an informational tool designed to help users better understand the composition of supermarket food products. Products are analyzed and displayed based on a custom scoring formula that incorporates:
- Nutri-Score
- Additives Score
- Ultra-Processed Score

The final score is automatically generated using a proprietary formula, which is explained in the app.

The app does not provide medical, nutritional, or dietary advice and should not be used as a substitute for consulting a professional.

4. Account Creation and Data Collection
To use the app, you must create an account. During the beta version, we collect the following personal data:
- Email address
- First name
- Last name

Data collection and processing is carried out in accordance with the Privacy Policy available from the beta stage.

5. User Contributions
Users may submit food products not already present in the database. To ensure data accuracy:
- Submitted products do not appear automatically in the app;
- All user-submitted data is manually reviewed by the Purio team before being published;
- Users are responsible for the accuracy of the submitted information.

The team reserves the right to correct, modify, or reject any submitted content.

6. Information Quality and Accuracy
The Purio team makes every effort to ensure that displayed information is:
- Accurate
- Up-to-date
- Relevant

However, due to the use of external sources, automated data processing, and potential changes in product composition, some information may be incomplete or inaccurate. Users are encouraged to refer to the product label for final decision-making.

7. Limitation of Liability
By using the app, you acknowledge and agree that:
- The Purio team is not responsible for your dietary or purchasing decisions;
- The information provided is for reference only and does not guarantee any health outcome;
- You use the app at your own risk.

8. Intellectual Property
All rights to the app's design, scoring logic, interface, editorial content, and proprietary formula belong to the Purio team.

- Reproduction, redistribution, or use of this content without written permission is prohibited.

9. Feedback
By using the beta version of the app, you agree that we may collect and analyze:
- Suggestions, feedback, or comments submitted by you;
- App usage behavior (anonymized or pseudonymized) to improve the product experience.

10. Changes to Terms
These terms may be updated at any time during the beta phase. Changes will be communicated in-app, and continued use implies acceptance of the updated terms.

11. Contact
For any questions, suggestions, or issues regarding the app, contact us at:
hello@purio.io

12. Acceptance
By using the Purio app, you confirm that:
- You have read, understood, and accepted these terms;
- You agree to the collection and use of the personal data mentioned above;
- You understand that this is a beta version and that functionalities and data may change.''',
      'ro': '''Termeni și Condiții – Aplicația Purio (versiune Beta)
Ultima actualizare: [01.09.2025]

1. Despre versiunea Beta
Aplicația Purio se află în faza de testare beta. Această versiune este disponibilă unui număr limitat de utilizatori, selectați pentru a contribui la testarea și validarea funcționalităților.

- Scopul principal este de a îmbunătăți aplicația pe baza feedbackului primit;
- Pot apărea ocazional erori, disfuncționalități sau date incomplete;
- Echipa depune toate eforturile pentru a oferi informații corecte, dar pot exista și unele erori sau omisiuni inerente acestui stadiu de dezvoltare.

2. Lipsa entității juridice
Aplicația este dezvoltată de o echipă independentă, aflată într-o etapă incipientă, fără existența unei entități juridice în spate în acest moment.

- Nu sunt furnizate servicii comerciale sau contractuale;
- Aplicația este disponibilă gratuit și exclusiv în scop de testare.

3. Scopul aplicației
Purio este o aplicație informativă care te ajută să înțelegi mai bine compoziția produselor alimentare din supermarketuri. Produsele sunt analizate și afișate pe baza unui scor propriu calculat pornind de la:
- Nutri-Score
- Additives Score
- Ultra-Processed Score

Scorul final este generat automat folosind o formulă proprie, care este explicată în aplicație.

Aplicația nu oferă sfaturi medicale sau nutriționale și nu înlocuiește consultul unui specialist.

4. Crearea unui cont și colectarea datelor
Pentru a folosi aplicația, este necesară crearea unui cont. În versiunea beta, colectăm următoarele date personale:
- Adresă de email
- Prenume
- Nume

Colectarea și prelucrarea acestor date se face în conformitate cu Politica de Confidențialitate disponibilă încă din versiunea beta.

5. Contribuția utilizatorilor
Utilizatorii pot adăuga produse care nu există deja în baza de date. Pentru a asigura acuratețea informațiilor:
- Produsele introduse nu apar automat în aplicație;
- Toate datele sunt verificate manual de echipa Purio înainte de publicare;
- Utilizatorii sunt responsabili pentru corectitudinea informațiilor introduse.

Echipa își rezervă dreptul de a corecta, completa sau respinge conținutul adăugat de utilizatori.

6. Calitatea și acuratețea informațiilor
Echipa Purio își dă tot interesul ca informațiile afișate să fie:
- Corecte,
- Actualizate,
- Relevante.

Totuși, având în vedere sursele multiple, volumul mare de date și procesarea automată, este posibil ca unele informații să fie incomplete sau eronate. Utilizatorii trebuie să consulte și eticheta fizică a produselor pentru decizii informate.

7. Limitări de responsabilitate
Prin folosirea aplicației, înțelegi și ești de acord că:
- Echipa Purio nu este responsabilă pentru deciziile tale alimentare;
- Informațiile afișate sunt orientative și nu garantează un anumit rezultat asupra sănătății;
- Folosești aplicația pe propria răspundere.

8. Drepturi de autor
Toate drepturile asupra aplicației, designului, logicii de calcul, interfeței, conținutului editorial și a formulei de scor aparțin echipei Purio.

- Nu este permisă copierea, redistribuirea sau utilizarea conținutului fără acord scris.

9. Feedback
Folosirea aplicației în versiunea beta presupune că putem colecta și analiza:
- Opinii, sugestii și observații trimise de tine;
- Comportamentul în aplicație (în mod anonim sau pseudonimizat) pentru îmbunătățirea experienței.

10. Modificări ale termenilor
Acești termeni pot fi modificați oricând pe durata versiunii beta. Modificările vor fi afișate în aplicație, iar utilizarea continuă reprezintă acceptarea noilor termeni.

11. Contact
Pentru orice întrebare, sugestie sau problemă legată de aplicație, ne poți scrie la:
hello@purio.io

12. Acceptare
Prin utilizarea aplicației Purio, confirmi că:
- Ai citit, înțeles și acceptat acești termeni;
- Accepți prelucrarea datelor personale menționate mai sus;
- Înțelegi că aplicația este în versiune beta și că anumite funcționalități și informații pot fi supuse modificărilor.''',
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
          'Stay updated with the latest from Purio! Turn on notifications to never miss:\t•\tImportant updates\n\t•\tPersonalized tips\n\t•\tExclusive features',
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
