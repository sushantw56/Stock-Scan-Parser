import 'dart:convert';

List<StocksDataModel> stocksDataModelFromJson(String str) =>
    List<StocksDataModel>.from(
        json.decode(str).map((x) => StocksDataModel.fromJson(x)));

class StocksDataModel {
  StocksDataModel({
    this.id,
    this.name,
    this.tag,
    this.color,
    this.criteria,
  });

  int? id;
  String? name;
  String? tag;
  String? color;
  List<Criterion>? criteria;

  factory StocksDataModel.fromJson(Map<String, dynamic> json) =>
      StocksDataModel(
        id: json["id"],
        name: json["name"],
        tag: json["tag"],
        color: json["color"],
        criteria: List<Criterion>.from(
            json["criteria"].map((x) => Criterion.fromJson(x))),
      );
}

class Criterion {
  Criterion({
    this.type,
    this.text,
    this.variable,
  });

  String? type;
  String? text;
  Map<String, dynamic>? variable;

  factory Criterion.fromJson(Map<String, dynamic> json) => Criterion(
        type: json["type"],
        text: json["text"],
        variable: json["variable"],
      );
}

class IndicatorType {
  IndicatorType({
    this.type,
    this.values,
    this.studyType,
    this.parameterName,
    this.minValue,
    this.maxValue,
    this.defaultValue,
  });

  String? type;
  List<int>? values;
  String? studyType;
  String? parameterName;
  int? minValue;
  int? maxValue;
  int? defaultValue;

  factory IndicatorType.fromJson(Map<String, dynamic> json) => IndicatorType(
        type: json["type"],
        values: json["values"] == null
            ? null
            : List<int>.from(json["values"].map((x) => x)),
        studyType: json["study_type"],
        parameterName: json["parameter_name"],
        minValue: json["min_value"],
        maxValue: json["max_value"],
        defaultValue: json["default_value"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "values":
            values == null ? null : List<dynamic>.from(values!.map((x) => x)),
        "study_type": studyType,
        "parameter_name": parameterName,
        "min_value": minValue,
        "max_value": maxValue,
        "default_value": defaultValue,
      };
}

class ValueType {
  ValueType({
    this.type,
    this.values,
  });

  String? type;
  List<double>? values;

  factory ValueType.fromJson(Map<String, dynamic> json) => ValueType(
        type: json["type"],
        values: List<double>.from(json["values"].map((x) => x.toDouble())),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "values": List<dynamic>.from(values!.map((x) => x)),
      };
}
