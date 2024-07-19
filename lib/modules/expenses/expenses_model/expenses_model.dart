
class ExpensesModel {
  final int? id;
  final String note;
  final double amount;
  final DateTime date;

  ExpensesModel({this.id, required this.note, required this.amount, required this.date});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'note': note,
      'amount': amount,
      'date': date.toIso8601String(),
    };
  }

  factory ExpensesModel.fromMap(Map<String, dynamic> map) {
    return ExpensesModel(
      id: map['id'],
      note: map['note'],
      amount: map['amount'],
      date: DateTime.parse(map['date']),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is ExpensesModel &&
              runtimeType == other.runtimeType &&
              id == other.id &&
              note == other.note &&
              amount == other.amount &&
              date == other.date;

  @override
  int get hashCode => id.hashCode ^ note.hashCode ^ amount.hashCode ^ date.hashCode;
}


