//
//  Mjehuric.m
//  DeepSea
//
//  Created by Anton Orzes on 22/01/2017.
//  Copyright © 2017 Anton Orzes. All rights reserved.
//

#import "Mjehuric.h"
@interface Mjehuric()
{
    NSTimer *timer;
    float a,oldX;
}
@end
@implementation Mjehuric
- (id)initWithPosition:(CGPoint)position {
    self = [super init];
    if (self) {
        self.texture = [SKTexture textureWithImageNamed:@"mjehuric"];
        float size = arc4random_uniform(8)+2;
        float veloc = arc4random_uniform(25)/8+1;
        self.size = CGSizeMake(size, size);
        self.position = position;
        oldX = position.x;
        a = 0;
        timer = [NSTimer scheduledTimerWithTimeInterval:0.02
                                                 target:self
                                               selector:@selector(moveBubble:)
                                               userInfo:[NSNumber numberWithFloat:veloc]
                                                repeats:YES];
    }
    return self;
}

- (void)moveBubble:(NSTimer *)velocity {
    a += 0.1;
    CGPoint position = self.position;
    position.y += [velocity.userInfo floatValue];
    position.x = oldX + sin(a)*10;
    self.position = position;
    if (position.y>self.parent.scene.size.height) {
        [timer invalidate];
        timer = nil;
        [self removeFromParent];
    }
}

@end
