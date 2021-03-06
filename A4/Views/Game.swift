//
//  Game.swift
//  A4
//
//  Created by ofir david on 2021-11-30.
//

import SwiftUI
import SpriteKit
struct Game: View {
    var scene: SKScene {
            let scene = GameScene()
        scene.size = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        scene.scaleMode = .aspectFill
        scene.anchorPoint = CGPoint(x: 0, y: 0)
            return scene
    }
    
    var body: some View {
        SpriteView(scene: scene)
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height )
                    .ignoresSafeArea()    }
}

struct Game_Previews: PreviewProvider {
    static var previews: some View {
        Game()
    }
}
