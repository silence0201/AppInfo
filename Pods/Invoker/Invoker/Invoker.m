//
//  Invoker.m
//  InvokerDemo
//
//  Created by Silence on 05/02/2017.
//  Copyright © 2017 Silence. All rights reserved.
//

#import "Invoker.h"
#import <UIKit/UIKit.h>

#define force_inline __inline__ __attribute__((always_inline))

//  Objective-C type encoding: http://nshipster.com/type-encodings/
typedef NS_ENUM(NSInteger, SIMethodArgumentType) {
    SIMethodArgumentTypeUnknown             = 0,
    SIMethodArgumentTypeChar,
    SIMethodArgumentTypeInt,
    SIMethodArgumentTypeShort,
    SIMethodArgumentTypeLong,
    SIMethodArgumentTypeLongLong,
    SIMethodArgumentTypeUnsignedChar,
    SIMethodArgumentTypeUnsignedInt,
    SIMethodArgumentTypeUnsignedShort,
    SIMethodArgumentTypeUnsignedLong,
    SIMethodArgumentTypeUnsignedLongLong,
    SIMethodArgumentTypeFloat,
    SIMethodArgumentTypeDouble,
    SIMethodArgumentTypeBool,
    SIMethodArgumentTypeVoid,
    SIMethodArgumentTypeCharacterString,
    SIMethodArgumentTypeCGPoint,
    SIMethodArgumentTypeCGSize,
    SIMethodArgumentTypeCGRect,
    SIMethodArgumentTypeUIEdgeInsets,
    SIMethodArgumentTypeObject,
    SIMethodArgumentTypeClass
};
static force_inline SIMethodArgumentType argumentTypeWithEncode(const char * encode){
    if (strcmp(encode, @encode(char)) == 0) {
        return SIMethodArgumentTypeChar;
    } else if (strcmp(encode, @encode(int)) == 0) {
        return SIMethodArgumentTypeInt;
    } else if (strcmp(encode, @encode(short)) == 0) {
        return SIMethodArgumentTypeShort;
    } else if (strcmp(encode, @encode(long)) == 0) {
        return SIMethodArgumentTypeLong;
    } else if (strcmp(encode, @encode(long long)) == 0) {
        return SIMethodArgumentTypeLongLong;
    } else if (strcmp(encode, @encode(unsigned char)) == 0) {
        return SIMethodArgumentTypeUnsignedChar;
    } else if (strcmp(encode, @encode(unsigned int)) == 0) {
        return SIMethodArgumentTypeUnsignedInt;
    } else if (strcmp(encode, @encode(unsigned short)) == 0) {
        return SIMethodArgumentTypeUnsignedShort;
    } else if (strcmp(encode, @encode(unsigned long)) == 0) {
        return SIMethodArgumentTypeUnsignedLong;
    } else if (strcmp(encode, @encode(unsigned long long)) == 0) {
        return SIMethodArgumentTypeUnsignedLongLong;
    } else if (strcmp(encode, @encode(float)) == 0) {
        return SIMethodArgumentTypeFloat;
    } else if (strcmp(encode, @encode(double)) == 0) {
        return SIMethodArgumentTypeDouble;
    } else if (strcmp(encode, @encode(BOOL)) == 0) {
        return SIMethodArgumentTypeBool;
    } else if (strcmp(encode, @encode(void)) == 0) {
        return SIMethodArgumentTypeVoid;
    } else if (strcmp(encode, @encode(char *)) == 0) {
        return SIMethodArgumentTypeCharacterString;
    } else if (strcmp(encode, @encode(id)) == 0) {
        return SIMethodArgumentTypeObject;
    } else if (strcmp(encode, @encode(Class)) == 0) {
        return SIMethodArgumentTypeClass;
    } else if (strcmp(encode, @encode(CGPoint)) == 0) {
        return SIMethodArgumentTypeCGPoint;
    } else if (strcmp(encode, @encode(CGSize)) == 0) {
        return SIMethodArgumentTypeCGSize;
    } else if (strcmp(encode, @encode(CGRect)) == 0) {
        return SIMethodArgumentTypeCGRect;
    } else if (strcmp(encode, @encode(UIEdgeInsets)) == 0) {
        return SIMethodArgumentTypeUIEdgeInsets;
    } else {
        return SIMethodArgumentTypeUnknown;
    }
}

