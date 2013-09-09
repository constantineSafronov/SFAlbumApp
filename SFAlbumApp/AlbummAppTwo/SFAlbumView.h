//
//  SFAlbumView.h
//  AlbummApp
//
//  Created by Constantine on 9/6/13.
//  Copyright (c) 2013 Privat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SFAlbumView.h"


@class SFAlbumView;

@protocol SFAlbumViewDelegate <NSObject>

-(void)SFAlbumView:(SFAlbumView *)albumView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;

@end


@interface SFAlbumView : UICollectionView <UICollectionViewDelegate,UICollectionViewDataSource>


@property(nonatomic,assign) id albumViewDelegate;
@property(nonatomic,strong) NSArray *dataSourceArray;


@end
