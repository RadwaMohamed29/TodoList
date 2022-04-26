//
//  DetailsViewController.m
//  TodoList
//
//  Created by Radwa on 05/04/2022.
//

#import "DetailsViewController.h"

@interface DetailsViewController ()

@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextView *desc;

@property (weak, nonatomic) IBOutlet UISegmentedControl *priorty;
@property (weak, nonatomic) IBOutlet UIDatePicker *date;



@end
@implementation DetailsViewController
{
    NSMutableArray<Note*>*listOfNote;
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
    _priorty.selectedSegmentIndex=_task.prioy;
    _date.date=_task.date;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    def=[NSUserDefaults standardUserDefaults];
    listOfNote=[[self readArrayWithCustomObjFromUserDefaults:@"note"]mutableCopy];
    array=[[self readArrayWithCustomObjFromUserDefaults:@"inProgress"]mutableCopy];
    doneArray=[[self readArrayWithCustomObjFromUserDefaults:@"done"]mutableCopy];
    
}
- (IBAction)addToProgress:(id)sender {
    note=[Note new];
    note.name=_name.text;
    note.date=_date.date;
    note.desc=_desc.text;
    note.prioy=_priorty.selectedSegmentIndex;
    [listOfNote removeObjectAtIndex:_index];

    [self writeArrayWithCustomObjToUserDefaults:@"note" withArray:listOfNote];
    
    
    [array addObject:note];
    [self writeArrayWithCustomObjToUserDefaults:@"inProgress" withArray:array];

    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)addToDone:(id)sender {
    note=[Note new];
    note.name=_name.text;
    note.date=_date.date;
    note.desc=_desc.text;
    note.prioy=_priorty.selectedSegmentIndex;
    [listOfNote removeObjectAtIndex:_index];

    [self writeArrayWithCustomObjToUserDefaults:@"note" withArray:listOfNote];
    
    
    [doneArray addObject:note];
    [self writeArrayWithCustomObjToUserDefaults:@"done" withArray:doneArray];

    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)okBtn:(id)sender {
    [[listOfNote objectAtIndex:_index] setName:_name.text];
    [[listOfNote objectAtIndex:_index] setDesc:_desc.text];
    [[listOfNote objectAtIndex:_index] setDate:_date.date];
    [[listOfNote objectAtIndex:_index] setPrioy:_priorty.selectedSegmentIndex];
    [self writeArrayWithCustomObjToUserDefaults:@"note" withArray:listOfNote];
    [self.navigationController popViewControllerAnimated:YES];
    
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
@end
