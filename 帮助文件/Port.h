//
//  Port.m
//  ZuiMei
//
//  Created by 王大帅 on 15/9/14.
//  Copyright (c) 2015年 王大帅. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
// 1.精选分类
#define JING_XUAN_FEN_LEI @"http://zuimeia.com/api/navigation/all/app/top/?platform=2&openUDID=868201025680583&appVersion=3.2.2&appVersionCode=30202&systemVersion=21&resolution=1080x1920&platform=2&app_client=NiceAppAndroid&phoneModel=MX5"

// 2.侧栏信息
#define CE_LAN_XIN_XI @"http://zuimeia.com/api/config/?platform=2&user_id=0&openUDID=868201025680583&appVersion=3.2.2&appVersionCode=30202&systemVersion=21&resolution=1080x1920&platform=2&app_client=NiceAppAndroid&phoneModel=MX5"



// 3.应用信息
http://zuimeia.com/common/app/update/?package_name=com.brixd.niceapp&openUDID=868201025680583&appVersion=3.2.2&appVersionCode=30202&systemVersion=21&resolution=1080x1920&platform=android&channel=com.zuiapps.upgrade&lang=zh-cn

4.每日最美（首页）
http://zuimeia.com/api/apps/app/daily/?platform=2&page=1&page_size=20&openUDID=868201025680583&appVersion=3.2.2&appVersionCode=30202&systemVersion=21&resolution=1080x1920&platform=2&app_client=NiceAppAndroid&phoneModel=MX5

http://zuimeia.com/api/apps/app/daily/?platform=2&page=2&page_size=20&openUDID=868201025680583&appVersion=3.2.2&appVersionCode=30202&systemVersion=21&resolution=1080x1920&platform=2&app_client=NiceAppAndroid&phoneModel=MX5

5.随机？？？ (不可用)
http://zuimeia.com/api/v2/apps/random/?platform=2&openUDID=868201025680583&appVersion=3.2.2&appVersionCode=30202&systemVersion=21&resolution=&platform=2&app_client=NiceAppAndroid&phoneModel=MX5


6.发现应用—美友信息 （可用）
http://zuimeia.com/api/community/rank/users/?openUDID=868201025680583&appVersion=3.2.2&appVersionCode=30202&systemVersion=21&resolution=1080x1920&platform=2&app_client=NiceAppAndroid&phoneModel=MX5

http://zuimeia.com/api/community/rank/users/?openUDID=868201025680583&appVersion=3.2.2&appVersionCode=30202&systemVersion=21&resolution=1080x1920&platform=2&app_client=NiceAppAndroid&phoneModel=MX5

7.发现应用—排行信息 （不可用）
http://zuimeia.com/api/v2/apps/rank/?page=1&page_size=50&openUDID=868201025680583&appVersion=3.2.2&appVersionCode=30202&systemVersion=21&resolution=1080x1920&platform=2&app_client=NiceAppAndroid&phoneModel=MX5
http://zuimeia.com/api/v2/apps/rank/?page=1&page_size=50&openUDID=868201025680583&appVersion=3.2.2&appVersionCode=30202&systemVersion=21&resolution=1080x1920&platform=2&app_client=NiceAppAndroid&phoneModel=MX5

8.发现应用—精选信息 （不可用）
http://zuimeia.com/api/v3/apps/?start_date=0&openUDID=868201025680583&appVersion=3.2.2&appVersionCode=30202&systemVersion=21&resolution=1080x1920&platform=2&app_client=NiceAppAndroid&phoneModel=MX5

http://zuimeia.com/api/v3/apps/?start_date=0&openUDID=868201025680583&appVersion=3.2.2&appVersionCode=30202&systemVersion=21&resolution=1080x1920&platform=2&app_client=NiceAppAndroid&phoneModel=MX5

