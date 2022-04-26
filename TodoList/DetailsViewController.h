//
//  DetailsViewController.h
//  TodoList
//
//  Created by Radwa on 05/04/2022.
//

#import <UIKit/UIKit.h>
#import "Note.h"
NS_ASSUME_NONNULL_BEGIN

@interface DetailsViewController : UIViewController
@property Note* task;
@property int index;
@end

NS_ASSUME_NONNULL_END
