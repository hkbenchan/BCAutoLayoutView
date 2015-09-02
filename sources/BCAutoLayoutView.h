//
//  BCAutoLayoutView.h
//  
//
//  Created by Chan Ho Pan on 2/9/2015.
//
//

#import <UIKit/UIKit.h>

/**
 Positive values mean inside superview, while negative values mean outside superview
 */
struct BCAutoLayoutSpacing {
  
  CGFloat top;
  CGFloat bottom;
  CGFloat leading;
  CGFloat trailing;
  
};

typedef struct BCAutoLayoutSpacing BCAutoLayoutSpacing;

extern const BCAutoLayoutSpacing kBCAutoLayoutSpacingNoSpacing;

BCAutoLayoutSpacing BCAutoLayoutMakeSpacing(CGFloat top, CGFloat bottom, CGFloat leading, CGFloat trailing);

/**
 
 This class will automatic add Top, Bottom, Leading, Trailing NSLayoutConstraint to its superview
 
 */
@interface BCAutoLayoutView : UIView

@property (nonatomic, readonly) BCAutoLayoutSpacing superviewAutoLayoutSpacing;

- (instancetype)initWithFrame:(CGRect)frame;

- (instancetype)initWithCoder:(NSCoder *)aDecoder;

/**
 
 Call this method will update the stored value and constraints spacing immediately.
 If there is no superview, no new constraints will be created.
 
 */

- (void)setSpacingWithSuperView:(BCAutoLayoutSpacing)spacing;

/**
 
 Call this method will update the constraints spacing after the before commit block is finished.
 If there is no superview, no new constraints will be created and array passed in before commit block will be empty.

 */


- (void)setSpacingWithSuperView:(BCAutoLayoutSpacing)spacing beforeCommit:(void (^)(NSArray *))beforeCommitBlock;

@end
