//
//  ScaleBounceController.m
//  SKBounceAnimation
//
//  Created by Soroush Khanlou on 8/15/12.
//
//

#import "ScaleBounceController.h"

@interface ScaleBounceController ()
@property(nonatomic,strong)UIView *bouncingView1;
@property(nonatomic,strong)UIView *bouncingView2;
@property(nonatomic,strong)UIView *bouncingView3;
@property(nonatomic,strong)NSMutableArray *viewArray;

@end

@implementation ScaleBounceController



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	self.title = @"Scale Bounce";

    [self setupViewArray];
    

//	bouncingView.layer.transform = CATransform3DScale(bouncingView.layer.transform, 2, 2, 2);

	self.view.backgroundColor = [UIColor whiteColor];
    
    
    UIBarButtonItem *testButton1 = [[UIBarButtonItem alloc]
                                   initWithTitle:@"doTest1" style:UIBarButtonItemStylePlain
                                   target:self action:@selector(doTest1:)];
    
    UIBarButtonItem *testButton2 = [[UIBarButtonItem alloc]
                                    initWithTitle:@"doTest2" style:UIBarButtonItemStylePlain
                                    target:self action:@selector(doTest2:)];

    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:testButton1, testButton2, nil];
 
    
}

-(void)setupViewArray{
    self.viewArray = [NSMutableArray array];
    
    
    self.bouncingView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
	self.bouncingView1.center = CGPointMake(50, 200);
	self.bouncingView1.backgroundColor = [UIColor cyanColor];
	[self.view addSubview:self.bouncingView1];
    
    [self.viewArray addObject:self.bouncingView1];
	
	UILabel *textLabel1 = [[UILabel alloc] initWithFrame:self.bouncingView1.bounds];
	textLabel1.text = @"text1";
	textLabel1.textAlignment = UITextAlignmentCenter;
	textLabel1.backgroundColor = [UIColor clearColor];
	[self.bouncingView1 addSubview:textLabel1];
	
    
	self.bouncingView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
	self.bouncingView2.center = CGPointMake(120, 200);
	self.bouncingView2.backgroundColor = [UIColor cyanColor];
	[self.view addSubview:self.bouncingView2];
    [self.viewArray addObject:self.bouncingView2];
     
	UILabel *textLabel2 = [[UILabel alloc] initWithFrame:self.bouncingView1.bounds];
	textLabel2.text = @"text1";
	textLabel2.textAlignment = UITextAlignmentCenter;
	textLabel2.backgroundColor = [UIColor clearColor];
	[self.bouncingView2 addSubview:textLabel2];
    
	self.bouncingView3 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
	self.bouncingView3.center = CGPointMake(200, 200);
	self.bouncingView3.backgroundColor = [UIColor cyanColor];
	[self.view addSubview:self.bouncingView3];
    [self.viewArray addObject:self.bouncingView3];
    
	UILabel *textLabel3 = [[UILabel alloc] initWithFrame:self.bouncingView1.bounds];
	textLabel3.text = @"text1";
	textLabel3.textAlignment = UITextAlignmentCenter;
	textLabel3.backgroundColor = [UIColor clearColor];
	[self.bouncingView3 addSubview:textLabel3];

}

- (void)doTest1:(id)sender
{
    for( UIView *v in self.viewArray){
        [self bounceAnimation:v toScale:1.4 numberOfBounce:5 duration:0.5f];
    }
    
    [self performSelector:@selector(doTest2) withObject:nil afterDelay:1];
}
/*
- (void)doTest2:(id)sender
{
    [self bounceAnimation:bouncingView toScale:0.7 numberOfBounce:3 duration:0.5f];
}
 */

- (void)doTest2
{
    for( UIView *v in self.viewArray){
        [self bounceAnimation:v toScale:0.7 numberOfBounce:3 duration:0.5f];
    }

}

-(void)bounceAnimation:(UIView*)view
               toScale:(CGFloat)toScale
        numberOfBounce:(NSUInteger)numberOfBounce
              duration:(CFTimeInterval)duration {
    
	NSString *keyPath = @"transform";
	CATransform3D transform = view.layer.transform;
	id finalValue = [NSValue valueWithCATransform3D:
                     CATransform3DScale(transform, toScale, toScale, toScale)
                     ];
	
	SKBounceAnimation *bounceAnimation = [SKBounceAnimation animationWithKeyPath:keyPath];
	bounceAnimation.fromValue = [NSValue valueWithCATransform3D:transform];
	bounceAnimation.toValue = finalValue;
	bounceAnimation.duration = duration;
	bounceAnimation.numberOfBounces = numberOfBounce;
	bounceAnimation.shouldOvershoot = YES;
	
	[view.layer addAnimation:bounceAnimation forKey:@"someKey"];
	
	[view.layer setValue:finalValue forKeyPath:keyPath];
}

@end
