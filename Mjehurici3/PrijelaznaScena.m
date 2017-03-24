//
//  PrijelaznaScena.m
//  Mjehurici3
//
//  Created by Anton Orzes on 17/03/2017.
//  Copyright © 2017 Anton Orzes. All rights reserved.
//

#import "PrijelaznaScena.h"
#import "GameScene.h"
#import "Svjetlo.h"
#import "IzvorMjehurica.h"
#import "RibaSama.h"



@implementation PrijelaznaScena{
    
    int level;
    AVAudioPlayer *sound1;
    
}

- (void)didMoveToView:(SKView *)view {
    SKSpriteNode *podloga = [SKSpriteNode spriteNodeWithImageNamed:@"podmorje0"];
    podloga.size = self.size;
    podloga.zPosition = 1;
    [self addChild:podloga];
    for (int i=0; i<20; i++) {
        Svjetlo *sv = [[Svjetlo alloc]initWithPosition:CGPointMake(self.size.width/2, self.size.height/2+30)];
        [self addChild:sv];
        sv.zPosition = 1;
    }
    IzvorMjehurica *izMj = [[IzvorMjehurica alloc]initWithPosition:
                            CGPointMake(self.size.width/4-arc4random_uniform(self.size.width/2), -self.size.height/2)];
    [self addChild:izMj];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *osv = [defaults stringForKey:@"level"];
    level = [osv intValue];
    [self addText:[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.3] position:CGPointMake(5, -5)];
    [self addText:[UIColor colorWithRed:0.5 green:1.0 blue:1.0 alpha:1.0] position:CGPointMake(0, 0)];
    RibaSama *riba = [[RibaSama alloc]initWithSceneSize:self.size];
    riba.zPosition = 3;
    [self addChild:riba];
    
}

-(void)addText:(UIColor *)color position:(CGPoint)pos {
    SKLabelNode *tekst = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    tekst.text = [NSString stringWithFormat:@"level: %d",level+1];
    tekst.fontSize = 75;
    tekst.fontColor = color;
    tekst.position = pos;
    tekst.zPosition = 2;
    [self addChild:tekst];

}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    SKScene *gameS = [[GameScene alloc]initWithSize:self.size];
    gameS.scaleMode = SKSceneScaleModeAspectFill;
    gameS.anchorPoint = CGPointMake(0.5, 0.5);
    SKTransition *menuTranzicija = [SKTransition pushWithDirection:SKTransitionDirectionLeft duration:0.3];
    [self.view presentScene:gameS transition:menuTranzicija];
    
}


@end
