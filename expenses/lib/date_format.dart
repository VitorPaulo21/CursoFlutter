class DateFormat {
  DateFormat._();

  static String format({required DateTime date, required String format}) {
    String formated = format;
    if (formated.contains("yyyy")) {
      formated = formated.replaceAll("yyyy", date.year.toString());
    } else if (formated.contains("yy")) {
      String year = date.year.toString();
      formated = formated.replaceAll(
          "yy",
          year.substring(
              ((year.contains("0")) && (year.indexOf("0") == 1)) ? 2 : 1, 4));
    }

    if (formated.contains("MMMM")) {
      formated = formated.replaceAll("MMMM", _monthName(date));
    } else if (formated.contains("MMM")) {
      formated = formated.replaceAll("MMM", _monthName(date).substring(0, 3));
    } else if (formated.contains("MM")) {
      formated = formated.replaceAll(
          "MM",
          date.month.toString().length == 1
              ? "0" + date.month.toString()
              : date.month.toString());
    } else if (formated.contains("M")) {
      formated = formated.replaceAll("M", date.month.toString());
    }
    if (formated.contains("dd")) {
      formated = formated.replaceAll(
          "dd",
          date.day.toString().length == 1
              ? "0" + date.day.toString()
              : date.day.toString());
    } else if (formated.contains("d")) {
      formated = formated.replaceAll("d", date.day.toString());
    }
    return formated;
  }

  static String _monthName(DateTime date) {
    int month = date.month;
    print(month.toString());
    switch (month) {
      case 1:
        return "Janeiro";
      case 2:
        return "Fevereiro";
      case 3:
        return "Março";
      case 4:
        return "Abril";
      case 5:
        return "Maio";
      case 6:
        return "Junho";
      case 7:
        return "Julho";
      case 8:
        return "Agosto";
      case 9:
        return "Setembro";
      case 10:
        return "Outubro";
      case 11:
        return "Novembro";
      case 12:
        return "Dezembro";
      default:
        return "";
    }
  }
}
