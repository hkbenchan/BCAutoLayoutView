//
//  ViewController.m
//  BCAutoLayoutView
//
//  Created by Chan Ho Pan on 2/9/2015.
//  Copyright (c) 2015 hpchan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) NSMutableArray *autoLayoutViews;

@property (nonatomic, strong) NSMutableArray *viewGestures;

@property (nonatomic, strong) NSArray *viewColors;

@end

@implementation ViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (NSMutableArray *)autoLayoutViews
{
  if (!_autoLayoutViews) {
    _autoLayoutViews = [[NSMutableArray alloc] init];
  }
  return _autoLayoutViews;
}

- (NSMutableArray *)viewGestures
{
  if (!_viewGestures) {
    _viewGestures = [[NSMutableArray alloc] init];
  }
  return _viewGestures;
}

- (NSArray *)viewColors
{
  if (!_viewColors) {
    _viewColors = [[NSArray alloc]
                   initWithObjects:[UIColor blueColor], [UIColor yellowColor], [UIColor greenColor], [UIColor redColor], nil];
  }
  return _viewColors;
}

- (IBAction)zeroSpaceButtonPressed:(id)sender
{
  UIView *lastView = (UIView *)[self.autoLayoutViews lastObject];
  
  if (!lastView) {
    lastView = self.containerView;
  }
  
  BCAutoLayoutView *newView = [[BCAutoLayoutView alloc] initWithFrame:CGRectMake(0, 0, lastView.frame.size.width, lastView.frame.size.height)];
  
  newView.backgroundColor = [self.viewColors objectAtIndex:(self.autoLayoutViews.count % self.viewColors.count)];
  [newView setSpacingWithSuperView:kBCAutoLayoutSpacingNoSpacing];
  
  [self addBCAutoLayoutView:newView toView:lastView];
}

- (IBAction)nonzeroSpaceButtonPressed:(id)sender
{
  UIView *lastView = (UIView *)[self.autoLayoutViews lastObject];
  
  if (!lastView) {
    lastView = self.containerView;
  }
  
  BCAutoLayoutView *newView = [[BCAutoLayoutView alloc] initWithFrame:CGRectMake(0, 0, lastView.frame.size.width, lastView.frame.size.height)];
  
  newView.backgroundColor = [self.viewColors objectAtIndex:(self.autoLayoutViews.count % self.viewColors.count)];
  [newView setSpacingWithSuperView:BCAutoLayoutMakeSpacing(10, 20, 30, 40)];
  
  [self addBCAutoLayoutView:newView toView:lastView];
}

- (void)addBCAutoLayoutView:(BCAutoLayoutView *)view toView:(UIView *)superview
{
  [superview addSubview:view];
  [self.autoLayoutViews addObject:view];
  
  UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userDidTap:)];
  [view addGestureRecognizer:tapGR];
  [self.viewGestures addObject:tapGR];
}

- (void)userDidTap:(UITapGestureRecognizer *)tapGestureRecognizer
{
//  NSLog(@"user did tap %@", tapGestureRecognizer);
  
  if (tapGestureRecognizer.view == [self.autoLayoutViews lastObject]) {
    UIView *view = (UIView *)[self.autoLayoutViews lastObject];
    
    [self.viewGestures removeLastObject];
    [self.autoLayoutViews removeLastObject];
    
    [view removeGestureRecognizer:tapGestureRecognizer];
    [view removeFromSuperview];
  }
}


@end
