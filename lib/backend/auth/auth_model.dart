import 'package:appwrite/appwrite.dart';
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;
import 'package:uuid/uuid.dart';

class AppwriteService {
  late final Client client;
  late final Account account;

  AppwriteService._privateConstructor() {
    client = Client()
      ..setEndpoint('https://cloud.appwrite.io/v1') // Replace with your Appwrite endpoint
      ..setProject('67628bb600216f03b34c');                  // Replace with your project ID

    account = Account(client);
  }

  static final AppwriteService _instance = AppwriteService._privateConstructor();

  static AppwriteService get instance => _instance;
}




class AuthService {
  final Account _account = AppwriteService.instance.account;
  final String userId = Uuid().v4();

  /// Register a new user
  Future<models.User> registerUser(String email, String password) async {
    try {
      final user = await _account.create(
        email: email,
        password: password, userId: '',
      );
      return user;
    } catch (e) {
      throw Exception('Registration failed: ${e.toString()}');
    }
  }

  /// Login a user
  Future<models.Session> loginUser(String email, String password) async {
    try {
      final session = await _account.createEmailPasswordSession(
        email: email,
        password: password,
      );
      return session;
    } catch (e) {
      throw Exception('Login failed: ${e.toString()}');
    }
  }

  /// Logout the current user
  Future<void> logoutUser() async {
    try {
      await _account.deleteSessions();
    } catch (e) {
      throw Exception('Logout failed: ${e.toString()}');
    }
  }

  /// Get the current authenticated user
  Future<models.User?> getCurrentUser() async {
    try {
      final user = await _account.get();
      return user;
    } catch (e) {
      return null; // No user is logged in
    }
  }

  /// Reset password
  Future<void> resetPassword(String email) async {
    try {
      await _account.createRecovery(
        email: email,
        url: 'https://[YOUR_REDIRECT_URL]', // Replace with your frontend redirect URL
      );
    } catch (e) {
      throw Exception('Password reset failed: ${e.toString()}');
    }
  }

  /// Start phone authentication by sending an OTP
  Future<void> startPhoneAuth(String phoneNumber, String updatedUserId) async {
    try {
      await _account.createPhoneToken(
        userId: userId,  // Replace with a unique user ID, e.g., `unique()` or a custom string.
        phone: phoneNumber,
      );
      updatedUserId = userId;
    } catch (e) {
      throw Exception('Failed to send OTP: ${e.toString()}');
    }
  }

  /// Verify the OTP to complete the phone authentication
  Future<models.Session> verifyPhoneAuth(String userId, String otp) async {
    try {
      final session = await _account.updatePhoneSession(
        userId: userId,
        secret: otp,
      );
      return session;
    } catch (e) {
      throw Exception('Failed to verify OTP: ${e.toString()}');
    }
  }
}


