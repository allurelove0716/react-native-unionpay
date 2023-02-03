//
//  SecurityUtils.m
//
//  Created by xxw on 14-4-15.
//  Copyright (c) 2014年 ChinaUMS. All rights reserved.
//

#import "SecurityUtils.h"
#import "CommonCrypto/CommonDigest.h"

#import "md5.h"
#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#import "rsa.h"
#import "sha1.h"
#import "pk.h"
#import "entropy.h"
#import "ctr_drbg.h"
#import "des.h"
#import "config.h"

#import <sys/socket.h>
#import <sys/socket.h>
#import <arpa/inet.h>
#import <netdb.h>
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>

#include <ifaddrs.h>
#import <dlfcn.h>
#import <SystemConfiguration/SystemConfiguration.h>

static const char encodingTable[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";

@implementation SecurityUtils

+(NSString *)RSASign:(NSString *)pemFilePath Content:(NSData *)content
{
    int ret = 1;
    rsa_context *rsa;
    pk_context key;
    unsigned char hash[20];
    unsigned char buf[POLARSSL_MPI_MAX_SIZE];
    
    pk_init( &key );
    ret = pk_parse_keyfile( &key, [pemFilePath UTF8String], NULL );
    
    rsa = pk_rsa( key );
    if( ret != 0 )
    {
        return nil;
    }
    
    if( ( ret = rsa_check_privkey( rsa ) ) != 0 )
    {
        return nil;
    }

    sha1([content bytes], [content length], hash);
    
    if( ( ret = rsa_pkcs1_sign( rsa, NULL, NULL, RSA_PRIVATE, POLARSSL_MD_SHA1,
                               20, hash, buf ) ) != 0 )
    {
        return nil;
    }
    
    pk_free( &key );
    
    NSData *signedData = [NSData dataWithBytes:buf length:128];

    return [SecurityUtils dataWithBase64Encoding:signedData];
}

+ (NSString *)RSASignWithPrivateKey:(NSString *)privateKey originString:(NSString *)originString {
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path = [documentPath stringByAppendingPathComponent:@"UMSPAY-RSAPrivateKey"];
    
    //把密钥写入文件
    NSString *formatKey = [SecurityUtils formatPrivateKey:privateKey];
    [formatKey writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:nil];
    
    NSString *signStr = [SecurityUtils RSASign:path Content:[originString dataUsingEncoding:NSUTF8StringEncoding]];
    
    return signStr;
}

//rsa签名，私钥格式化
+ (NSString *)formatPrivateKey:(NSString *)privateKey {
    const char *pstr = [privateKey UTF8String];
    int len = (int)[privateKey length];
    NSMutableString *result = [NSMutableString string];
    [result appendString:@"-----BEGIN PRIVATE KEY-----\n"];
    int index = 0;
    int count = 0;
    while (index < len) {
        char ch = pstr[index];
        if (ch == '\r' || ch == '\n') {
            ++index;
            continue;
        }
        [result appendFormat:@"%c", ch];
        if (++count == 79)
        {
            [result appendString:@"\n"];
            count = 0;
        }
        index++;
    }
    [result appendString:@"\n-----END PRIVATE KEY-----"];
    return result;
}

+ (NSString *)dataWithBase64Encoding:(NSData *)originData;
{
    if ([originData length] == 0)
        return @"";
    
    char *characters = malloc((([originData length] + 2) / 3) * 4);
    if (characters == NULL)
        return nil;
    NSUInteger length = 0;
    
    NSUInteger i = 0;
    while (i < [originData length])
    {
        char buffer[3] = {0,0,0};
        short bufferLength = 0;
        while (bufferLength < 3 && i < [originData length])
            buffer[bufferLength++] = ((char *)[originData bytes])[i++];
        
        //  Encode the bytes in the buffer to four characters, including padding "=" characters if necessary.
        characters[length++] = encodingTable[(buffer[0] & 0xFC) >> 2];
        characters[length++] = encodingTable[((buffer[0] & 0x03) << 4) | ((buffer[1] & 0xF0) >> 4)];
        if (bufferLength > 1)
            characters[length++] = encodingTable[((buffer[1] & 0x0F) << 2) | ((buffer[2] & 0xC0) >> 6)];
        else characters[length++] = '=';
        if (bufferLength > 2)
            characters[length++] = encodingTable[buffer[2] & 0x3F];
        else characters[length++] = '=';
    }
    
    return [[NSString alloc] initWithBytesNoCopy:characters length:length encoding:NSASCIIStringEncoding freeWhenDone:YES];
}

@end
