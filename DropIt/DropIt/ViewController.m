//
//  ViewController.m
//  DropIt
//
//  Created by shawjan on 15/12/18.
//  Copyright © 2015年 shawjan. All rights reserved.
//

#import "ViewController.h"
#import "DropItBehavior.h"


@interface ViewController ()<UIDynamicAnimatorDelegate>
@property (weak, nonatomic) IBOutlet UIView *gameView;
@property(nonatomic, strong) UIDynamicAnimator *animator;
@property (nonatomic, strong) DropItBehavior *dropItBehavior;
@end

const CGSize Default_Size = {40, 40};

@implementation ViewController

-(UIDynamicAnimator *)animator
{
    if(!_animator){
        _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.gameView];
        _animator.delegate = self;
    }
    return _animator;
}

-(DropItBehavior *)dropItBehavior
{
    if(!_dropItBehavior){
        _dropItBehavior = [[DropItBehavior alloc] init];
        [self.animator addBehavior:self.dropItBehavior];
    }
    return _dropItBehavior;
}

- (IBAction)tapGesture:(UITapGestureRecognizer *)sender {
    [self dropIt];
}

-(void)dropIt
{
    CGRect frame;
    frame.origin = CGPointZero;
    frame.size = Default_Size;
    int x = (arc4random() % (int)self.view.bounds.size.width) / Default_Size.width;
    frame.origin.x = x *Default_Size.width;
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.backgroundColor = [self randomColor];
    [self.gameView addSubview:view];
    [self.dropItBehavior addItem:view];
}

-(void)dynamicAnimatorDidPause:(UIDynamicAnimator *)animator
{
    [self removeCompleteRows];
}

-(BOOL)removeCompleteRows
{
    NSMutableArray *dropsToRemove = [[NSMutableArray alloc] init];
    for(CGFloat y = self.gameView.bounds.size.height - Default_Size.height / 2; y > 0; y -= Default_Size.height){
        BOOL rowIsComplete = YES;
        NSMutableArray *dropsFound = [[NSMutableArray alloc] init];
        for(CGFloat x = Default_Size.width/2; x <self.gameView.bounds.size.width; x += Default_Size.width){
            UIView *hitView = [self.gameView hitTest:CGPointMake(x, y) withEvent:NULL];
            if([hitView superview] == self.gameView){
                [dropsFound addObject:hitView];
            }else{
                rowIsComplete = NO;
                break;
            }
        }
        if(![dropsFound count]) break;
        if(rowIsComplete) [dropsToRemove addObjectsFromArray:dropsFound];
    }
    
    if([dropsToRemove count]){
        for (UIView *drop in dropsToRemove) {
            [self.dropItBehavior removeItem:drop];
        }
        [self animatorRemoveDrop:dropsToRemove];
    }
    return NO;
}

-(void)animatorRemoveDrop:(NSArray*)items
{
    [UIView animateWithDuration:1.0
                     animations:^{
                         for(UIView *drop in items){
                             int x = arc4random() % (int)(self.gameView.bounds.size.width * 5) - self.gameView.bounds.size.width * 2;
                             int y = self.gameView.bounds.size.height;
                             drop.center = CGPointMake(x, -y);
                         }
                     }completion:^(BOOL finished){
                         [items makeObjectsPerformSelector:@selector(removeFromSuperview)];
                     }];
}

-(UIColor *)randomColor
{
    switch (arc4random() % 3) {
        case 0:
            return [UIColor redColor];
        case 1:
            return [UIColor greenColor];
        case 2:
            return [UIColor yellowColor];
        default:
            break;
    }
    return [UIColor blueColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
