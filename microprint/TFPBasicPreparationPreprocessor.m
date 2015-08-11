//
//  TFPBasicPreparationPreprocessor.m
//  MicroPrint
//
//  Created by Tomas Franzén on Mon 2015-06-22.
//

#import "TFPBasicPreparationPreprocessor.h"
#import "TFPGCode.h"
#import "TFPExtras.h"
#import "TFPGCodeHelpers.h"


@implementation TFPBasicPreparationPreprocessor


- (TFPGCodeProgram*)processUsingParameters:(TFPPrintParameters*)parameters {
	NSArray *preamble =
	@[
	  [TFPGCode codeForSettingFanSpeed:parameters.filament.fanSpeed],
	  [TFPGCode codeForHeaterTemperature:parameters.idealTemperature waitUntilDone:NO],
	  
	  [TFPGCode absoluteModeCode],
	  [TFPGCode moveWithPosition:[TFP3DVector zVector:5] feedRate:2900],
	  [TFPGCode moveHomeCode],
	  [TFPGCode codeForHeaterTemperature:parameters.idealTemperature waitUntilDone:YES],
	  
	  [TFPGCode relativeModeCode],
	  [TFPGCode codeForExtrusion:2 feedRate:2000],
	  [TFPGCode resetExtrusionCode],
	  [TFPGCode absoluteModeCode],
	  [TFPGCode codeForSettingFeedRate:2400],
	];
	
	double raiseHeight;
	double maxZ = parameters.boundingBox.z + parameters.boundingBox.zSize;
	if(maxZ >= 110) {
		raiseHeight = 0;
	}else if(maxZ >= 25) {
		raiseHeight = 3;
	}else{
		raiseHeight = 25 + 3 - maxZ;
	}
	
	TFP3DVector *backPosition = (maxZ > 60) ? [TFP3DVector xyVectorWithX:90 y:84] : [TFP3DVector xyVectorWithX:95 y:95];
	
	NSArray *postamble =
	@[
	  [TFPGCode codeWithComment:@"POSTAMBLE"],
	  [TFPGCode codeForTurningOffHeater],

	  [TFPGCode relativeModeCode],
	  [TFPGCode moveWithPosition:[TFP3DVector vectorWithX:@5 Y:@5 Z:@(raiseHeight)] feedRate:2000],
	  [TFPGCode absoluteModeCode],
	  [TFPGCode moveWithPosition:backPosition feedRate:-1],
	  
	  [TFPGCode turnOffFanCode],
	  [TFPGCode turnOffMotorsCode],
	  [TFPGCode codeWithComment:@"END"],
	  ];
	
	
	BOOL(^setsTemperatureOrFanSpeed)(TFPGCode*) = ^BOOL(TFPGCode *line) {
		NSInteger M = [line valueForField:'M' fallback:-1];
		return (M == 104 || M == 106 || M == 107 || M == 109);
	};
	
	
	NSMutableArray *output = [NSMutableArray new];
	[output addObjectsFromArray:preamble];
	[output addObjectsFromArray:[self.program.lines tf_rejectWithBlock:setsTemperatureOrFanSpeed]];
	[output addObjectsFromArray:postamble];
	
	return [[TFPGCodeProgram alloc] initWithLines:output];
}


@end
