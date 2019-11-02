//
//  HCEnterButton.swift
//  HCPolytonicGreekKBapp
//
//  Created by Jeremy March on 2/3/17.
//  Copyright © 2017 Jeremy March. All rights reserved.
//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at http://mozilla.org/MPL/2.0/.
//


import UIKit

class HCEnterButton: UIButton {
        
        var btype: Int? = nil
        var buttonDown:Bool = false
        /*
         var bgColor:UIColor = .white
         var bgDownColor:UIColor = .black
         var textColor:UIColor = .black
         var textDownColor:UIColor = .white
         */
        
        var bgColor = HopliteConstants.keyBGColor
        var textColor = HopliteConstants.keyTextColor
        var bgDownColor = HopliteConstants.keyBGColorDown
        var textDownColor = HopliteConstants.keyTextColorDown
        
        let blueColor:UIColor = UIColor.init(red: 0/255.0, green: 122/255.0, blue: 255/255.0, alpha: 1.0)
        /*
         // Only override draw() if you perform custom drawing.
         // An empty implementation adversely affects performance during animation.
         override func draw(_ rect: CGRect) {
         // Drawing code
         }
         */
        
        required init(buttonType: Int = 0) {
            // set myValue before super.init is called
            self.btype = buttonType
            
            super.init(frame: .zero)
            
            // set other operations after super.init, if required
            
            backgroundColor = bgColor
            setTitleColor(textColor, for: [])
            titleLabel?.font = UIFont(name: "Helvetica", size: 16.0)
            
            self.addTarget(self, action: #selector(touchUpInside(sender:)), for: .touchUpInside)
            self.addTarget(self, action: #selector(touchUpOutside(sender:)), for: .touchUpOutside)
            self.addTarget(self, action: #selector(touchDown(sender:)), for: .touchDown)
            
            self.addTarget(self, action: #selector(touchDown(sender:)), for: .touchDragEnter)
            self.addTarget(self, action: #selector(touchUpInside(sender:)), for: .touchDragExit)
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        @objc func touchUpInside(sender: UIButton!) {
            
                setTitleColor(.white, for: [])
                backgroundColor = blueColor
            buttonDown = false
        }
        
        @objc func touchUpOutside(sender: UIButton!) {
            
                setTitleColor(.white, for: [])
                backgroundColor = blueColor
                buttonDown = false
        }
        
        @objc func touchDown(sender: UIButton!) {
            
                setTitleColor(blueColor, for: [])
                backgroundColor = .white
                buttonDown = true
        }
        
}
