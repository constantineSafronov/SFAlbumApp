//
//  SFAlbumView.m
//  AlbummApp
//
//  Created by Constantine on 9/6/13.
//  Copyright (c) 2013 Privat. All rights reserved.
//

#import "SFAlbumView.h"
#import "SFStackLayout.h"
#import "SFCollectionViewCell.h"

#define CELL_ID @"CELL_ID"


@interface SFAlbumView () <UICollectionViewDataSource,UICollectionViewDelegate>

@end

@implementation SFAlbumView


#pragma mark -
#pragma mark init

-(id)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    
    if([super initWithFrame:frame collectionViewLayout:layout]){
        [self registerClass:[SFCollectionViewCell class] forCellWithReuseIdentifier:CELL_ID];
        self.delegate = self;
        self.dataSource = self;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
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


-(UICollectionViewController*)nextViewControllerAtPoint:(CGPoint)p
{
    return nil;
}

#pragma mark -
#pragma mark UICollectionView Delegate

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    SEL selector = @selector(SFAlbumView:didSelectItemAtIndexPath:);
    if(self.albumViewDelegate && [self.albumViewDelegate respondsToSelector:selector]){
        
        [self.albumViewDelegate SFAlbumView:self didSelectItemAtIndexPath:indexPath];
    }
}


@end
