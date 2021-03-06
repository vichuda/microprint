//
//  TFDecimal3DPoint.m
//  MicroPrint
//
//

#import "TFP3DVector.h"
#import "TFPExtras.h"


@interface TFP3DVector ()
@property (readwrite) NSNumber *x;
@property (readwrite) NSNumber *y;
@property (readwrite) NSNumber *z;
@end


@implementation TFP3DVector


- (instancetype)initWithX:(NSNumber*)X Y:(NSNumber*)Y Z:(NSNumber*)Z {
	if(!(self = [super init])) return nil;
	
	self.x = X;
	self.y = Y;
	self.z = Z;
	
	return self;
}


+ (instancetype)vectorWithX:(NSNumber*)X Y:(NSNumber*)Y Z:(NSNumber*)Z {
	return [[self alloc] initWithX:X Y:Y Z:Z];
}


+ (instancetype)emptyVector {
	return [self vectorWithX:nil Y:nil Z:nil];
}


+ (instancetype)zeroVector {
	return [self vectorWithX:@0 Y:@0 Z:@0];
}


+ (instancetype)zVector:(double)z {
	return [self vectorWithX:nil Y:nil Z:@(z)];
}


+ (instancetype)xVector:(double)x {
	return [self vectorWithX:@(x) Y:nil Z:nil];
}


+ (instancetype)yVector:(double)y {
	return [self vectorWithX:nil Y:@(y) Z:nil];
}


+ (instancetype)xyVectorWithX:(double)x y:(double)y {
	return [self vectorWithX:@(x) Y:@(y) Z:nil];
}


+ (instancetype)vectorWithPosition:(TFPAbsolutePosition)position {
	return [[self alloc] initWithX:isnan(position.x) ? nil : @(position.x)
								 Y:isnan(position.y) ? nil : @(position.y)
								 Z:isnan(position.z) ? nil : @(position.z)];
}


- (NSString *)description {
	return [NSString stringWithFormat:@"[%@  %@  %@]", self.x ?: @"nil", self.y ?: @"nil", self.z ?: @"nil"];
}


- (TFP3DVector*)vectorByDefaultingToValues:(TFP3DVector*)defaults {
	return [TFP3DVector vectorWithX:(self.x ?: defaults.x) Y:(self.y ?: defaults.y) Z:(self.z ?: defaults.z)];
}


- (TFP3DVector*)vectorByAdjustingZ:(double)delta {
	return [TFP3DVector vectorWithX:self.x Y:self.y Z:self.z ? @(self.z.doubleValue + delta) : nil];
}


- (double)distanceToPoint:(TFP3DVector*)point {
	point = [point vectorByDefaultingToValues:self];
	
	return sqrt(pow(point.x.doubleValue - self.x.doubleValue, 2) + pow(point.y.doubleValue - self.y.doubleValue, 2) + pow(point.z.doubleValue - self.z.doubleValue, 2));
}


- (TFP3DVector*)vectorWithFieldsPresentInVector:(TFP3DVector*)otherVector {
	return [TFP3DVector vectorWithX:(otherVector.x ? self.x : nil)
								  Y:(otherVector.y ? self.y : nil)
								  Z:(otherVector.z ? self.z : nil)
			];
}


- (TFP3DVector*)vectorByAdding:(TFP3DVector*)vector {
	return [TFP3DVector vectorWithX:(self.x ? @(self.x.doubleValue + vector.x.doubleValue) : nil)
								  Y:(self.y ? @(self.y.doubleValue + vector.y.doubleValue) : nil)
								  Z:(self.z ? @(self.z.doubleValue + vector.z.doubleValue) : nil)
			];
}


- (TFP3DVector*)vectorBySubtracting:(TFP3DVector*)vector {
	return [TFP3DVector vectorWithX:(self.x ? @(self.x.doubleValue - vector.x.doubleValue) : nil)
								  Y:(self.y ? @(self.y.doubleValue - vector.y.doubleValue) : nil)
								  Z:(self.z ? @(self.z.doubleValue - vector.z.doubleValue) : nil)
			];
}


- (TFP3DVector*)vectorByDividingBy:(TFP3DVector*)vector {
	return [TFP3DVector vectorWithX:(self.x ? @(self.x.doubleValue / vector.x.doubleValue) : nil)
								  Y:(self.y ? @(self.y.doubleValue / vector.y.doubleValue) : nil)
								  Z:(self.z ? @(self.z.doubleValue / vector.z.doubleValue) : nil)
			];
}


- (TFP3DVector*)vectorByMultiplyingBy:(TFP3DVector*)vector {
	return [TFP3DVector vectorWithX:(self.x ? @(self.x.doubleValue * vector.x.doubleValue) : nil)
								  Y:(self.y ? @(self.y.doubleValue * vector.y.doubleValue) : nil)
								  Z:(self.z ? @(self.z.doubleValue * vector.z.doubleValue) : nil)
			];
}


- (TFP3DVector*)absoluteVector {
	return [TFP3DVector vectorWithX:(self.x ? @(fabs(self.x.doubleValue)) : nil)
								  Y:(self.y ? @(fabs(self.y.doubleValue)) : nil)
								  Z:(self.z ? @(fabs(self.z.doubleValue)) : nil)
			];
}


- (TFP3DVector*)vectorByMultiplyingByScalar:(double)value {
	return [self vectorByMultiplyingBy:[TFP3DVector vectorWithX:@(value) Y:@(value) Z:@(value)]];
}


- (TFP3DVector*)vectorByDividingByScalar:(double)value {
	return [self vectorByDividingBy:[TFP3DVector vectorWithX:@(value) Y:@(value) Z:@(value)]];
}


- (TFP3DVector*)vectorBySettingX:(double)x {
	return [self.class vectorWithX:@(x) Y:self.y Z:self.z];
}


- (TFP3DVector*)vectorBySettingY:(double)y {
	return [self.class vectorWithX:self.x Y:@(y) Z:self.z];
}


- (TFP3DVector*)vectorBySettingZ:(double)z {
	return [self.class vectorWithX:self.x Y:self.y Z:@(z)];
}


- (TFP3DVector*)vectorBySettingY:(double)y z:(double)z {
	return [self.class vectorWithX:self.x Y:@(y) Z:@(z)];
}


@end