class ApiErrorParser {
  static String parseMessage(dynamic response) {
    if (response == null) {
      return 'An error occurred. Please try again.';
    }

    if (response is String && response.isNotEmpty) {
      return response;
    }

    if (response is! Map) {
      return 'An error occurred. Please try again.';
    }

    final map = Map<String, dynamic>.from(response);

    final error = map['error'];
    if (error is Map) {
      final message = error['message'] ?? error['Message'];
      if (message is String && message.isNotEmpty) return message;
    }

    final data = map['data'];
    if (data is Map) {
      final dataMessage = data['message'] ?? data['Message'];
      if (dataMessage is String && dataMessage.isNotEmpty) return dataMessage;
    }

    final topMessage = map['message'] ?? map['Message'];
    if (topMessage is String && topMessage.isNotEmpty) return topMessage;

    return 'An error occurred. Please try again.';
  }
}
