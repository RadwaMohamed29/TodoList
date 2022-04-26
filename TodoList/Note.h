//
//  Note.h
//  TodoList
//
//  Created by Radwa on 05/04/2022.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Note : NSObject
@property NSString* name;
@property int prioy;
@property NSData* date;
@property NSString* desc;

@end

NS_ASSUME_NONNULL_END
