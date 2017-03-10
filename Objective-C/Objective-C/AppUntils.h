//
//  AppUntils.h
//  Objective-C
//
//  Created by QianTuFD on 2017/3/3.
//  Copyright © 2017年 fandy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppUntils : NSObject

+ (void)saveUUIDToKeyChain;
+ (NSString *)readUUIDFromKeyChain;

@end
