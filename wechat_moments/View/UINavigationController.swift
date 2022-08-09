//
//  UINavigationController.swift
//  wechat_moments
//
//  Created by Sixiao He on 2022/7/28.
//

import Foundation
import UIKit

class NavigationController: UINavigationController {
    override var shouldAutorotate: Bool {
        return topViewController?.shouldAutorotate ?? super.shouldAutorotate
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return topViewController?.supportedInterfaceOrientations ?? super.supportedInterfaceOrientations
    }
}
