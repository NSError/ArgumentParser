//
//  spiffy.m
//  FSArgumentParser
//
//  Created by Christopher Miller on 2/28/12.
//  Copyright (c) 2012, 2013 Christopher Miller. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FSArguments.h"

#include <stdio.h>

int main (int argc, const char * argv[]) {
    @autoreleasepool {
        FSArgumentSignature
            * helpSig = [FSArgumentSignature argumentSignatureWithFormat:@"[-h --help]"],
            * ifSig = [FSArgumentSignature argumentSignatureWithFormat:@"[-i --if]="],
            * ofSig = [FSArgumentSignature argumentSignatureWithFormat:@"[-o --of]="];
        NSArray * signatures = @[helpSig, ifSig, ofSig];

        FSArgumentPackage * arguments = [[NSProcessInfo processInfo] fsargs_parseArgumentsWithSignatures:signatures];

        bool print_help = false;
        
        if ([arguments booleanValueForSignature:helpSig]) {
            print_help = true;
        } else {
            printf("  Input File: %s\n", [[[arguments firstObjectForSignature:ifSig] description] UTF8String]);
            printf("  OutputFile: %s\n", [[[arguments firstObjectForSignature:ofSig] description] UTF8String]);
        }
        
        if (print_help) {
            printf("Example program:\n");
            printf("  %s Input file\n", [[ifSig descriptionForHelp:2 terminalWidth:80] UTF8String]);
            printf("  %s Output file\n", [[ofSig descriptionForHelp:2 terminalWidth:80] UTF8String]);
        }

    }
    return 0;
}
