//
//  TFPZeroBedOperation.h
//  microprint
//
//  Created by William Waggoner on 7/29/15.
//  Copyright (c) 2015 Tomas Franzén. All rights reserved.
//

#import "TFPOperation.h"

@interface TFPZeroBedOperation : TFPOperation
@property (copy) void(^prepStartedBlock)();
@property (copy) void(^zeroStartedBlock)();
@property (copy) void(^didStopBlock)();

- (void)start;
- (void)stop;

@end
