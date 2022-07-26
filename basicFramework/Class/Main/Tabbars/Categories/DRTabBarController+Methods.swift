//
//  DRTabBarController+Methods.swift
//  basicFramework
//
//  Created by DevWang on 2022/7/21.
//  Copyright © 2022 Dream works. All rights reserved.
//

import UIKit

extension TabbarItemType {
    var type: DRTabBarController.ItemType {
        switch self {
        case .home:
            return .home
        case .new:
            return .new
        case .follow:
            return .follow
        case .more:
            return .more
        }
    }
}

extension DRTabBarController {
    @objc
    static var dr_tabBarController: DRTabBarController? {
        return UIApplication.shared.delegate?.window??.rootViewController as? DRTabBarController
    }
    
    @objc
    static var isJustLaunched: Bool {
        return dr_tabBarController == nil
    }
    
    @objc
    static var cameraIndex: Int {
        return -1
    }
    
    @objc
    static func itemIndex(type: TabbarItemType) -> Int {
        return type.type.index
    }
}

extension DRTabBarController {
    enum ItemType: CaseIterable {
        case home
        case new
        case follow
        case more
        
        init(rawValue: Int) {
            if let ret = Self.allCases.first(where: {$0.index == rawValue}) {
                self = ret
            } else {
                self = .home
            }
        }
        
        var index: Int {
            switch self {
            case .home:
                return 0
            case .new:
                return 1
            case .follow:
                return 2
            case .more:
                return 3
            }
        }
        
        var tabName: String {
            switch self {
            case .home:
                return "homepage"
            case .new:
                return "new_page"
            case .follow:
                return "follow_plants"
            case .more:
                return "more"
            }
        }
    }
}
