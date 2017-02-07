//
//  udarniVal.m
//  Mjehurici3
//
//  Created by Anton Orzes on 05/02/2017.
//  Copyright © 2017 Anton Orzes. All rights reserved.
//

#import "UdarniVal.h"

@implementation UdarniVal
- (id)initWithPosition:(CGPoint)position
{
    self = [super init];
    if (self) {
        static const uint32_t maliCategory    =  0x1 << 1;
        static const uint32_t glavniCategory    =  0x1 << 2;
        self.position = position;
        self.size = CGSizeMake(10, 10);
        self.texture = [SKTexture textureWithImageNamed:@"aura0"];
        self.name = @"spinny";
        self.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:5];
        self.physicsBody.categoryBitMask = glavniCategory;
        self.physicsBody.contactTestBitMask = maliCategory;
        self.physicsBody.collisionBitMask = 0;
        self.physicsBody.affectedByGravity = NO;
        SKAction *vrti = [SKAction group:@[[SKAction rotateByAngle:M_PI_2 duration:1.5],[SKAction scaleBy:20.0 duration:1.5]]];
        SKAction *val = [SKAction sequence:@[vrti,
                                            [SKAction fadeAlphaTo:0 duration:0.5],
                                            [SKAction removeFromParent]]];
        [self runAction:val];
    }
    return self;
}
@end
