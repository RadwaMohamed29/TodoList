//
//  ProgressViewController.m
//  TodoList
//
//  Created by Radwa on 05/04/2022.
//

#import "ProgressViewController.h"
#import "Note.h"
#import "DetailsInProgressViewController.h"
@interface ProgressViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end

@implementation ProgressViewController

{
    NSUserDefaults *def;
    NSMutableArray<Note*> *listOfNote;
    Note*note;
    NSMutableArray* doneArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    note=[Note new];
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    def=[NSUserDefaults standardUserDefaults];
    listOfNote=[[self readArrayWithCustomObjFromUserDefaults:@"inProgress"]mutableCopy];
    doneArray=[[self readArrayWithCustomObjFromUserDefaults:@"done"]mutableCopy];
    [_tableView reloadData];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    return @"TASKS";
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

        return listOfNote.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];

        cell.textLabel.text=[[listOfNote objectAtIndex:indexPath.row] name ];
        if([[listOfNote objectAtIndex:indexPath.row] prioy]==0){
            cell.imageView.image=[UIImage imageNamed:@"low"];
        }else if ([[listOfNote objectAtIndex:indexPath.row] prioy]==1){
            cell.imageView.image=[UIImage imageNamed:@"mid"];
        }else{
            cell.imageView.image=[UIImage imageNamed:@"high"];
        }
        
    
   
    return  cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailsInProgressViewController *view=[self.storyboard instantiateViewControllerWithIdentifier:@"DetailsInProgressViewController"];
    view.task=[listOfNote objectAtIndex:indexPath.row];
  
    [view setIndex:indexPath.row];
    printf("%d",indexPath.row);
    [self.navigationController pushViewController:view animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
            [listOfNote removeObjectAtIndex:indexPath.row];
            [_tableView deleteRowsAtIndexPaths:[NSMutableArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
           def=[NSUserDefaults standardUserDefaults];
           [self writeArrayWithCustomObjToUserDefaults:@"inProgress" withArray:listOfNote];
           [_tableView reloadData];

         }
//    [listOfNote removeObjectAtIndex:indexPath.row];
//    NSData*data=[NSKeyedArchiver archivedDataWithRootObject:listOfNote requiringSecureCoding:YES error:NULL];
//    [def setObject:data forKey:@"note"];
//    [tableView reloadData];
}
-(NSArray *)readArrayWithCustomObjFromUserDefaults:(NSString*)keyName
{
    NSData *data = [def objectForKey:keyName];
    NSArray *myArray = [[NSKeyedUnarchiver unarchiveObjectWithData:data]mutableCopy];
    return myArray;
}
-(void)writeArrayWithCustomObjToUserDefaults:(NSString *)keyName withArray:(NSMutableArray *)myArray
    {
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:myArray];
        [def setObject:data forKey:keyName];
        [def synchronize];
    }
//- (IBAction)addToDone:(id)sender {
////    note=[Note new];
////    note.name=_name.text;
////    note.date=_date.date;
////    note.desc=_desc.text;
////    note.prioy=_prioy.selectedSegmentIndex;
//    //[listOfNote removeObjectAtIndex:];
//
//    [self writeArrayWithCustomObjToUserDefaults:@"inProgress" withArray:listOfNote];
//
//    [doneArray addObject:listOfNote];
//    [self writeArrayWithCustomObjToUserDefaults:@"done" withArray:doneArray];
//
//    [self.navigationController popViewControllerAnimated:YES];
//
//}

@end
