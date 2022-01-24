//
//  Instructions.swift
//  A4
//
//  Created by ofir david on 2021-12-01.
//

import SwiftUI

struct Instructions: View {
    var body: some View {
        ZStack{
            Image("earth")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/).opacity(0.5)
            VStack{
                Text("Scorpion Invasion").font(.largeTitle)
                Spacer()
                Text("Your task is to defend planet Earth from the massive scorpion invasion").font(.title2)
                Text("to fire a hellfire bullet projectile from your cannon, you will need to predict where the scorpion arrives by the time the bullet finishes its travel distance").font(.title2)
                Text("tap where you want your bullet to reach to while accounting for the travel time of the bullet and scorpion, as the bullet will only travel to where you pressed and not travel any further").font(.title2)
                Text("any scorpions that manage to escape will lead to a score loss").font(.title2)
                Text("so what are you waiting for? the we need your help!").font(.title2)
                Spacer()
            }
            .padding(40)
        }.navigationTitle("Instructions")
    }
}

struct Instructions_Previews: PreviewProvider {
    static var previews: some View {
        Instructions()
    }
}
