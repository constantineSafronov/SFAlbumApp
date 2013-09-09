//
//  SFAlbumViewController.m
//  AlbummApp
//
//  Created by Constantine on 9/6/13.
//  Copyright (c) 2013 Privat. All rights reserved.
//

#import "SFAlbumViewController.h"
#import "SFAlbumView.h"
#import "SFCollectionViewCell.h"
#import "SFStackLayout.h"
#import "SFCollectionViewController.h"

#define MAX_COUNT 12
#define CELL_ID @"CELL_ID"
#define HIDDING_ANIMATION_DURATION 0.2f

@interface SFAlbumViewController ()

@property (nonatomic,strong) NSArray *dataSource;

@end

@implementation SFAlbumViewController


#pragma mark -
#pragma mark View Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupDataSource];
	[self.collectionView registerClass:[SFCollectionViewCell class] forCellWithReuseIdentifier:CELL_ID];
    self.title = @"Albums";
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    for(int i=0; i<[self collectionView:self.collectionView numberOfItemsInSection:0];i++){
        
        NSIndexPath *indexP = [NSIndexPath indexPathForItem:i inSection:0];
        SFCollectionViewCell* cell = (SFCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:indexP];
        
        [UIView animateWithDuration:HIDDING_ANIMATION_DURATION animations:^{
            [cell setAlpha:1.0f];
        }];
    }
}

#pragma mark -
#pragma mark Setup Data Source


-(void)setupDataSource{
    
    NSString *plistName = [NSString stringWithFormat:@"SFPhotosets"];
    NSArray *contentArray = [[NSMutableArray alloc] initWithContentsOfFile:
                             [[NSBundle mainBundle] pathForResource:plistName
                                                             ofType:@"plist"]];
    self.dataSource = contentArray;
}

#pragma mark -
#pragma mark UICollectionView Data Source

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
   SFCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:CELL_ID forIndexPath:indexPath];
    SFStackLayout* stackLayout = [[SFStackLayout alloc] init];
    SFAlbumView *albumView = [[SFAlbumView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, cell.frame.size.width, cell.frame.size.height) collectionViewLayout:stackLayout];
    albumView.dataSourceArray = [self.dataSource objectAtIndex:indexPath.item];
    albumView.userInteractionEnabled = NO;
    [cell setBackgroundView:albumView];
    
    return cell;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataSource ? [self.dataSource count] : 0;
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

#pragma mark -
#pragma mark UICollectionView Delegate

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self hideExtraAlbumsExceptAlbumAtIndexPath:indexPath];
}

#pragma mark -
#pragma mark NextViewControllerAtPoint


-(UICollectionViewController*)nextViewControllerAtPoint:(CGPoint)p withIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *attributes = [self.collectionView layoutAttributesForItemAtIndexPath:indexPath];
    CGPoint cellPoint;
    CGFloat navBarHeight = self.navigationController.navigationBar.frame.size.height;
    CGFloat statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
    if(statusBarHeight > 20.0f){
        statusBarHeight = 20.0f; // ios beta 6 sometimes shows 568.0 for status bar, maybe this issue would be fixed
    }
    CGFloat barsHeight = navBarHeight + statusBarHeight;
    
    if(self.collectionView.contentOffset.y > 0){
        cellPoint = CGPointMake(attributes.center.x, attributes.center.y - (self.collectionView.contentOffset.y + barsHeight));
    }else{
        cellPoint = attributes.center;
    }
    
    SFStackLayout* stackLayout = [[SFStackLayout alloc] init];
    stackLayout.targetCenter = cellPoint;
    SFCollectionViewController *nextCollectionViewController = [[SFCollectionViewController alloc] initWithCollectionViewLayout:stackLayout];
    nextCollectionViewController.dataSourceArray = [self.dataSource objectAtIndex:indexPath.item];
    nextCollectionViewController.collectionView.dataSource = nextCollectionViewController;
    
    return nextCollectionViewController;
}

#pragma mark -
#pragma mark HideExtraAlbumsExceptAlbumAtIndexPath


-(void)hideExtraAlbumsExceptAlbumAtIndexPath:(NSIndexPath *)indexPath{
    
    NSMutableArray *indexArray = [NSMutableArray array];
    for(int i=0; i<[self collectionView:self.collectionView numberOfItemsInSection:0];i++){
        
        NSIndexPath *indexP = [NSIndexPath indexPathForItem:i inSection:0];
        if(indexPath.item != i){
            [indexArray addObject:indexP];
        }
    }
    [UIView animateWithDuration:HIDDING_ANIMATION_DURATION animations:^{
        
        [indexArray enumerateObjectsUsingBlock:^(NSIndexPath *index, NSUInteger idx, BOOL *stop) {
            SFCollectionViewCell* cell = (SFCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:index];
            [cell setAlpha:0.0f];
        }];
        
    } completion:^(BOOL finished) {
        [self.navigationController pushViewController:[self nextViewControllerAtPoint:CGPointZero withIndexPath:indexPath] animated:NO];
    }];
}

@end
