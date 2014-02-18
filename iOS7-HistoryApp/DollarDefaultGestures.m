#import "DollarDefaultGestures.h"
#import "DollarPointCloud.h"
#import "DollarPoint.h"

DollarPointCloud * MakePointCloud(NSString *name, NSArray *points) {
    return [[DollarPointCloud alloc] initWithName:name points:points];
}

DollarPoint * MakePoint(float x, float y, int id) {
    return [[DollarPoint alloc] initWithId:@(id) x:x y:y];
}

@implementation DollarDefaultGestures

+ (id)defaultPointClouds {
    static NSArray *defaultPointClouds = nil;
    if (!defaultPointClouds) {
        defaultPointClouds = [self pointClouds];
    }
    return defaultPointClouds;
}

+ (NSMutableArray *)pointClouds {
    NSMutableArray *pointClouds = [NSMutableArray array];
    
    
    pointClouds[0] = MakePointCloud(@"lower s", @[
                                            MakePoint(550,507,1),
                                            MakePoint(540,510,1),
                                            MakePoint(520,512,1),
                                            MakePoint(500,515,1),
                                            
                                            MakePoint(490,510,1),
                                            MakePoint(490,505,1),
                                            MakePoint(490,495,1),
                                            MakePoint(500,485,1),
                                            MakePoint(520,480,1),
                                            MakePoint(530,477,1),
                                            MakePoint(540,475,1),
                                            
                                            MakePoint(540,470,1),
                                            MakePoint(535,465,1),
                                            MakePoint(530,460,1),
                                            MakePoint(525,460,1),
                                            MakePoint(520,457,1),
                                            MakePoint(510,453,1),
                                            MakePoint(500,450,1),
                                            MakePoint(490,450,1)
                                            ]);
    
    
    pointClouds[1] = MakePointCloud(@"lower case C", @[
                                                       MakePoint(590,460,1),
                                                       MakePoint(550,520,1),
                                                       MakePoint(480,500,1),
                                                       MakePoint(430,440,1),
                                                       MakePoint(430,390,1),
                                                       MakePoint(435,330,1),
                                                       MakePoint(470,290,1),
                                                       MakePoint(530,280,1),
                                                       MakePoint(580,300,1)
                                                       ]);

	/*pointClouds[0] = MakePointCloud(@"T", @[
                                    MakePoint(30,7,1),
                                    MakePoint(103,7,1),
                      
                                    MakePoint(66,7,2),
                                    MakePoint(66,87,2)
                                    ]);
    
	pointClouds[1] = MakePointCloud(@"N", @[
                                    MakePoint(177,92,1),
                                    MakePoint(177,2,1),
                      
                                    MakePoint(182,1,2),
                                    MakePoint(246,95,2),
                      
                                    MakePoint(247,87,3),
                                    MakePoint(247,1,3)
                                    ]);
    
	pointClouds[2] = MakePointCloud(@"D", @[
                                    MakePoint(345,9,1),
                                    MakePoint(345,87,1),
                      
                                    MakePoint(351,8,2),
                                    MakePoint(363,8,2),
                                    MakePoint(372,9,2),
                                    MakePoint(380,11,2),
                                    MakePoint(386,14,2),
                                    MakePoint(391,17,2),
                                    MakePoint(394,22,2),
                                    MakePoint(397,28,2),
                                    MakePoint(399,34,2),
                                    MakePoint(400,42,2),
                                    MakePoint(400,50,2),
                                    MakePoint(400,56,2),
                                    MakePoint(399,61,2),
                                    MakePoint(397,66,2),
                                    MakePoint(394,70,2),
                                    MakePoint(391,74,2),
                                    MakePoint(386,78,2),
                                    MakePoint(382,81,2),
                                    MakePoint(377,83,2),
                                    MakePoint(372,85,2),
                                    MakePoint(367,87,2),
                                    MakePoint(360,87,2),
                                    MakePoint(355,88,2),
                                    MakePoint(349,87,2)
                                    ]);
    
	pointClouds[3] = MakePointCloud(@"P", @[
                                    MakePoint(507,8,1),
                                    MakePoint(507,87,1),
                                    
                                    MakePoint(513,7,2),
                                    MakePoint(528,7,2),
                                    MakePoint(537,8,2),
                                    MakePoint(544,10,2),
                                    MakePoint(550,12,2),
                                    MakePoint(555,15,2),
                                    MakePoint(558,18,2),
                                    MakePoint(560,22,2),
                                    MakePoint(561,27,2),
                                    MakePoint(562,33,2),
                                    MakePoint(561,37,2),
                                    MakePoint(559,42,2),
                                    MakePoint(556,45,2),
                                    MakePoint(550,48,2),
                                    MakePoint(544,51,2),
                                    MakePoint(538,53,2),
                                    MakePoint(532,54,2),
                                    MakePoint(525,55,2),
                                    MakePoint(519,55,2),
                                    MakePoint(513,55,2),
                                    MakePoint(510,55,2)
                                    ]);
    
	pointClouds[4] = MakePointCloud(@"X", @[
                                    MakePoint(30,146,1),
                                    MakePoint(106,222,1),
                                    
                                    MakePoint(30,225,2),
                                    MakePoint(106,146,2)
                                    ]);
    
	pointClouds[5] = MakePointCloud(@"H", @[
                                    MakePoint(188,137,1),
                                    MakePoint(188,225,1),
                                    
                                    MakePoint(188,180,2),
                                    MakePoint(241,180,2),
                                    
                                    MakePoint(241,137,3),
                                    MakePoint(241,225,3)
                                    ]);
    
	pointClouds[6] = MakePointCloud(@"I", @[
                                    MakePoint(371,149,1),
                                    MakePoint(371,221,1),
                                    
                                    MakePoint(341,149,2),
                                    MakePoint(401,149,2),
                                    
                                    MakePoint(341,221,3),
                                    MakePoint(401,221,3)
                                    ]);
    
	pointClouds[7] = MakePointCloud(@"lower case I", @[
                                    MakePoint(510,510,1),
                                    MakePoint(510,460,1),
                                    MakePoint(510,410,1),
                                    MakePoint(510,360,1),
                                    MakePoint(510,280,1),
                                    
                                    MakePoint(510,630,2)
                                    ]);
    
	pointClouds[8] = MakePointCloud(@"line", @[
                                    MakePoint(12,347,1),
                                    MakePoint(119,347,1)
                                    ]);
    
	pointClouds[9] = MakePointCloud(@"lower case C", @[
                                    MakePoint(590,460,1),
                                    MakePoint(550,520,1),
                                    MakePoint(480,500,1),
                                    MakePoint(430,440,1),
                                    MakePoint(430,390,1),
                                    MakePoint(435,330,1),
                                    MakePoint(470,290,1),
                                    MakePoint(530,280,1),
                                    MakePoint(580,300,1)
                                    ]);
    
	pointClouds[10] = MakePointCloud(@"lower case M", @[
                                     MakePoint(320,520,1),
                                     MakePoint(320,400,1),
                                     MakePoint(320,340,1),
                                     MakePoint(320,280,1),
                                     MakePoint(320,240,1),
                                     MakePoint(330,275,1),
                                     MakePoint(330,325,1),
                                     MakePoint(330,375,1),
                                     MakePoint(330,425,1),
                                     MakePoint(365,480,1),
                                     MakePoint(410,500,1),
                                     MakePoint(460,480,1),
                                     MakePoint(495,380,1),
                                     MakePoint(495,275,1),
                                     MakePoint(510,275,1),
                                     MakePoint(510,330,1),
                                     MakePoint(510,380,1),
                                     MakePoint(550,470,1),
                                     MakePoint(590,500,1),
                                     MakePoint(660,470,1),
                                     MakePoint(670,400,1),
                                     MakePoint(670,340,1),
                                     MakePoint(670,280,1),
                                     
                                    ]);
    
	pointClouds[11] = MakePointCloud(@"arrowhead", @[
                                     MakePoint(506,349,1),
                                     MakePoint(574,349,1),
                                     
                                     MakePoint(525,306,2),
                                     MakePoint(584,349,2),
                                     MakePoint(525,388,2)
                                     ]);
    
	pointClouds[12] = MakePointCloud(@"lower case E", @[
                                                        MakePoint(506,349,1),
                                                        MakePoint(574,349,1),
                                                        
                                                        MakePoint(525,306,2),
                                                        MakePoint(584,349,2),
                                                        MakePoint(525,388,2)
                                                        
                                     MakePoint(370,400,1),
                                     
                                     MakePoint(375,400,1),
                                     MakePoint(380,400,1),
                                     MakePoint(390,400,1),
                                     MakePoint(400,400,1),
                                     MakePoint(410,400,1),
                                     MakePoint(420,400,1),
                                     MakePoint(430,400,1),
                                     MakePoint(440,400,1),
                                     MakePoint(450,400,1),
                                     MakePoint(460,400,1),
                                     
                                     MakePoint(470,400,1),
                                     MakePoint(480,400,1),
                                     MakePoint(490,400,1),
                                     MakePoint(500,400,1),
                                     MakePoint(510,400,1),
                                     MakePoint(520,400,1),
                                     MakePoint(530,400,1),
                                     MakePoint(540,400,1),
                                     
                                     MakePoint(535,415,2),
                                     MakePoint(530,430,2),
                                     MakePoint(525,445,2),
                                     MakePoint(520,460,2),
                                     MakePoint(515,475,2),
                                     MakePoint(510,490,2),
                                     
                                     MakePoint(500,492,2),
                                     MakePoint(490,495,2),
                                     MakePoint(480,500,2),
                                     MakePoint(470,505,2),
                                     MakePoint(460,510,2),
                                     
                                     MakePoint(450,505,2),
                                     MakePoint(440,500,2),
                                     MakePoint(430,495,2),
                                     MakePoint(420,490,2),
                                     MakePoint(410,485,2),
                                     MakePoint(400,480,2),
                                     MakePoint(390,470,2),
                                     
                                     
                                     MakePoint(370,320,2),
                                     MakePoint(400,290,2),
                                     MakePoint(450,280,2),
                                     MakePoint(520,290,2),

                                    ]);

    
	pointClouds[13] = MakePointCloud(@"lower case S", @[

                                     MakePoint(550,507,1),
                                     MakePoint(540,510,1),
                                     MakePoint(520,512,1),
                                     MakePoint(500,515,1),
                                     
                                     MakePoint(490,510,1),
                                     MakePoint(490,505,1),
                                     MakePoint(490,495,1),
                                     MakePoint(500,485,1),
                                     MakePoint(520,480,1),
                                     MakePoint(530,477,1),
                                     MakePoint(540,475,1),
                                     
                                     MakePoint(540,470,1),
                                     MakePoint(535,465,1),
                                     MakePoint(530,460,1),
                                     MakePoint(525,460,1),
                                     MakePoint(520,457,1),
                                     MakePoint(510,453,1),
                                     MakePoint(500,450,1),
                                     MakePoint(490,450,1),
                                     
                                    ]);
    

    
    pointClouds[14] = MakePointCloud(@"lower case A", @[MakePoint(560, 510, 1),
                                                        MakePoint(460, 505, 1),
                                                        MakePoint(418, 430, 1),
                                                        MakePoint(415, 325, 1),
                                                        MakePoint(510, 290, 1),
                                                        MakePoint(580, 340, 1),
                                                        MakePoint(580, 380, 1),
                                                        MakePoint(580, 480, 1),
                                                        
                                                        MakePoint(610, 400, 1),
                                                        MakePoint(610, 370, 1),
                                                        MakePoint(610, 330, 1)
                                                        ]);
    
    pointClouds[15] = MakePointCloud(@"lower case B", @[MakePoint(410, 695, 1),
                                                        MakePoint(410, 635, 1),
                                                        MakePoint(410, 585, 1),
                                                        MakePoint(410, 435, 1),
                                                        MakePoint(410, 335, 1),
                                                        MakePoint(420, 295, 1),
                                                        MakePoint(420, 370, 1),
                                                        MakePoint(420, 450, 1),
                                                        MakePoint(450, 520, 1),
                                                        MakePoint(490, 540, 1),
                                                        MakePoint(550, 540, 1),
                                                        MakePoint(590, 460, 1),
                                                        MakePoint(590, 400, 1),
                                                        MakePoint(560, 300, 1),
                                                        MakePoint(520, 290, 1)
                                                        ]);
                                                        
    */
    return pointClouds;
}

@end