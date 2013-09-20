//
//  SFCollectionViewController.m
//  AlbumsApp
//
//  Created by Constantine on 9/5/13.
//  Copyright (c) 2013 Privat. All rights reserved.
//

#import "SFCollectionViewController.h"
#import "SFCollectionViewCell.h"
#import "SFAlbumViewController.h"
#import "SFStackLayout.h"

#define CELL_ID @"CELL_ID"

static const int MaxItemsCountOnScreen = 15;

@interface SFCollectionViewController ()

@property (nonatomic,strong) SFStackLayout* stackLayout;
@end

@implementation SFCollectionViewController


#pragma mark -
#pragma mark init

-(id)initWithCollectionViewLayout:(UICollectionViewFlowLayout *)layout
{
    if (self = [super initWithCollectionViewLayout:layout])
    {
        [self.collectionView registerClass:[SFCollectionViewCell class] forCellWithReuseIdentifier:CELL_ID];
        self.stackLayout = (SFStackLayout *)layout;
        self.title = @"Photos";
    }
    return self;
}

#pragma mark -
#pragma mark View Life Cycle

-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    [self performSelector:@selector(changeLayout) withObject:nil afterDelay:0.0];
}


-(void)viewDidLoad{
    
    [super viewDidLoad];
    [self.collectionView setBackgroundColor:[UIColor whiteColor]];
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemReply target:self action:@selector(backBarButtonWasTapped)];
    [self.navigationItem setLeftBarButtonItem:backButton];
}

#pragma mark -
#pragma mark ButtonsAction


-(void)backBarButtonWasTapped{
    
    __block __weak id weakSelf = self;
    
    if([self.dataSourceArray count] > MaxItemsCountOnScreen){
        [self.collectionView setContentOffset:CGPointMake(0.0f, 0.0f) animated:YES];
        [self.collectionView reloadData];
    }
    [self.collectionView setCollectionViewLayout:self.stackLayout animated:YES completion:^(BOOL finished) {
        [weakSelf popBack];
    }];
}


-(void)popBack{
    [self.navigationController popViewControllerAnimated:NO];
}

#pragma mark -
#pragma mark ChangeLayout

-(void)changeLayout{
    
    UICollectionViewFlowLayout* grid = [[UICollectionViewFlowLayout alloc] init];
    grid.itemSize = CGSizeMake(93.0, 93.0);
    grid.sectionInset = UIEdgeInsetsMake(10.0, 10.0, 10.0, 10.0);
    [self.collectionView setCollectionViewLayout:grid animated:YES];
}


#pragma mark -
#pragma mark UICollectionView Data Source

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SFCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:CELL_ID forIndexPath:indexPath];
     cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg",[self.dataSourceArray objectAtIndex:indexPath.item]]];
    return cell;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataSourceArray ? [self.dataSourceArray count] : 0;
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}


#pragma mark -
#pragma mark UICollectionView Delegate


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //do somthing, for example push Scroll Controller
}


@end
