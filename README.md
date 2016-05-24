# SZFood

- /***********
深圳小吃知识点汇总 *************/

1利用coreData把数据储存到磁盘（也叫持久化）

步骤：创建托管模型 -> 创建托管对象模型 -> 使用托管对象(获取APPDelegate中的缓冲区对象) -> 取回数据(缓冲区里的对象) -> (删除和更新数据)

2.关于我们页面 iOS9 提供3种方式显示网页:

Safari浏览器 - 可以让Safari来打开你指定的URL,app会暂时切换到Safari U IWebView/WKWebView - 前者是iOS 8之前最常用的浏览器控件,后者是前者的增强 SFSafariViewController – iOS 9新推出的控制器。相对于内嵌全功能的Safari浏览器,

3.利用leanCloud对数据进行云存储 （具体可见leanCloud开发文档）

延时加载图片，提高用户体验 离线缓冲 利用UIActivityIndicatorView告诉用户正在加载数据 利用refalshViewControll进行下拉刷新

4.利用pageViewControll 进行引导页面设计

5.自定义单元格

6.NSDefault存储

附件一

Core Data 是对SQLite的包装,让数据库交互更面向对象化、建模可视化,无需掌握SQL语言

文件式:如iOS工程目录下的Info.plist文件, 专用于保存工程配置。 特性:更改频率低,数据量很小。 操作类:NSUserDefault 数据库式:如餐馆列表可能成千上万条记录。 特性:更新频繁,数据量极大。 框架:Core Data

Managed Object Context: 托管对象缓冲区。用于管理各个对象,在Core Data框架和数据库间进行交互。 比如从数据库中取数据,保存数据到数据库是最常见的交互。 Persistent Store Coordinator: 持久化协调器。用于管理底层数据库间的协调,iOS默认是SQLite,默认即可。 Managed Object Model: 托管对象模型。描述数据库建模方案(schema)。 Xcode中用.xcdatamodeld文件,可视化定义 数据实体(entity)及其属性和关系。 Persistent Store: 数据保存方式:SQLite数据库、二进制文件或XML文件
Status API Training Shop Blog About
