//
//  EncodeDecodeUtils.m
//  IosCurrencyConverter
//
//  Created by Bikash Shrestha on 9/24/18.
//  Copyright © 2018 Bikash Shrestha. All rights reserved.
//

#import "EncodeDecodeUtils.h"
#import <objc/runtime.h>

@implementation EncodeDecodeUtils

+ (id) decodeWithDecoder:(NSCoder *)decoder object:(NSObject *) object{
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([object class], &outCount);
    for (i = 0; i < outCount; i++) {
        
        objc_property_t property = properties[i];
        NSString *propertyName = [self getPropertyName:property];
        const char * rawPropertyType = [self getRawPropertyType:property];
        
        if (strcmp(rawPropertyType, @encode(float)) == 0) {
            
            float value = [decoder decodeFloatForKey:propertyName];
            [object setValue:@(value).stringValue forKey:propertyName];
            
        } else if(strcmp(rawPropertyType, @encode(double)) == 0) {
            
            double value = [decoder decodeDoubleForKey:propertyName];
            [object setValue:@(value).stringValue forKey:propertyName];
            
        }  else if (strcmp(rawPropertyType, @encode(int)) == 0) {
            
            int value = [decoder decodeIntForKey:propertyName];
            [object setValue:@(value).stringValue forKey:propertyName];
            
        } else if (strcmp(rawPropertyType, @encode(BOOL)) == 0) {
            
            BOOL value = [decoder decodeBoolForKey:propertyName];
            [object setValue:@(value).stringValue forKey:propertyName];
            
        } else if (strcmp(rawPropertyType, @encode(id)) == 0) {
            
        } else {
            id value = [decoder decodeObjectForKey:propertyName];
            [object setValue:value forKey:propertyName];
        }
        
    }
    free(properties);
    return object;
}

+ (void) encodeWithCoder:(NSCoder *)encoder object:(NSObject *) object{
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([object class], &outCount);
    for (i = 0; i < outCount; i++) {
        
        objc_property_t property = properties[i];
        NSString *propertyName = [self getPropertyName:property];
        const char * rawPropertyType = [self getRawPropertyType:property];
        id value = [object valueForKey:propertyName];
        
        if (strcmp(rawPropertyType, @encode(float)) == 0) {
            
            [encoder encodeFloat:[value floatValue] forKey:propertyName];
            
        } else if(strcmp(rawPropertyType, @encode(double)) == 0) {
            
            [encoder encodeDouble:[value doubleValue] forKey:propertyName];
            
        }  else if (strcmp(rawPropertyType, @encode(int)) == 0) {
            
            [encoder encodeInt:[value intValue] forKey:propertyName];
            
        } else if (strcmp(rawPropertyType, @encode(BOOL)) == 0) {
            
            [encoder encodeBool:[value boolValue] forKey:propertyName];
            
        } else if (strcmp(rawPropertyType, @encode(id)) == 0) {
            
        } else {
            
            [encoder encodeObject: value forKey:propertyName];
            
        }
        
    }
    free(properties);
}

+ (const char *) getRawPropertyType: (objc_property_t) property  {
    const char * type = property_getAttributes(property);
    NSString * typeString = [NSString stringWithUTF8String:type];
    NSArray * attributes = [typeString componentsSeparatedByString:@","];
    NSString * typeAttribute = [attributes objectAtIndex:0];
    NSString * propertyType = [typeAttribute substringFromIndex:1];
    return [propertyType UTF8String];
}

+ (NSString *) getPropertyName: (objc_property_t) property  {
    const char * name = property_getName(property);
   return [NSString stringWithCString:name encoding:NSUTF8StringEncoding];
}

@end
