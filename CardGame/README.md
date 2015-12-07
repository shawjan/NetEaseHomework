# CardGame

结构：
-card
    -playingCard
-deck
    -playingCardDeck
-viewController

详细描述
-card 
contents 定义了纸牌的基本内容，即什么card
chosen 是否被选择
matched 是否匹配
matchedOrNot 判断匹配的方法

-playingCard
suit 定义了纸牌的花色
rank 定义了纸牌的大小

-deck
addCard 定义了添加纸牌的方式
drawRandomCard 定义了随机抽取纸牌的方法
remainCards 定义了剩余纸牌的方法

-playingCardDeck
init 重构了初始化的方法

-viewController
定义了按钮方法
