//
//  GameScene.swift
//  WordBlastoff
//
//  Created by nook on 10/27/15.
//  Copyright (c) 2015 Nebulous Games. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    let masterAtlas = SKTextureAtlas(named: "images")
    var blackHole:SKSpriteNode!
    let lettersBitMask:UInt32 = 0xF0000000
    let blackHoleBitMask:UInt32 = 0x0000000F

    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        let myLabel = SKLabelNode(fontNamed:"Chalkduster")
        myLabel.text = "Hello, World!";
        myLabel.fontSize = 45;
        myLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame));

        let frameMiddle = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMidY(self.frame))

        blackHole = SKSpriteNode(texture: masterAtlas.textureNamed("hole0.png"))
        blackHole.position = frameMiddle
        blackHole.physicsBody = SKPhysicsBody(circleOfRadius: blackHole.size.width/2)
        blackHole.physicsBody?.affectedByGravity = false
//        blackHole.physicsBody?.collisionBitMask = 0
        blackHole.physicsBody?.dynamic = true
        
        blackHole.physicsBody?.categoryBitMask = blackHoleBitMask
        blackHole.physicsBody?.collisionBitMask = lettersBitMask
        
        let vortex = SKFieldNode.vortexField()
        vortex.enabled = true
        vortex.position = frameMiddle
        vortex.strength = 50

        let bigFrame = CGRectApplyAffineTransform(self.frame, CGAffineTransformScale(CGAffineTransformIdentity, 20, 20))
        vortex.region = SKRegion(size:  bigFrame.size)
        
        let gravity = SKFieldNode.radialGravityField()
        gravity.enabled = true
        gravity.position = frameMiddle
        gravity.strength = 2
        gravity.region = SKRegion(size: bigFrame.size)
        
        gravity.categoryBitMask = lettersBitMask
        vortex.categoryBitMask = lettersBitMask
        
        blackHole.physicsBody?.fieldBitMask = 0
        
//        blackHole.physicsBody?.categoryBitMask =
        
        self.addChild(myLabel)
        self.addChild(blackHole)

        self.scene?.addChild(vortex)
        self.scene?.addChild(gravity)

    }


    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        
        for touch in touches {
            let location = touch.locationInNode(self)
            
//            let sprite = SKSpriteNode(imageNamed:"Spaceship")
        
            
//            print(masterAtlas.textureNamed("_1@2x.png"))
//            print(masterAtlas.textureNamed("_1.png"))
//            print(masterAtlas.textureNamed("_1"))

                let newSprite = SKSpriteNode(texture: masterAtlas.textureNamed("_1@2x.png"))
            newSprite.position = location

            self.addChild(newSprite)

            
//            newSprite.physicsBody =
            
//            newSprite.position = CGPointMake(100, 100)
//            newSprite.zPosition = 100
//            self.addChild(newSprite)
            
            let frameMiddle = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMidY(self.frame))
            
            
//            let  = SKFieldNode
            
            
            

            
            

            
//            self.scene?.addChild(gravity)

            
            newSprite.physicsBody = SKPhysicsBody(circleOfRadius: newSprite.size.width/2)
//            .Create (node.Texture, node.Size);
            newSprite.physicsBody?.affectedByGravity = true
            newSprite.physicsBody?.allowsRotation = true
            newSprite.physicsBody?.mass = 30
            newSprite.physicsBody?.friction = 0.3
            
            self.scene?.physicsWorld.gravity = CGVectorMake(0, 0)


            newSprite.physicsBody?.categoryBitMask = lettersBitMask
            newSprite.physicsBody?.collisionBitMask = blackHoleBitMask | lettersBitMask
            newSprite.physicsBody?.contactTestBitMask = blackHoleBitMask
            
            
            if let bhPhysics = blackHole.physicsBody, let nsPhysics = newSprite.physicsBody{
                
                let joint = SKPhysicsJointLimit.jointWithBodyA(bhPhysics, bodyB: nsPhysics, anchorA: blackHole.position, anchorB: newSprite.position)
                
                print("blackhole pos \(blackHole.position)")
                print("newSprite pos \(newSprite.position)")
                
                
                self.physicsWorld.addJoint(joint)
                
            }
            
            
            
//            newSprite.xScale = 0.5
//            newSprite.yScale = 0.5
            print(location)
            
//            let action = SKAction.rotateByAngle(CGFloat(M_PI), duration:1)
            
//            sprite.runAction(SKAction.repeatActionForever(action))
            
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
