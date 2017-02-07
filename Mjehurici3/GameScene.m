//
//  GameScene.m
//  Mjehurici3
//
//  Created by Anton Orzes on 04/02/2017.
//  Copyright © 2017 Anton Orzes. All rights reserved.
//

#import "GameScene.h"
#import "Bubble.h"
#import "UdarniVal.h"
#import "Riba.h"
#import "Svjetlo.h"
#import "IzvorMjehurica.h"

@implementation GameScene {
    SKShapeNode *_spinnyNode;
    SKLabelNode *points;
    int cNum;
    AVAudioPlayer *sound1;
}

- (void)didMoveToView:(SKView *)view {
    // Setup your scene here
    cNum = 0;
    static const uint32_t maliCategory    =  0x1 << 1;
    static const uint32_t glavniCategory    =  0x1 << 2;
    self.physicsWorld.contactDelegate = self;
    
    CGFloat w = (self.size.width + self.size.height) * 0.05;
    
    SKSpriteNode *podloga = [SKSpriteNode spriteNodeWithImageNamed:@"podmorje"];
    podloga.size = self.size;
    podloga.zPosition = 0;
    [self addChild:podloga];
    
    _spinnyNode = [SKShapeNode shapeNodeWithRectOfSize:CGSizeMake(w/4, w/4) cornerRadius:w /8];
    _spinnyNode.lineWidth = 3.5;
    _spinnyNode.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:w/2];
    _spinnyNode.physicsBody.categoryBitMask = glavniCategory;
    _spinnyNode.physicsBody.contactTestBitMask = maliCategory;
    _spinnyNode.physicsBody.collisionBitMask = 0;
    _spinnyNode.physicsBody.affectedByGravity = NO;
    _spinnyNode.physicsBody.usesPreciseCollisionDetection=YES;
    _spinnyNode.name = @"spinny";
    [_spinnyNode runAction:[SKAction repeatActionForever:[SKAction rotateByAngle:M_PI duration:1]]];
    [_spinnyNode runAction:[SKAction sequence:@[
                                                [SKAction scaleBy:1.5 duration:0.5],
                                                [SKAction fadeOutWithDuration:0.5],
                                                [SKAction removeFromParent],
                                                ]]];
    
    for (int i=0; i<20; i++) {
        CGPoint poz = CGPointMake(self.size.width/4 - arc4random_uniform(self.size.width)*0.5,
                                  self.size.height/4 - arc4random_uniform(self.size.height)*0.5);
        Bubble *bu = [[Bubble alloc] initWithPosition:poz size:50];
        [self addChild:bu];
    }
    
    points = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    points.text = @"0/20";
    points.fontSize = 45;
    points.fontColor = [UIColor colorWithRed:0.0 green:1.0 blue:1.0 alpha:1.0];
    points.position = CGPointMake(self.frame.size.width/2-120,self.frame.size.height/2-100);
    [self addChild:points];
    NSURL *sound = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"plop2" ofType:@"mp3"]];
    sound1 = [[AVAudioPlayer alloc]initWithContentsOfURL:sound error:nil];
    [sound1 setVolume: 1.0];
    [sound1 prepareToPlay];
    for (int i=0; i<20; i++) {
        Svjetlo *sv = [[Svjetlo alloc]initWithPosition:CGPointMake(self.size.width/2, self.size.height/2+30)];
        [self addChild:sv];
        sv.zPosition = 1;
    }
    IzvorMjehurica *izMj = [[IzvorMjehurica alloc]initWithPosition:CGPointMake(self.size.width/6, -self.size.height/2)];
    [self addChild:izMj];
    
}

- (void)didBeginContact:(SKPhysicsContact *)contact{
    if([contact.bodyA.node.name isEqualToString:@"bubble"]){
        SKNode *node = contact.bodyA.node;
        [node removeFromParent];
        cNum++;
    } else if([contact.bodyB.node.name isEqualToString:@"bubble"]){
        SKNode *node = contact.bodyB.node;
        [node removeFromParent];
        cNum++;
    }
    [sound1 play];
    points.text = [NSString stringWithFormat:@"%d/20",cNum];
    UdarniVal *uv = [[UdarniVal alloc] initWithPosition:contact.contactPoint];
    [self addChild:uv];
    Riba *rb = [[Riba alloc]initWithPosition:contact.contactPoint];
    [self addChild:rb];
    
    
}

- (void)touchDownAtPoint:(CGPoint)pos {
    SKShapeNode *n = [_spinnyNode copy];
    n.position = pos;
    n.strokeColor = [SKColor greenColor];
    [self addChild:n];
}

- (void)touchMovedToPoint:(CGPoint)pos {
    SKShapeNode *n = [_spinnyNode copy];
    n.position = pos;
    n.strokeColor = [SKColor blueColor];
    [self addChild:n];
}

- (void)touchUpAtPoint:(CGPoint)pos {
    SKShapeNode *n = [_spinnyNode copy];
    n.position = pos;
    n.strokeColor = [SKColor purpleColor];
    [self addChild:n];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    for (UITouch *t in touches) {[self touchDownAtPoint:[t locationInNode:self]];}
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    //for (UITouch *t in touches) {[self touchMovedToPoint:[t locationInNode:self]];}
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    for (UITouch *t in touches) {[self touchUpAtPoint:[t locationInNode:self]];}
}
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    for (UITouch *t in touches) {[self touchUpAtPoint:[t locationInNode:self]];}
}


-(void)update:(CFTimeInterval)currentTime {
    // Called before each frame is rendered
}

@end
