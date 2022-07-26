//
//  DRTabBarController+InitialData.swift
//  basicFramework
//
//  Created by DevWang on 2022/7/21.
//  Copyright © 2022 Dream works. All rights reserved.
//

import UIKit

protocol TabbarBusinessProtocol: NSObjectProtocol {
    var privateMethods: DRTabBarController.PrivateMethods {get}
}

extension DRTabBarController {
    class Business {
        private unowned var delegate: TabbarBusinessProtocol & UITabBarController
        init(delegate: TabbarBusinessProtocol & UITabBarController) {
            self.delegate = delegate
        }
        
        func doBusiness() {
            self.fetchFireConfig()
            self.loadMyPlants()
        }
        
        private func fetchFireConfig() {
//            self.firConfig.fetch {[weak self] status, error in
//                if status != .success {
//                    return
//                }
//                guard let self = self else { return }
//                self.firConfig.activate {[weak self] change, error in
//                    if error != nil {
//                        return
//                    }
//                    guard let self = self else { return }
//                    if let value = self.firConfig.configValue(forKey: "purchase_prediction").stringValue, value.count > 0 {
//                        GL().Tracking_Event("purchase_prediction_validation", parameters: [GLT_PARAM_VALUE: value])
//                    }
//                }
//            }
        }
        
        private func loadMyPlants() {
//            GardenDataManager.shared().load(false, completion: nil)
//            PersonalCenterData.shared().load(false, completion: nil)
        }
        
        //MARK: - Lazy load
//        private lazy var firConfig: RemoteConfig = {
//            RemoteConfig.remoteConfig()
//        }()
    }
}
