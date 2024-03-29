class ApiUrls {
  static const String baseUrl = 'https://shreekrishnagaushala.org/';

  static const String baseUrlPath = 'AdminPanel/WebApi/index.php?p=';

  static const String loginApi = '${baseUrlPath}Login';
  static const String getTypesApi = '${baseUrlPath}getTypes';
  static const String generatePDFApi = baseUrlPath;
  static const String spendAmountApi = '${baseUrlPath}spendAmount';
  static const String getSpendsApi = '${baseUrlPath}getSpends';
  static const String getBillingApi = '${baseUrlPath}getBilling';
  static const String editPdfApi = '${baseUrlPath}updatePdf';
  static const String deletePdfApi = '${baseUrlPath}deletePdf';
  static const String editSpendApi = '${baseUrlPath}updatespendAmount';
  static const String deleteSpendApi = '${baseUrlPath}deletespendAmount';
}
