// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(number) =>
      "Мы отправили код в SMS-сообщении на номер: ${number}";

  static String m1(seconds) =>
      "Повторная отправка кода возможна через ${seconds} секунд";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "change_phone_number":
            MessageLookupByLibrary.simpleMessage("Изменить номер"),
        "enter_code": MessageLookupByLibrary.simpleMessage("Введите код"),
        "enter_code_msg": m0,
        "enter_phone":
            MessageLookupByLibrary.simpleMessage("Введите Ваш номер телефона"),
        "enter_phone_msg": MessageLookupByLibrary.simpleMessage(
            "Мы отправим код на указанный номер для проверки телефона"),
        "next": MessageLookupByLibrary.simpleMessage("Продолжить"),
        "repeat_sms":
            MessageLookupByLibrary.simpleMessage("Отправить код повторно"),
        "sms_code_repeat_time": m1,
        "theme_dark": MessageLookupByLibrary.simpleMessage("Тёмная"),
        "theme_light": MessageLookupByLibrary.simpleMessage("Светлая"),
        "unknown_error": MessageLookupByLibrary.simpleMessage("unknown_error")
      };
}
