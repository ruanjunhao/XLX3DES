//
//  XLX3DES.h
//  XLX3DES
//
//  Created by charles on 2017/4/28.
//  Copyright © 2017年 charles. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XLX3DES : NSObject

/**
 *  3des加密
 *
 *  @param string 待加密的string
 *  @param key     约定的密钥
 *  @param iv      约定的密钥
 *
 *  @return 3des加密后的string
 */
+ (NSString*)encryptWithString:(NSString*)string useKey:(NSString*)key iv:(NSString*)iv;

/**
 *  3des解密
 *
 *  @param string 待解密的string
 *  @param key     约定的密钥
 *  @param iv      约定的密钥
 *
 *  @return 3des解密后的string
 */
+ (NSString*)decryptWithString:(NSString*)string useKey:(NSString*)key iv:(NSString*)iv;

@end
