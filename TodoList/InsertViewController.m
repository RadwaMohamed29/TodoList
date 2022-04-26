//
//  InsertViewController.m
//  TodoList
//
//  Created by Radwa on 05/04/2022.
//

#import "InsertViewController.h"
#import "Note.h"
@interface InsertViewController ()
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextView *desc;


@property (weak, nonatomic) IBOutlet UIDatePicker *date;
@property (weak, nonatomic) IBOutlet UISegmentedControl *priority;

@end

@implementation InsertViewController
{
    Note *note;
    NSMutableArray* listOfNote;
    NSUserDefaults* def;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    def =[NSUserDefaults standardUserDefaults];
    note=[Note new];
    listOfNote=[[self readArrayWithCustomObjFromUserDefaults:@"note"]mutableCopy];
         
    
}
- (IBAction)add:(id)sender {
    [note setName:_name.text];
    [note setDesc:_desc.text];
    note.prioy=_priority.selectedSegmentIndex ;
    note.date=_date.date;
    [listOfNote addObject:note];
    [self writeArrayWithCustomObjToUserDefaults:@"note" withArray:listOfNote];
    [self.navigationController popViewControllerAnimated:YES];
     
}
-(void)writeArrayWithCustomObjToUserDefaults:(NSString *)keyName withArray:(NSMutableArray *)myArray
{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:myArray];
    [def setObject:data forKey:keyName];
    [def synchronize];
}

-(NSArray *)readArrayWithCustomObjFromUserDefaults:(NSString*)keyName
{
    NSData *data = [def objectForKey:keyName];
    NSArray *myArray = [NSMutableArray arrayWithArray:[NSKeyedUnarchiver unarchiveObjectWithData:data]];
    return myArray;
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
