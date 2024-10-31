//
//  BehaviorRelay+Extension.swift
//  RxTableViewDemo
//
//  Created by yh jl on 2024/10/29.
//

import Foundation
import RxSwift
import RxRelay
import RxDataSources

extension BehaviorRelay where Element: RangeReplaceableCollection,Element.Index == Int, Element.Element : SectionModelType {
    
    // 更新指定 section 中的 items
    func updateItems(inSection sectionIndex: Int, modify: (inout [Element.Element.Item]) -> Void) {
        var currentValue = Array(self.value) // 将不可变集合转换为可变数组
        guard sectionIndex >= 0 && sectionIndex < currentValue.count else { return }
        var sectionItems = currentValue[sectionIndex].items
        modify(&sectionItems)
        let newSection = Element.Element(original: currentValue[sectionIndex], items: sectionItems)
        currentValue[sectionIndex] = newSection
        self.accept(Element(currentValue))
    }

    
    // 添加单个元素
    func append(_ element: Element.Element) {
        var currentValue = self.value
        currentValue.append(element)
        self.accept(currentValue)
    }
    

    // 添加多个元素
    func append(contentsOf elements: [Element.Element]) {
        var currentValue = self.value
        currentValue.append(contentsOf: elements)
        self.accept(currentValue)
    }

    // 插入元素
    func insert(_ element: Element.Element, at index: Element.Index) {
        var currentValue = self.value
        currentValue.insert(element, at: index)
        self.accept(currentValue)
    }

    // 删除元素
    func remove(at index: Element.Index) {
        var currentValue = self.value
        currentValue.remove(at: index)
        self.accept(currentValue)
    }
    
    func removeFirst() {
        var currentValue = self.value
        currentValue.removeFirst()
        self.accept(currentValue)
    }
    
    // 替换指定位置的元素
    func replace(newElement:Element.Element,at:Element.Index) {
        var newValue = value
        newValue.remove(at: at)
        newValue.insert(newElement, at: at)
        accept(newValue)
    }
}
