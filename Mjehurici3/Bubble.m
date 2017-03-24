//
//  Bubble.m
//  Mjehurici3
//
//  Created by Anton Orzes on 05/02/2017.
//  Copyright © 2017 Anton Orzes. All rights reserved.
//

#import "Bubble.h"

@implementation Bubble

- (id)initWithPosition:(CGPoint)position size:(float)size
{
    self = [super init];
    if (self) {
        CGFloat w = size*5;
        //CGSize s = self.parent.scene.size;
        static const uint32_t maliCategory    =  0x1 << 1;
        static const uint32_t glavniCategory    =  0x1 << 2;
        self.position = position;
        self.size = CGSizeMake(size, size);
        self.zPosition = 2;
        self.texture = [SKTexture textureWithImageNamed:@"ribaUmj"];
        self.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:size/2];
        self.physicsBody.categoryBitMask = maliCategory;
        self.physicsBody.contactTestBitMask = glavniCategory;
        self.physicsBody.collisionBitMask = 0;
        self.physicsBody.affectedByGravity = NO;
        self.name = @"bubble";
        CGFloat goreX = w*2.0 - arc4random_uniform(w*4.0);
        CGFloat goreY = w*3.0 - arc4random_uniform(w*6.0);
        float time = sqrt( powf(goreX,2.0) + powf(goreY,2.0))/35;
        CGVector gore = CGVectorMake(goreX, goreY);
        CGVector dolje = CGVectorMake(-goreX, -goreY);
        SKAction *goreDolje = [SKAction moveBy:gore duration:time];
        SKAction *doljeGore = [SKAction moveBy:dolje duration:time];
        [self runAction:[SKAction repeatActionForever:[SKAction sequence:@[goreDolje,doljeGore]]]];

    }
    return self;
}

@end
