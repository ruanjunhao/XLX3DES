//
//  main.m
//  XLX3DES
//
//  Created by charles on 2017/4/28.
//  Copyright © 2017年 charles. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XLX3DES.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSString *beMakeString = @"charles";
        
        NSString *encrypptString = [XLX3DES encryptWithString:beMakeString useKey:@"demo" iv:nil];
        NSString *decryptString = [XLX3DES decryptWithString:encrypptString useKey:@"demo" iv:nil];
        
        NSLog(@"3des加密:%@",encrypptString);
        NSLog(@"3des解密:%@",decryptString);
    }
    return 0;
}
