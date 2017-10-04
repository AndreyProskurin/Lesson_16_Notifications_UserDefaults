//
//  HeaderView.m
//  Lesson_16
//
//  Created by Andrey Proskurin on 03.10.17.
//  Copyright © 2017 Andrey Proskurin. All rights reserved.
//

#import "HeaderView.h"

@implementation HeaderView

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSArray *array = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self.class)
                                                       owner:self
                                                     options:nil];
        UIView *nibView = [array firstObject];
        [self addSubview:nibView];
        
        NSString *str = [[NSUserDefaults standardUserDefaults] objectForKey:@"Key1"];
        NSLog(@"%@", str);
    }
    return self;
}

@end
