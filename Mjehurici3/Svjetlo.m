//
//  Svjetlo.m
//  DeepSea
//
//  Created by Anton Orzes on 27/01/2017.
//  Copyright © 2017 Anton Orzes. All rights reserved.
//

#import "Svjetlo.h"

@implementation Svjetlo
- (id)initWithPosition:(CGPoint)position
{
    self = [super init];
    if (self) {
        self.position = CGPointMake(0, position.y+50);
        self.size = CGSizeMake(25, position.y*1.3);
        self.anchorPoint = CGPointMake(0.5, 1.0);
        self.texture = [SKTexture textureWithImageNamed: @"zrakaSvjetla"];
        self.alpha = 0.1;
        double angle = M_PI/(arc4random_uniform(50)+15);
        double move = 130;
        double duration = (arc4random_uniform(80)+20.0)/10.0;
        //double duration = 5;
        SKAction *lightRight = [SKAction group:@[[SKAction rotateToAngle:angle duration:duration],
                                                 [SKAction scaleXTo:0.2 duration:duration/3.0],
                                                 [SKAction moveBy:CGVectorMake(move, 0) duration:duration/2.0]]];
        SKAction *lightLeft = [SKAction group:@[[SKAction rotateToAngle:-angle*2.0 duration:duration],
                                                [SKAction scaleXTo:1.0 duration:duration/3.0],
                                                [SKAction moveBy:CGVectorMake(-move, 0) duration:duration/2.0]]];
        SKAction *lightAnimation = [SKAction repeatActionForever:[SKAction sequence:@[lightRight,lightLeft]]];
        [self runAction:lightAnimation];
    }
    return self;
}
@end
