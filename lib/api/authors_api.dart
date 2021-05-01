import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_app/utilities/apiutilitie.dart';
import 'package:flutter_app/models/news.dart';
class AuthorsAPI{


  Future<NewsModel>fetchAllAuthors() async {
    var url = Uri.parse(base_api+all_authors_api);
    var newsModel=null;
    var response = await http.get(url);
    try{
    if(response.statusCode==200){
      var jsonData=jsonDecode(response.body);
      newsModel=NewsModel.fromJson(jsonData);

    }
    }catch(Exeption){
      return newsModel;
    }
    return newsModel;

  }
  Future<NewsModel>recentUpdates() async {
    var url = Uri.parse(base_api+all_authors_api);
    var newsModel=null;
    var response = await http.get(url);
    try{
      if(response.statusCode==200){
        var jsonData=jsonDecode(response.body);
        newsModel=NewsModel.fromJson(jsonData);

      }
    }catch(Exeption){
      return newsModel;
    }
    return newsModel;

  }
  Future<NewsModel>fetchAllPopular() async {
    var url = Uri.parse(base_api+all_authors_api);
    var newsModel=null;
    var response = await http.get(url);
    try{
      if(response.statusCode==200){
        var jsonData=jsonDecode(response.body);
        newsModel=NewsModel.fromJson(jsonData);

      }
    }catch(Exeption){
      return newsModel;
    }
    return newsModel;

  }

}