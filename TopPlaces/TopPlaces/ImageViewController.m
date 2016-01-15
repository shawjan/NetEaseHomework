//
//  ImageViewController.m
//  Imaginarium
//
//  Created by shawjan on 15/12/22.
//  Copyright © 2015年 shawjan. All rights reserved.
//

#import "ImageViewController.h"

@interface ImageViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *imageScrollView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property(nonatomic, strong) UIImageView *imageView;
@property(nonatomic, strong) UIImage *image;
@end
//http://images.apple.com/v/iphone-5s/gallery/a/images/download/photo_1.jpg
@implementation ImageViewController

-(void)setImageScrollView:(UIScrollView *)imageScrollView
{
    _imageScrollView = imageScrollView;
    self.imageScrollView.contentSize = self.imageView ? self.imageView.frame.size : CGSizeZero;//取决于scrollview创建的时间，有可能image已经下载好了，但是scrollview还未创建，也有可能相反，因此需要保持一致。
    self.imageScrollView.minimumZoomScale = 0.2;
    self.imageScrollView.maximumZoomScale = 2.0;
    self.imageScrollView.delegate = self;
}

-(void)setImageURL:(NSURL *)imageURL
{
    [self.activityIndicator startAnimating];
    _imageURL = imageURL;
    [self startDownloadingImage];

    //self.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:self.imageURL]];
   
}

-(void)startDownloadingImage
{
    self.image = nil;
    if(self.imageURL){
        NSURLRequest *request = [NSURLRequest requestWithURL:self.imageURL];
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration ephemeralSessionConfiguration];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
        NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request
            completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:location]];
                if(!error){
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.activityIndicator stopAnimating];
                        self.image = image;
                    });
                }
        }];
        [task resume];//
    }
}

-(UIImage *)image
{
    return self.imageView.image;
}

-(void)setImage:(UIImage *)image
{
    self.imageScrollView.zoomScale = 1.0;
    self.imageView.image = image;
    [self.imageView sizeToFit];
    self.imageView.frame = CGRectMake(0, 0, self.imageView.frame.size.width, self.imageView.frame.size.height);
    self.imageScrollView.contentSize = self.imageView ? self.imageView.frame.size : CGSizeZero;//取决于scrollview创建的时间，有可能image已经下载好了，但是scrollview还未创建，也有可能相反，因此需要保持一致。
}

-(UIImageView *)imageView
{
    if(!_imageView){
        _imageView = [[UIImageView alloc] init];
    }
    return _imageView;
}

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.imageScrollView addSubview:self.imageView];
    //self.imageView.backgroundColor = [UIColor redColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
