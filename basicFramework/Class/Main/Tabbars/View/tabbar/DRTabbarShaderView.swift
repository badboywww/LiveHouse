//
//  DRTabbarShaderView.swift
//  basicFramework
//
//  Created by DevWang on 2022/7/21.
//  Copyright © 2022 Dream works. All rights reserved.
//

import UIKit
import SnapKit
import ProjectCommon

class DRTabbarShaderView: UIView {

    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configUI() {
        addSubview(line)
        addSubview(centerImageView)
        
        self.centerImageView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 104.0, height: 31.0))
            make.centerX.bottom.equalToSuperview()
        }
        
        self.line.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(0.6)
        }
    }
    
    @objc var gHeight: Double {
        return 31.0
    }
    
    //MARK: - Lazy load
    private lazy var centerImageView: UIImageView = {
        var centerImageView = UIImageView(image: UIImage(named: "bg_navigation_bar1"))
        return centerImageView
    }()
    
    private lazy var line: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.dr_colorDynamic(light: 0xE0E0E0, light_a: 0.7, dark: 0x000000, dark_a: 0.0)
        return view
    }()

}
