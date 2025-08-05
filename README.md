# Purio

A Flutter app for product health scoring and analysis. Scan products, view nutritional information, and get health scores to make informed purchasing decisions.

## Features

- **Product Scanning**: Scan barcodes to get product information
- **Health Scoring**: AI-powered health score calculation based on nutritional data and ingredients
- **Product Details**: View comprehensive product information including ingredients and nutritional values
- **User Authentication**: Secure login and registration system
- **Product History**: Track previously scanned products

## Prerequisites

Before you begin, ensure you have the following installed:

- **Flutter SDK** (3.16.0 or higher)
- **Dart SDK** (3.2.0 or higher)
- **Android Studio** or **VS Code** with Flutter extensions
- **Git**

## Getting Started

### 1. Clone the Repository

```bash
git clone <repository-url>
cd purio_flatter
```

### 2. Install Dependencies

```bash
flutter pub get
```

### 3. Platform-Specific Setup

#### For iOS:
```bash
cd ios
pod install
cd ..
```

#### For Android:
No additional setup required.

### 4. Environment Configuration

The app uses Supabase for backend services. Ensure you have:

- Supabase project URL and API keys configured in `lib/backend/supabase/supabase.dart`
- Proper Row Level Security (RLS) policies set up in your Supabase database

### 5. Run the App

#### Development Mode:
```bash
flutter run
```

#### Release Mode:
```bash
flutter run --release
```

#### For Specific Platform:
```bash
# iOS
flutter run -d ios

# Android
flutter run -d android

# Web
flutter run -d chrome
```

## Project Structure

```
lib/
├── auth/                    # Authentication logic
├── backend/                 # Backend services and database
│   ├── api_requests/        # API call handlers
│   ├── schema/             # Data structures
│   └── supabase/           # Supabase configuration
├── components/             # Reusable UI components
├── flutter_flow/           # FlutterFlow generated code
├── product/               # Product-related screens
├── scan/                  # Barcode scanning functionality
├── services/              # Business logic services
└── sign_up_windows/       # Authentication screens
```

## Key Dependencies

- **supabase_flutter**: Backend database and authentication
- **go_router**: Navigation and routing
- **google_fonts**: Typography
- **flutter_flow**: UI framework

## Troubleshooting

### Common Issues:

1. **Dependencies not found**: Run `flutter pub get`
2. **iOS build issues**: Run `cd ios && pod install && cd ..`
3. **Supabase connection errors**: Check your API keys and RLS policies
4. **Health score not updating**: Ensure RLS policies allow authenticated users to update the Products table

### Flutter Doctor

If you encounter issues, run:
```bash
flutter doctor
```

This will check your Flutter installation and identify any problems.

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## License

This project is licensed under the MIT License.
