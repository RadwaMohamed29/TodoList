//
//  TOdoViewController.m
//  TodoList
//
//  Created by Radwa on 05/04/2022.
//

#import "TOdoViewController.h"
#import "InsertViewController.h"
#import "Note.h"
#import "DetailsViewController.h"
@interface TOdoViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UISearchBar *search;


@end

@implementation TOdoViewController
{
    NSUserDefaults *def;
    NSMutableArray<Note*> *listOfNote;
    Note*note;
    NSMutableArray* selectedTask;
    BOOL isSelected;
    UIImageView *image;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    note=[Note new];
    isSelected=NO;
    _search.delegate=self;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    def=[NSUserDefaults standardUserDefaults];
    listOfNote=[[self readArrayWithCustomObjFromUserDefaults:@"note"]mutableCopy];
    [_tableView reloadData];
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    if(searchText.length==0){
        isSelected=NO;
    }else{
        isSelected=YES;
        selectedTask=[[NSMutableArray alloc]init];
        for (int i=0; i<listOfNote.count; i++) {
            if ([listOfNote[i].name hasPrefix:searchText] || [listOfNote[i].name hasPrefix:[searchText lowercaseString]]) {
                    [selectedTask addObject:listOfNote[i]];
            }
        }
    }
    [_tableView reloadData];
 
}
- (IBAction)add:(id)sender {
   InsertViewController *view=[self.storyboard instantiateViewControllerWithIdentifier:@"InsertViewController"];
    [self.navigationController pushViewController:view animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    return @"TASKS";
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (isSelected) {
        if ([selectedTask count]!=0){
            _tableView.hidden = false;

        }else{
            _tableView.hidden = true;

        }
        return selectedTask.count;
    }else{
        if ([listOfNote count]!=0){
            _tableView.hidden = false;

        }else{
            _tableView.hidden = true;

        }
        return listOfNote.count;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if(isSelected){
        cell.textLabel.text=[[selectedTask objectAtIndex:indexPath.row] name ];
        if([[selectedTask objectAtIndex:indexPath.row] prioy]==0){
            cell.imageView.image=[UIImage imageNamed:@"low"];
        }else if ([[selectedTask objectAtIndex:indexPath.row] prioy]==1){
            cell.imageView.image=[UIImage imageNamed:@"mid"];
        }else{
            cell.imageView.image=[UIImage imageNamed:@"high"];
        }
        
    }else{
        cell.textLabel.text=[[listOfNote objectAtIndex:indexPath.row] name ];
        if([[listOfNote objectAtIndex:indexPath.row] prioy]==0){
            cell.imageView.image=[UIImage imageNamed:@"low"];
        }else if ([[listOfNote objectAtIndex:indexPath.row] prioy]==1){
            cell.imageView.image=[UIImage imageNamed:@"mid"];
        }else{
            cell.imageView.image=[UIImage imageNamed:@"high"];
        }
        
    }
   
    return  cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
            [listOfNote removeObjectAtIndex:indexPath.row];
            [_tableView deleteRowsAtIndexPaths:[NSMutableArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
           def=[NSUserDefaults standardUserDefaults];
           [self writeArrayWithCustomObjToUserDefaults:@"note" withArray:listOfNote];
           [_tableView reloadData];

         }
//    [listOfNote removeObjectAtIndex:indexPath.row];
//    NSData*data=[NSKeyedArchiver archivedDataWithRootObject:listOfNote requiringSecureCoding:YES error:NULL];
//    [def setObject:data forKey:@"note"];
//    [tableView reloadData];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailsViewController *view=[self.storyboard instantiateViewControllerWithIdentifier:@"DetailsViewController"];
    view.task=[listOfNote objectAtIndex:indexPath.row];
    [view setIndex:indexPath.row];
    [self.navigationController pushViewController:view animated:YES];
    
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
@end
