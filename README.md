
# BookQuotes - Quote Sharing Platform 📚✨

A full-stack mobile application for discovering, sharing, and managing your favorite book quotes. Built with Flutter for the frontend and Spring Boot for the backend, featuring a clean architecture and modern development practices.

![Flutter](https://img.shields.io/badge/Flutter-3.19-blue?style=for-the-badge&logo=flutter)
![Spring Boot](https://img.shields.io/badge/Spring%20Boot-3.2-green?style=for-the-badge&logo=spring)
![Dart](https://img.shields.io/badge/Dart-3.2-blue?style=for-the-badge&logo=dart)
![Java](https://img.shields.io/badge/Java-17-red?style=for-the-badge&logo=java)

## 🚀 Features

### Frontend (Flutter)
- ✅ **User Authentication** - Secure login and registration with JWT tokens
- ✅ **Quote Management** - Add, view, and manage your favorite book quotes
- ✅ **Beautiful UI** - Modern, responsive design with light/dark theme support
- ✅ **State Management** - BLoC pattern for predictable state management
- ✅ **Offline Support** - Local storage for authentication tokens
- ✅ **Error Handling** - Comprehensive error handling with user-friendly messages

### Backend (Spring Boot)
- ✅ **RESTful API** - Clean API endpoints for quotes and user management
- ✅ **JWT Authentication** - Secure token-based authentication
- ✅ **Spring Security** - Role-based access control and security configuration
- ✅ **Database Integration** - JPA with Hibernate for data persistence
- ✅ **Password Encryption** - BCrypt password encoding for security

## 🛠 Tech Stack

### Frontend
| Technology | Purpose |
|------------|---------|
| **Flutter** | Cross-platform mobile framework |
| **Dart** | Programming language |
| **BLoC** | State management pattern |
| **GetIt** | Dependency injection |
| **Equatable** | Value equality |
| **HTTP** | API communication |
| **Shared Preferences** | Local storage |
| **Google Fonts** | Typography |

### Backend
| Technology | Purpose |
|------------|---------|
| **Spring Boot 3** | Java framework |
| **Spring Security** | Authentication & authorization |
| **JWT** | JSON Web Tokens |
| **JPA/Hibernate** | ORM and database management |
| **MySQL** | Database |
| **Maven** | Dependency management |
| **BCrypt** | Password encryption |

## 📸 Screenshots

*(Add your app screenshots here)*

## 🏗 Project Architecture

### Frontend Structure
```
lib/
├── core/
│   ├── config/theme/          # App themes and colors
│   ├── error/                 # Custom exceptions and failures
│   ├── services/              # Token storage and core services
│   └── utils/                 # Utility classes
├── features/
│   ├── quotes/                # Quotes feature module
│   │   ├── data/              # Data layer
│   │   ├── domain/            # Domain layer
│   │   └── presentation/      # Presentation layer
│   └── user/                  # User authentication module
│       ├── data/              # Auth data layer
│       ├── domain/            # Auth domain layer
│       └── presentation/      # Auth presentation layer
└── main.dart                  # App entry point
```

### Backend Structure
```
src/
├── main/java/com/example/bookQuotes/
│   ├── config/                # Security and JWT configuration
│   ├── controller/            # REST controllers
│   ├── entity/                # JPA entities
│   ├── repository/            # Data access layer
│   ├── services/              # Business logic layer
│   ├── dto/                   # Data transfer objects
│   └── exceptionHandler/      # Custom exceptions
└── resources/
    └── application.properties
```

## ⚙️ Installation & Setup

### Prerequisites
- **Flutter SDK 3.0+**
- **Dart SDK**
- **Java JDK 17+**
- **Maven 3.6+**
- **MySQL 8.0+**

### Backend Setup

#### 1. Clone the repository
```bash
git clone https://github.com/yourusername/bookquotes.git
cd bookquotes/backend
```

#### 2. Configure database in `application.properties`
```properties
spring.datasource.url=jdbc:mysql://localhost:3306/bookquotes
spring.datasource.username=your_username
spring.datasource.password=your_password
spring.jpa.hibernate.ddl-auto=update
spring.jpa.show-sql=true

jwt.secret=your-super-secret-jwt-key-minimum-32-characters
server.port=8080

# CORS configuration for Flutter app
spring.web.cors.allowed-origins=http://localhost:3000,http://10.0.2.2:8080
spring.web.cors.allowed-methods=GET,POST,PUT,DELETE,OPTIONS
spring.web.cors.allowed-headers=*
```

#### 3. Run the backend
```bash
mvn spring-boot:run
```

### Frontend Setup

#### 1. Navigate to frontend directory
```bash
cd bookquotes/frontend
```

#### 2. Install dependencies
```bash
flutter pub get
```

#### 3. Configure API endpoint
Update `lib/features/quotes/data/dataSources/quoteRemote.dart`:
```dart
static const String baseUrl = 'http://10.0.2.2:8080/api/quotes'; // For Android emulator
// static const String baseUrl = 'http://localhost:8080/api/quotes'; // For iOS simulator
// static const String baseUrl = 'http://your-server-ip:8080/api/quotes'; // For physical device
```

#### 4. Run the application
```bash
flutter run
```

## 📚 API Documentation

### Authentication Endpoints

| Method | Endpoint | Description | Auth Required |
|--------|----------|-------------|---------------|
| `POST` | `/api/users/signup` | User registration | ❌ |
| `POST` | `/api/users/login` | User login | ❌ |
| `GET` | `/api/users/{id}` | Get user by ID | ✅ |
| `DELETE` | `/api/users/{id}` | Delete user | ✅ |

### Quotes Endpoints

| Method | Endpoint | Description | Auth Required |
|--------|----------|-------------|---------------|
| `GET` | `/api/quotes/all` | Get all quotes | ❌ |
| `GET` | `/api/quotes/{id}` | Get quote by ID | ❌ |
| `POST` | `/api/quotes/create` | Create new quote | ✅ |
| `DELETE` | `/api/quotes/delete/{id}` | Delete quote | ✅ |

### Request/Response Examples

#### User Registration
```http
POST /api/users/signup
Content-Type: application/json

{
  "username": "booklover",
  "email": "user@example.com",
  "password": "securepassword"
}
```

**Response:**
```json
{
  "username": "booklover",
  "email": "user@example.com"
}
```

#### User Login
```http
POST /api/users/login
Content-Type: application/json

{
  "email": "user@example.com",
  "password": "securepassword"
}
```

**Response:**
```json
{
  "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "username": "booklover",
  "message": "Login successful"
}
```

#### Create Quote
```http
POST /api/quotes/create
Authorization: Bearer your-jwt-token
Content-Type: application/json

{
  "text": "To be or not to be, that is the question.",
  "author": "William Shakespeare",
  "book_name": "Hamlet"
}
```

**Response:**
```json
{
  "text": "To be or not to be, that is the question.",
  "author": "William Shakespeare",
  "book_title": "Hamlet"
}
```

## 🔧 Configuration

### Backend Environment Variables
```bash
export DATABASE_URL=jdbc:mysql://localhost:3306/bookquotes
export DATABASE_USERNAME=your_username
export DATABASE_PASSWORD=your_password
export JWT_SECRET=your-jwt-secret-key
```

### Frontend Configuration
Key configuration files:
- `lib/core/config/theme/AppTheme.dart` - Theme customization
- `lib/core/config/theme/AppColor.dart` - Color scheme
- `lib/core/services/token_storage.dart` - Token management

## 🧪 Testing

### Backend Testing
```bash
# Run all tests
mvn test

# Run specific test class
mvn test -Dtest=QuotesControllerTest

# Generate test coverage report
mvn jacoco:report
```

### Frontend Testing
```bash
# Run unit tests
flutter test

# Run integration tests
flutter test integration_test/

# Generate test coverage
flutter test --coverage
```

## 📦 Build & Deployment

### Build Flutter APK
```bash
# Build APK for Android
flutter build apk --release

# Build App Bundle for Play Store
flutter build appbundle --release

# Build for iOS
flutter build ios --release
```

### Build Spring Boot Application
```bash
# Clean build
mvn clean package

# Run with production profile
java -jar target/bookquotes-1.0.0.jar --spring.profiles.active=prod
```

### Docker Deployment
```dockerfile
# Backend Dockerfile
FROM openjdk:17-jdk-slim
COPY target/bookquotes-1.0.0.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","/app.jar"]
```

## 🤝 Contributing

We welcome contributions! Please follow these steps:

1. **Fork the repository**
2. **Create a feature branch**
   ```bash
   git checkout -b feature/amazing-feature
   ```
3. **Commit your changes**
   ```bash
   git commit -m 'Add some amazing feature'
   ```
4. **Push to the branch**
   ```bash
   git push origin feature/amazing-feature
   ```
5. **Open a Pull Request**

### Development Guidelines
- Follow Flutter and Spring Boot best practices
- Write tests for new features
- Update documentation accordingly
- Use meaningful commit messages

## 🐛 Troubleshooting

### Common Issues

#### Backend Connection Refused
```bash
# Check if Spring Boot is running
curl http://localhost:8080/api/quotes/all

# Verify database connection
mysql -u username -p bookquotes
```

#### Flutter Build Issues
```bash
# Clean and rebuild
flutter clean
flutter pub get
flutter run
```

#### JWT Token Issues
- Verify token expiration (30 days default)
- Check JWT secret configuration
- Ensure proper Authorization header format

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👥 Authors

- **Your Name** - *Initial work* - [YourUsername](https://github.com/yourusername)

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Spring Boot team for robust backend solutions
- Contributors and testers
- Open source community

## 📞 Support

If you encounter any issues or have questions:

1. **Check existing issues** on GitHub
2. **Create a new issue** with detailed description
3. **Contact the development team**

---

