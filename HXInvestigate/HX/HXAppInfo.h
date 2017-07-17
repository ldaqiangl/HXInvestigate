//
//  HXAppInfo.h
//  HBBForPrincipal
//
//  Created by 董富强 on 16/7/20.
//  Copyright © 2016年 HXKid. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HXAppInfo : NSObject

@property (nonatomic, strong) NSArray *languageCodesISO2A;
@property (nonatomic, strong) NSArray *supportedDevices;
@property (nonatomic, strong) NSArray *ipadScreenshotUrls;
@property (nonatomic, strong) NSArray *appletvScreenshotUrls;
@property (nonatomic, strong) NSArray *genreIds;
@property (nonatomic, strong) NSArray *screenshotUrls;
@property (nonatomic, strong) NSArray *advisories;
@property (nonatomic, strong) NSArray *genres;


@property (nonatomic, copy) NSString *primaryGenreName;
@property (nonatomic, copy) NSString *artworkUrl100;
@property (nonatomic, copy) NSString *currency;
@property (nonatomic, copy) NSString *artworkUrl512;
@property (nonatomic, copy) NSString *fileSizeBytes;
@property (nonatomic, copy) NSString *artworkUrl60;
@property (nonatomic, copy) NSString *trackViewUrl;
//@property (nonatomic, copy) NSString *description;
@property (nonatomic, copy) NSString *version;
@property (nonatomic, copy) NSString *bundleId;
@property (nonatomic, copy) NSString *artistViewUrl;
@property (nonatomic, copy) NSString *releaseDate;
@property (nonatomic, copy) NSString *isGameCenterEnabled;
@property (nonatomic, copy) NSString *wrapperType;
@property (nonatomic, copy) NSString *trackId;
@property (nonatomic, copy) NSString *minimumOsVersion;
@property (nonatomic, copy) NSString *formattedPrice;
@property (nonatomic, copy) NSString *primaryGenreId;
@property (nonatomic, copy) NSString *currentVersionReleaseDate;
@property (nonatomic, copy) NSString *artistId;
@property (nonatomic, copy) NSString *trackContentRating;
@property (nonatomic, copy) NSString *artistName;

@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *trackCensoredName;
@property (nonatomic, copy) NSString *trackName;

@property (nonatomic, copy) NSString *kind;
@property (nonatomic, copy) NSString *contentAdvisoryRating;
@property (nonatomic, copy) NSString *releaseNotes;
@property (nonatomic, copy) NSString *isVppDeviceBasedLicensingEnabled;
@property (nonatomic, copy) NSString *sellerName;

@end
