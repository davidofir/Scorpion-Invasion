//
//  ContentView.swift
//  A4
//
//  Created by ofir david on 2021-11-30.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView{
            ZStack{
                Image("earth")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/).opacity(0.5)
                VStack{
                    NavigationLink(destination: Game()){
                        Text("Play!")
                    }.buttonStyle(CustomButton(first: Color.red, second: Color(red: 0, green: 0, blue: 0.7), third: Color(red: 0.1, green: 0, blue: 0.7), secondary: Color.black))
                    NavigationLink(destination: ScoreBoard()){
                        Text("ScoreBoard")
                    }.buttonStyle(CustomButton(first: Color.red, second: Color(red: 0, green: 0, blue: 0.8), third: Color(red: 0.3, green: 0, blue: 0.4), secondary: Color.black))
                    NavigationLink(destination: Instructions()){
                        Text("Instructions")
                    }.buttonStyle(CustomButton(first: Color.red, second: Color(red: 0, green: 0, blue: 0.4), third: Color(red: 0.5, green: 0, blue: 0.7), secondary: Color.black))
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
