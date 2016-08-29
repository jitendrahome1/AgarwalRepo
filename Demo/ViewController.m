//
//  ViewController.m
//  Demo
//
//  Created by Jitendra on 29/08/16.
//  Copyright © 2016 Jitendra. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    NSArray *arrImages;
    
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    arrImages = [[NSArray alloc]initWithObjects:@"back.jpg",@"headerImag.jpg",@"image1.jped",@"image2.jpg" ,nil];
    
    self.aJAPaging.arrItems = arrImages;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
