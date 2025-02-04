import 'package:cbl/cbl.dart';

class CouchbaseService {
  AsyncDatabase? database;

  Future<void> init() async {
    database ??= await Database.openAsync('database');
  }

  Future<bool> add(
      {required Map<String, dynamic> data,
      required String collectionName}) async {
    final colletion = await database?.createCollection(collectionName);

    if (colletion != null) {
      final document = MutableDocument(data);
      return await colletion.saveDocument(document);
    }
    return false;
  }

  Future<List<Map<String,dynamic>>> fetch({required String collectionName, String? filter }) async{
    await database?.createCollection(collectionName);
    // Quary de consulta da Collection
    final quary = await database?.createQuery('SELECT * FROM ${collectionName} ${filter != null ? 'WHERE ${filter}' : '' }');
    // Executo a consulta
    final result = await quary?.execute();
    // Pego o resultado da consulta
    final results = await result?.allResults();
    // Mapeio os dados
    final data =  results?.map( (e) => e.toPlainMap()).toList();
    // Retorno os dados e caso não encontre eu retorno lista vazia;
    return data ?? [];

  }
}
