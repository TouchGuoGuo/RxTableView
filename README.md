# RxTableView


## 特性

1、一行代码快速实现UITableView/UICollectionView(暂时未实现)数据源绑定

2、通过RxDataSource快速管理UITableView数据源

3、允许动态插入数据以及混合样式

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
##### 2.1、创建不带动画的TableView数据模型 
	
```swift
/// 创建的模型需要遵循RxRowType
struct RxTableViewControllerModel : RxRowType {
    /// 传入创建的cell
    var cell: UIView.Type = RxTableViewControllerCell.self
    /// 数据源
    var title:String
}
```

##### 2.2、创建带动画的TableView数据模型 
/// 创建带有动画的模型需要遵循RxAnimationRowType
struct RxTableViewControllerModel : RxAnimationRowType {
    /// 传入创建的cell
    var cell: UIView.Type = RxTableViewControllerCell.self
    /// 数据源
    var title:String
}

##### 3、创建TableView 以及TableViewCell
```swift
/// 可以通过代码或者xib创建UITableViewCell,但是都需要继承RxTableViewCell，不然无法进行数据的绑定
class RxTableViewControllerCell : RxTableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /// 绑定cell的数据
    override func setupCellIndexModel(model: Any, indexPath: IndexPath) {
	/// 不实现将无法正常获取到当前cell的IndexPath
        super.setupCellIndexModel(model: model, indexPath: indexPath)
	/// 绑定不带有动画的数据源
        if let model = model as? RxTableViewControllerModel {
            textLabel?.text = model.title
        }
	/// 绑定带有动画的数据源
	/// 带有动画的数据源多了一层AnyRxAnimationRowType包装创建每个cell的唯一标识，最后从_base中获取数据模型
        if let base = model as? AnyRxAnimationRowType,let model = base._base as? RxTableViewControllerModel {
            textLabel?.text = model.title
        }
        
    }
}

```
#### 4、RxTableView - RxAnimationTableView

```swift
/// UITableView 继承 RxTableView 或者在xib中创建UITableView 继承 RxTableView
/// 创建一个TableView
init(style:UITableView.Style = .plain)

override init(frame: CGRect, style: UITableView.Style)

/// RxTableView的配置
/// 绑定数据的数据源
public var list = BehaviorRelay<[RxSectionModel]>(value: [])
    
/// cell中的点击事件模型
public var gesture = PublishSubject<RxCellGestureModel>()

/// indexTitles类型 根据数据源自动设置 也可以使用custom自定义 设置none时不显示
public var indexTitlesType:RxTableViewIndexTitles = .none

/// 索引的点击事件
public var indexTitlesGesture = PublishSubject<(String,Int)>()

/// 打开编辑模式
/// - Parameters:
///   - move: 是否允许拖动
///   - animated: animated description
public func openEdit(move:Bool = false,animated:Bool = true)
    
/// 关闭编辑模式
/// - Parameter animated: animated description
public func closeEdit(animated:Bool = true)

```


##### 4、为RxTableView和RxAnimationTableView绑定数据

```swift 
/// 不带动画样式的数据源
var models:[RxTableViewControllerModel] = [
RxTableViewControllerModel(title:"老虎"),
RxTableViewControllerModel(title:"狮子"),
RxTableViewControllerModel(title:"兔子"),
RxTableViewControllerModel(title:"猴子")
]

/// 带动画样式的数据源
var models:[RxTableViewControllerModel] = [
AnyRxAnimationRowType(RxTableViewControllerModel(title:"老虎")),
AnyRxAnimationRowType(RxTableViewControllerModel(title:"狮子")),
AnyRxAnimationRowType(RxTableViewControllerModel(title:"兔子")),
AnyRxAnimationRowType(RxTableViewControllerModel(title:"猴子"))
]

/// 创建不带动画的section
let section = RxSectionModel(items:models)

/// 创建带有动画的section
let section = RxAnimationSectionModel(items:models)

/// 绑定数据
tableView.list.accept([section])

```

##### 5、改变数据源

###### 操作section

```swift

let section = RxSectionModel(items:models)
let section = RxAnimationSectionModel(items:models)

/// 末尾添加section
tableView.list.append(section)

/// 插入section
tableView.list.insert(section,at:section)

/// 删除section
tableView.list.remove(at: 0)

```

###### 操作row

```swift

let row = RxTableViewControllerModel(title:"老虎")
let row = AnyRxAnimationRowType(RxTableViewControllerModel(title:"老虎"))

/// 添加row
tableView.list.updateItems(inSection: section, modify: {$0.append(row)})

/// 插入row
tableView.list.updateItems(inSection: section, modify: {$0.insert(row, at: 0)})

/// 删除row
tableView.list.updateItems(inSection: section, modify: { $0.remove(at: 0)})

```



