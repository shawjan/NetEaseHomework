# NetEaseHomework
NetEase Homework

Assignment 1
1、根据ppt运行Matchismo程序，正常翻转卡片没有警告和错误。
2、导入card，deck，playingCard，PlayingCardDeck类，运行程序
3、在CardGameViewController中添加一个私有属性Deck*
4、使用懒初始化的方法初始化属性。
5、完善Matchismo程序，使之能够每次翻转随机显示一张卡片。
6、不要改变存在的功能

Assignment 2
1、根据ppt运行Matchismo程序，上一个版本的Matchismo正常工作没有警告和错误。
2、添加一个重置功能，能够重新开始游戏。
3、使用UISwitch或UISegmentedControl，让用户可以选择2张卡片匹配还是3张卡片匹配游戏
4、当用户开始游戏时候使要求3的按钮不能够选择，重新开始比赛后恢复可以选择。
5、添加一个UILabel，能够提示用户游戏规则
6、把卡片增加到30张
7、不要改变公开的方法，但可以改变私有方法或添加公有方法

额外功能
1、添加一个UISlider，可以查看用户玩过的历史记录
2、改变卡牌的背面以及app的图标，熟悉app icon和launch image

Assignment 3
1、添加一个set游戏，并尽可能的和已有的游戏共享代码 
2、与3张牌匹配差不多，set也是一个匹配得分的游戏
3、set是3张牌匹配的游戏，原来的可以是两张牌匹配
4、用UITabBarController布局两个游戏
5、根据不同的屏幕大小有不同的卡牌数量，由你决定
6、用三角形、圆形正方形以及attributedString
7、展示分数，重新发牌
8、增强UI的视觉效果，比如错误和正确的颜色变化
9、用另外的一个界面展示历史记录

额外功能
1、添加item图标
2、记录玩家最高记录
3、区分set game和deck game
4、添加setting

Assignment 4
1、仍然要求set 和deck两种游戏，可以展示分数和重新发牌，但你可以移除history界面
2、卡牌看起来跟真实的一样，用UIBezierPath和Core graphics功能，不要对set card用images或attributedstrings。卡牌的内容需要与边界有合适的比例。
3、当成功匹配，需要移除卡牌
4、在真实的set游戏中，玩家有12张牌，并且如果剩下的牌不能够组成set的时候，他有可以请求额外3张牌的选择
5、采用翻转的动画效果
6、牌出现和消失需要动画效果，
7、发牌动画效果
8、横屏竖屏都能够正常玩游戏，用上useAutolayout尽可能，
9、横屏竖屏的变换需要动画效果
10、用UIDynamicAnimator实现这样的效果：当捏合时两张组成一堆，并且这堆是可以移动的，点击堆卡牌会回到原来的位置
额外功能
1、计算一个set的最佳分数；惩罚包括抽取三张额外的牌，如果他错过一个存在的set；能知道一场游戏何时结束
2、能够提示用户是否存在一个set，自己决定采用什么提示效果
3、做一个两人游戏
4、想想更多使用动画的地方

Assignment 5
1、从Flickr加载数据
2、创建UITabBarController界面，第一个tab显示热门地点的照片列表，按照国家名字首字母排序分区；第二个tab显示最近看过的20张照片，按照浏览的时间顺序
3、section title为国家名字，title为城市名字，subtitle为州名
4、当用户点击选择某个地点，你需要展示该地点的50张照片列表
5、照片列表中照片title为title，描述为subtitle，如果照片没有title，用描述作为title，如果都没有，用Unknown作为title
6、当选中一张照片，在scrolling view中，可以移动缩放
7、显示照片的界面要有照片的title
8、无论何时照片显示在屏幕上，需要自动缩放适合屏幕大小，用户可以放大缩小图片
9、应用的主线程不能够被锁住，如果应用正在加载东西，那么应该给用户一个反馈
10、应用能够在竖屏横屏使用，以及iPhone和iPad上面，需要有各自适应的风格
11、照片的列表英爱保存在NSUserDefaults中
12、在真机上测试
