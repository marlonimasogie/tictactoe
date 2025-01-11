import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ///////////////////////////////////// V A R I A B L E S //////////////////////////////////////////////////////////////////////////////////////

//If it is player X turn - true/false
  bool xTurn = true; //the First Play is X

//Creating a list variable of what will go in the gride
  List<String> displayXO = [
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
  ]; //this is the variable that will show up in the grid

//Fonts
  static var textFontsBlack = GoogleFonts.pressStart2p(
      textStyle: TextStyle(color: Colors.black, letterSpacing: 3));
  static var textFontsWhite = GoogleFonts.pressStart2p(
      textStyle: TextStyle(color: Colors.white, letterSpacing: 3));

  // Player Scores
  int xScore = 0;
  int oScore = 0;

  ///////////////////////////////////// F U N C T I O N S //////////////////////////////////////////////////////////////////////////////////////

  /// If Grid is tapped do the following in the function/method below
  void _tapped(int index) {
    setState(() {
      //change the variable of what is stored in displayXO for either an X or an O
      if (displayXO[index] == "X" || displayXO[index] == "O") {
        null;
      } else if (xTurn == true && displayXO[index] == "") {
        displayXO[index] = "X";
        xTurn = !xTurn;
      } else if (xTurn == false && displayXO[index] == "") {
        displayXO[index] = "O";
        xTurn = !xTurn;
      }

      _checkWinner(); //constantly check if there is a winner everytime someone taps the button
    });
  }

//funtion to check if there is a winner or not?
  void _checkWinner() {
    // Horizontal wins
    if (displayXO[0] == displayXO[1] &&
        displayXO[0] == displayXO[2] &&
        displayXO[0] != "") {
      _showDialogue(displayXO[0]);
    } else if (displayXO[3] == displayXO[4] &&
        displayXO[3] == displayXO[5] &&
        displayXO[3] != "") {
      _showDialogue(displayXO[3]);
    } else if (displayXO[6] == displayXO[7] &&
        displayXO[6] == displayXO[8] &&
        displayXO[6] != "") {
      _showDialogue(displayXO[6]);
    }

    // Vertical wins
    else if (displayXO[0] == displayXO[3] &&
        displayXO[0] == displayXO[6] &&
        displayXO[0] != "") {
      _showDialogue(displayXO[0]);
    } else if (displayXO[1] == displayXO[4] &&
        displayXO[1] == displayXO[7] &&
        displayXO[1] != "") {
      _showDialogue(displayXO[1]);
    } else if (displayXO[2] == displayXO[5] &&
        displayXO[2] == displayXO[8] &&
        displayXO[2] != "") {
      _showDialogue(displayXO[2]);
    }

    // Diagonal wins
    else if (displayXO[0] == displayXO[4] &&
        displayXO[0] == displayXO[8] &&
        displayXO[0] != "") {
      _showDialogue(displayXO[0]);
    } else if (displayXO[2] == displayXO[4] &&
        displayXO[2] == displayXO[6] &&
        displayXO[2] != "") {
      _showDialogue(displayXO[2]);
    }

    //Draw and show Dialogue Box
    else if (displayXO.every((displayXO) => displayXO != "")) {
      ///Start dialogue box
      showDialog(
          barrierDismissible: //allowing us to get rid of the alert diaolugie by pressening outside of the box
              false,
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("It's a Draw!"),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      _clearBoard(); //function to clear the board
                      Navigator.of(context).pop();
                    },
                    child: Text("Play Again!"))
              ],
            );
          });
    }
  }

//Show winner dialogue box and tally score
  void _showDialogue(String winner) {
    showDialog(
        barrierDismissible: //allowing us to get rid of the alert diaolugie by pressening outside of the box
            false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Winner: ' + winner),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    _clearBoard();
                    Navigator.of(context).pop();
                  },
                  child: Text("Play Again!"))
            ],
          );
        });
    //Tally the score
    if (winner == "X") {
      xScore = xScore + 1;
    } else if (winner == "O") {
      oScore = oScore + 1;
    }
  }

  //function to clear board
  void _clearBoard() {
    setState(() {
      for (var i = 0; i < 9; i++) {
        displayXO[i] = "";
      }
    });
  }

  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  ///////////////////////////////////// M A I N A P P U I//////////////////////////////////////////////////////////////////////////////////////

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 71, 70, 70),
      body: Column(
        children: [
          Expanded(
            child: Container(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 65, bottom: 20),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Player X:",
                          style:
                              textFontsWhite, //variable above of what the player textstyile is
                        ),
                        Text(
                          xScore.toString(), //variable for player X's score
                          style:
                              textFontsWhite, //variable above of what the player textstyile is
                        ),
                      ]),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 65, bottom: 20),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Player O:",
                          style:
                              textFontsWhite, //variable above of what the player textstyile is
                        ),
                        Text(
                          oScore.toString(), //variable for player O's score
                          style:
                              textFontsWhite, //variable above of what the player textstyile is
                        ),
                      ]),
                ),
              ],
            )),
          ),
          Expanded(
            flex: 3,
            child: GridView.builder(
                itemCount: 9,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      _tapped(
                          index); //Function that we will create on what happens during Tapp
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                        color: Colors.white,
                      )),
                      child: Center(
                        child: Text(
                          displayXO[
                              index], //add a variable here to change the value in each square
                          style: TextStyle(color: Colors.white, fontSize: 40),
                        ),
                      ),
                    ),
                  );
                }),
          ),
          Expanded(
            child: Container(
              color: const Color.fromARGB(255, 71, 70, 70),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Tick Tac Toe",
                    style: textFontsWhite,
                  ),
                  Text(
                    "by Marlito",
                    style: textFontsWhite,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
