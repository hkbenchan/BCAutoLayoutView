BCAutoLayoutView
---

A drop-in solution for add subviews without consider setting NSLayoutConstraint.

A UIView subclass that create constraints to its superview's inner bounds.

Installation
---

Manual install
---
Copy BCAutoLayoutView.h and BCAutoLayoutView.m to your directory.

Using CocoaPods
---
```ruby
pod "BCAutoLayoutView"
```

Usage
---

Minimal implementation

```objective-c

// In some ViewController files...

// create a UIView with 100x100 size
BCAutoLayoutView *view = [[BCAutoLayoutView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];

// view will be added with Top(0), Bottom(0), Leading(0), Trailing(0) constraints to superview
[self.view addSubview:view];

```

Use
```objective-c
- (void)setSpacingWithSuperView:(BCAutoLayoutSpace)space;
```
to set the constraints to BCAutoLayoutView

```objective-c

// this can be called after the view is setup and at the time with the view is already added in the superview
// once called, the view will be added with Top(10), Bottom(20), Leading(30), Trailing(40) constraints
[view setSpacingWithSuperView:BCAutoLayoutMakeSpacing(10, 20, 30, 40)];

```
