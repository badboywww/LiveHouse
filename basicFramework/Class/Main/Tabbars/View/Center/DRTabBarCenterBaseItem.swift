//
//  DRTabBarCenterBaseItem.swift
//  basicFramework
//
//  Created by DevWang on 2022/7/21.
//  Copyright © 2022 Dream works. All rights reserved.
//

import UIKit
import SnapKit

@objc
class DRTabBarCenterBaseItem: UIView {

    @objc
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configUI() {
        addSubview(self.button)
        self.button.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    @objc var centerSize: CGSize {
        return CGSize(width: 58.0, height: 58.0)
    }
    
    @objc var bottomEdge: Double {
        return 0.0
    }
    
    //MARK: - lazy load
    @objc private(set) lazy var button: UIButton = {
        let button = UIButton()
        return button
    }()

}
