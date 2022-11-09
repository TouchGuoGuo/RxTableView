////
////  UIViewController+SwiftEntryKit.swift
////  RxSwiftDemo
////
////  Created by 臧志明 on 2022/11/3.
////
//
//import Foundation
//import SwiftEntryKit
//import UIKit
//
//protocol SwiftEntryKitProtocol {}
//
//extension UIViewController : SwiftEntryKitProtocol {}
//
//extension SwiftEntryKitProtocol {
//
//    /// 展示底部弹出视图
//    /// - Parameters:
//    ///   - controller: controller description
//    ///   - heightRatio: heightRatio description
//    func showBottomAlert(with controller:UIViewController,color backColor:UIColor = .white) {
//        SwiftEntryKit.display(entry: controller, using: bottomEKAttributes(backColor: backColor))
//    }
//
//    /// 纯透明底部的底部弹窗
//    /// - Parameter controller: controller description
//    func showBottomClearAlert(with controller:UIViewController) {
//        SwiftEntryKit.display(entry: controller, using: bottomClearEKAttributes())
//    }
//
//    /// 展示带有导航的底部弹窗
//    /// - Parameters:
//    ///   - controller: controller description
//    ///   - heightRatio: heightRatio description
//    func showBottomNavAlert(with controller:UIViewController,backColor:UIColor = .white,canScroll:Bool = true) {
//        let nav = UINavigationController(rootViewController: controller)
//        SwiftEntryKit.display(entry: nav, using: bottomEKAttributes(backColor: backColor,canScroll:canScroll))
//    }
//
//    /// 展示中间弹窗
//    /// - Parameter controller: controller description
//    func showCenterAlert(with controller:UIViewController) {
//        SwiftEntryKit.display(entry: controller, using: centerEKAttributes())
//    }
//
//    private func centerEKAttributes() -> EKAttributes {
//        var attributes: EKAttributes
//        attributes = .centerFloat
//        attributes.displayMode = .light
//        attributes.displayDuration = .infinity
//        attributes.screenBackground = .color(color: EKColor(.black.withAlphaComponent(0.6)))
//        attributes.entryBackground = .color(color: .clear)
//        attributes.screenInteraction = .absorbTouches
//        attributes.entryInteraction = .absorbTouches
//        attributes.scroll = .disabled
//        attributes.entranceAnimation = .init(
//            translate: .init(
//                duration: 0.5,
//                spring: .init(damping: 0.7, initialVelocity: 0)
//            )
//        )
//        attributes.exitAnimation = .init(
//            translate: .init(duration: 0.35)
//        )
//        attributes.popBehavior = .animated(
//            animation: .init(
//                translate: .init(duration: 0.35)
//            )
//        )
//        attributes.shadow = .active(
//            with: .init(
//                color: .black,
//                opacity: 0.3,
//                radius: 6
//            )
//        )
//        attributes.positionConstraints.size = .init(
//            width: .fill,
//            height: .fill
//        )
//        attributes.positionConstraints.verticalOffset = 0
//        attributes.positionConstraints.safeArea = .overridden
//        attributes.statusBar = .dark
//        return attributes
//
//    }
//
//    private func bottomClearEKAttributes() -> EKAttributes {
//        var attributes: EKAttributes
//        attributes = .bottomToast
//        attributes.displayMode = .light
//        attributes.displayDuration = .infinity
//        attributes.entryBackground = .clear//.visualEffect(style: .standard)
//        attributes.screenInteraction = .absorbTouches
//        attributes.scroll = .edgeCrossingDisabled(swipeable: true)
//        attributes.statusBar = .dark
//        attributes.positionConstraints.safeArea = .overridden
//        attributes.positionConstraints.size = .init(
//            width: .fill,
//            height: .fill
//        )
//
//        return attributes
//    }
//
//    private func bottomEKAttributes(backColor:UIColor,canScroll:Bool = true) -> EKAttributes {
//        var attributes: EKAttributes
//        attributes = .bottomFloat
//        attributes.displayMode = .light
//        attributes.displayDuration = .infinity
//        attributes.screenBackground = .color(color: EKColor(.black.withAlphaComponent(0.6)))
//        attributes.entryBackground = .color(color: EKColor(backColor))//.color(color: .white)
//        attributes.screenInteraction = .absorbTouches
//        attributes.entryInteraction = .absorbTouches
//        attributes.scroll = canScroll ? .edgeCrossingDisabled(swipeable: true) : .disabled
//        attributes.entranceAnimation = .init(
//            translate: .init(
//                duration: 0.5,
//                spring: .init(damping: 1, initialVelocity: 0)
//            )
//        )
//        attributes.exitAnimation = .init(
//            translate: .init(duration: 0.35)
//        )
//        attributes.popBehavior = .animated(
//            animation: .init(
//                translate: .init(duration: 0.35)
//            )
//        )
//        attributes.shadow = .active(
//            with: .init(
//                color: .black,
//                opacity: 0.3,
//                radius: 6
//            )
//        )
//        attributes.positionConstraints.size = .init(
//            width: .fill,
//            height: .ratio(value: 1)
//        )
//        attributes.positionConstraints.verticalOffset = 0
//        attributes.positionConstraints.safeArea = .overridden
//        attributes.statusBar = .dark
//        return attributes
//    }
//
//}
