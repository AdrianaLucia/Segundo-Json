//
//  BIDMasterViewController.h
//  Segundo Json
//
//  Created by Adriana Nolberto on 7/18/13.
//  Copyright (c) 2013 Adriana Nolberto. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface BIDMasterViewController : UITableViewController

@property (nonatomic,strong) NSArray *comunidades;

-(void)empezarAParsear:(NSData *)urlData;
-(void)generarJSON:(id)sender;


@end
