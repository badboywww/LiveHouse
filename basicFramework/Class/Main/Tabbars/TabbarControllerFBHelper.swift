//
//  TabbarControllerFBHelper.swift
//  basicFramework
//
//  Created by DevWang on 2022/7/21.
//  Copyright © 2022 studentW. All rights reserved.
//

import UIKit

@objc
public class TabbarControllerFBHelper: NSObject {
    
    private var isStarted: Bool = false
    private var duration: Double = 0
    private var startTime: Double? = nil
    
    @objc override init() {
        super.init()
        addObserver()
    }
    
    @objc func begin() {
        self.isStarted = true;
        self.startTime = CFAbsoluteTimeGetCurrent();
    }
    
    @objc func end() {
        if !isStarted {
            return
        }
        
        self.addTime()
        self.startTime = nil
        self.duration = 0
        self.isStarted = false
    }
    
    //MARK: - Addobserver
    private func addObserver() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(didEnterBackground(_:)),
                                               name: UIApplication.didEnterBackgroundNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(willEnterForeground(_:)),
                                               name: UIApplication.willEnterForegroundNotification,
                                               object: nil)
    }
    
    @objc
    private func didEnterBackground(_ notification: Notification) {
        if isStarted {
            pause()
        }
    }
    
    @objc
    private func willEnterForeground(_ notification: Notification) {
        if isStarted {
            resume()
        }
    }
    
    //MARK: - Private methods
    private func addTime() {
        if let startTime = startTime {
            self.duration = self.duration + CFAbsoluteTimeGetCurrent() - startTime
        }
    }
    
    private func pause() {
        if !isStarted {
            return
        }
        self.addTime()
        self.startTime = nil
    }
    
    private func resume() {
        if !self.isStarted {
            return
        }
        self.startTime = CFAbsoluteTimeGetCurrent()
    }

}
