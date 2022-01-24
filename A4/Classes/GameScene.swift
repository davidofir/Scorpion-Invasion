//
//  GameScene.swift
//  A4
//
//  Created by ofir david on 2021-11-30.
//

import SpriteKit
import GameplayKit

// step 7 - add Physics categories struct
struct PhysicsCategory{
    static let None : UInt32 = 0
    static let All : UInt32 = UInt32.max
    static let Baddy : UInt32 = 0b1 // 1
    static let Hero : UInt32 = 0b10 // 2
    // future expansion - dunno if we'll make it here
    static let Projectile : UInt32 = 0b11 // 3
    
}

// step 6 - add collision detection delegate
class GameScene: SKScene, SKPhysicsContactDelegate {
    
    
    //private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    let explosionNode = SKEffectNode(fileNamed: "MyParticle.sks")
    // step 1 define our background & hero
    var background = SKSpriteNode(imageNamed: "earth")
    private var heroNode : SKSpriteNode?
    private var bulletNode : SKSpriteNode?
    // step 11 - add score
    private var score : Int?
    let scoreIncrement = 10
    private var lblScore = SKLabelNode()
    private var lblTitle = SKLabelNode()
    func initLabels()
    {
        lblScore.name = "lblScore"
        lblScore.text = "Score: "
        lblScore.fontSize = 64
        lblScore.fontColor = UIColor.red
        lblScore.position = CGPoint(x: 200, y: 500)
        lblScore.zPosition = 11
        self.addChild(lblScore)
    }
    
    override func didMove(to view: SKView) {
        
        initLabels()
        
        // step 2a - add background first and fade it
        background.position = CGPoint(x: frame.size.width/4, y: frame.size.height/4)
        background.alpha = 0.2
        addChild(background)
        // end step 2aImages
        
        // Get label node from scene and store it for use later
       
            lblTitle.alpha = 0.0
            lblTitle.run(SKAction.fadeIn(withDuration: 2.0))
        
        
        // Create shape node to use during mouse interaction
        
        explosionNode?.position = CGPoint(x: -100, y: -100)
        addChild(explosionNode!)
        // step 2b - initialize our hero node - the jays
        heroNode = SKSpriteNode(imageNamed: "gun")
        heroNode?.position = CGPoint(x: 200, y: 90)
        heroNode?.zRotation = 4.2
        addChild(heroNode!)
        bulletNode = SKSpriteNode(imageNamed: "bullet")
        bulletNode?.zRotation = -4.7
        bulletNode?.position = CGPoint(x: 5, y: 5)
        addChild(bulletNode!)
        // end step 2b
        
        // step 8 - add physics to our hero
        
        physicsWorld.gravity = CGVector(dx: 0,dy: 0)
        physicsWorld.contactDelegate = self
        // end step 8
        
        // step 9b - add collision detection to our hero
        
        bulletNode?.physicsBody = SKPhysicsBody(circleOfRadius: (bulletNode?.size.width)!/2)
        bulletNode?.physicsBody?.isDynamic = true
        bulletNode?.physicsBody?.categoryBitMask = PhysicsCategory.Projectile
        bulletNode?.physicsBody?.contactTestBitMask = PhysicsCategory.Baddy
        bulletNode?.physicsBody?.collisionBitMask = PhysicsCategory.None
        bulletNode?.physicsBody?.usesPreciseCollisionDetection = true
        // end step 9b
        
        // step 4 - bringing in the baddies
        run(SKAction.repeatForever(SKAction.sequence([SKAction.run(addBaddy), SKAction.wait(forDuration: 2)])))
        
        // step 11b - init score
        score = 0
        self.lblScore.text = "Score: \(score!)"
       
            lblScore.alpha = 0.0
            lblScore.run(SKAction.fadeIn(withDuration: 2.0))
        
        
    }
    
