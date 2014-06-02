

#import "API.h"
#import "AFNetworking.h"
#import "WCViewController.h"

@implementation API

@synthesize mClientInfoDict;
@synthesize mDataDict;
@synthesize mVC;
@synthesize mDeviceToken;
@synthesize mDate;
@synthesize mMatch;
@synthesize mTeam1;
@synthesize mTeam2;


static API *instance;
static NSBundle *bundle = nil;

// SAVE KEY
NSString *M_TABLE = @"M_TABLE_1";


+ (API*)getAPI {
    if (instance == nil) {
        instance = [[API alloc] init];
    }
    return instance;
}

- (API*)init {
    API *a = [super init];
    
    
    self.mClientInfoDict = [[NSMutableDictionary alloc] init];
    self.mDataDict = [[NSMutableDictionary alloc] init];
    
    [self initLanguage];
    
    [mClientInfoDict setValue:API_VERSION forKey:@"apiv"];
    NSString * appVersionString = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
	[mClientInfoDict setValue:appVersionString forKey:@"appv"];
	[mClientInfoDict setValue:@"ios" forKey:@"platform"];
    NSString *mid = [UIDevice currentDevice].model;
	[mClientInfoDict setValue:mid forKey:@"mid"];
    
    return a;
}

// Localize

- (NSString*)getLanguage {
    NSUserDefaults* defs = [NSUserDefaults standardUserDefaults];
    NSArray* languages = [defs objectForKey:@"AppleLanguages"];
    return [languages objectAtIndex:0];
}

- (void)initLanguage {
    [self setLanguage:[self getLanguage]];
}

- (void)setLanguage:(NSString *)l {
//    
//    if(![l isEqualToString:@"en"]
//       && ![l isEqualToString:@"th"]
//       && ![l isEqualToString:@"ja"])
//        l = @"en";
//    
//    NSString *path = [[NSBundle mainBundle] pathForResource:l ofType:@"lproj" ];
//    bundle = [NSBundle bundleWithPath:path];
//    
//    [[NSUserDefaults standardUserDefaults] setObject:[NSArray arrayWithObjects:l, nil] forKey:@"AppleLanguages"];
//    [[NSUserDefaults standardUserDefaults] synchronize];
    [mClientInfoDict setValue:l forKey:@"language"];
}

- (NSString *)translate:(NSString *)key {
    return [bundle localizedStringForKey:key value:@"" table:nil];
}



// #PERSISTENCE_BEGEIN
#pragma mark - PERSISTENCE

- (id)getObject:(NSString*)key {
    id obj;
    obj = [mDataDict objectForKey:key];
    if(!obj){
        obj = [self loadObject:key];
        if(obj)
            [mDataDict setObject:obj forKey:key];
    }
    return obj;
}

- (id)loadObject:(NSString*)key {
	NSUserDefaults *u = [NSUserDefaults standardUserDefaults];
	NSData *d = [u objectForKey:key];
	if(d){
		id obj = [NSKeyedUnarchiver unarchiveObjectWithData:d];
		return obj;
	}
	return nil;
}

- (void)saveObject:(id)obj forKey:(NSString*)key {
    NSUserDefaults *u = [NSUserDefaults standardUserDefaults];
	NSData *d = [NSKeyedArchiver archivedDataWithRootObject:obj];
	[u setObject:d forKey:key];
	[u setObject:[NSDate date] forKey:[key stringByAppendingString:@"Date"]];
    [u synchronize];
    [mDataDict setObject:obj forKey:key];
}

- (void)deleteObject:(NSString*)key {
    NSUserDefaults *u = [NSUserDefaults standardUserDefaults];
    [u removeObjectForKey:key];
    [u synchronize];
    [mDataDict removeObjectForKey:key];
}

- (void)clearAllUserDefault {
    NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
}

// #PERSISTENCE_END








// #API_BEGIN
#pragma mark - API

- (NSMutableDictionary*)initialParam {
    return [NSMutableDictionary dictionaryWithDictionary:mClientInfoDict];
}

- (void)api_cancel_all_call {
    //    [[[APIClientHttps sharedClient] operationQueue] cancelAllOperations];
    //    [[[APIClientHttp sharedClient] operationQueue] cancelAllOperations];
    
    // Dont know to stop this new afnetwork lib version
}

- (void)api_call:(NSString*)api_name
           https:(BOOL)https
          params:(NSMutableDictionary*)params
         success:(APISuccess)success
         failure:(APIFail)failure
{
    NSString *postPath = [API_PREFIX stringByAppendingString:api_name];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *postURL = (https) ? API_HTTPS : API_HTTP;
    postURL = [postURL stringByAppendingString:postPath];
    
    
    [manager POST:postURL
       parameters:params
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              success(responseObject);
          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              failure(error);
          }];
}







- (void)api_get_table:(APISuccess)success
              failure:(APIFail)failure {
    NSMutableDictionary *params = [self initialParam];
    [self api_call:@"get_table" https:NO params:params success:success failure:failure];
}


- (void)api_link_device_token:(APISuccess)success
                      failure:(APIFail)failure {
    if(!mDeviceToken)
        return;
    
    NSMutableDictionary *params = [self initialParam];
    [params setObject:mDeviceToken forKey:@"device_token"];
    [self api_call:@"link_device_token" https:NO params:params success:success failure:failure];
}


// #API_ONLINE_END



- (void)gotoEndOfLine {
    NSString *url = @"itms-apps://itunes.apple.com/app/id729354602";
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}



@end
