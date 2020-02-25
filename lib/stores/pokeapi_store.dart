import 'dart:convert';

import 'package:mobx/mobx.dart';
import 'package:pokedex_flutter/consts/consts_api.dart';
import 'package:pokedex_flutter/models/pokeapi.dart';
import 'package:http/http.dart' as http;
part 'pokeapi_store.g.dart';

class PokeApiStore = _PokeApiStoreBase with _$PokeApiStore;

abstract class _PokeApiStoreBase with Store {
  @observable
  PokeAPI _pokeAPI;

  @computed
  PokeAPI get pokeAPI => _pokeAPI;

  @action
  fetchPokemonList() {
    loadPokeApi().then((pokeList) {
      _pokeAPI = pokeList;
    });
  }

  Future<PokeAPI> loadPokeApi() async {
    try {
      final response = await http.get(ConstsAPI.pokeapiURL);
      var decodeJson = jsonDecode(response.body);
      return PokeAPI.fromJson(decodeJson);
    } catch (e, stacktrace) {
      print('Erro loading list' + stacktrace.toString());
      return null;
    }
  }
}
