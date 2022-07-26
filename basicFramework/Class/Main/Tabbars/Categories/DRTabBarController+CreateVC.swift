//
//  DRTabBarController+CreateVC.swift
//  basicFramework
//
//  Created by DevWang on 2022/7/21.
//  Copyright © 2022 Dream works. All rights reserved.
//

import UIKit

extension DRTabBarController {
    class Creator {
        func createTabbarController(_ type: DRTabBarController.ItemType) -> TabItemViewController {
            switch type {
            case .home:
                return createHome()
            case .more:
                return createMore()
            case .follow:
                return createFollow()
            case .new:
                return createNew()
            }
            
        }
        
        private func createHome() -> TabItemViewController {
            return HomeViewController()
        }

        private func createNew() -> TabItemViewController {
            return NewViewController()
        }

        private func createFollow() -> TabItemViewController {
            return FriendViewController()
        }

        private func createMore() -> TabItemViewController {
            return PersonalViewController()
        }
    }
}

protocol DRTabBarControllerPrivateProtocol: NSObjectProtocol {
    var dr_tabbar: DRTabBarController.DrTabbar {get}
    var tabNames: [String] {get}
}

extension DRTabBarController {
    class PrivateMethods {
        private unowned var delegate: (UITabBarController & DRTabBarControllerPrivateProtocol)
        
        init(delegate: DRTabBarController & DRTabBarControllerPrivateProtocol) {
            self.delegate = delegate
        }
        
        var currentTabEventName: String {
            return tabEventNameAt(self.delegate.selectedIndex)
        }
        
        func itemEvent(type: TabbarItemType) -> String {
            let index = DRTabBarController.itemIndex(type: type)
            return self.delegate.tabNames.growth_itemAt(index) ?? ""
        }
        
        func tabEventNameAt(_ index: Int) -> String {
            return self.delegate.tabNames.growth_itemAt(index) ?? ""
        }
        
        func popAndDismissToRoot() {
            guard let navigationController = self.delegate.selectedViewController as? UINavigationController else {
                return
            }
            navigationController.popToRootViewController(animated: false)
            if delegate.presentedViewController != nil {
                delegate.dismiss(animated: false, completion: nil)
            }
        }
        
        func change(preIndex: Int, to currentIndex: Int) {
            let preEventName = tabEventNameAt(preIndex)
            let curEventName = tabEventNameAt(currentIndex)
            
            //update badge
            if TabbarItemType.follow.type.index == currentIndex {
                delegate.dr_tabbar.updateBadge(at: currentIndex, count: 0)
            }
            
            self.tabItemViewControllerAtIndex(preIndex)?.selected = false
            self.tabItemViewControllerAtIndex(currentIndex)?.selected = true
            
            // track click event
//            GL().Tracking_Event(curEventName, parameters: [GLT_PARAM_FROM: preEventName])
            postTabbarItemClicked(currentIndex)
            
            if currentIndex == 0 {
//                GL().Tracking_Event("home_realshow")
            }
        }
        
        func cameraAction() {
            let from = tabEventNameAt(delegate.selectedIndex)
//            GL().Tracking_Event("camera", parameters: [GLT_PARAM_FROM: from])
            guard let currentTabController = currentTabController else {
                return
            }
            
            if currentTabController.overrideTabbarCameraAction() {
                return
            }
//            FlowerImagePickerManager.showNormalImagePickerFromAB()
//            let parameters = [GLT_PARAM_FROM: "camera_tab"]
//            GL().Tracking_Event("photograph_page", parameters: parameters)
//            GL().Tracking_Event("tabbar_camera_click", parameters: parameters)
            postTabbarItemClicked(DRTabBarController.cameraIndex)
        }
        
        func tabViewControllerOfType(_ type: TabbarItemType) -> UIViewController? {
            guard let vc = self.delegate.viewControllers?.growth_itemAt(type.type.index) else {
                return nil
            }
            
            if let nav = vc as? UINavigationController {
                return nav.viewControllers.first
            }
            return vc
        }
        
        //MARK: - Private methods
        private func tabItemViewControllerAtIndex(_ index: Int) -> TabItemViewController? {
            return self.delegate.viewControllers?.growth_itemAt(index)?.tabItemViewController
        }
        
        private var currentTabController: TabItemViewController? {
            return self.delegate.selectedViewController?.tabItemViewController
        }
        
        private func postTabbarItemClicked(_ index: Int) {
            NotificationCenter.default.post(name: DRTabBarController.notificationTabbarItemClick, object: ["tabBarItemIndex": index])
        }
    }
}

fileprivate extension UIViewController {
    var tabItemViewController: TabItemViewController? {
        if let vc = self as? TabItemViewController {
            return vc
        }
        if let nav = self as? UINavigationController, let tabVc = nav.viewControllers.first as? TabItemViewController {
            return tabVc
        }
        return nil
    }
}

extension Array {
    func growth_itemAt(_ index: Int) -> Element? {
        if index >= 0 && index < self.count {
            return self[index]
        }
        return nil
    }
}
