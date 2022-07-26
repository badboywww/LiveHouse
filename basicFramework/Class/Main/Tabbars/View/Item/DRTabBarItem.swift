//
//  DRTabBarItem.swift
//  basicFramework
//
//  Created by DevWang on 2022/7/21.
//  Copyright © 2022 Dream works. All rights reserved.
//

import UIKit
import ProjectCommon
import SnapKit

class DRTabBarItem: DRTripleButton {

    private let normalIcon: String
    private let selectedIcon: String
    private let title: String
    private let font: UIFont
    private let normalColor: UIColor
    private let selectedColor: UIColor
    @objc var badgeHidden: Bool = false {
        didSet {
            showCurrentBage()
        }
    }
    
    override var selected: Bool {
        didSet {
            showCurrentSelectedStatus()
        }
    }
    
    @objc
    init(normalIcon: String, selectedIcon: String, title: String, font: UIFont, normalColor: UIColor, selectedColor: UIColor) {
        self.normalIcon = normalIcon
        self.selectedIcon = selectedIcon
        self.title = title
        self.font = font
        self.normalColor = normalColor
        self.selectedColor = selectedColor
        super.init(frame: .zero)
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configUI() {
        dr_addSubviews([titleLabel, iconView, badgeView])
        
        iconView.snp.makeConstraints { make in
            make.top.equalTo(4.0)
            make.size.equalTo(CGSize(width: 24.0, height: 24.0))
            make.centerX.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(iconView.snp.bottom)
            make.centerX.equalToSuperview()
            make.leading.greaterThanOrEqualToSuperview().offset(5.0)
            make.bottom.lessThanOrEqualToSuperview()
        }
        
        let badgeSize = CGSize(width: 6.0, height: 6.0)
        badgeView.snp.makeConstraints { make in
            make.size.equalTo(badgeSize)
            make.centerX.equalToSuperview().offset(14.0)
            make.top.equalToSuperview().offset(2.0)
        }
        badgeView.layer.cornerRadius = badgeSize.width/2
        showCurrentBage()
        showCurrentSelectedStatus()
    }
    
    private func showCurrentBage() {
        self.badgeView.isHidden = self.badgeHidden
    }
    
    private func showCurrentSelectedStatus() {
        let icon = selected ? selectedIcon : normalIcon
        let color = selected ? selectedColor : normalColor
        self.iconView.image = UIImage(named: icon)
        self.titleLabel.textColor = color
    }
    
    override func showUIForClickOnSelectedState() {
        super.showUIForClickOnSelectedState()
        UIView.animate(withDuration: 0.2) {
            self.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        } completion: { _ in
            UIView.animate(withDuration: 0.2) {
                self.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            }
        }
    }
    
    //MARK: - Lazy load
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.baselineAdjustment = .alignCenters
        label.text = self.title
        label.font = self.font
        return label
    }()
    
    private lazy var badgeView: UIView = {
        let badgeView = UIView()
        badgeView.backgroundColor = UIColor.dr_color(0xff6666)
        return badgeView
    }()
    
    private lazy var iconView: UIImageView = {
        let iconView = UIImageView()
        iconView.clipsToBounds = true
        iconView.contentMode = .scaleAspectFit
        return iconView
    }()

}
