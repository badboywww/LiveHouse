//
//  DRTabBarController.swift
//  basicFramework
//
//  Created by DevWang on 2022/7/21.
//  Copyright © 2022 studentW. All rights reserved.
//

import UIKit

//主要用于OC的桥接
@objc enum TabbarItemType: Int {
    case home
    case new
    case follow
    case more
}

@objc
public class DRTabBarController: UITabBarController {
    
    typealias DrTabbar = UIView & DRTabbarProtocol
    @objc var canDealNotification: Bool = false
    
    @objc static var notificationNameTabbarItemClick: String {
        return "kNotificationNameTabBarItemClicked"
    }
    
    static var notificationTabbarItemClick: Notification.Name {
        return Notification.Name(rawValue: notificationNameTabbarItemClick)
    }
    
    public override var selectedIndex: Int {
        didSet {
            self.privateMethods.change(preIndex: oldValue, to: selectedIndex)
        }
    }

    public override func viewDidLoad() {
        super.viewDidLoad()

        setupTabbar()
        setupControllers()
        self.business.doBusiness()
    }
    
    //MARK: - Public methods
    @objc func itemView(type: TabbarItemType) -> UIView? {
        let index = Self.itemIndex(type: type)
        return self.dr_tabbar.itemView(at: index)
    }
    
    @objc func itemEvent(type: TabbarItemType) -> String {
        self.privateMethods.itemEvent(type: type)
    }
    
    @objc var cameraItemView: UIView {
        return self.dr_tabbar.centerItemView
    }
    
    @objc func changeSelectType(_ type: TabbarItemType) {
        self.selectedIndex = type.type.index
    }
    
    @objc func jumpToRoot(type: TabbarItemType) {
        self.privateMethods.popAndDismissToRoot()
        if selectedIndex != type.type.index {
            changeSelectType(type)
        }
    }
    
    @objc func cameraAction() {
        self.privateMethods.cameraAction()
    }
    
    @objc func updateBadge(type: TabbarItemType, count: Int) {
        let index = Self.itemIndex(type: type)
        self.dr_tabbar.updateBadge(at: index, count: count)
    }
    
    @objc func jumpToMyPlants(type: Int) {
        self.changeSelectType(.follow)
//        if let myPlantsVC = privateMethods.tabViewControllerOfType(.myplants) as? MyPlantsViewController {
//            myPlantsVC.scroll(to: type, animated: false)
//        }
    }
    
    //MARK: - Private methods
    private func setupTabbar() {
        self.setValue(self.dr_tabbar, forKey: "tabBar")
    }
    
    private func setupControllers() {
        self.tabControllers.forEach { vc in
            let navigationController = DRNavigationViewController(rootViewController: vc)
            self.addChild(navigationController)
        }
    }
    
    //MARK: - Lazy load
    private lazy var tabItemTypes: [DRTabBarController.ItemType] = {
        var tabItemTypes = [DRTabBarController.ItemType]()
        tabItemTypes.append(DRTabBarController.ItemType(rawValue: 0))
        tabItemTypes.append(DRTabBarController.ItemType(rawValue: 1))
        tabItemTypes.append(DRTabBarController.ItemType(rawValue: 2))
        tabItemTypes.append(DRTabBarController.ItemType(rawValue: 3))
        return tabItemTypes
    }()
    
    lazy var tabNames: [String] = {
        tabItemTypes.map {$0.tabName}
    }()
    
    private lazy var creator: DRTabBarController.Creator = {
        DRTabBarController.Creator()
    }()
    
    lazy var privateMethods: DRTabBarController.PrivateMethods = {
        DRTabBarController.PrivateMethods(delegate: self)
    }()
    
    private lazy var business: DRTabBarController.Business = {
        DRTabBarController.Business(delegate: self)
    }()
    
    private lazy var tabControllers: [TabItemViewController] = {
        tabItemTypes.map {creator.createTabbarController($0)}
    }()
    
    lazy var dr_tabbar: DrTabbar = {
        let tabbar = DRTabBar(frame: .zero)
        tabbar.centerItemHandler = {[weak self] in
            self?.cameraAction()
        }
        return tabbar
    }()

}

//MARK: - Autorotate
extension DRTabBarController {
    public override var shouldAutorotate: Bool {
        return false
    }
    
    public override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    public override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return .portrait
    }
}

extension DRTabBarController: DRTabBarControllerPrivateProtocol {}
extension DRTabBarController: TabbarBusinessProtocol {}
