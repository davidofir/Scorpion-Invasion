//
//  ScoreBoard.swift
//  A4
//
//  Created by ofir david on 2021-12-01.
//

import SwiftUI
struct ScoreRow: View{
    var score : Score
    var body: some View{
        
        VStack{
            HStack{
                Spacer()
            Text("Name: \(score.Name)")
                .font(.title2)
                .foregroundColor(.blue)
                Spacer()
            }.padding(20)
            HStack{
                Spacer()
            Text("Score: \(score.Score)")
                .font(.title2)
                .foregroundColor(.red)
                Spacer()
            }.padding(20)
        }
    }
}
struct ScoreBoard: View {
    @ObservedObject var fetch = GetData()
    var body: some View {
        List{
            ForEach(fetch.scores.sorted(by: {$0.Score > $1.Score }), id: \.self){ s in
                ScoreRow(score: s)
            }
        }.opacity(0.75)
        .background(Image("earth"), alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        .navigationTitle("ScoreBoard")
    }
}