    // step 3 - adding bad guy leafs
    func random() -> CGFloat{
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    
    func random(min:CGFloat, max: CGFloat) -> CGFloat{
        return random() * (max-min) + min
    }
    func addBaddy(){
        
        let baddy = SKSpriteNode(imageNamed: "scorpion")
        baddy.zRotation = -9
        baddy.xScale = baddy.xScale * -1
        baddy.size = CGSize(width: 30, height: 60)
        let actualX = random(min: baddy.size.width/2, max: size.width-baddy.size.width/2)
        baddy.position = CGPoint(x: actualX, y:size.width*2 + baddy.size.height/2)
        
        addChild(baddy)
        
        // step 9 - add physics to our baddy
        baddy.physicsBody = SKPhysicsBody(rectangleOf: baddy.size)
        baddy.physicsBody?.isDynamic = true
        baddy.physicsBody?.categoryBitMask = PhysicsCategory.Baddy
        baddy.physicsBody?.contactTestBitMask = PhysicsCategory.Hero
        baddy.physicsBody?.collisionBitMask = PhysicsCategory.None
        
        // end step 9
        
        let actualDuration = random(min: CGFloat(2.0), max:CGFloat(4.0))
        
        let actionMove = SKAction.move(to: CGPoint(x: actualX, y: -baddy.size.height/2), duration: TimeInterval(actualDuration))
        
        //let actionMoveDone = SKAction.removeFromParent()
        let decrementScore = SKAction.run{
            self.score! = self.score! - self.scoreIncrement
            SKAction.removeFromParent()
            self.lblScore.text = "Score: \(self.score!)"
            
            self.lblScore.alpha = 0.0
            self.lblScore.run(SKAction.fadeIn(withDuration: 2.0))
        }
        baddy.run(SKAction.sequence([actionMove, decrementScore]))
    }
    
    // step 10 delegete methods for physics
    
    func heroDidCollideWithBaddy(hero: SKSpriteNode, baddy: SKSpriteNode){
    
        
        let displayEffect = SKAction.move(to: baddy.position, duration: 0)
        let waitEffect = SKAction.wait(forDuration: 0.5)
        let removeEffect = SKAction.move(to: CGPoint(x: -100, y: -100), duration: 0)
        explosionNode?.run(SKAction.sequence([displayEffect,waitEffect,removeEffect]))
        hero.removeFromParent()
        score = score! + scoreIncrement
        self.lblScore.text = "Score: \(score!)"
        
        lblScore.alpha = 0.0
        lblScore.run(SKAction.fadeIn(withDuration: 2.0))
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        var firstBody : SKPhysicsBody
        var secondBody : SKPhysicsBody
        
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        }else{
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        if((firstBody.categoryBitMask & PhysicsCategory.Baddy != 0) &&
            (secondBody.categoryBitMask & PhysicsCategory.Projectile != 0)){
            heroDidCollideWithBaddy(hero: firstBody.node as! SKSpriteNode, baddy: secondBody.node as! SKSpriteNode)
        }
    }
    // end step 10
    
    // step 5 - now lets move our hero
    func moveGoodGuy(toPoint pos : CGPoint){
        
        bulletNode?.position = heroNode!.position
        let actionMove = SKAction.move(to: pos, duration: 0.5)
        let actionMoveDone = SKAction.move(to: CGPoint(x: -100, y: -100), duration: 0)
        
        bulletNode?.run(SKAction.sequence([actionMove,actionMoveDone]))
    }
    
    
 /*   func touchDown(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.green
            self.addChild(n)
        }
        // step 5b - now lets move our hero
        moveGoodGuy(toPoint: pos)
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.blue
            self.addChild(n)
            
            
            // step 5c - now lets move our hero
            moveGoodGuy(toPoint: pos)
        }
    }
    
    func touchUp(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.red
            self.addChild(n)
        }
    }*/
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // step 5c - now lets move our hero
        let pos : CGPoint = (touches.first?.location(in: self))!
        moveGoodGuy(toPoint: pos)
      
    }
    
 /*   override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    */
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
