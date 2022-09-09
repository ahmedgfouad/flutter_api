import 'package:firsts_api/buisnes_logec/character_cubit.dart';
import 'package:firsts_api/conestanse/colors.dart';
import 'package:firsts_api/data/models/Character.dart';
import 'package:firsts_api/presentation/Widgets/character_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';

class CaractureScreens extends StatefulWidget {

  @override
  State<CaractureScreens> createState() => _CaractureScreensState();
}

class _CaractureScreensState extends State<CaractureScreens> {
  late List<Character>allCharacters;
  late List<Character> searchedForCharacters;
  bool  _isSearching =false;
  final _searchTextController= TextEditingController();

  Widget _buildSearchField(){
    return TextField(
      controller: _searchTextController,
      cursorColor: MycColors.myGrey,
      decoration: InputDecoration(
        hintText: "Find a character ",
        border: InputBorder.none,
        hintStyle: TextStyle(
          color: MycColors.myGrey,
          fontSize: 18,
        ),
      ),
      style: TextStyle(
        color: MycColors.myGrey,
        fontSize: 18,
      ),
      onChanged: (searcherCharacter){
        addSearchedForItemsToSearchedList(searcherCharacter);
      },
    );
  }
  void addSearchedForItemsToSearchedList(String searcherCharacter){
    searchedForCharacters=allCharacters
        .where((character) =>
            character.name!.toLowerCase().startsWith(searcherCharacter))
        .toList();
    setState(() {

    });
  }
  List <Widget> _buildAppBarActions(){
    if(_isSearching ){
      return [
        IconButton(
            onPressed:(){
              _clearSearch();
              Navigator.pop(context);
            },
            icon: Icon(Icons.clear ,color: MycColors.myGrey,),),
      ];
    }else{
      return [
        IconButton(
            onPressed: _startSearch,
            icon: Icon(Icons.search,color: MycColors.myGrey,),),
      ];

    }
  }
  void _startSearch(){
    ModalRoute.of(context)!
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching  ));
    setState(() {
      _isSearching=true;
    });
  }
  void _stopSearching (){
    _clearSearch();

    setState(() {
      _isSearching=false;
    });
  }

  void _clearSearch(){
    setState(() {
      _searchTextController.clear();
    });

  }
  @override
  void initState() {
    super.initState();

    BlocProvider.of<CharacterCubit>(context).getAllCharacters();
  }

  Widget buildBlocWidget (){
    return BlocBuilder<CharacterCubit,CharacterState>(
        builder: (context,state){
          if(state is CharactersLoaded ){
            allCharacters=(state).characters;
            return buildLoadedListWidgets();
          } else{
            return showLoadingIndicator();
          }
        },
    );
  }

  Widget showLoadingIndicator(){
    return Center(child: CircularProgressIndicator(
      color: MycColors.myYellow,
    ),);

  }

  Widget buildLoadedListWidgets(){
    return SingleChildScrollView(
      child: Container(
        color: MycColors.myGrey,
        child: Column(
          children: [
            buildCharactersList(),
          ],
        ),
      ),
    );
  }

  Widget buildCharactersList(){
    return GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2/3,
          crossAxisSpacing: 1,
          mainAxisSpacing: 1,
        ),
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        padding: EdgeInsets.zero,
        itemCount: _searchTextController.text.isEmpty? allCharacters.length : searchedForCharacters.length,
        itemBuilder:(ctx,index){
          return CharacterItem(
            character: _searchTextController.text.isEmpty ?allCharacters[index] : searchedForCharacters[index],
          );
        },
    );
  }

Widget _buildAppBarTitle(){
    return  Text("Characters",
      style: TextStyle(
        color: MycColors.myGrey,
      ),
    );
}
Widget buildNoInternetWidget(){
 return Center(
   child: Container(
     color: Colors.white,
     child: Column(
       mainAxisAlignment: MainAxisAlignment.center,
       children: [
         SizedBox(height: 20,),
         Text("Can't connect chick internet ",
         style: TextStyle(
           fontSize: 20,
           color: MycColors.myGrey,
           
         ),
         ),
         Image.asset("images/offline.png"),
       ],
     ),
   ),
 ) ;
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MycColors.myYellow,
        leading: _isSearching ?BackButton(color: MycColors.myGrey,) : Container(),
        title: _isSearching ? _buildSearchField() : _buildAppBarTitle(),
        actions: _buildAppBarActions(),

      ),
      body: OfflineBuilder(
      connectivityBuilder: (
      BuildContext context,
      ConnectivityResult connectivity,
      Widget child,
    ) {
        final bool connected = connectivity != ConnectivityResult.none;
        if(connected ){
          return buildBlocWidget();
        }else{
          return buildNoInternetWidget();
        }
      },
        //child: showLoadingIndicator(),
      ),

     // buildBlocWidget(),
    );
  }
}