@implementation NSMethodSignature (Invoker)

- (SIMethodArgumentType)returnType{
    return argumentTypeWithEncode([self methodReturnType]) ;
}

- (SIMethodArgumentType)argumentTypeAtIndex:(NSUInteger)index{
    return argumentTypeWithEncode([self getArgumentTypeAtIndex:index]) ;
}

- (NSInvocation *)invocationWithArguments:(NSArray *)arguments{
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:self] ;
    NSAssert(arguments == nil || [arguments isKindOfClass:[NSArray class]], @"# Invoker # arguments is not an array") ;
    [arguments enumerateObjectsUsingBlock:^(id  _Nonnull argument, NSUInteger idx, BOOL * _Nonnull stop) {
        NSInteger index = idx + 2; // start with 2
        SIMethodArgumentType type = [self argumentTypeAtIndex:index];
        switch (type) {
            case SIMethodArgumentTypeChar: {
                char value = [argument charValue];
                [invocation setArgument:&value atIndex:index];
            } break;
            case SIMethodArgumentTypeInt: {
                int value = [argument intValue];
                [invocation setArgument:&value atIndex:index];
            } break;
            case SIMethodArgumentTypeShort: {
                short value = [argument shortValue];
                [invocation setArgument:&value atIndex:index];
            } break;
            case SIMethodArgumentTypeLong: {
                long value = [argument longValue];
                [invocation setArgument:&value atIndex:index];
            } break;
            case SIMethodArgumentTypeLongLong: {
                long long value = [argument longLongValue];
                [invocation setArgument:&value atIndex:index];
            } break;
            case SIMethodArgumentTypeUnsignedChar: {
                unsigned char value = [argument unsignedCharValue];
                [invocation setArgument:&value atIndex:index];
            } break;
            case SIMethodArgumentTypeUnsignedInt: {
                unsigned int value = [argument unsignedIntValue];
                [invocation setArgument:&value atIndex:index];
            } break;
            case SIMethodArgumentTypeUnsignedShort: {
                unsigned short value = [argument unsignedShortValue];
                [invocation setArgument:&value atIndex:index];
            } break;
            case SIMethodArgumentTypeUnsignedLong: {
                unsigned long value = [argument unsignedLongValue];
                [invocation setArgument:&value atIndex:index];
            } break;
            case SIMethodArgumentTypeUnsignedLongLong: {
                unsigned long long value = [argument unsignedLongLongValue];
                [invocation setArgument:&value atIndex:index];
            } break;
            case SIMethodArgumentTypeFloat: {
                float value = [argument floatValue];
                [invocation setArgument:&value atIndex:index];
            } break;
            case SIMethodArgumentTypeDouble: {
                double value = [argument doubleValue];
                [invocation setArgument:&value atIndex:index];
            } break;
            case SIMethodArgumentTypeBool: {
                BOOL value = [argument boolValue];
                [invocation setArgument:&value atIndex:index];
            } break;
            case SIMethodArgumentTypeVoid: {
                
            } break;
            case SIMethodArgumentTypeCharacterString: {
                const char *value = [argument UTF8String];
                [invocation setArgument:&value atIndex:index];
            } break;
            case SIMethodArgumentTypeObject: {
                [invocation setArgument:&argument atIndex:index];
            } break;
            case SIMethodArgumentTypeClass: {
                Class value = [argument class];
                [invocation setArgument:&value atIndex:index];
            } break;
                
            default: break;
        }
    }];
    
    return invocation;
}

@end

@implementation NSInvocation (Invoker)

- (id)invoke:(id)target selector:(SEL)selector returnType:(SIMethodArgumentType)type{
    self.target = target ;
    self.selector = selector ;
    [self invoke] ;
    return [self returnValueForType:type] ;
}

