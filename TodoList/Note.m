//
//  Note.m
//  TodoList
//
//  Created by Radwa on 05/04/2022.
//

#import "Note.h"

@implementation Note
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    if (self!=nil) {
        _name=[coder decodeObjectForKey:@"name"];
        _date=[coder decodeObjectForKey:@"date"];
        _prioy=[coder decodeIntForKey:@"priority"];
        _desc=[coder decodeObjectForKey:@"desc"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    //[super encodeWithCoder:coder];
    [coder encodeObject:_name forKey:@"name"];
    [coder encodeObject:_desc forKey:@"desc"];
    [coder encodeObject:_date forKey:@"date"];
    [coder encodeInt:_prioy forKey:@"priority"];
}

@end
