//
//  AKLine.m
//  AudioKit
//
//  Auto-generated on 2/18/15.
//  Copyright (c) 2015 Aurelius Prochazka. All rights reserved.
//
//  Implementation of Csound's line:
//  http://www.csounds.com/manual/html/line.html
//

#import "AKLine.h"
#import "AKManager.h"

@implementation AKLine

- (instancetype)initWithFirstPoint:(AKConstant *)firstPoint
                       secondPoint:(AKConstant *)secondPoint
             durationBetweenPoints:(AKConstant *)durationBetweenPoints
{
    self = [super initWithString:[self operationName]];
    if (self) {
        _firstPoint = firstPoint;
        _secondPoint = secondPoint;
        _durationBetweenPoints = durationBetweenPoints;
        self.state = @"connectable";
        self.dependencies = @[_firstPoint, _secondPoint, _durationBetweenPoints];
    }
    return self;
}

- (instancetype)init
{
    self = [super initWithString:[self operationName]];
    if (self) {
        // Default Values
        _firstPoint = akp(0);
        _secondPoint = akp(1);
        _durationBetweenPoints = akp(1);
        self.state = @"connectable";
        self.dependencies = @[_firstPoint, _secondPoint, _durationBetweenPoints];
    }
    return self;
}

+ (instancetype)line
{
    return [[AKLine alloc] init];
}

- (void)setOptionalFirstPoint:(AKConstant *)firstPoint {
    _firstPoint = firstPoint;
}
- (void)setOptionalSecondPoint:(AKConstant *)secondPoint {
    _secondPoint = secondPoint;
}
- (void)setOptionalDurationBetweenPoints:(AKConstant *)durationBetweenPoints {
    _durationBetweenPoints = durationBetweenPoints;
}

- (NSString *)inlineStringForCSD
{
    NSMutableString *inlineCSDString = [[NSMutableString alloc] init];

    [inlineCSDString appendString:@"line("];
    [inlineCSDString appendString:[self inputsString]];
    [inlineCSDString appendString:@")"];

    return inlineCSDString;
}


- (NSString *)stringForCSD
{
    NSMutableString *csdString = [[NSMutableString alloc] init];

    [csdString appendFormat:@"%@ line ", self];
    [csdString appendString:[self inputsString]];
    return csdString;
}

- (NSString *)inputsString {
    NSMutableString *inputsString = [[NSMutableString alloc] init];

    
    [inputsString appendFormat:@"%@, ", _firstPoint];
    
    [inputsString appendFormat:@"%@, ", _durationBetweenPoints];
    
    [inputsString appendFormat:@"%@", _secondPoint];
    return inputsString;
}

@end
