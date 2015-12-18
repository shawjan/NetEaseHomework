//
//  SuperCardView.m
//  SuperCard
//
//  Created by shawjan on 15/12/14.
//  Copyright © 2015年 shawjan. All rights reserved.
//

#import "SuperCardView.h"


@interface SuperCardView ()
@property(nonatomic, assign) CGFloat faceCardScaleFactor;
@end

@implementation SuperCardView
@synthesize faceCardScaleFactor = _faceCardScaleFactor;
const CGFloat FaceCardScaleFactor = 0.9;
-(CGFloat)faceCardScaleFactor
{
    if(!_faceCardScaleFactor){
        _faceCardScaleFactor = FaceCardScaleFactor;
    }
    return _faceCardScaleFactor;
}

-(void)setFaceCardScaleFactor:(CGFloat)faceCardScaleFactor
{
    _faceCardScaleFactor = faceCardScaleFactor;
    [self setNeedsDisplay];
}

-(void)setRank:(NSUInteger)rank
{
    _rank = rank;
    [self setNeedsDisplay];
}

-(void)setFaceUp:(BOOL)faceUp
{
    _faceUp = faceUp;
    [self setNeedsDisplay];
}

-(void)setSuit:(NSString *)suit
{
    _suit = suit;
    [self setNeedsDisplay];
}

-(NSString*)rankAsString
{
    return @[@"?", @"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"Q", @"K"][self.rank];
}

-(void)pinchAction:(UIPinchGestureRecognizer*)pinchGesture
{
    if(self.faceUp){
        if(pinchGesture.state == UIGestureRecognizerStateChanged || pinchGesture.state == UIGestureRecognizerStateEnded){
            self.faceCardScaleFactor = pinchGesture.scale;
            //pinchGesture.scale = 1.0;
        }
    }
}

const NSInteger Default_Card_Height = 180;
const NSInteger Default_Card_Corner = 12.0;

-(CGFloat)viewScaleFactor{return self.bounds.size.height / Default_Card_Height;};
-(CGFloat)contentCorner{return [self viewScaleFactor] * Default_Card_Corner;};
-(CGFloat)contentOffset{return [self contentCorner] / 3.0;};

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:[self contentCorner]];
    [roundedRect addClip];
    [[UIColor whiteColor] setFill];
    UIRectFill(self.bounds);
    
    [[UIColor blackColor] setStroke];
    [roundedRect stroke];
    
    if(self.faceUp){
        
        UIImage *image = [UIImage imageNamed:@"cardback"];
        if(image){
            CGRect imageRect = CGRectInset(self.bounds, self.bounds.size.width * (1.0 - self.faceCardScaleFactor), self.bounds.size.height * (1.0 - self.faceCardScaleFactor));
            [image drawInRect:imageRect];
        }else{
            NSLog(@"done nothing!");
        }
        [self drawCorner];
    }else{
        UIImage *cardBackImage = [UIImage imageNamed:@"cardback"];
        [cardBackImage drawInRect:self.bounds];
    }
}

-(void)drawCorner
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.alignment = NSTextAlignmentCenter;
    UIFont *contentFont = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    contentFont = [contentFont fontWithSize:contentFont.pointSize * [self viewScaleFactor]];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\n%@", [self rankAsString], self.suit] attributes:@{NSParagraphStyleAttributeName:paragraphStyle, NSFontAttributeName: contentFont}];
    CGRect textBounds;
    textBounds.origin = CGPointMake([self contentOffset], [self contentOffset]);
    textBounds.size = attributedString.size;
    [attributedString drawInRect:textBounds];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, self.bounds.size.width, self.bounds.size.height);
    CGContextRotateCTM(context, M_PI);
    [attributedString drawInRect:textBounds];
}

-(void)setup
{
    self.backgroundColor = nil;
    self.opaque = NO;
    self.contentMode = UIViewContentModeRedraw;
}

-(void)awakeFromNib
{
    [self setup];
}
@end
