//
//  DRTabbarProtocol.swift
//  basicFramework
//
//  Created by DevWang on 2022/7/21.
//  Copyright © 2022 Dream works. All rights reserved.
//

import UIKit

@objc protocol DRTabbarProtocol {
    @objc var currentSelectedIndex: Int {get set}
    @objc var centerItemView: UIView {get}
    @objc func updateBadge(at index: Int, count: Int)
    @objc func itemView(at index: Int) -> UIView?
}