9. 发现应用—最新 （可用）
http://zuimeia.com/api/community/apps/?pos=-1&page_size=20&platform=2&openUDID=868201025680583&appVersion=3.2.2&appVersionCode=30202&systemVersion=21&resolution=1080x1920&platform=2&app_client=NiceAppAndroid&phoneModel=MX5

10.发现应用— 合集 (不可用)
http://zuimeia.com/api/v2/albums/?page=1&page_size=20&openUDID=868201025680583&appVersion=3.2.2&appVersionCode=30202&systemVersion=21&resolution=1080x1920&platform=2&app_client=NiceAppAndroid&phoneModel=MX5

11.游戏
http://zuimeia.com/api/apps/app/game/?page=1&page_size=20&openUDID=868201025680583&appVersion=3.2.2&appVersionCode=30202&systemVersion=21&resolution=1080x1920&platform=2&app_client=NiceAppAndroid&phoneModel=MX5

http://zuimeia.com/api/apps/app/game/?page=1&page_size=20&openUDID=868201025680583&appVersion=3.2.2&appVersionCode=30202&systemVersion=21&resolution=1080x1920&platform=2&app_client=NiceAppAndroid&phoneModel=MX5

12.游戏？？？
http://zuimeia.com/api/category/12/all/?type=zuimei.daily&page=1&page_size=20&openUDID=868201025680583&appVersion=3.2.2&appVersionCode=30202&systemVersion=21&resolution=1080x1920&platform=2&app_client=NiceAppAndroid&phoneModel=MX5

13.精选分类 - - 全部
http://zuimeia.com/api/navigation/60/app/all/?platform=2&page=1&page_size=20&openUDID=868201025680583&appVersion=3.2.2&appVersionCode=30202&systemVersion=21&resolution=1080x1920&platform=2&app_client=NiceAppAndroid&phoneModel=MX5

14.搜索关键字
http://zuimeia.com/api/community/tags/?type=zuimei.tag.home&platform=2&openUDID=868201025680583&appVersion=3.2.2&appVersionCode=30202&systemVersion=21&resolution=1080x1920&platform=2&app_client=NiceAppAndroid&phoneModel=MX5
*/

// 1.发现应用
// 1.1精选--不可用
#define DISCOVER_STAR_URL @"http://zuimeia.com/api/v3/apps/?start_date=0&openUDID=868201025680583&appVersion=3.2.2&appVersionCode=30202&systemVersion=21&resolution=1080x1920&platform=2&app_client=NiceAppAndroid&phoneModel=MX5"

// 1.2最新
#define DISCOVER_NEW_URL @"http://zuimeia.com/api/community/apps/?pos=%ld&page_size=20&platform=2&openUDID=868201025680583&appVersion=3.2.2&appVersionCode=30202&systemVersion=21&resolution=1080x1920&platform=2&app_client=NiceAppAndroid&phoneModel=MX5"
// 1.3合辑--不可用
#define DISCOVER_GROUP_URL @"http://zuimeia.com/api/v2/albums/?page=1&page_size=20&openUDID=868201025680583&appVersion=3.2.2&appVersionCode=30202&systemVersion=21&resolution=1080x1920&platform=2&app_client=NiceAppAndroid&phoneModel=MX5"
// 1.4美友
#define DISCOVER_FRIEND_URL @"http://zuimeia.com/api/community/rank/users/?openUDID=868201025680583&appVersion=3.2.2&appVersionCode=30202&systemVersion=21&resolution=1080x1920&platform=2&app_client=NiceAppAndroid&phoneModel=MX5"
// 1.5排行--不可用
#define DISCOVER_RANK_URL @"http://zuimeia.com/api/v2/apps/rank/?page=1&page_size=50&openUDID=868201025680583&appVersion=3.2.2&appVersionCode=30202&systemVersion=21&resolution=1080x1920&platform=2&app_client=NiceAppAndroid&phoneModel=MX5"
// 2.每日最美
#define DAYLY_BEST_URL  @"http://zuimeia.com/api/apps/app/daily/?platform=2&page=%ld&page_size=20&openUDID=868201025680583&appVersion=3.2.2&appVersionCode=30202&systemVersion=21&resolution=1080x1920&platform=2&app_client=NiceAppAndroid&phoneModel=MX5"

