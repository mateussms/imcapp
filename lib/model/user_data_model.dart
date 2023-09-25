import 'package:hive/hive.dart';

part 'user_data_model.g.dart';

@HiveType(typeId: 0)
class UserData extends HiveObject {
  @HiveField(0)
  late String nome;

  @HiveField(1)
  late double altura;

   UserData();

  UserData.criar(this.nome, this.altura);
}