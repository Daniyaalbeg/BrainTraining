//
//  ContentView.swift
//  BrainTraining
//
//  Created by Daniyaal Beg on 29/01/2020.
//  Copyright © 2020 dan. All rights reserved.
//

import SwiftUI

struct ContentView: View {

  let moves = ["rock", "paper", "scissors"]
  let moveEmojis = ["✊", "✋", "✌️"]

  @State var gameMoveChoice = Int.random(in: 0..<3)
  @State var shouldPlayerWin = Bool.random()
  @State var isGameOver = false
  @State var score = 0

  var body: some View {
    ZStack {
      LinearGradient(gradient: Gradient(colors: [.yellow, .orange]), startPoint: .top, endPoint: .bottom)
        .edgesIgnoringSafeArea(.all)
      VStack {
        Text("Score: \(score)")
          .font(.system(Font.TextStyle.largeTitle))
        Spacer()
        Text(moveEmojis[gameMoveChoice])
          .font(.system(size: 70))
          .shadow(radius: 5)
        Text("You should \(shouldPlayerWin ? "win" : "lose")")
          .font(.system(Font.TextStyle.headline))
        Spacer()
        HStack {
          ForEach(0 ..< moves.count) { index in
            Button(action: {
              self.buttonTapped(chosenMove: index)
            }) {
              Text(self.moveEmojis[index])
                .font(.system(size: 70))
              .shadow(radius: 5)
            }
          }
        }
      }
    }
    .alert(isPresented: $isGameOver) {
      Alert(title: Text("You have Won"), message: Text("Congratulations, you do have a brain!"), dismissButton: .destructive(Text("Restart?")) {
        self.score = 0
        })
    }
  }

  func buttonTapped(chosenMove: Int) {
    if chosenMove == gameMoveChoice {
      //Draw
      gameMoveChoice = Int.random(in: 0..<3)
      shouldPlayerWin = Bool.random()
      print("Draw")
      return
    }

    var won = false

    if shouldPlayerWin {
      //Player wins
      if chosenMove == 0 { //chose rock
        if gameMoveChoice == 2 {
          //Win
          score += 1
          won = true
        }
      } else if chosenMove == 1 { //chose paper
        if gameMoveChoice == 0 {
          //Win
          score += 1
          won = true
        }
      } else { //chose scissors
        if gameMoveChoice == 1 {
          //Win
          score += 1
          won = true
        }
      }
    } else {
      //Computer wins
      if gameMoveChoice == 0 {
        if chosenMove == 2 {
          //win
          score += 1
          won = true
        }
      } else if gameMoveChoice == 1 {
        if chosenMove == 0 {
          //win
          score += 1
          won = true
        }
      } else {
        if chosenMove == 1 {
          //win
          score += 1
          won = true
        }
      }
    }

    if !won {
      score -= 1
    }

    if score == 10 {
      isGameOver = true
    }

    gameMoveChoice = Int.random(in: 0..<3)
    shouldPlayerWin = Bool.random()
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
