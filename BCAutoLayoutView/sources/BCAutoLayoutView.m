//
//  BCAutoLayoutView.m
//  
//
//  Created by Chan Ho Pan on 2/9/2015.
//
//

#import "BCAutoLayoutView.h"

const BCAutoLayoutSpacing kBCAutoLayoutSpacingNoSpacing = { .top = 0, .bottom = 0, .leading = 0, .trailing = 0 };

BCAutoLayoutSpacing BCAutoLayoutMakeSpacing(CGFloat top, CGFloat bottom, CGFloat leading, CGFloat trailing) {
  
  BCAutoLayoutSpacing spacing;
  
  spacing.top = top;
  spacing.bottom = bottom;
  spacing.leading = leading;
  spacing.trailing = trailing;
  
  return spacing;
}

@interface BCAutoLayoutView ()

@property (nonatomic, readwrite) BCAutoLayoutSpacing superviewAutoLayoutSpacing;

@property (nonatomic, strong) NSMutableArray *BCConstraints;

@end

@implementation BCAutoLayoutView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
  if (self = [super initWithFrame:frame]) {
    [self commonSetup];    
  }
  return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
  if (self = [super initWithCoder:aDecoder]) {
    [self commonSetup];
  }
  return self;
}

- (NSMutableArray *)BCConstraints
{
  if (!_BCConstraints) {
    _BCConstraints = [[NSMutableArray alloc] init];
  }
  return _BCConstraints;
}

- (void)commonSetup
{
  self.translatesAutoresizingMaskIntoConstraints = NO;
  self.superviewAutoLayoutSpacing = kBCAutoLayoutSpacingNoSpacing;
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
  NSLog(@"will move to superview %@; previous superview %@", newSuperview, self.superview);
  
  if (newSuperview != nil) {
    // remove all existing constraints
    
//    for (NSLayoutConstraint *constraint in self.bcConstraints) {
//      if (self.superview != nil) {
//        [self.superview removeConstraint:constraint];
//      }
//    }
    if (self.superview) {
      [self.superview removeConstraints:self.BCConstraints];
    }
    [self.BCConstraints removeAllObjects];
    
  } else {

  }
}

- (void)didMoveToSuperview
{
  NSLog(@"did move to superview");
  
  if (self.superview) {
    [self constructBCConstraints];
    [self.superview addConstraints:self.BCConstraints];
//    [self setNeedsLayout];
//    [self setNeedsUpdateConstraints];
    
  }
  
}

- (void)setSpacingWithSuperView:(BCAutoLayoutSpacing)spacing
{
  [self setSpacingWithSuperView:spacing beforeCommit:nil];
}

- (void)setSpacingWithSuperView:(BCAutoLayoutSpacing)spacing beforeCommit:(void (^)(NSArray *))beforeCommitBlock
{
  self.superviewAutoLayoutSpacing = spacing;
  
  if (self.superview) {
    // remove all BC constraints from superview
    [self.superview removeConstraints:self.BCConstraints];
  }
  
  [self constructBCConstraints];
  
  if (beforeCommitBlock) {
    beforeCommitBlock(self.BCConstraints);
  }

  if (self.superview) {
    // add the constraints to superview now
    [self.superview addConstraints:self.BCConstraints];
  }
}

- (void)constructBCConstraints
{
  [self.BCConstraints removeAllObjects];
  
  if (self.superview) {
    [self.BCConstraints addObjectsFromArray:
      @[
        [NSLayoutConstraint constraintWithItem:self
                                     attribute:NSLayoutAttributeTop
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self.superview
                                     attribute:NSLayoutAttributeTop
                                    multiplier:1
                                      constant:self.superviewAutoLayoutSpacing.top],
        
        [NSLayoutConstraint constraintWithItem:self
                                     attribute:NSLayoutAttributeBottom
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self.superview
                                     attribute:NSLayoutAttributeBottom
                                    multiplier:1
                                      constant:-self.superviewAutoLayoutSpacing.bottom],
        
        [NSLayoutConstraint constraintWithItem:self
                                     attribute:NSLayoutAttributeLeading
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self.superview
                                     attribute:NSLayoutAttributeLeading
                                    multiplier:1
                                      constant:self.superviewAutoLayoutSpacing.leading],
        
        [NSLayoutConstraint constraintWithItem:self
                                     attribute:NSLayoutAttributeTrailing
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self.superview
                                     attribute:NSLayoutAttributeTrailing
                                    multiplier:1
                                      constant:-self.superviewAutoLayoutSpacing.trailing]
      ]
    ];
  }
}

//- (void)updateConstraints
//{
//  
//  
//  [super updateConstraints];
//}

@end
