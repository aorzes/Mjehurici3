//
//  Riba.m
//  Mjehurici3
//
//  Created by Anton Orzes on 05/02/2017.
//  Copyright © 2017 Anton Orzes. All rights reserved.
//

#import "Riba.h"

@implementation Riba
- (id)initWithPosition:(CGPoint)position
{
    self = [super init];
    if (self) {
        self.position = position;
        self.size = CGSizeMake(50, 50);
        self.texture = [SKTexture textureWithImageNamed:@"riba"];
        SKAction *bjezi = [SKAction sequence:@[[SKAction moveTo:CGPointMake(-400, position.y) duration:3],
                                                 [SKAction removeFromParent]]];
        SKAction *mashi = [SKAction repeatActionForever:
                           [SKAction animateWithTextures:
                            [NSArray arrayWithObjects:
                             [SKTexture textureWithImageNamed:@"riba1"],
                             [SKTexture textureWithImageNamed:@"riba2"],
                             [SKTexture textureWithImageNamed:@"riba3"],
                             [SKTexture textureWithImageNamed:@"riba2"],nil] timePerFrame:0.1]];
        
        [self runAction:[SKAction group:@[bjezi,mashi]]];
    }
    return self;
}
@end