// 3.精选分类

#define CATEGORY_STAR_URL @"http://zuimeia.com/api/navigation/all/app/top/?platform=2&openUDID=868201025680583&appVersion=3.2.2&appVersionCode=30202&systemVersion=21&resolution=1080x1920&platform=2&app_client=NiceAppAndroid&phoneModel=MX5"

// 4.游戏推荐
#define GAME_URL @"http://zuimeia.com/api/apps/app/game/?page=%ld&page_size=20&openUDID=868201025680583&appVersion=3.2.2&appVersionCode=30202&systemVersion=21&resolution=1080x1920&platform=2&app_client=NiceAppAndroid&phoneModel=MX5"


// 4.评论列表

#define COMMENT_URL @"http://zuimeia.com/api/comment/%ld/all/?user_id=0&type=zuimei.daily&page=%ld&page_size=10&openUDID=868201025680583&appVersion=3.2.2&appVersionCode=30202&systemVersion=21&resolution=1080x1920&platform=2&app_client=NiceAppAndroid&phoneModel=MX5"


// 5.app信息
#define APP_INFO_URL @"http://zuimeia.com/api/apps/app/%ld/?openUDID=868201025680583&appVersion=3.2.2&appVersionCode=30202&systemVersion=21&resolution=1080x1920&platform=2&app_client=NiceAppAndroid&phoneModel=MX5"

// 6.更多分类APP

#define MORE_APP_URL @"http://zuimeia.com/api/navigation/%@/app/all/?platform=2&page=%ld&page_size=20&openUDID=868201025680583&appVersion=3.2.2&appVersionCode=30202&systemVersion=21&resolution=1080x1920&platform=2&app_client=NiceAppAndroid&phoneModel=MX5"


// http://zuimeia.com/api/comment/3362/all/?user_id=0&type=zuimei.daily&page=1&page_size=10&openUDID=868201025680583&appVersion=3.2.2&appVersionCode=30202&systemVersion=21&resolution=1080x1920&platform=2&app_client=NiceAppAndroid&phoneModel=MX5

// 用户信息
#define USER_INFO_URL @"http://zuimeia.com/api/user/%@/statistic/?platform=2&openUDID=null&appVersion=3.2.2&appVersionCode=30202&systemVersion=22&resolution=1080x1920&platform=2&app_client=NiceAppAndroid&phoneModel=MX5"

// 推荐应用
#define COMMUNITY_APPS_URL @"http://zuimeia.com/api/user/%@/community/apps/?page=%ld&page_size=20&platform=2&openUDID=null&appVersion=3.2.2&appVersionCode=30202&systemVersion=22&resolution=1080x1920&platform=2&app_client=NiceAppAndroid&phoneModel=MX5"

// 收藏应用
#define COLLECT_APPS_URL @"http://zuimeia.com/api/collect/%@/all/?page=%ld&page_size=20&platform=2&openUDID=null&appVersion=3.2.2&appVersionCode=30202&systemVersion=22&resolution=1080x1920&platform=2&app_client=NiceAppAndroid&phoneModel=MX5"

// 搜索页面
#define SEARCH_INFO_URL @"http://zuimeia.com/api/community/tags/?type=%@&platform=2&openUDID=null&appVersion=3.2.2&appVersionCode=30202&systemVersion=22&resolution=1080x1920&platform=2&app_client=NiceAppAndroid&phoneModel=MX5"

#define SEARCH_RESULT_URL @"http://zuimeia.com/api/search/?openUDID=null&appVersion=3.2.2&appVersionCode=30202&systemVersion=22&resolution=1080x1920&platform=2&app_client=NiceAppAndroid&phoneModel=MX5"







