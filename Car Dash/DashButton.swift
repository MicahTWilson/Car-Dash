//
//  DashButton.swift
//  Car Dash
//
//  Created by Micah Wilson on 7/13/15.
//  Copyright (c) 2015 Micah Wilson. All rights reserved.
//

import Foundation
import UIKit

class DashButton: UIButton {
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        super.touchesBegan(touches, withEvent: event)
        self.nextResponder()?.touchesBegan(touches, withEvent: event)
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        super.touchesEnded(touches, withEvent: event)
        self.nextResponder()?.touchesEnded(touches, withEvent: event)
    }
}