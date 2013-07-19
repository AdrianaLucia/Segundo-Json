//
//  BIDMasterViewController.m
//  Segundo Json
//
//  Created by Adriana Nolberto on 7/18/13.
//  Copyright (c) 2013 Adriana Nolberto. All rights reserved.
//

#import "BIDMasterViewController.h"




@implementation BIDMasterViewController

@synthesize comunidades;

/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Master", @"Master");
    }
    return self;
}

*/

- (void)dealloc
{
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    /*self.navigationItem.leftBarButtonItem = self.editButtonItem;

   /* 
     IBarButtonItem *addButton = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)] autorelease];
      self.navigationItem.rightBarButtonItem = addButton;
    */
    UIBarButtonItem *json=[[UIBarButtonItem alloc]initWithTitle:@"Generar JSON" style:UIBarButtonItemStylePlain target:self action:@selector(generarJSON:)];
    
    self.navigationItem.rightBarButtonItem=json;
    [json release];
    
    
    NSURL *url=[NSURL URLWithString:@"http://dl.dropbox.com/u/270074/iOSTutorials/JSON/test.json"];
    NSData *urlData=[NSData dataWithContentsOfURL:url];
    
    [self empezarAParsear:urlData];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
- (void)insertNewObject:(id)sender
{
    if (!_objects) {
        _objects = [[NSMutableArray alloc] init];
    }
    [_objects insertObject:[NSDate date] atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}
 */

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.comunidades count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
       /* cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        */
        
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    NSDictionary *comunidad= [self.comunidades objectAtIndex:indexPath.row];
    cell.textLabel.text=[comunidad objectForKey:@"nombre"];
    cell.textLabel.textColor=[UIColor redColor];
    NSString *subtitulo=[NSString stringWithFormat:@"Superficie: %@ - Porcentaje: %@",[comunidad objectForKey:@"superficie"],[comunidad objectForKey:@"porcentaje"]];
    cell.detailTextLabel.text=subtitulo;
    cell.detailTextLabel.textColor=[UIColor blueColor];
    
    cell.imageView.image=[UIImage imageNamed:@"1Star.png"];
    
 //[cell setBackgroundColor:[UIColor colorWithRed:32 green:25 blue:12 alpha:1]];
    self.tableView.backgroundColor=[UIColor grayColor];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

/*
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}
 */

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


-(void)empezarAParsear:(NSData *)urlData
{
    NSError *error=nil;
    
    NSDictionary *jsonDic=[NSJSONSerialization JSONObjectWithData:urlData options:kNilOptions error:&error];
    
    if (error!=nil) {
        NSLog(@"Error : %@", [error localizedDescription]);
    }
    else{
        self.comunidades=[jsonDic objectForKey:@"comunidades"];
    }
}

-(void)generarJSON:(id)sender
{
    NSError *error=nil;
    
    NSData *json=[NSJSONSerialization dataWithJSONObject:self.comunidades options:NSJSONWritingPrettyPrinted error:&error];
    
    NSString *jsonString=[[NSString alloc]initWithData:json encoding:NSUTF8StringEncoding];
    
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:jsonString delegate:self cancelButtonTitle:@"ok" otherButtonTitles: nil];
    [alert show];
    [jsonString release];
    [alert release];
}

@end
