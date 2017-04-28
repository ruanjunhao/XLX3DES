//
//  XLX3DES.m
//  XLX3DES
//
//  Created by charles on 2017/4/28.
//  Copyright © 2017年 charles. All rights reserved.
//

#import "XLX3DES.h"
#import "GTMBase64.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCrypto.h>

@implementation XLX3DES

#pragma mark- 3des加密
+(NSString *)encryptWithString:(NSString *)string useKey:(NSString *)key iv:(NSString *)iv{
    return [self codeWithString:string keyString:key ivString:iv operation:kCCEncrypt];
}

#pragma mark- 3des解密
+(NSString *)decryptWithString:(NSString *)string useKey:(NSString *)key iv:(NSString *)iv{
    return [self codeWithString:string keyString:key ivString:iv operation:kCCDecrypt];
}


+(NSString *) codeWithString:(NSString*)string keyString:(NSString*)keyString ivString:(NSString*)ivString operation:(CCOperation)encryptOrDecrypt{
    const void * vString;
    size_t vStringBufferSize;
    
    if (encryptOrDecrypt== kCCDecrypt){
        NSData * EncryptData = [GTMBase64 decodeData:[string dataUsingEncoding:NSUTF8StringEncoding]];
        vStringBufferSize= [EncryptData length];
        vString = [EncryptData bytes];
    } else {
        NSData * tempData = [string dataUsingEncoding:NSUTF8StringEncoding];
        vStringBufferSize= [tempData length];
        vString = [tempData bytes];
    }
    
    CCCryptorStatus ccStatus;
    uint8_t * bufferPtr = NULL;
    size_t bufferPtrSize = 0;
    size_t movedBytes = 0;
    // uint8_t ivkCCBlockSize3DES;
    
    bufferPtrSize = (vStringBufferSize + kCCBlockSize3DES)
    &~(kCCBlockSize3DES- 1);
    
    bufferPtr = malloc(bufferPtrSize* sizeof(uint8_t));
    memset((void*)bufferPtr,0x0, bufferPtrSize);
    
    const void * vKey = (const void *)[keyString UTF8String];
    const void * vIv = (const void *)[ivString UTF8String];
    
    uint8_t iv[kCCBlockSize3DES];
    memset((void*) iv,0x0, (size_t)sizeof(iv));
    
    ccStatus = CCCrypt(encryptOrDecrypt,
                       kCCAlgorithm3DES,
                       kCCOptionPKCS7Padding,
                       vKey,//key
                       kCCKeySize3DES,
                       vIv,//iv,
                       vString,//string,
                       vStringBufferSize,
                       (void*)bufferPtr,
                       bufferPtrSize,
                       &movedBytes);
    
    if (ccStatus== kCCParamError) return @"PARAM ERROR";
    else if (ccStatus == kCCBufferTooSmall) return @"BUFFER TOO SMALL";
    else if (ccStatus == kCCMemoryFailure) return @"MEMORY FAILURE";
    else if (ccStatus == kCCAlignmentError) return @"ALIGNMENT ERROR";
    else if (ccStatus == kCCDecodeError) return @"DECODE ERROR";
    else if (ccStatus == kCCUnimplemented) return @"UNIMPLEMENTED";
    else if (ccStatus == kCCOverflow) return @"OVERFLOW";
    else if (ccStatus == kCCRNGFailure) return @"RNG FAILURE";
    else if (ccStatus == kCCUnspecifiedError) return @"UNSPECIFIED ERROR";
    else if (ccStatus == kCCCallSequenceError) return @"CALL SEQUENCE ERROR";
    
    NSString * result;
    
    if (encryptOrDecrypt== kCCDecrypt) {
        result = [[NSString alloc] initWithData:[NSData dataWithBytes:(const void *)bufferPtr length:(NSUInteger)movedBytes] encoding:NSUTF8StringEncoding];
    } else {
        NSData * myData =[NSData dataWithBytes:(const void *)bufferPtr length:(NSUInteger)movedBytes];
        result = [GTMBase64 stringByEncodingData:myData];
    }
    return result;
}

@end
