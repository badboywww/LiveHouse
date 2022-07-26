//
//  DRTabBarCenterItem.swift
//  basicFramework
//
//  Created by DevWang on 2022/7/21.
//  Copyright © 2022 Dream works. All rights reserved.
//

import UIKit
import ProjectCommon

class DRTabBarCenterItem: DRTabBarCenterBaseItem {
    @objc override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configUI() {
        self.button.setImage(UIImage(named: "icon_navbar_camera"), for: .normal)
    }
    
    override var bottomEdge: Double {
        return 14.0
    }
}
