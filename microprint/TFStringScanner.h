#import <Foundation/Foundation.h>

typedef enum {
	TFTokenTypeIdentifier,
	TFTokenTypeNumeric,
	TFTokenTypeSymbol,
} TFTokenType;


@interface TFStringScanner : NSObject

@property (readonly, copy, nonatomic) NSString *string;
@property (nonatomic) NSUInteger location;
@property (readonly, getter=isAtEnd, nonatomic) BOOL atEnd;
@property (readonly, nonatomic) TFTokenType lastTokenType;

+ (id)scannerWithString:(NSString*)string;
- (id)initWithString:(NSString*)string;

- (void)addMulticharacterSymbol:(NSString*)symbol;
- (void)addMulticharacterSymbols:(NSString*)symbol, ...;
- (void)removeMulticharacterSymbol:(NSString*)symbol;

- (unichar)scanCharacter;
- (NSString*)scanForLength:(NSUInteger)length;
- (NSString*)scanStringFromCharacterSet:(NSCharacterSet*)set;

- (BOOL)scanString:(NSString*)substring;
- (NSString*)scanToString:(NSString*)substring;
- (BOOL)scanWhitespace;
- (NSString*)scanToEnd;

- (NSString*)scanToken;
- (BOOL)scanToken:(NSString*)matchToken;
- (NSString*)peekToken;

@end