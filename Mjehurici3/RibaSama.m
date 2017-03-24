//
//  RibaSama.m
//  Mjehurici3
//
//  Created by Anton Orzes on 21/03/2017.
//  Copyright © 2017 Anton Orzes. All rights reserved.
//

#import "RibaSama.h"

@implementation RibaSama
- (id)initWithSceneSize:(CGSize)size {
    self = [super init];
    if (self) {
        self.position = CGPointMake(size.width/2-50, -size.height/3+arc4random_uniform(size.height/3));
        self.size = CGSizeMake(70, 70);
        self.texture = [SKTexture textureWithImageNamed:@"riba"];
        SKAction *mashiL = [SKAction repeatAction:
                            [SKAction animateWithTextures:
                            [NSArray arrayWithObjects:
                             [SKTexture textureWithImageNamed:@"riba0"],
                             [SKTexture textureWithImageNamed:@"riba1"],
                             [SKTexture textureWithImageNamed:@"riba2"],
                             [SKTexture textureWithImageNamed:@"riba3"],
                             [SKTexture textureWithImageNamed:@"riba2"],
                             [SKTexture textureWithImageNamed:@"riba1"],nil] timePerFrame:0.1]
                            count:6];
        SKAction *plivajL = [SKAction moveTo:CGPointMake(-size.width/2+50, self.position.y) duration:3.6];
        SKAction *okreniR = [SKAction animateWithTextures:
                             [NSArray arrayWithObjects:
                              [SKTexture textureWithImageNamed:@"riba4"],
                              [SKTexture textureWithImageNamed:@"riba5"],
                              [SKTexture textureWithImageNamed:@"riba6"],
                              [SKTexture textureWithImageNamed:@"riba7"],nil] timePerFrame:0.2];
        
        SKAction *mashiR =  [SKAction repeatAction:
                            [SKAction animateWithTextures:
                             [NSArray arrayWithObjects:
                              [SKTexture textureWithImageNamed:@"riba8"],
                              [SKTexture textureWithImageNamed:@"riba9"],
                              [SKTexture textureWithImageNamed:@"riba10"],
                              [SKTexture textureWithImageNamed:@"riba11"],
                              [SKTexture textureWithImageNamed:@"riba10"],
                              [SKTexture textureWithImageNamed:@"riba9"],nil] timePerFrame:0.1]
                             count:6];
        SKAction *plivajR = [SKAction moveTo:CGPointMake(size.width/2-50, self.position.y) duration:3.6];
        SKAction *okreniL = [SKAction animateWithTextures:
                             [NSArray arrayWithObjects:
                              [SKTexture textureWithImageNamed:@"riba7"],
                              [SKTexture textureWithImageNamed:@"riba6"],
                              [SKTexture textureWithImageNamed:@"riba5"],
                              [SKTexture textureWithImageNamed:@"riba4"],nil] timePerFrame:0.2];
        SKAction *groupL = [SKAction group:@[mashiL,plivajL]];
        SKAction *groupR = [SKAction group:@[mashiR,plivajR]];
        SKAction *plivaj = [SKAction repeatActionForever:[SKAction sequence:@[groupL,okreniR, groupR,okreniL]]];
        [self runAction:plivaj];
    }
    return self;
}

@end
