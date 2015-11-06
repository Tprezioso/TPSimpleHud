//
//  ViewController.m
//  TPSimpleHud
//
//  Created by Thomas Prezioso on 10/29/15.
//  Copyright © 2015 Thomas Prezioso. All rights reserved.
//

#import "ViewController.h"
#import "TPHud.h"

@interface ViewController ()
- (IBAction)progressButton:(id)sender;
- (IBAction)stopProgressButton:(id)sender;
@property(strong, nonatomic)TPHud *hud;


@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)progressButton:(id)sender
{
    self.hud = [[TPHud alloc] init];
    [self.hud showInView:self.view];
}

- (IBAction)stopProgressButton:(id)sender
{
    [self.hud hideInView:self.view];
}
@end
