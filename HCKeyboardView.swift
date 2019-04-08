//
//  HCKeyboardView.swift
//  HCPolytonicGreekKBapp
//
//  Created by Jeremy March on 9/14/17.
//  Copyright © 2017 Jeremy March. All rights reserved.
//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at http://mozilla.org/MPL/2.0/.
//


import UIKit

class HCKeyboardView: UIView {
    var buttons:[[UIButton]] = []
    var buttonWidth:CGFloat = 0
    var extraBottomPadding:CGFloat = 0
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let viewWidth:CGFloat = self.bounds.width
        let viewHeight:CGFloat = self.bounds.height
        
        var mainKeyboardWidth = viewWidth
        
        //determine maxColumns
        var maxColumns = 0
        for row in buttons
        {
            var c = 0
            for col in row
            {
                if col.titleLabel?.text != "xxx"
                {
                    c += 1
                }
            }
            if c > maxColumns
            {
                maxColumns = c
            }
        }

        //smoosh means squish the top row of numbers/metrical signs to fit width while other rows get wider buttons
        let smoosh = (maxColumns > 9 && (buttons[0][0].titleLabel?.text == "1" || buttons[0][0].titleLabel?.text == "×"))
        
        let maxRows = buttons.count
        var buttonHSpacing:CGFloat = 5.0
        var buttonVSpacing:CGFloat = 5.0
        var sidePadding:CGFloat = 0.0
        
        var isHC = false
        if buttons[0][0] is HCMFButton
        {
            isHC = true
            buttonHSpacing = 5.0
            buttonVSpacing = 7.0
            sidePadding = 14.0
        }
        else if maxColumns > 9
        {
            buttonHSpacing = 4.0
            sidePadding = buttonHSpacing
        }

        var numKeysInRow = 0
        var xoffstart:CGFloat = sidePadding
        mainKeyboardWidth -= (sidePadding * 2) - buttonHSpacing
        var xoff:CGFloat = 0
        buttonWidth = 0
        var buttonHeight:CGFloat = 0
        
        let nonSmooshButtonWidth = (mainKeyboardWidth - (buttonHSpacing * (CGFloat(9) + 1.0))) / CGFloat(9)
        
        buttonWidth = (mainKeyboardWidth - (buttonHSpacing * (CGFloat(maxColumns) + 1.0))) / CGFloat(maxColumns)
        buttonHeight = (viewHeight - extraBottomPadding - (buttonVSpacing * (CGFloat(maxRows) + 1.0))) / CGFloat(maxRows)
        var delButtonWidth:CGFloat = 0.0
        if UIDevice.current.userInterfaceIdiom == .pad
        {
            delButtonWidth = (mainKeyboardWidth - (buttonHSpacing * (CGFloat(9) + 1.0))) / CGFloat(9)  * 1.36
        }
        /*else if isHC
        {
            delButtonWidth = buttonWidth
        }*/
        else
        {
            delButtonWidth = buttonHeight
        }
        
        for (i, row) in buttons.enumerated()
        {
            numKeysInRow = row.count
            xoffstart = sidePadding
            xoff = xoffstart
            
            var realButtonWidth = buttonWidth
            if smoosh && numKeysInRow > 9
            {
                realButtonWidth = buttonWidth
            }
            else if smoosh
            {
                realButtonWidth = nonSmooshButtonWidth
            }
            
            if numKeysInRow < maxColumns
            {
                var cols = maxColumns
                if maxColumns > 9 && smoosh
                {
                    cols -= 1
                }
                xoffstart = ((buttonWidth + buttonHSpacing) / 2.0) * CGFloat(cols - numKeysInRow) + buttonHSpacing
            }
            else
            {
                xoffstart = sidePadding //buttonHSpacing
            }
            xoff = xoffstart
            
            var x = false //skip one
            for a in row {
                if a.titleLabel?.text == "enter" || a.titleLabel?.text == "space"
                {
                    if !x
                    {
                        x = true
                        continue
                    }
                    xoff -= (buttonWidth * 2.6) - buttonWidth
                }
                if a is HCMFButton
                {
                    xoff = buttonHSpacing
                }
            }
            
            for (_, key) in row.enumerated()
            {
                if key.titleLabel?.text == "xxx"
                {
                    key.isHidden = true
                }
                else
                {
                    key.isHidden = false
                    if key is HCDeleteButton
                    {
                        key.frame = CGRect(x: xoff, y: (CGFloat(i) * (buttonVSpacing + buttonHeight)) + buttonVSpacing, width: delButtonWidth, height: buttonHeight)
                        xoff += buttonHSpacing + (delButtonWidth)
                    }
                    else if key is HCMFButton
                    {
                        xoff = sidePadding + (buttonWidth) - buttonHeight
                        key.frame = CGRect(x: xoff, y: (CGFloat(i) * (buttonVSpacing + buttonHeight)) + buttonVSpacing, width: buttonHeight, height: buttonHeight)
                        xoff += buttonHSpacing + buttonHeight
                    }
                    else if key.titleLabel?.text == "enter" || key.titleLabel?.text == "space"
                    {
                        if isHC
                        {
                            key.frame = CGRect(x: xoff, y: (CGFloat(i) * (buttonVSpacing + buttonHeight)) + buttonVSpacing, width: viewWidth - xoff - buttonHSpacing, height: buttonHeight)
                            xoff += buttonHSpacing + (realButtonWidth * 1.9)
                        }
                        else
                        {
                            key.frame = CGRect(x: xoff, y: (CGFloat(i) * (buttonVSpacing + buttonHeight)) + buttonVSpacing, width: realButtonWidth * 2.6, height: buttonHeight)
                            xoff += buttonHSpacing + (realButtonWidth * 2.6)
                        }
                    }
                    else
                    {
                        //let aa = key as! HCButton
                        var buttonDown = false
                        if let aa = key as? HCButton
                        {
                            if aa.buttonDown
                            {
                                buttonDown = true
                            }
                        }
                        let aa = key as? HCButton
                        
                        if buttonDown && aa!.btype == 0
                        {
                            let width2 = realButtonWidth * aa!.buttonDownWidthFactor
                            let height2 = (buttonHeight * aa!.buttonDownHeightFactor) + aa!.buttonTail
                            let x2 = xoff - (((realButtonWidth * aa!.buttonDownWidthFactor) - realButtonWidth) / 2)
                            let y2 = ((CGFloat(i) * (buttonVSpacing + buttonHeight)) + buttonVSpacing) - height2 + buttonHeight + aa!.buttonTail
                            
                            key.frame = CGRect(x: x2, y: y2, width: width2, height: height2)
                            key.superview?.bringSubviewToFront(key)
                            xoff += (buttonHSpacing + realButtonWidth)
                        }
                        else
                        {
                            key.frame = CGRect(x: xoff, y: (CGFloat(i) * (buttonVSpacing + buttonHeight)) + buttonVSpacing, width: realButtonWidth, height: buttonHeight)
                            xoff += (buttonHSpacing + realButtonWidth)
                        }
                    }
                }
                //key.setNeedsDisplay() //needed for iOS 8.4 when app extension
                //commented out, setting contentMode of button to .redraw achieves same thing.
                //https://stackoverflow.com/questions/13434794/calling-setneedsdisplay-in-layoutsubviews
            }
        }
    }
}
