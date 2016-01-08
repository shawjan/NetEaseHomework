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
const CGFloat FaceCardScaleFactor = 0.85;
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

-(void)setRank:(NSInteger)rank
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
        
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%@%@", [self rankAsString], self.suit]];
        if(image){
            CGRect imageRect = CGRectInset(self.bounds, self.bounds.size.width * (1.0 - self.faceCardScaleFactor), self.bounds.size.height * (1.0 - self.faceCardScaleFactor));
            [image drawInRect:imageRect];
        }else{
            [self drawSuit];
        }
        [self drawCorner];
    }else{
        UIImage *cardBackImage = [UIImage imageNamed:@"cardback"];
        [cardBackImage drawInRect:self.bounds];
    }
}

-(void)drawSuit
{
    CGRect suitRect = CGRectInset(self.bounds, self.bounds.size.width * (1.0 - self.faceCardScaleFactor), self.bounds.size.height * (1.0 - self.faceCardScaleFactor));
    UIFont *font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    font = [font fontWithSize:font.pointSize *[self viewScaleFactor]];
    NSAttributedString *suitAttriStr = [[NSAttributedString alloc] initWithString:self.suit attributes:@{NSFontAttributeName: font}];
    CGSize fontSize = suitAttriStr.size;
    switch (self.rank) {
        case 1:
        case 2:
        case 3:
        case 4:
        case 5:
        case 6:
        {
            int col = self.rank > 3 ? 2 : 1;
            int row = (int)self.rank / col;
            CGFloat horizonGap = (suitRect.size.width - fontSize.width * col);
            CGFloat verticalGap = (suitRect.size.height - fontSize.height * row) / (row - 1);
            for (int i = 0; i < col; ++i) {
                for (int j = 0; j < row; ++j) {
                    CGRect textBounds;
                    CGFloat originX = col == 1 ? suitRect.origin.x + (suitRect.size.width - fontSize.width * col) / 2 : suitRect.origin.x + (horizonGap + fontSize.width) * i;
                    CGFloat originY = row == 1 ? suitRect.origin.y + (suitRect.size.height - fontSize.height) / 2 : suitRect.origin.y + (verticalGap + fontSize.height) * j;
                    textBounds.origin = CGPointMake(originX, originY);
                    textBounds.size = fontSize;
                    [suitAttriStr drawInRect:textBounds];
                }
            }
            if(self.rank == 5){
                CGRect textBounds;
                textBounds.origin = CGPointMake(suitRect.origin.x + (suitRect.size.width - fontSize.width) / 2, suitRect.origin.y + (suitRect.size.height - fontSize.height) / 2);
                textBounds.size = fontSize;
                [suitAttriStr drawInRect:textBounds];
            }
            break;
        }
        case 7:
        case 8:
        case 9:
        case 10:
        {
            int col = 3;
            int row = self.rank == 7 || self.rank == 8 ? 3 : 4;
            int remaind = (int)self.rank - row * (col - 1);
            CGFloat horizonGap = (suitRect.size.width - fontSize.width * col) / (col - 1);
            CGFloat verticalGap = (suitRect.size.height - fontSize.height * row) / (row - 1);
            for (int i = 0; i < col; ++i) {
                if(i == 1){
                    CGFloat extraVerticalGap = (suitRect.size.height - fontSize.height * 2) / 3;
                    for (int j = 0; j < remaind; ++j) {
                        CGRect textBounds;
                        textBounds.origin = CGPointMake(suitRect.origin.x + (horizonGap + fontSize.width) * i, suitRect.origin.y + extraVerticalGap + (extraVerticalGap + fontSize.height) * j);
                        textBounds.size = fontSize;
                        [suitAttriStr drawInRect:textBounds];
                    }
                }else{
                    for(int j = 0; j < row; ++j){
                        CGRect textBounds;
                        textBounds.origin = CGPointMake(suitRect.origin.x + (horizonGap + fontSize.width) * i, suitRect.origin.y + (verticalGap + fontSize.height) * j);
                        textBounds.size = fontSize;
                        [suitAttriStr drawInRect:textBounds];
                    }
                }
            }
            break;
        }
        default:
            break;
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
