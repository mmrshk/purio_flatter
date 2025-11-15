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
      'ro': 'Salut 👋🏻',
    },
    'nhf9yk6j': {
      'en': 'Explore',
      'ro': 'Explorează',
    },
    'ujegbdrr': {
      'en': 'Scan',
      'ro': 'Scanează',
    },
    '8woh7s4n': {
      'en': 'Analyze products \nquickly.',
      'ro': 'Analizează produsele \nrapid.',
    },
    '4dsnt882': {
      'en': 'Search',
      'ro': 'Caută',
    },
    '6k9wcww2': {
      'en': 'Find product info\nfast.',
      'ro': 'Găsește informații despre produse\nrapid.',
    },
    'ba1vcuow': {
      'en': 'Additives',
      'ro': 'Aditivi',
    },
    'no_additives': {
      'en': 'No additives',
      'ro': 'Fără aditivi',
    },
    'nsdcps41': {
      'en': 'Learn what’s inside.',
      'ro': 'Află ce este înăuntru.',
    },
    'sg8ho7tf': {
      'en': 'Bad ingredients',
      'ro': 'Ingrediente dăunătoare',
    },
    'ga6umnbw': {
      'en': 'Spot harmful items.',
      'ro': 'Identifică produse dăunătoare.',
    },
    'hine2wdn': {
      'en': 'Popular scans',
      'ro': 'Scanări populare',
    },
    'home_trending': {
      'en': 'Trending',
      'ro': 'În tendințe',
    },
    'home_discover': {
      'en': 'Discover',
      'ro': 'Descoperă',
    },
    'home_scans_label': {
      'en': 'scans',
      'ro': 'scanări',
    },
    'home_day_streak': {
      'en': 'day streak',
      'ro': 'zile la rând',
    },
  },
  // ProductDetails
  {
    '9bs48st0': {
      'en': 'Ingredients',
      'ro': 'Ingrediente',
    },
    'ingredients_order_info': {
      'en': 'The first ingredients listed are the ones used the most in the product.',
      'ro': 'Primele ingrediente listate sunt cele folosite cel mai mult în produs.',
    },
    'raw_ingredients': {
      'en': 'Raw ingredients',
      'ro': 'Ingrediente brute',
    },
    '6mn4fkqn': {
      'en': 'See all',
      'ro': 'Vezi tot',
    },
    'xme295my': {
      'en': 'Recommendations',
      'ro': 'Recomandări',
    },
    '4h3ql1fs': {
      'en': 'See All',
      'ro': 'Vezi Tot',
    },
    'whclgaz0': {
      'en': 'Looking for a healthier alternative?',
      'ro': 'Cauți o alternativă mai sănătoasă?',
    },
    't0jrl3ay': {
      'en': 'Scoring method',
      'ro': 'Metoda de evaluare',
    },
    'pus9jfji': {
      'en': 'Learn how products are rated',
      'ro': 'Află cum sunt evaluate produsele',
    },
    'muer1xqs': {
      'en': 'Product details',
      'ro': 'Detalii produs',
    },
    'no_ingredients': {
      'en': 'No ingredients',
      'ro': 'Fără ingrediente',
    },
  },
  // History
  {
    'ymharo6a': {
      'en': 'History',
      'ro': 'Istoric',
    },
    'loading_history': {
      'en': 'Loading your history...',
      'ro': 'Se încarcă istoricul...',
    },
    'no_history': {
      'en': 'No history yet',
      'ro': 'Încă nu ai istoric',
    },
    'no_favorites': {
      'en': 'No favorites yet',
      'ro': 'Încă nu ai favorite',
    },
    'your_favorite_products_will_appear_here': {
      'en': 'Your favorite products will appear here',
      'ro': 'Produsele tale favorite vor apărea aici',
    },
    'your_recently_viewed_products_will_appear_here': {
      'en': 'Your recently viewed products will appear here',
      'ro': 'Produsele tale vizionate recent vor apărea aici',
    },
    'recent': {
      'en': 'Recent',
      'ro': 'Recent',
    },
    'favorites': {
      'en': 'Favorites',
      'ro': 'Favorite',
    },

  },
  // ProfileSettings
  {
    'y2pb74w6': {
      'en': 'Follow us',
      'ro': 'Urmărește-ne',
    },
    'faq_key': {
      'en': 'FAQ',
      'ro': 'Întrebări Frecvente',
    },
    'subscription_key': {
      'en': 'Subscription',
      'ro': 'Abonament',
    },
  },
  // EditProfile
  {
    'c4vorr30': {
      'en': 'Sign out',
      'ro': 'Deconectează-te',
    },
    't9wjo91d': {
      'en': 'Delete account',
      'ro': 'Șterge contul',
    },
    'fh8utk4t': {
      'en': 'Edit profile',
      'ro': 'Editează profilul',
    },
    'setting_default': {
      'en': 'Settings',
      'ro': 'Setări',
    },
    'feedback': {
      'en': 'Feedback',
      'ro': 'Feedback'
    },
    'stay_connected_title': {
      'en': 'Stay connected with us!',
      'ro': 'Rămâi conectat cu noi!',
    },
  },
  // Navigation
  {
    'nav_home': {
      'en': 'Home',
      'ro': 'Acasă',
    },
    'nav_scan': {
      'en': 'Scan',
      'ro': 'Scanează',
    },
    'nav_history': {
      'en': 'History',
      'ro': 'Istoric',
    },
  },
  // LanguageSelection
  {
    'language_selection_title': {
      'en': 'Language Selection',
      'ro': 'Selectarea limbii',
    },
    'language_selection_subtitle': {
      'en': 'Select your preferred language',
      'ro': 'Selectează limba preferată',
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
      'ro': 'Politica de Confidențialitate',
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
      'en': 'Terms & Conditions',
      'ro': 'Termeni și condiții',
    },
  },
  // Notifications
  {
    'slf2ttsv': {
      'en': 'Allow notifications',
      'ro': 'Permite notificări',
    },
    '34tdq6vv': {
      'en':
          'Stay updated with the latest from Purio! Turn on notifications to never miss:\t•\tImportant updates\n\t•\tPersonalized tips\n\t•\tExclusive features',
      'ro': 'Rămâi la curent cu cele mai noi de la Purio! Activează notificările pentru a nu rata niciodată:\t•\tActualizări importante\n\t•\tSfaturi personalizate\n\t•\tFuncții exclusive',
    },
    '56c3uq32': {
      'en': '1. Open settings',
      'ro': '1. Deschide Setările',
    },
    'ohkg5sd0': {
      'en': '2. Tap notifications',
      'ro': '2. Atinge Notificări',
    },
    'eho3lknd': {
      'en': '3. Allow Purio to end you notifications.',
      'ro': '3. Permite Purio să îți trimită notificări.',
    },
    'se2g3ybz': {
      'en': 'Notifications',
      'ro': 'Notificări',
    },
  },
  // SingUp-LogIn
  {
    '4pwlcxs5': {
      'en': 'Choose better, live healthier.',
      'ro': 'Alege conștient, trăiește sănătos.',
    },
    'wn1wwzvk': {
      'en': 'Continue with email',
      'ro': 'Continuă cu email',
    },
    '8wzpehyg': {
      'en': 'Continue with Apple',
      'ro': 'Continuă cu Apple',
    },
    'jc8728go': {
      'en': 'Continue with Google',
      'ro': 'Continuă cu Google',
    },
  },
  // ContinueEmail
  {
    'iwrt97yc': {
      'en': 'What\'s your email?',
      'ro': 'Care este emailul tău?',
    },
    'on87fhzu': {
      'en': 'E-mail',
      'ro': 'E-mail',
    },
    '6iwy3c8t': {
      'en': 'E-mail is required',
      'ro': 'E-mail-ul este obligatoriu',
    },
    'dl11rfgt': {
      'en': 'Wrong email format!',
      'ro': 'Format de email greșit!',
    },
    'uifyvl16': {
      'en': 'Continue ',
      'ro': 'Continuă',
    },
  },
  // ContinuePassword
  {
    'vg0xbsod': {
      'en': 'Now choose a password',
      'ro': 'Alege o parolă pentru contul tău',
    },
    'p6q6bvub': {
      'en': 'You are creating an account with ',
      'ro': 'Creezi un cont cu ',
    },
    'd0ornpmi': {
      'en': 'Change.',
      'ro': 'Schimbă.',
    },
    '6dgk7ipy': {
      'en': 'Password',
      'ro': 'Parolă',
    },
    '2ise810c': {
      'en': 'Confirm password',
      'ro': 'Confirmă parola',
    },
    'vb2ld97q': {
      'en': 'I agree to ',
      'ro': 'Sunt de acord cu ',
    },
    '1owv5d59': {
      'en': ' and ',
      'ro': ' și ',
    },
    '8fble3n3': {
      'en': 'Privacy policy',
      'ro': 'Politica de confidențialitate',
    },
    'gnsgggcs': {
      'en': '',
      'ro': '',
    },
    'ott5beqb': {
      'en': 'Continue',
      'ro': 'Continuă',
    }
  },
  // ContinueAccountDetails
  {
    'o0u1599y': {
      'en': 'Account Details',
      'ro': 'Detalii cont',
    },
    'q0c6t28l': {
      'en': 'We\'d love to refer to you by name',
      'ro': 'Ne-ar plăcea să te cunoaștem mai bine',
    },
    '1iym6wsx': {
      'en': 'First name',
      'ro': 'Prenume',
    },
    '7lzk8ecf': {
      'en': 'Last name',
      'ro': 'Nume',
    },
    'rsh3njnz': {
      'en': 'Continue',
      'ro': 'Continuă',
    },
  },
  // Continue1stQuestion
  {
    '6c55y8ef': {
      'en': '2 quick questions',
      'ro': '2 întrebări rapide',
    },
    'mgmbqkym': {
      'en': '*1: How do you choose your products?',
      'ro': '*1: Cum îți alegi produsele?',
    },
    'o63c9mmp': {
      'en': 'Continue ',
      'ro': 'Continuă',
    },
  },
  // Continue2ndQuestion
  {
    'd0ty1i2e': {
      'en': '2 quick questions',
      'ro': '2 întrebări rapide',
    },
    '49mr6z1h': {
      'en': '*2: What do you want Purio to help you with?',
      'ro': '*2: Cu ce vrei să te ajute Purio?',
    },
    'vdrxnj9r': {
      'en': 'Done',
      'ro': 'Gata',
    },
  },
  // PurioProScreen
  {
    '0gcv45ml': {
      'en': 'FREE PRO\n7-days trial',
      'ro': 'PRO GRATUIT\n7 zile de încercare',
    },
    'olj1knz7': {
      'en':
          'No payment now. Cancel any time. Then \n139.99 RON/year (11,66 RON/month).',
      'ro': 'Fără plată acum. Anulează oricând. Apoi \n139,99 RON/an (11,66 RON/lună).',
    },
    'tzfzejzp': {
      'en': 'Continue ',
      'ro': 'Continuă',
    },
    '5lhkthck': {
      'en': 'Purio ',
      'ro': 'Purio ',
    },
    '2o4n27pd': {
      'en': 'Pro',
      'ro': 'Pro',
    },
  },
  // IncorrectPassword
  {
    'ku9srp21': {
      'en': 'Welcome back! Log In in \nto your Purio account ',
      'ro': 'Bine ai revenit! Intră în \ncontul tău Purio',
    },
    'lkdgd0je': {
      'en': 'Email',
      'ro': 'Email',
    },
    '9ksxi6ui': {
      'en': 'Password',
      'ro': 'Parolă',
    },
    'qf0w5nzs': {
      'en':
          'Password is incorrect. Try again or use the link to get an \nemail with log-in informations.',
      'ro': 'Parola este incorectă. Încearcă din nou sau folosește linkul pentru a primi un \nemail cu informațiile de conectare.',
    },
    'l3wjlhe6': {
      'en': 'Log In',
      'ro': 'Conectează-te',
    },
    'iux3zrs3': {
      'en': 'Email me a link to log in',
      'ro': 'Trimite-mi un email pentru conectare',
    },
    'zxw8kqmd': {
      'en': 'or',
      'ro': 'sau',
    },
    '6ux8sd2f': {
      'en': 'Continue with Google',
      'ro': 'Continuă cu Google',
    },
    '1mz4wwxe': {
      'en': 'Log in',
      'ro': 'Conectare',
    },
  },
  // PasswordRecovery
  {
    'ibq84nqr': {
      'en': 'Check your email!',
      'ro': 'Verifică emailul!',
    },
    '6e8v1ttz': {
      'en': 'We send an email with a link that will log \nyou in to ',
      'ro': 'Am trimis un email cu un link care te va conecta la ',
    },
    'pvix1n9k': {
      'en': 'name@yahoo.com',
      'ro': 'exemplu@yahoo.com',
    },
    'czibjxvt': {
      'en': '.',
      'ro': '.',
    },
    'xhnu7gl3': {
      'en': 'Remember to check the spam folder..',
      'ro': 'Nu uita să verifici și dosarul spam.',
    },
    'nxzoe4v2': {
      'en': 'I didn’t get an email.',
      'ro': 'Nu am primit un email.',
    },
    'ev3u6i5n': {
      'en': 'Log in',
      'ro': 'Conectare',
    },
  },
  // Feedback
  {
    'd96v3xf6': {
      'en': 'ISSUE, QUESTION OR SUGGESTION',
      'ro': 'PROBLEMĂ, ÎNTREBARE SAU SUGESTIE',
    },
    'pkpdfk4m': {
      'en': 'Your message to our team',
      'ro': 'Mesajul tău către echipa noastră',
    },
    'fxp8nvjw': {
      'en': 'Send',
      'ro': 'Trimite',
    },
    'wvrb7mdi': {
      'en': 'Feedback',
      'ro': 'Feedback',
    },
    'feedback_enter_message': {
      'en': 'Please enter your feedback message',
      'ro': 'Te rugăm să introduci mesajul de feedback',
    },
    'feedback_enter_message_or_photo': {
      'en': 'Please add a message or attach at least one photo.',
      'ro': 'Te rugăm să adaugi un mesaj sau să atașezi cel puțin o fotografie.',
    },
    'feedback_sending': {
      'en': 'Sending...',
      'ro': 'Se trimite...',
    },
    'feedback_success': {
      'en': 'Thank you for your feedback!',
      'ro': 'Mulțumim pentru feedback!',
    },
    'feedback_error': {
      'en': 'Failed to send feedback. Please try again.',
      'ro': 'Eșec la trimiterea feedback-ului. Te rugăm să încerci din nou.',
    },
    'feedback_add_photo': {
      'en': 'Attach Photos',
      'ro': 'Atașează fotografii',
    },
    'feedback_photo_hint': {
      'en': 'Add up to 5 screenshots or photos to give more context (optional).',
      'ro': 'Adaugă până la 5 capturi de ecran sau fotografii pentru mai mult context (opțional).',
    },
    'feedback_add_photo_action': {
      'en': 'Add photo',
      'ro': 'Adaugă fotografie',
    },
    'feedback_photo_camera': {
      'en': 'Take a photo',
      'ro': 'Fă o fotografie',
    },
    'feedback_photo_gallery': {
      'en': 'Choose from gallery',
      'ro': 'Alege din galerie',
    },
    'feedback_photo_limit': {
      'en': 'You can attach up to 5 photos.',
      'ro': 'Poți atașa până la 5 fotografii.',
    },
    'feedback_photo_error': {
      'en': 'We couldn’t load that photo. Please try again.',
      'ro': 'Nu am putut încărca fotografia. Te rugăm să încerci din nou.',
    },
  },
  // LogIn
  {
    'zxstwbxi': {
      'en': 'Welcome back! Log In in \nto your Purio account ',
      'ro': 'Bine ai revenit! Intră în \ncontul tău Purio',
    },
    'efelxctk': {
      'en': 'Email',
      'ro': 'Email',
    },
    '5vvgj7nm': {
      'en': 'Password',
      'ro': 'Parolă',
    },
    'bd1tkpa2': {
      'en': 'Log in',
      'ro': 'Conectează-te',
    },
    '4cnlg5zd': {
      'en': 'Email me a link to log in',
      'ro': 'Trimite-mi un email pentru conectare',
    },
    'ek1imcbd': {
      'en': 'or',
      'ro': 'sau',
    },
    'tyg9wgvo': {
      'en': 'Continue with Google',
      'ro': 'Continuă cu Google',
    },
  },
  // Search
  {
    'cnw6hi6r': {
      'en': 'Search',
      'ro': 'Caută',
    },
    'orieo052': {
      'en': 'Find Your Product',
      'ro': 'Caută produsul dorit',
    },
    'search_by_product_name_or_brand': {
      'en': 'Search by product name or brand and discover detailed insights instantly. 🛒',
      'ro': 'Caută un produs după nume sau marcă și află instant detalii despre el. 🛒',
    },
  },
  // RecoveryEmailPopup
  {
    'xj8l6u3y': {
      'en': 'Didn’t get the email?',
      'ro': 'Nu ai primit emailul?',
    },
    'u94e2ug8': {
      'en': 'Send the email again',
      'ro': 'Trimite emailul din nou',
    },
    '8uzxzp8n': {
      'en': 'Contact support',
      'ro': 'Contactează suportul',
    },
  },
  // DeleteAccountPopUp
  {
    'sup7de9p': {
      'en': 'Are you sure?',
      'ro': 'Sigur vrei să ștergi contul?',
    },
    'qp8tp30w': {
      'en': 'All your data will be gone. \nSure about this?',
      'ro': 'Toate datele tale se vor pierde. \nSigur vrei să ștergi contul?',
    },
    'rh4mxwuv': {
      'en': 'Keep my account',
      'ro': 'Păstrează contul',
    },
    'h0ea7x3j': {
      'en': 'Delete it anyway',
      'ro': 'Șterge-l oricum',
    },
    'delete_request_success': {
      'en': 'We received your request. We’ll delete your account shortly.',
      'ro': 'Am primit solicitarea ta. Îți vom șterge contul în curând.',
    },
    'delete_request_error': {
      'en': 'Couldn’t submit the request. Please try again.',
      'ro': 'Nu am putut trimite solicitarea. Încearcă din nou.',
    },
  },
  // Additives
  {
    '5wsh581s': {
      'en': 'E101',
      'ro': 'E101',
    },
    'b3x4k9h3': {
      'en': 'Risk free',
      'ro': 'Risc zero',
    },
  },
  // Scoring Method
  {
    'scoring_method_title': {
      'en': 'Scoring Method',
      'ro': 'Metoda de Scorare',
    },
    'how_we_score_products': {
      'en': 'How we score products',
      'ro': 'Cum scorăm produsele',
    },
    'overall_safety_score': {
      'en': 'Overall Safety Score',
      'ro': 'Scorul General de Siguranță',
    },
    'no_scoring': {
      'en': 'No scoring',
      'ro': 'Fără scor',
    },
    'overall_safety_description': {
      'en': 'Our comprehensive safety score (0-100) evaluates multiple factors to help you make informed decisions about the products you consume.',
      'ro': 'Scorul nostru comprehensiv de siguranță (0-100) evaluează multiple factori pentru a te ajuta să iei decizii informate despre produsele pe care le consumi.',
    },
    'nutritional_quality': {
      'en': 'Nutritional Quality',
      'ro': 'Calitatea Nutrițională',
    },
    'nutritional_quality_description': {
      'en': 'We analyze the nutritional content including calories, fats, sugars, and essential nutrients to assess the overall health value.',
      'ro': 'Analizăm conținutul nutrițional incluzând calorii, grăsimi, zaharuri și nutrienți esențiali pentru a evalua valoarea generală pentru sănătate.',
    },
    'additives_ingredients': {
      'en': 'Additives & Ingredients',
      'ro': 'Aditivi și Ingrediente',
    },
    'additives_ingredients_description': {
      'en': 'We evaluate the safety and necessity of additives, preservatives, and artificial ingredients in the product.',
      'ro': 'Evaluăm siguranța și necesitatea aditivilor, conservanților și ingredientelor artificiale din produs.',
    },
    'processing_level': {
      'en': 'Processing Level',
      'ro': 'Nivelul de Procesare',
    },
    'processing_level_description': {
      'en': 'We assess how heavily processed the product is, as less processed foods are generally healthier.',
      'ro': 'Evaluăm cât de mult este procesat produsul, deoarece alimentele mai puțin procesate sunt în general mai sănătoase.',
    },
    'score_interpretation': {
      'en': 'Score Interpretation',
      'ro': 'Interpretarea Scorului',
    },
    'excellent': {
      'en': 'Free risk',
      'ro': 'Riscuri zero',
    },
    'very_healthy_choice': {
      'en': 'Very healthy choice',
      'ro': 'Alegere foarte sănătoasă',
    },
    'good': {
      'en': 'Low risk',
      'ro': 'Riscuri reduse',
    },
    'generally_healthy_option': {
      'en': 'Generally healthy option',
      'ro': 'Opțiune în general sănătoasă',
    },
    'fair': {
      'en': 'Moderate risk',
      'ro': 'Riscuri moderate',
    },
    'moderate_health_impact': {
      'en': 'Moderate health impact',
      'ro': 'Impact moderat asupra sănătății',
    },
    'poor': {
      'en': 'High risk',
      'ro': 'Riscuri ridicate',
    },
    'consider_alternatives': {
      'en': 'Consider alternatives',
      'ro': 'Ia în considerare alternative',
    },
    'our_methodology': {
      'en': 'Our Methodology',
      'ro': 'Metodologia Noastră',
    },
    'methodology_description': {
      'en': 'Our scoring system is based on scientific research and nutritional guidelines. We continuously update our methodology to reflect the latest findings in nutrition science and food safety.',
      'ro': 'Sistemul nostru de scorare se bazează pe cercetări științifice și ghiduri nutriționale. Actualizăm continuu metodologia pentru a reflecta cele mai recente descoperiri în știința nutriției și siguranța alimentelor.',
    },
    'scoring_system_intro': {
      'en': 'Our health scoring system evaluates products based on three key factors:',
      'ro': 'Sistemul nostru de scorare pentru sănătate evaluează produsele pe baza a trei factori cheie:',
    },
    'nova_score_desc': {
      'en': 'Nova Score (processing level)',
      'ro': 'Scorul Nova (nivelul de procesare)',
    },
    'nutri_score_desc': {
      'en': 'Nutri Score (nutritional quality)',
      'ro': 'Scorul Nutri (calitatea nutrițională)',
    },
    'additives_score_desc': {
      'en': 'Additives Score (additive safety)',
      'ro': 'Scorul Aditivi (siguranța aditivilor)',
    },
    'scoring_formula_title': {
      'en': 'Final Score Formula:',
      'ro': 'Formula Scorului Final:',
    },
    'scoring_formula': {
      'en': '(Nutri Score × 40%) + (Additives Score × 30%) + (Nova Score × 30%)',
      'ro': '(Scorul Nutri × 40%) + (Scorul Aditivi × 30%) + (Scorul Nova × 30%)',
    },
    'safety_rule': {
      'en': 'Safety Rule: High-risk additives automatically cap the score at 49 points.',
      'ro': 'Regula de Siguranță: Aditivii cu risc ridicat limitează automat scorul la 49 de puncte.',
    },
  },
  // Miscellaneous
  {
    'sgr8p66f': {
      'en': 'Authentication Error: [error]',
      'ro': 'Eroare de autentificare: [eroare]',
    },
    'xnpah5j0': {
      'en': 'Email already in used',
      'ro': 'Emailul este deja folosit',
    },
    'scan_barcode_text': {
      'en': 'Please, scan barcode',
      'ro': 'Vă rugăm, scanați codul de bare',
    },
    // First Question Options
    'level_explorer': {
      'en': 'Explorer',
      'ro': 'Explorator',
    },
    'level_explorer_desc': {
      'en': 'I pick what looks good or feels \nfamiliar.',
      'ro': 'Aleg produsele care arată bine sau îmi par familiare.',
    },
    'level_label_curios': {
      'en': 'Label curios',
      'ro': 'Curios de etichete',
    },
    'level_label_curios_desc': {
      'en': 'I sometimes check labels for \nhealthier choices.',
      'ro': 'Citesc uneori etichetele ca să fac alegeri mai sănătoase.',
    },
    'level_label_pro': {
      'en': 'Label Pro',
      'ro': 'Expert în etichete',
    },
    'level_label_pro_desc': {
      'en': 'I analyze ingredients to choose \nthe best products.',
      'ro': 'Analizez ingredientele pentru a alege cele mai bune produse.',
    },
    // Second Question Options
    'expectation_find': {
      'en': 'Find',
      'ro': 'Găsesc',
    },
    'expectation_find_desc': {
      'en': ' healthier food options',
      'ro': ' mai ușor \nvariante sănătoase',
    },
    'expectation_understand': {
      'en': 'Understand',
      'ro': 'Înțeleg',
    },
    'expectation_understand_desc': {
      'en': ' labels \nbetter',
      'ro': ' mai bine etichetele',
    },
    'expectation_create': {
      'en': 'Create',
      'ro': 'Creez',
    },
    'expectation_create_desc': {
      'en': ' a healthy \nshopping list',
      'ro': ' liste de cumpărături sănătoase',
    },
    'expectation_save': {
      'en': 'Save',
      'ro': 'Economisesc',
    },
    'expectation_save_desc': {
      'en': ' time while \nshopping',
      'ro': ' timp la cumpărături',
    },
    'expectation_learn': {
      'en': 'Learn',
      'ro': 'Învăț',
    },
    'expectation_learn_desc': {
      'en': ' about \nbalanced nutrition',
      'ro': ' despre nutriție echilibrată',
    },
    'expectation_track': {
      'en': 'Track',
      'ro': 'Urmăresc',
    },
    'expectation_track_desc': {
      'en': ' my food\nchoices over time',
      'ro': ' alegerile mele alimentare în timp',
    },
    // Product submission dialog
    'product_not_found_title': {
      'en': 'Oops! Product Not Found',
      'ro': 'Ups! Produsul nu a fost găsit',
    },
    'product_not_found_message': {
      'en': 'Wow, you found a rare gem! 🎉',
      'ro': 'Uau, ai găsit o raritate! 🎉',
    },
    'product_not_found_help': {
      'en': 'Help us grow! Add this product to share with others',
      'ro': 'Ajută-ne să creștem! Adaugă acest produs pentru a-l împărtăși cu alții',
    },
    'no_image_selected': {
      'en': 'No image selected',
      'ro': 'Nicio imagine selectată',
    },
    'take_photo': {
      'en': 'Take Photo',
      'ro': 'Fă o poză',
    },
    'choose_from_gallery': {
      'en': 'Gallery',
      'ro': 'Galerie',
    },
    'add_this_product': {
      'en': 'Add this product',
      'ro': 'Adaugă acest produs',
    },
    'continue_scanning': {
      'en': 'Continue scanning',
      'ro': 'Continuă scanarea',
    },
    'product_submitted_success': {
      'en': 'Product submitted successfully! Thank you for your contribution.',
      'ro': 'Produsul a fost trimis cu succes! Mulțumim pentru contribuție.',
    },
  },
].reduce((a, b) => a..addAll(b));

String getLocalizedText(BuildContext context, String englishText, String romanianText) {
  return FFLocalizations.of(context).languageCode == 'ro' ? romanianText : englishText;
}
