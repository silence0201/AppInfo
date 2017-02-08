//
//  Invoker.h
//  InvokerDemo
//
//  Created by Silence on 05/02/2017.
//  Copyright © 2017 Silence. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark --- NSObject Category

@interface NSObject (Invoker)

#pragma mark --- instance Method

/**
    Invoke a selector with name

    @param selectorName SelectorName
    @return Return Value
 */
- (id)invoke:(NSString *)selectorName ;

/**
    Invoke a selector with name and argsArray

    @param selectorName SelectorName
    @param arguments Arguments Array
    @return Return Value
 */
- (id)invoke:(NSString *)selectorName arguments:(NSArray *)arguments ;

#pragma mark --- Class Method

/**
    Invoke a selector with name (Class Method)
 
    @param selectorName SelectorName
    @return Return Value
 */
+ (id)invoke:(NSString *)selectorName ;


/**
    Invoke a selector with name and argsArray (Class Method)
 
    @param selectorName SelectorName
    @param arguments Arguments Array
    @return Return Value
 */
+ (id)invoke:(NSString *)selectorName arguments:(NSArray *)arguments ;

@end

#pragma mark --- NSObject NSString
@interface NSString (Invoker)

/**
    Invoke class method with NSString

    @param selectorName SelectorName
    @return Return Value
 */
- (id)invokeClassMethod:(NSString *)selectorName ;

/**
    Invoke class method with NSString and argsArray

    @param selectorName SelectorName
    @param arguments Arguments list
    @return Return Value
 */
- (id)invokeClassMethod:(NSString *)selectorName arguments:(NSArray *)arguments ;

@end