- (id)returnValueForType:(SIMethodArgumentType)type{
    __unsafe_unretained id returnValue;
    switch (type) {
        case SIMethodArgumentTypeChar: {
            char value;
            [self getReturnValue:&value];
            returnValue = @(value);
        } break;
        case SIMethodArgumentTypeInt:  {
            int value;
            [self getReturnValue:&value];
            returnValue = @(value);
        } break;
        case SIMethodArgumentTypeShort:  {
            short value;
            [self getReturnValue:&value];
            returnValue = @(value);
        } break;
        case SIMethodArgumentTypeLong:  {
            long value;
            [self getReturnValue:&value];
            returnValue = @(value);
        } break;
        case SIMethodArgumentTypeLongLong:  {
            long long value;
            [self getReturnValue:&value];
            returnValue = @(value);
        } break;
        case SIMethodArgumentTypeUnsignedChar:  {
            unsigned char value;
            [self getReturnValue:&value];
            returnValue = @(value);
        } break;
        case SIMethodArgumentTypeUnsignedInt:  {
            unsigned int value;
            [self getReturnValue:&value];
            returnValue = @(value);
        } break;
        case SIMethodArgumentTypeUnsignedShort:  {
            unsigned short value;
            [self getReturnValue:&value];
            returnValue = @(value);
        } break;
        case SIMethodArgumentTypeUnsignedLong:  {
            unsigned long value;
            [self getReturnValue:&value];
            returnValue = @(value);
        } break;
        case SIMethodArgumentTypeUnsignedLongLong:  {
            unsigned long long value;
            [self getReturnValue:&value];
            returnValue = @(value);
        } break;
        case SIMethodArgumentTypeFloat:  {
            float value;
            [self getReturnValue:&value];
            returnValue = @(value);
        } break;
        case SIMethodArgumentTypeDouble:  {
            double value;
            [self getReturnValue:&value];
            returnValue = @(value);
        } break;
        case SIMethodArgumentTypeBool: {
            BOOL value;
            [self getReturnValue:&value];
            returnValue = @(value);
        } break;
        case SIMethodArgumentTypeCharacterString: {
            const char *value;
            [self getReturnValue:&value];
            returnValue = [NSString stringWithUTF8String:value];
        } break;
        case SIMethodArgumentTypeCGPoint: {
            CGPoint value;
            [self getReturnValue:&value];
            returnValue = [NSValue valueWithCGPoint:value];
        } break;
        case SIMethodArgumentTypeCGSize: {
            CGSize value;
            [self getReturnValue:&value];
            returnValue = [NSValue valueWithCGSize:value];
        } break;
        case SIMethodArgumentTypeCGRect: {
            CGRect value;
            [self getReturnValue:&value];
            returnValue = [NSValue valueWithCGRect:value];
        } break;
        case SIMethodArgumentTypeUIEdgeInsets: {
            UIEdgeInsets value;
            [self getReturnValue:&value];
            returnValue = [NSValue valueWithUIEdgeInsets:value];
        } break;
        case SIMethodArgumentTypeObject:
        case SIMethodArgumentTypeClass:
            [self getReturnValue:&returnValue];
            break;
        default: break;
    }
    return returnValue;
}

@end

static force_inline id invoke(id target, NSString *selectorName, NSArray *arguments){
    SEL selector = NSSelectorFromString(selectorName) ;
    NSMethodSignature *signature = [target methodSignatureForSelector:selector] ;
    if (signature) {
        NSInvocation *invocation = [signature invocationWithArguments:arguments] ;
        id returnValue = [invocation invoke:target selector:selector returnType:[signature returnType]] ;
        return returnValue ;
    }else{
        NSLog(@"# Invoker # selector: \"%@\" NOT FOUND", NSStringFromSelector(selector));
        return nil;
    }
}

#pragma mark --- NSObject Category

@implementation NSObject (Invoker)

#pragma mark --- instance Method

- (id)invoke:(NSString *)selectorName arguments:(NSArray *)arguments{
    return invoke(self, selectorName, arguments) ;
}

- (id)invoke:(NSString *)selectorName{
    return [self invoke:selectorName arguments:nil] ;
}


#pragma mark --- Class Method

+ (id)invoke:(NSString *)selectorName arguments:(NSArray *)arguments{
    return invoke(self.class, selectorName, arguments) ;
}

+ (id)invoke:(NSString *)selectorName{
    return [self invoke:selectorName arguments:nil] ;
}

@end

@implementation NSString (Invoker)

- (id)invokeClassMethod:(NSString *)selectorName arguments:(NSArray *)arguments{
    return [NSClassFromString(self) invoke:selectorName arguments:arguments] ;
}

- (id)invokeClassMethod:(NSString *)selectorName{
    return [self invokeClassMethod:selectorName arguments:nil] ;
}

@end



