//
//  CustomButton.swift
//  A4
//
//  Created by ofir david on 2021-11-30.
//

import SwiftUI
struct CustomButton:ButtonStyle{
    var first: Color
    var second: Color
    var third: Color
    var secondary: Color
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.title)
            .frame(minWidth: 200, idealWidth: 200, maxWidth: 200, minHeight: 40, idealHeight: 40, maxHeight:40)
            .padding(15)
            .foregroundColor(secondary)
            .overlay(RoundedRectangle(cornerRadius: 25)
                        .stroke(secondary,lineWidth: 3))
            .background(LinearGradient(gradient: Gradient(colors: [first,second,third]),startPoint: .top,endPoint: .bottom)
        ).cornerRadius(25)
            .compositingGroup()
            .shadow(color: secondary, radius: 3)
            .opacity(configuration.isPressed ? 0.5 : 1.0)
            .scaleEffect(configuration.isPressed ? 0.8 : 1.0)
        
    }
}
