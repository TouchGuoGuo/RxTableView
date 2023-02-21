# RxTableView


## 特性


1.一行代码快速实现UITableView/UICollectionView数据源绑定


2.支持空数据占位图的设置


-


## 安装 


#### CocoaPods - Podfile


```ruby
use_frameworks!
target '<Your Target Name>' do
	pod 'RxTableView+RxCollectionView'
end
```


#### 使用
##### 1、引入头文件

```swift
import RxTableView+RxCollectionView
```
##### 2、创建TableView数据模型 
	
```swift 
/// 数据模型需要遵循RxsectionType协议
struct RxTableDemoModel : RxsectionType {
/// cell注册方式
var registerStyle: RxSectionCellRegisterStyle = .nib
/// cell的className
var cellName: String = '<cell的className>'
/// 自定义的数据
var title:String = "cell的标题"
}
```
	

##### 3、创建TableView 以及TableViewCell

#### TableView

```swift
/// UITableView 继承于 RxTableView
/// 创建一个TableView
var tableView:RxTableView = RxTableView()
```

#### TableViewCell

```swift 
/// UITableViewCell 继承于 RxTableViewCell
/// 为cell中的组件赋值
override func setupCellModel(model:Any) {
	if let model = model as? RxTableDemoModel {
		self.title.text = model.title
	}
}
/// 为cell中的组件添加点击事件
override func tapGestureViewsForCell() -> [RxGestureModel] {
	return [
	RxGestureModel(code:"自定义标识",view:title)
	]
}
```

##### 4、为TableView绑定数据

```swift 
/// 设置数据源
var models:[RxTableDemoModel] = [
	RxTableDemoModel(title:"老虎"),
	RxTableDemoModel(title:"狮子"),
	RxTableDemoModel(title:"兔子"),
	RxTableDemoModel(title:"猴子")
	]
/// 创建section
let section = RxsectionModel(items:models)
/// 绑定数据
tableView.list.accept([section])
```

##### 5、扩展功能

```swift 
/// tableview是否允许编辑(默认为false)
var allowEdit:Bool = false
	
/// 空数据占位图 （不设置不显示）
var emptyModel:RxEmptyModel?
	
/// cell中的视图点击事件传递出的信号
let gestureSubject
	
/// 装载下拉刷新功能
func setupHeaderRefresh()
	
/// 装载自定义下拉刷新功能
func setupCustomRefresh(header:MJRefreshHeader)
	
/// 装载加载更多功能
func setupFooterRefresh()
	
/// 装载自定义加载更多功能
func setupCustomRefresh(footer:MJRefreshFooter)
	
/// 传出的信号在未装载下拉以及加载更多时会收不到订阅消息
	
/// 下拉刷新后传递出的信号
let headerRefreshSubject
	
/// 上拉加载后传递出的信号
let footerRefreshSubject
```

