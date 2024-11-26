class customer {
  final String CName;
  final String? CDName;
  final String? DOB;
  final String? Code;
  final String CMobile;
  final String Email;
  bool isclick;
  final String id;
  customer({
    required this.CName,
     this.CDName,
     this.DOB,
    this.Code = '91',
    required this.CMobile,
    required this.Email,
    this.isclick = false,
    required this.id,
  });
}
