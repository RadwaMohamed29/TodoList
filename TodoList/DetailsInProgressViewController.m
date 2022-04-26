//
//  DetailsInProgressViewController.m
//  TodoList
//
//  Created by Radwa on 06/04/2022.
//

#import "DetailsInProgressViewController.h"

@interface DetailsInProgressViewController ()
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextView *desc;
@property (weak, nonatomic) IBOutlet UISegmentedControl *prioy;
@property (weak, nonatomic) IBOutlet UIDatePicker *date;

@end

@implementation DetailsInProgressViewController
{
    Note *note;
    NSUserDefaults *def;
    NSMutableArray* array;
    NSMutableArray* doneArray;
    NSMutableArray<Note*>*resultArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _name.text=_task.name;
    _desc.text=_task.desc;
    _prioy.selectedSegmentIndex=_task.prioy;
    _date.date=_task.date;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    def=[NSUserDefaults standardUserDefaults];
    array=[[self readArrayWithCustomObjFromUserDefaults:@"inProgress"]mutableCopy];
    doneArray=[[self readArrayWithCustomObjFromUserDefaults:@"done"]mutableCopy];

}



-(NSArray *)readArrayWithCustomObjFromUserDefaults:(NSString*)keyName
{
    NSData *data = [def objectForKey:keyName];
    NSArray *myArray = [NSMutableArray arrayWithArray:[NSKeyedUnarchiver unarchiveObjectWithData:data]];
    return myArray;
}
-(void)writeArrayWithCustomObjToUserDefaults:(NSString *)keyName withArray:(NSMutableArray *)myArray
{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:myArray];
    [def setObject:data forKey:keyName];
    [def synchronize];
}
- (IBAction)addToDone:(id)sender {
    note=[Note new];
    note.name=_name.text;
    note.date=_date.date;
    note.desc=_desc.text;
    note.prioy=_prioy.selectedSegmentIndex;
    [array removeObjectAtIndex:_index];

    [self writeArrayWithCustomObjToUserDefaults:@"inProgress" withArray:array];


    [doneArray addObject:note];
    [self writeArrayWithCustomObjToUserDefaults:@"done" withArray:doneArray];

    [self.navigationController popViewControllerAnimated:YES];
}

@end
