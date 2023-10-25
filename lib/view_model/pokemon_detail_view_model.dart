import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:poke_api/data/models/response_pokemon.dart';
import 'package:poke_api/util/api_request_status.dart';
import 'package:poke_api/data/service/network_service.dart';
import 'package:poke_api/util/string_extention.dart';
import 'package:poke_api/util/util.dart';

class PokemonDetailViewModel extends ChangeNotifier{

  int statusCode = 0;

  ApiHelper service = ApiHelper(); 

  APIRequestStatus requestStatus = APIRequestStatus.loading;

  ResponsePokemon? data;

  Future getAPIDetailPokemon(String url) async {
    requestStatus = APIRequestStatus.loading;
    notifyListeners();
    try {
      var response = await service.getAPIPath(url);

      statusCode = response.statusCode;
      var decode = jsonDecode(response.body);
      data  = ResponsePokemon.fromJson(decode);
      requestStatus = APIRequestStatus.loaded;
      notifyListeners();
    } catch (e) {
      if (Util.isConnectionError(e)) {
        requestStatus = APIRequestStatus.connectionError;
        notifyListeners();
      } else {
        requestStatus = APIRequestStatus.error;
        notifyListeners();
      }
    }
  }

  List<Widget> getImages() {
    List<Widget> imageWidgets = [];
    List<String> images = [];
    if (data != null) {
      if (data!.sprites != null) {
        if (data!.sprites!.front_default != null) {
          images.add(data!.sprites!.front_default!);
        }
        if (data!.sprites!.back_default != null) {
          images.add(data!.sprites!.back_default!);
        }
        if (data!.sprites!.front_female != null) {
          images.add(data!.sprites!.front_female!);
        }
        if (data!.sprites!.back_female != null) {
          images.add(data!.sprites!.back_female!);
        }
        if (data!.sprites!.front_shiny != null) {
          images.add(data!.sprites!.front_shiny!);
        }
        if (data!.sprites!.back_shiny != null) {
          images.add(data!.sprites!.back_shiny!);
        }
        if (data!.sprites!.front_shiny_female != null) {
          images.add(data!.sprites!.front_shiny_female!);
        }
        if (data!.sprites!.back_shiny_female != null) {
          images.add(data!.sprites!.back_shiny_female!);
        }
      }
    }
    if (images.length > 0) {
      imageWidgets.add(
        Container(
            width: 80,
            child: Text(
              "Images",
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
      );
      imageWidgets.add(
        Container(
          child: Text(
            ": ",
            textAlign: TextAlign.start,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ),
      );
      List<Widget> widgets = [];
      images.forEach((image) {
        widgets.add(Image.network(
          image,
          width: 80,
          height: 80,
        ));
      });
      var scroll = Expanded(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
              mainAxisSize: MainAxisSize.min,
              children: widgets,
            ),
        ),
      );
      imageWidgets.add(scroll);
    }
    return imageWidgets;
  }
  String getStats() {
    var stats = "";
    if (data != null) {
      if (data!.stats != null) {
        if (data!.stats!.length > 0) {
          data!.stats!.forEach((element) {
            if(stats != ""){
              stats = stats + ", ";
            }
            var name = element.stat!.name!.replaceAll("-", " ").titleCase();
            
            stats = stats + name + " : " + element.base_stat.toString();
          });
        }
      }
    }
    return stats;
  }

  String getTypes() {
    var types = "";
    if (data != null) {
      if (data!.types != null) {
        if (data!.types!.length > 0) {
          data!.types!.forEach((element) {
            if (types != "") {
              types = types + ", ";
            }
            var name = element.type!.name!.replaceAll("-", " ").titleCase();

            types = types + name;
          });
        }
      }
    }
    return types;
  }

  String getMoves() {
    var moves = "";
    if (data != null) {
      if (data!.moves != null) {
        if (data!.moves!.length > 0) {
          data!.moves!.forEach((element) {
            if (moves != "") {
              moves = moves + ", ";
            }
            var name = element.move!.name!.replaceAll("-", " ").titleCase();

            moves = moves + name;
          });
        }
      }
    }
    return moves;
  }

  String getAbilities() {
    var abilities = "";
    if (data != null) {
      if (data!.abilities != null) {
        if (data!.abilities!.length > 0) {
          data!.abilities!.forEach((element) {
            if (abilities != "") {
              abilities = abilities + ", ";
            }
            var name = element.ability!.name!.replaceAll("-", " ").titleCase();

            abilities = abilities + name;
          });
        }
      }
    }
    return abilities;
  }

}