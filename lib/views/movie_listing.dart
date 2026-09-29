import 'package:flutter/material.dart';
import 'package:southsea_cinema/constants.dart';
import 'package:southsea_cinema/widgets/nav_drawer.dart';

class MovieListing extends StatelessWidget {
  const MovieListing({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(appTitle, style: cinemaHeaderStyle),
        backgroundColor: cinemaSurface,
        iconTheme: const IconThemeData(color: cinemaBrand),
        elevation: 0,

     
        

        
      ),
    
      drawer: const NavDrawer(),
      body: 
         Container( 
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [ 
          Text('Emma(2020) (U)'),
          Text("Emma. (2020) is a visually vibrant, witty period romantic comedy directed by Autumn de Wilde and based on Jane Austen's 1815 novel."),
          Row(children: [
            Text('Friday 2nd October 2026, 18:00 - ends at 19:24. ' ),

            Text('Please note that Discounts/ Membership benefits will be applied once you have selected your tickets.' )
          


          ]
          )
        ]
        )
      
      )

      
      
    );
    
  }
}
