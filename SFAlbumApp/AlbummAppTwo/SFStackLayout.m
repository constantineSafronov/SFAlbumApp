//
//  SFStackLayout.m
//  AlbummApp
//
//  Created by Constantine on 9/6/13.
//  Copyright (c) 2013 Privat. All rights reserved.
//

#import "SFStackLayout.h"
#import <UIKit/UIGeometry.h>



@implementation SFStackLayout
{
    NSMutableArray *_angles;
    NSMutableArray *_attributesArray;
}

- (id) init
{
    self = [super init];
    
    if (self) {
        _stackCount = 2;
        _itemSize = CGSizeMake(80, 120);
        _angles = [[NSMutableArray alloc] initWithCapacity:_stackCount * 10];
    }
    return self;
}


- (void)prepareLayout
{
    CGSize size = self.collectionView.bounds.size;
    
    CGPoint center;
    if(self.targetCenter.x > 0){
        center = CGPointMake(self.targetCenter.x, self.targetCenter.y);
    }else{
        center = CGPointMake(size.width / 2.0, size.height / 2.0);
    }
    

    // We only display one section in this layout.
    NSInteger itemCount = [self.collectionView numberOfItemsInSection:0];
    
    if (!_attributesArray) {
        _attributesArray = [[NSMutableArray alloc] initWithCapacity:itemCount];
    }
    [_angles removeAllObjects];
    
    CGFloat maxAngle = M_1_PI / 1.2;
    CGFloat minAngle = - M_1_PI / 1.2;
    CGFloat diff = maxAngle - minAngle;
    
    [_angles addObject:[NSNumber numberWithFloat:0]];
    for (NSInteger i = 1; i < _stackCount * 10; i++) {
        int hash = (i * 2654435761 % 2^32);
        hash = (hash * 2654435761 % 2^32);

        CGFloat currentAngle = ((hash % 1000) / 1000.0 * diff) + minAngle;
        [_angles addObject:[NSNumber numberWithFloat:currentAngle]];
    }
    
    for (NSInteger i = 0; i < itemCount; i ++) {
        
        NSInteger angleIndex = i % (_stackCount * 10);
        
        NSNumber *angleNumber = [_angles objectAtIndex:angleIndex];
        CGFloat angle = angleNumber.floatValue;
        
        UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
        attributes.size = _itemSize;        
        attributes.center = center;
        attributes.transform = CGAffineTransformMakeRotation(angle);
        
        if (i > _stackCount)
        {
            attributes.alpha = 0.0;
        }
        else
        {
            attributes.alpha = 1.0;
        }
        attributes.zIndex = (itemCount - i);
        
        [_attributesArray addObject:attributes];
    }
}


- (void)invalidateLayout
{
    _attributesArray = nil;
}


- (CGSize)collectionViewContentSize
{
    return self.collectionView.bounds.size;
}


- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [_attributesArray objectAtIndex:indexPath.item];
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    return _attributesArray;
}


@end
