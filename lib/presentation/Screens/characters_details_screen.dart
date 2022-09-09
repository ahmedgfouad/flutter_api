 import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firsts_api/buisnes_logec/character_cubit.dart';
import 'package:firsts_api/conestanse/colors.dart';
import 'package:firsts_api/data/models/Character.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class CharacterDetailsScreen extends StatelessWidget {

final Character character ;

  const CharacterDetailsScreen({Key? key,required this.character}) : super(key: key);

  Widget buildSliverAppBar(){
    return SliverAppBar(
      expandedHeight: 600,
      pinned: true,
      stretch: true,
      backgroundColor: MycColors.myGrey,
      flexibleSpace: FlexibleSpaceBar(
        //centerTitle: true,
        title: Text(
          character.nickname!,
          style: TextStyle(
            color: MycColors.myWhite,
          ),
        ),
        background: Hero(
          tag: character.charId!,
          child: Image.network(character.image!,fit: BoxFit.cover,),
        ),
      ),
    );
  }
  Widget characterInfo(String title , String value ){
    return RichText(
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        text: TextSpan(
          children: [
            TextSpan(
              text : title,
              style: TextStyle(
                color: MycColors.myWhite,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              )
            ),
            TextSpan(
                text : value,
                style: TextStyle(
                  color: MycColors.myWhite,
                  fontSize: 16,
                )
            ),
          ],
        ),
    );
   }
   Widget buildDivider(double endIndent ){
    return Divider(
      color: MycColors.myYellow,
      endIndent: endIndent,
      height: 30,
      thickness: 2,
    );

   }

   Widget chickIfQuotesAreLoaded(CharacterState state ){
    if(state is QuotesLoaded ){
      return displayRandomQuoteOrEmptySpace(state);
    }else{
      return showProgressIndicator();

    }
   }

   Widget displayRandomQuoteOrEmptySpace(state){
    var quotes = (state).quotes;
    if(quotes.length !=0){
      int randomQuoteIndex=Random().nextInt(quotes.length-1);
      return Center(
        child: DefaultTextStyle(
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            color: MycColors.myWhite,
            shadows: [
              Shadow(
                blurRadius: 7,
                color: MycColors.myYellow,
                offset: Offset(0,0),
              )
            ]
          ),
          child: AnimatedTextKit(
            repeatForever: true,
            animatedTexts: [
              FlickerAnimatedText(quotes[randomQuoteIndex].quote),
            ],
          )
        ),
      );
    } else{
     return Container();
    }
   }

   Widget showProgressIndicator(){
    return Center(
      child: CircularProgressIndicator(
        color: MycColors.myYellow,
      ),
    );

   }


  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CharacterCubit>(context).getQuotes(character.name!);

    return Scaffold(
      backgroundColor: MycColors.myGrey,
      body: CustomScrollView(
        slivers: [
          buildSliverAppBar(),
        SliverList(delegate: SliverChildListDelegate(
          [
            Container(
              margin: EdgeInsets.fromLTRB(14, 14, 14, 0),
              padding: EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  characterInfo('Job : ', character.jobs.join(' / ')),
                  buildDivider(315),
                  characterInfo('Appeared in : ',character.categoryForTwoSeries!),
                  buildDivider(250),
                  characterInfo('Seasons : ',
                      character.appearanceOfSeasons.join(' / ')),
                  buildDivider(280),
                  characterInfo('Status  : ', character.statusIfDeadOrAlive!),
                  buildDivider(300),

                  character.betterCallSaulAppearance!.isEmpty
                      ? Container()
                      : characterInfo('Better Call Saul Seasons  : ',
                          character.betterCallSaulAppearance!.join(' / ')),

                  character.betterCallSaulAppearance!.isEmpty
                      ? Container()
                      : buildDivider(150),
                  characterInfo('Actor / Actors : ', character.actorName!),
                  buildDivider(235),
                  SizedBox(height: 20,),
                  BlocBuilder<CharacterCubit,CharacterState>(
                      builder: (context,state){
                       return chickIfQuotesAreLoaded(state) ;

                  }
                  ),
                ],
              ),
            ),
            SizedBox(height: 500,)
          ],
        ),
        )
      ]
      ),
    );
  }
}
