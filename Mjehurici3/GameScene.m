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
#import "PrijelaznaScena.h"

@implementation GameScene {
    
    SKLabelNode *needPoints;
    SKLabelNode *accomplis;
    
    int needed;
    int complite;
    int total;
    int kraj;
    int tapNum;
    int level;
    NSArray *numNeed;
    AVAudioPlayer *sound1;
    NSTimer *timer;
    SKAction *pulse;
}

-(void)saveLevel {
    if(level<numNeed.count/2-1) {level++;}
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    [defaults setInteger: level forKey:@"level"];
    [defaults synchronize];
}

- (void)didMoveToView:(SKView *)view {
    // Setup your scene here
    complite = 0;
    needed = 2;
    total = 5;
    kraj = 0;
    tapNum = 0;
    numNeed = @[@2,@5, @6,@9, @8,@15, @9,@16, @12,@20, @16,@21, @18,@25, @21,@30, @26,@35, @31,@40, @35,@41,
                @30,@35, @25,@30, @22,@28 ];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *osv = [defaults stringForKey:@"level"];
    level = [osv intValue];
    
    needed = [[numNeed objectAtIndex:level*2]intValue];
    total = [[numNeed objectAtIndex:level*2+1]intValue];
    self.view.multipleTouchEnabled = NO;
    self.physicsWorld.contactDelegate = self;
    
//    CGFloat w = (self.size.width + self.size.height) * 0.05;
    NSString *imageName = [NSString stringWithFormat:@"podmorje%d",level%10+1];
    SKSpriteNode *podloga = [SKSpriteNode spriteNodeWithImageNamed:imageName];
    podloga.size = self.size;
    podloga.zPosition = 0;
    [self addChild:podloga];
    
    
    for (int i=0; i<total; i++) {
        CGPoint poz = CGPointMake(self.size.width/4 - arc4random_uniform(self.size.width)*0.5,
                                  self.size.height/4 - arc4random_uniform(self.size.height)*0.5);
        Bubble *bu = [[Bubble alloc] initWithPosition:poz size:70];
        [self addChild:bu];
    }
    
    needPoints = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    needPoints.text = [NSString stringWithFormat:@"level:%d, %d/%d",level+1,needed,total];
    needPoints.fontSize = 45;
    //needPoints.fontColor = [UIColor colorWithRed:0.0 green:1.0 blue:1.0 alpha:1.0];
    needPoints.fontColor = [UIColor whiteColor];
    needPoints.position = CGPointMake(self.frame.size.width/2-190,self.frame.size.height/2-100);
    [self addChild:needPoints];
    accomplis = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    accomplis.text = [NSString stringWithFormat:@"%d/%d",needed,total];
    accomplis.fontSize = 65;
    //accomplis.fontColor = [UIColor colorWithRed:0.0 green:1.0 blue:1.0 alpha:1.0];
    accomplis.fontColor = [UIColor whiteColor];
    accomplis.position = CGPointMake(-self.frame.size.width/2+120,-self.frame.size.height/2+100);
    [self addChild:accomplis];
    
    NSURL *sound = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"plop2" ofType:@"mp3"]];
    sound1 = [[AVAudioPlayer alloc]initWithContentsOfURL:sound error:nil];
    [sound1 setVolume: 1.0];
    [sound1 prepareToPlay];
    for (int i=0; i<20; i++) {
        Svjetlo *sv = [[Svjetlo alloc]initWithPosition:CGPointMake(self.size.width/2, self.size.height/2+30)];
        [self addChild:sv];
        sv.zPosition = 1;
    }
    IzvorMjehurica *izMj = [[IzvorMjehurica alloc]initWithPosition:
                            CGPointMake(self.size.width/4-arc4random_uniform(self.size.width/2), -self.size.height/2)];
    //[self addChild:izMj];
    SKAction *pov = [SKAction scaleTo:1.6 duration:0.2];
    SKAction *sma = [SKAction scaleTo:1.0 duration:0.2];
    pulse = [SKAction sequence:@[pov, sma]];
    
}

- (void)didBeginContact:(SKPhysicsContact *)contact {
    if([contact.bodyA.node.name isEqualToString:@"bubble"]){
        SKNode *node = contact.bodyA.node;
        [node removeFromParent];
        complite++;
    } else if([contact.bodyB.node.name isEqualToString:@"bubble"]){
        SKNode *node = contact.bodyB.node;
        [node removeFromParent];
        complite++;
    }
    [sound1 play];
    accomplis.text = [NSString stringWithFormat:@"%d/%d",complite,needed];
    [accomplis runAction:pulse];
    UdarniVal *uv = [[UdarniVal alloc] initWithPosition:contact.contactPoint];
    [self addChild:uv];
    Riba *rb = [[Riba alloc]initWithPosition:contact.contactPoint];
    [self addChild:rb];
    kraj = 0;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if (tapNum == 0) {
        tapNum++;
        for (UITouch *t in touches) {
            UdarniVal *uv = [[UdarniVal alloc] initWithPosition:[t locationInNode:self]];
            [self addChild:uv];
            timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(jeliKraj) userInfo:nil repeats:YES];
        }
    }
}

- (void)jeliKraj {
    kraj++;
    if (kraj==5 && tapNum>0){
        if (complite >= needed) {
            [self saveLevel];
        }
        SKScene *prijelaznaS = [[PrijelaznaScena alloc]initWithSize:self.size];
        prijelaznaS.scaleMode = SKSceneScaleModeAspectFill;
        prijelaznaS.anchorPoint = CGPointMake(0.5, 0.5);
        [timer invalidate];
        timer = nil;
        SKTransition *tranzicija = [SKTransition crossFadeWithDuration:0.5];
        [self.view presentScene:prijelaznaS transition:tranzicija];
    }
}

@end
