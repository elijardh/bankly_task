import 'package:bankly_task/app/logic/credit_debit_filtering.dart';

class TransactionModel {
  String? trnAmount;
  String? trnCounterPartyService;
  DateTime? trnDate;
  String? trnCounterpartyBankCode;
  String? trnContractReference;
  String? trnPaymentReference;
  String? trnCounterPartyReference;
  String? logourl;
  String? trnDrCr;
  String? accountNumber;
  String? accountName;
  String? counterPartyAccountNumber;
  String? counterPartyAccountName;
  String? journalNarration;
  String? trnCounterPartyBankName;
  String? ftCounterPartySwitchCode;
  String? trnNarration;
  String? source;
  String? bankCode;
  String? branchCode;
  String? maker;
  String? checker;
  String? bankName;
  String? trnId;

  TransactionModel({
    this.trnAmount,
    this.trnCounterPartyService,
    this.trnDate,
    this.trnCounterpartyBankCode,
    this.trnContractReference,
    this.trnPaymentReference,
    this.trnCounterPartyReference,
    this.logourl,
    this.trnDrCr,
    this.accountNumber,
    this.accountName,
    this.counterPartyAccountNumber,
    this.counterPartyAccountName,
    this.journalNarration,
    this.trnCounterPartyBankName,
    this.ftCounterPartySwitchCode,
    this.trnNarration,
    this.source,
    this.bankCode,
    this.branchCode,
    this.maker,
    this.checker,
    this.bankName,
    this.trnId,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      trnAmount: json['trnAmount'] as String?,
      trnCounterPartyService: json['trnCounterPartyService'] as String?,
      trnDate: json['trnDate'] == null
          ? null
          : DateTime.parse(json['trnDate'] as String),
      trnCounterpartyBankCode: json['trnCounterpartyBankCode'] as String?,
      trnContractReference: json['trnContractReference'] as String?,
      trnPaymentReference: json['trnPaymentReference'] as String?,
      trnCounterPartyReference: json['trnCounterPartyReference'] as String?,
      logourl: json['logourl'] as String?,
      trnDrCr: json['trnDrCr'] as String?,
      accountNumber: json['accountNumber'] as String?,
      accountName: json['accountName'] as String?,
      counterPartyAccountNumber: json['counterPartyAccountNumber'] as String?,
      counterPartyAccountName: json['counterPartyAccountName'] as String?,
      journalNarration: json['journalNarration'] as String?,
      trnCounterPartyBankName: json['trnCounterPartyBankName'] as String?,
      ftCounterPartySwitchCode: json['ftCounterPartySwitchCode'] as String?,
      trnNarration: json['trnNarration'] as String?,
      source: json['source'] as String?,
      bankCode: json['bankCode'] as String?,
      branchCode: json['branchCode'] as String?,
      maker: json['maker'] as String?,
      checker: json['checker'] as String?,
      bankName: json['bankName'] as String?,
      trnId: json['trnId'] as String?,
    );
  }

  bool isDebit() {
    return debitKeywords.contains(trnDrCr?.toLowerCase() ?? "");
  }

  Map<String, dynamic> toJson() => {
        'trnAmount': trnAmount,
        'trnCounterPartyService': trnCounterPartyService,
        'trnDate': trnDate?.toIso8601String(),
        'trnCounterpartyBankCode': trnCounterpartyBankCode,
        'trnContractReference': trnContractReference,
        'trnPaymentReference': trnPaymentReference,
        'trnCounterPartyReference': trnCounterPartyReference,
        'logourl': logourl,
        'trnDrCr': trnDrCr,
        'accountNumber': accountNumber,
        'accountName': accountName,
        'counterPartyAccountNumber': counterPartyAccountNumber,
        'counterPartyAccountName': counterPartyAccountName,
        'journalNarration': journalNarration,
        'trnCounterPartyBankName': trnCounterPartyBankName,
        'ftCounterPartySwitchCode': ftCounterPartySwitchCode,
        'trnNarration': trnNarration,
        'source': source,
        'bankCode': bankCode,
        'branchCode': branchCode,
        'maker': maker,
        'checker': checker,
        'bankName': bankName,
        'trnId': trnId,
      };
}
