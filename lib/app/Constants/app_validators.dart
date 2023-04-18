class AppValidators{
  //at least one alphabet character and allows only the characters . and - to appear before the @ symbol
  // static RegExp emailValidator = RegExp(r'^.*[a-zA-Z]+[\.\-]?[a-zA-Z0-9]+@\w+([\.-]?\w+)*(\.\w{2,3})+$');

  static RegExp emailValidator = RegExp(r'^\w+([.-]?\w+)*@\w+([.-]?\w+)*(\.\w{2,3})+$');
  static RegExp emailHeadValidator = RegExp(r'^(?=.*[a-zA-Z])\d*.*');
  static RegExp phoneNumberValidator = RegExp(r'^\w+(\d)+$');
  static RegExp nameValidator = RegExp(r'^(?!\s)[a-zA-Z\s]+$');
  static RegExp locationValidator = RegExp(r'^(?=.*[a-zA-Z])[\d\s]*.*');
  static RegExp passwordValidator = RegExp(r"^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W).{8,30}$");
  static RegExp australiaPhoneValidator = RegExp(r'^([23478])(\d{4})(\d{4})$');
  static RegExp usaPhoneValidator = RegExp(r'^(\([2-9]\d{2}\)?|[2-9]\d{2}?)[2-9]\d{2}?\d{4}$');
  static RegExp netherlandsPhoneValidator = RegExp(r'^(\(?)(6)(\)?)((\d)){8}$');
  static RegExp alphanumericValidator = RegExp(r'^(?=.*[a-zA-Z])(?!\s)[a-zA-Z\d\s@#$%^&*!~_.-]+$');
}