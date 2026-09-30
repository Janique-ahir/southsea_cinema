import 'package:flutter/material.dart';
import 'package:southsea_cinema/constants.dart';
import 'package:southsea_cinema/widgets/nav_drawer.dart';

class MovieListing extends StatefulWidget {
  const MovieListing({super.key});

  @override
  State<MovieListing> createState() => _MovieListingState();

}
class _MovieListingState extends State<MovieListing>{
  int selectedTickets = 1;
  String bookingMessage = '';


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
          
          ]),
          DropdownMenu<int>(
            initialSelection: selectedTickets,
            dropdownMenuEntries: const [
              DropdownMenuEntry(value:1,label:'One ticket'),
              DropdownMenuEntry(value: 2,label:'Two tickets'),
              DropdownMenuEntry(value:3,label:'Three tickets'),
              DropdownMenuEntry(value:4,label:'Four tickets'),
              DropdownMenuEntry(value: 5, label: 'Five tickets')
            ],
            onSelected: (int? value){
              if (value != null){
                  setState((){
                    selectedTickets = value;

                  });
                }
              }),
            
          
          ElevatedButton(
            onPressed: () {
              setState((){
                bookingMessage = '$selectedTickets ticket(s) added to order';

          });
            },
            child: const Text('Add to Order'),
          ),
          Text(bookingMessage),
        ]
        )
      


      )

      
      
    );
    
  }
}
