//
//  TFPGCodeDocument.h
//  microprint
//
//  Created by Tomas Franzén on Mon 2015-07-13.
//  Copyright (c) 2015 Tomas Franzén. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@class TFPGCodeProgram;

@interface TFPGCodeDocument : NSDocument
@property TFPGCodeProgram *program;
@end