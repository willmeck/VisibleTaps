//
//  UIWindow+ShowTouches.swift
//
//  Created by Mecklenburg, William on 1/7/16.
//  Copyright © 2016 Capital One. All rights reserved.
//

import Foundation

extension UIWindow {
    
    public override func hitTest(point: CGPoint, withEvent event: UIEvent?) -> UIView? {
        var res:UIView?
        
        
        res = super.hitTest(point, withEvent: event)
        
        for subview in UIApplication.sharedApplication().keyWindow!.subviews {
            if subview.isMemberOfClass(OtherRingView) {
                return res
            }
        }
        
        let view = OtherRingView(frame: UIScreen.mainScreen().bounds)
        
        view.createRing(point.x, andY: point.y)
        
        UIApplication.sharedApplication().keyWindow?.addSubview(view)
        view.addAnimations()
        
        return res
        
    }
}
