import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:poke_api/data/models/default.dart';
import 'package:poke_api/data/models/response_list_pokemon.dart';
import 'package:poke_api/util/api_request_status.dart';
import 'package:poke_api/data/service/network_service.dart';
import 'package:poke_api/util/util.dart';

class PokemonViewModel extends ChangeNotifier{

  int statusCode = 0;

  ApiHelper service = ApiHelper(); 

  APIRequestStatus requestStatus = APIRequestStatus.loading;

  APIRequestStatus requestStatusLoadMore = APIRequestStatus.loaded;

  List<Default> list = [];

  List<Default> listShow = [];

  List<String> listImage = [];

  List<String> listImageShow = [];

  String? urlNext;

  Future getApiPokemonLoadMore() async {
    if(urlNext!=null){
      getAPIPokemon(urlNext!,loadMore: true);
    }
  }

  Future getAPIPokemon(String url, {bool loadMore = false}) async {
    if(loadMore){
      requestStatusLoadMore = APIRequestStatus.loading;
    }else{
      requestStatus = APIRequestStatus.loading;
    }
    notifyListeners();
    try {
      var response = await service.getAPIPath(url);

      statusCode = response.statusCode;
      var decode = jsonDecode(response.body);
      var data  = ResponseListPokemon.fromJson(decode);
      if (data.results != null) {
        list.addAll(data.results!);
        listShow.addAll(data.results!);
        data.results!.forEach((element) {
          var split = element.url!.split("v2");
          var name = split [1].substring(0,split[1].length-1);
          var image = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites"+
                  name +".png";
          listImage.add(image);
          listImageShow.add(image);
        });
      }
      urlNext = data.next;
      if(loadMore){
        requestStatusLoadMore = APIRequestStatus.loading;
      }else{
        requestStatus = APIRequestStatus.loaded;
      }
      notifyListeners();
    } catch (e) {
      if (Util.isConnectionError(e)) {
        if (loadMore) {
          requestStatusLoadMore = APIRequestStatus.connectionError;
        } else {
          requestStatus = APIRequestStatus.connectionError;
        }
        notifyListeners();
      } else {
        if (loadMore) {
          requestStatusLoadMore = APIRequestStatus.error;
        } else {
          requestStatus = APIRequestStatus.error;
        }
        notifyListeners();
      }
    }
  }

  void search(String value) {
    requestStatus = APIRequestStatus.loading;
    notifyListeners();
    if (value.isEmpty) {
      listShow = list;
      listImageShow = listImage;
    } else {
      listShow = [];
      listImageShow = [];
      for(var i=0; i< list.length; i++){
        if (list[i].name!.toLowerCase().contains(value.toLowerCase())) {
          print("add:" + list[i].name!);
          listShow.add(list[i]);
          listImageShow.add(listImage[i]);
        }
      }
    }
    requestStatus = APIRequestStatus.loaded;
    notifyListeners();
  }
}