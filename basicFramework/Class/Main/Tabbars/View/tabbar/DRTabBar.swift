//
//  DRTabBar.swift
//  basicFramework
//
//  Created by DevWang on 2022/7/21.
//  Copyright © 2022 Dream works. All rights reserved.
//

import UIKit
import ProjectCommon
import ReactiveObjC

@objc
public class DRTabBar: UITabBar {

    @objc var centerItemHandler: (()->())?
    
    // MARK: - lazy
    private lazy var shaderView: DRTabbarShaderView = {
        DRTabbarShaderView()
    }()
    
    private lazy var shell: UIView = {
        let shell = UIView()
        shell.backgroundColor = UIColor.dr_colorDynamic(0xffffff, 0x404040)
        return shell
    }()
    
    private lazy var barItemInfos: [(normalIcon: String, selectIcon: String, title: String)] = {
        return [
            ("icon_navbar_1_normal", "icon_navbar_1_hover", "Home"),
            ("icon_navbar_2_normal", "icon_navbar_2_hover", "New"),
            ("icon_navbar_3_normal", "icon_navbar_3_hover", "Follow"),
            ("icon_navbar_4_normal", "icon_navbar_4_hover", "More"),
        ]
    }()
    
    private(set) lazy var tabBarItems: [DRTabBarItem] = {
        let normalColor = UIColor.dr_colorDynamic(0x666666, 0x999999)
        let selectedColor = UIColor.dr_colorDynamic(0x1BB38D, 0x1BB38D)
        let font = UIFont.regular(11.0)
        let tabBarItems:[DRTabBarItem] = barItemInfos.map { info in
            let item = DRTabBarItem(normalIcon: info.normalIcon,
                                    selectedIcon: info.selectIcon,
                                    title: info.title,
                                    font: font,
                                    normalColor: normalColor,
                                    selectedColor: selectedColor)
            item.badgeHidden = true
            item.delegate = self
            return item
        }
        return tabBarItems
    }()
    
    private(set) lazy var centerItem: DRTabBarCenterBaseItem = {
        let centerItem = DRTabBarCenterItem()
        centerItem.button.rac_signal(for: .touchUpInside).subscribeNext {[weak self] _ in
            self?.centerButtonClickAction()
        }
        return centerItem
    }()
    
    // MARK: - init
    @objc
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        configUI()
        configTabbarItems()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configUI() {
        addSubview(shaderView)
        
        shaderView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(self.snp.top)
            make.height.equalTo(shaderView.gHeight)
        }
        
        addSubview(shell)
        
        shell.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func configTabbarItems() {
        var itemViews: [UIView] = self.tabBarItems
        itemViews.insert(centerItem, at: self.tabBarItems.count/2)
        shell.dr_addSubviews(itemViews)
        
        var lastView: UIView? = nil
        itemViews.forEach { itemView in
            itemView.snp.makeConstraints { make in
                if let lastView = lastView {
                    make.leading.equalTo(lastView.snp.trailing)
                } else {
                    make.leading.equalToSuperview()
                }
                
                if itemView == self.centerItem {
                    make.size.equalTo(self.centerItem.centerSize)
                    make.bottom.equalToSuperview().inset(self.centerItem.bottomEdge + UIApplication.dr_safeAreaInsets().bottom)
                    make.centerX.equalToSuperview()
                } else {
                    make.top.bottom.equalToSuperview()
                }
            }
            lastView = itemView
        }
        lastView?.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
        }
        Self.unionTabbarItmes(self.tabBarItems)
    }
    
    public var areaInsets: UIEdgeInsets? {
        if let delegate = UIApplication.shared.delegate, let window = delegate.window {
            return window?.safeAreaInsets
        }
        return nil
    }
    
    
    private func showIndex(_ index: Int) {
        tabBarItems.enumerated().forEach { (aindex, item) in
            let selected = (aindex == index)
            if item.selected != selected {
                item.selected = selected
            }
        }
    }
    
    //MARK: - Private actions
    private func centerButtonClickAction() {
        centerItemHandler?()
//        self.trackClickAtIndex(-1)
    }
    
    //MARK: - Overrid
    public override func layoutSubviews() {
        super.layoutSubviews()
        self.subviews.forEach { subView in
            if subView !== self.shell && subView !== self.shaderView {
                subView.isHidden = true
            }
        }
    }
    
    public override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if self.isHidden {
            return super.hitTest(point, with: event)
        }
        
        let tempPoint = self.centerItem.convert(point, from: self)
        if self.centerItem.bounds.contains(tempPoint) {
            return self.centerItem.button
        } else {
            return super.hitTest(point, with: event)
        }
    }
    
    public override var selectedItem: UITabBarItem? {
        didSet {
            guard let selectedItem = selectedItem, let index = self.items?.firstIndex(of: selectedItem) else {
                return
            }
            currentSelectedIndex = index
        }
    }
}


extension DRTabBar: TripleButtonDelegage {
    func tripleButton(_ sender: AnyObject, event: TripleButtonEvent) {
        guard let item = sender as? DRTabBarItem,
              let index = self.tabBarItems.firstIndex(of: item),
              let tabbarController = self.delegate as? UITabBarController else {
                  return
              }
        tabbarController.selectedIndex = index
        
        if event == .select {
//            self.trackClickAtIndex(index)
        }
    }
}

extension DRTabBar: DRTabbarProtocol {
    var currentSelectedIndex: Int {
        get {
            guard let selectedItem = selectedItem, let index = self.items?.firstIndex(of: selectedItem) else {
                return 0
            }
            return index
        }
        set {
            showIndex(newValue)
        }
    }
    
    var centerItemView: UIView {
        return self.centerItem
    }
    
    func updateBadge(at index: Int, count: Int) {
        let enable = count > 0
        if index >= 0 && self.tabBarItems.count > index {
            self.tabBarItems[index].badgeHidden = !enable
        }
    }
    
    func itemView(at index: Int) -> UIView? {
        tabbarItemAtIndex(index)
    }
    
    private func tabbarItemAtIndex(_ index: Int) -> UIView? {
        if index < 0 || index >= self.tabBarItems.count {
            return nil
        }
        
        return self.tabBarItems[index]
    }
}

extension DRTabBar {
    static func unionTabbarItmes(_ items: [DRTabBarItem]) {
        var lastView: UIView? = nil
        items.forEach { item in
            if let lastView = lastView {
                item.snp.makeConstraints { make in
                    make.width.equalTo(lastView.snp.width)
                }
            }
            lastView = item
        }
    }
}

