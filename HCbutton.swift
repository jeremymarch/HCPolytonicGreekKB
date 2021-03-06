//
//  HCbutton.swift
//  HCPolytonicGreekKBapp
//
//  Created by Jeremy March on 1/14/17.
//  Copyright © 2017 Jeremy March. All rights reserved.
//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at http://mozilla.org/MPL/2.0/.
//


import UIKit

class HCButton: UIButton {

    var btype: Int? = nil
    /*
    var bgColor:UIColor = .white
    var bgDownColor:UIColor = .black
    var textColor:UIColor = .black
    var textDownColor:UIColor = .white
    */
    
    var vbgColor = UIColor.white
    var vtextColor = UIColor.black
    var vbgDownColor = UIColor.white
    var vtextDownColor = UIColor.black
    
    let buttonRadius:CGFloat = 4.0
    
    let fontSize:CGFloat = 24.0
    let downFontSize:CGFloat = 36.0
    var buttonDown:Bool = false
    let buttonTail:CGFloat = 4
    let buttonDownWidthFactor:CGFloat = 1.66
    let buttonDownHeightFactor:CGFloat = 2.20
    let hPadding:CGFloat = 3;
    let vPadding:CGFloat = 8;
    let topMargin:CGFloat = 4;
    let buttonDownAddHeight:CGFloat = 62;
    let fontName = "helvetica"
    
    let blueColor:UIColor = UIColor.init(red: 0/255.0, green: 122/255.0, blue: 255/255.0, alpha: 1.0)
    
    //buttonType 0 changes shape when depressed, else no
    required init(buttonType: Int = 0, bgColor:UIColor, textColor:UIColor, bgColorDown:UIColor, textColorDown:UIColor) {
        // set myValue before super.init is called
        self.btype = buttonType
        
        vbgColor = bgColor
        vtextColor = textColor
        vbgDownColor = bgColorDown
        vtextDownColor = textColorDown
        
        super.init(frame: .zero)
        
        // set other operations after super.init, if required
        
        //backgroundColor = vbgColor
        setTitleColor(vtextColor, for: [])
        backgroundColor = UIColor.clear
        self.titleLabel!.font = UIFont(name: fontName, size: fontSize)
        
        self.addTarget(self, action: #selector(self.touchUpInside(sender:)), for: .touchUpInside)
        self.addTarget(self, action: #selector(self.touchUpOutside(sender:)), for: .touchUpOutside)
        self.addTarget(self, action: #selector(self.touchDown(sender:)), for: .touchDown)
        
        //these don't work, maybe this:
        //http://stackoverflow.com/questions/31916979/how-touch-drag-enter-works
        self.addTarget(self, action: #selector(touchDown(sender:)), for: .touchDragEnter)
        self.addTarget(self, action: #selector(touchUpInside(sender:)), for: .touchDragExit)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func touchUpInside(sender: UIButton!) {
        buttonDown = false
        
        if self.titleLabel?.text == "enter"
        {
            setTitleColor(.white, for: [])
            backgroundColor = blueColor
        }
        else if self.titleLabel?.text == "space"
        {
            setTitleColor(.gray, for: [])
            backgroundColor = .white
        }
        else if self.btype != 0
        {
            setTitleColor(vtextColor, for: [])
            //backgroundColor = vbgColor
            setNeedsDisplay()
        }
        else
        {
            if !(self.frame.size.width > self.frame.size.height * 1.5) && UIDevice.current.userInterfaceIdiom == .phone
            {
                let width = self.frame.size.width / buttonDownWidthFactor
                let height = (self.frame.size.height - buttonTail) / buttonDownHeightFactor
                let x = self.frame.origin.x + ((self.frame.size.width - (self.frame.size.width / buttonDownWidthFactor)) / 2)
                let y = self.frame.origin.y + (self.frame.size.height - height - buttonTail)
                
                let buttonFrame = CGRect(x:x, y:y, width:width, height:height)
                self.frame = buttonFrame
                self.titleLabel!.font = UIFont(name: fontName, size: fontSize)
                self.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0);
            }
            setTitleColor(vtextColor, for: [])
            setNeedsDisplay()
        }
    }
    
    @objc func touchUpOutside(sender: UIButton!) {
        buttonDown = false
        if self.titleLabel?.text == "enter"
        {
            setTitleColor(.white, for: [])
            backgroundColor = blueColor
        }
        else if self.titleLabel?.text == "space"
        {
            setTitleColor(.gray, for: [])
            backgroundColor = .white
        }
        else if self.btype != 0
        {
            setTitleColor(vtextColor, for: [])
            //backgroundColor = vbgColor
            setNeedsDisplay()
        }
        else
        {
            if !(self.frame.size.width > self.frame.size.height * 1.5) && UIDevice.current.userInterfaceIdiom == .phone
            {
                let width = self.frame.size.width / buttonDownWidthFactor
                let height = (self.frame.size.height - buttonTail) / buttonDownHeightFactor
                let x = self.frame.origin.x + ((self.frame.size.width - (self.frame.size.width / buttonDownWidthFactor)) / 2)
                let y = self.frame.origin.y + (self.frame.size.height - height - buttonTail)
                
                let buttonFrame = CGRect(x:x, y:y, width:width, height:height)
                self.frame = buttonFrame
                
                self.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0);
                self.titleLabel!.font = UIFont(name: fontName, size: fontSize)
            }
            setTitleColor(vtextColor, for: [])
            
            setNeedsDisplay()
        }
    }
    
    /*
     This accounts for why button down doesn't work on left hand side when used as app extension
     http://stackoverflow.com/questions/37196205/animation-delay-on-left-side-of-screen-in-ios-keyboard-extension
     */
    @objc func touchDown(sender: UIButton!) {
        buttonDown = true
        //sender.superview!.bringSubview(toFront: sender)
        if self.titleLabel?.text == "enter"
        {
            setTitleColor(blueColor, for: [])
            backgroundColor = .white
        }
        else if self.titleLabel?.text == "space"
        {
            setTitleColor(.white, for: [])
            backgroundColor = .black
        }
        else if self.btype != 0
        {
            setTitleColor(vtextDownColor, for: [])
            setNeedsDisplay()
            //backgroundColor = vbgDownColor
        }
        else
        {
            if !(self.frame.size.width > self.frame.size.height * 1.5) && UIDevice.current.userInterfaceIdiom == .phone
            {
                let width = self.frame.size.width * buttonDownWidthFactor
                let height = (self.frame.size.height * buttonDownHeightFactor) + buttonTail
                let x = self.frame.origin.x - (((self.frame.size.width * buttonDownWidthFactor) - self.frame.size.width) / 2)
                let y = self.frame.origin.y - height + self.frame.size.height + buttonTail
                
                let buttonFrame = CGRect(x:x, y:y, width:width, height:height)
                self.frame = buttonFrame
                
                self.titleEdgeInsets = UIEdgeInsets(top: -50, left: 0, bottom: 0, right: 0);
                self.titleLabel!.font = UIFont(name: fontName, size: downFontSize)
                setTitleColor(vtextColor, for: [])
            }
            else
            {
                setTitleColor(vtextDownColor, for: [])
            }
            setNeedsDisplay()
        }
    }
        
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        //NSLog("drawdraw: \(rect.size.width), \(rect.size.height)")
        
        let depressedPhoneButton:Bool = (buttonDown && !(rect.size.width > rect.size.height * 1.5)) && UIDevice.current.userInterfaceIdiom == .phone && self.btype == 0
        
        let ctx = UIGraphicsGetCurrentContext()
        
        let outerRect:CGRect = self.bounds//.insetBy(dx: 4.0, dy: 4.0);
        
        var outerPath:CGPath
        if depressedPhoneButton
        {
            outerPath = createDepressedButtonForRect(rect: outerRect, radius: buttonRadius + 2)
        }
        else
        {
            if UIDevice.current.userInterfaceIdiom == .pad
            {
                outerPath = UIBezierPath(roundedRect: outerRect, cornerRadius: HopliteConstants.ipadRadius).cgPath
            }
            else
            {
                outerPath = UIBezierPath(roundedRect: outerRect, cornerRadius: HopliteConstants.normalRadius).cgPath
            }
        }
        ctx?.saveGState()
        ctx?.addPath(outerPath)
        ctx?.clip()
        ctx?.restoreGState()
        
        ctx?.saveGState()
        if depressedPhoneButton
        {
            ctx?.addPath(createDepressedButtonForRect(rect: outerRect.insetBy(dx: 1.5, dy: 1.5), radius: buttonRadius + 2))
        }
        else
        {
            ctx?.addPath(outerPath)
        }
        if depressedPhoneButton
        {
            ctx?.setFillColor(vbgColor.cgColor)
        }
        else if buttonDown
        {
            ctx?.setFillColor(vbgDownColor.cgColor)
        }
        else
        {
            ctx?.setFillColor(vbgColor.cgColor)
            //ctx?.setShadow(offset: CGSize(width: 0, height: 10), blur: 2.0, color: UIColor.black.cgColor)
        }
        
        ctx?.fillPath()
        ctx?.restoreGState()
        
        if depressedPhoneButton
        {
            ctx?.saveGState()
            ctx?.addPath(createDepressedButtonForRect(rect: outerRect.insetBy(dx: 1.0, dy: 1.0), radius: buttonRadius + 2))
            ctx?.setLineWidth(0.5)
            ctx?.setStrokeColor(UIColor.lightGray.cgColor)
            ctx?.strokePath()
            ctx?.restoreGState()
        }
    }
    
    func createDepressedButtonForRect(rect:CGRect, radius:CGFloat ) -> CGMutablePath
    {
        let path:CGMutablePath = CGMutablePath()
        
        let offsetY:CGFloat = 54.0
        let a = superview as! HCKeyboardView
        let offsetX:CGFloat = (rect.maxX - a.buttonWidth) / 2// 10.0
        //NSLog("\(offsetX) abc \(rect.maxX) - \(rect.maxY / widthPerHeight)")
        let deltaY:CGFloat = 12.0
        
        let more:CGFloat = 12.0 //bigger radius for inner curves
        
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        
        //line, then arc around toward second point
        //first point is the destination of the line, second is where it arcs to
        
        //clockwise from top middle to right side, then curve down radius
        path.addArc(tangent1End: CGPoint(x:rect.maxX, y:rect.minY), tangent2End: CGPoint(x:rect.maxX, y:rect.maxY), radius: CGFloat(radius))
        //right-most side
        path.addArc(tangent1End: CGPoint(x:rect.maxX, y:rect.maxY - offsetY), tangent2End: CGPoint(x:rect.maxX - offsetX, y:rect.maxY - offsetY + deltaY), radius: CGFloat(radius + more))
        //xoffset towards middle
        path.addArc(tangent1End: CGPoint(x:rect.maxX - offsetX, y:rect.maxY - offsetY + deltaY), tangent2End: CGPoint(x:rect.maxX - offsetX, y:rect.maxY + deltaY), radius: CGFloat(radius + more))
        //yoffset down to bottom
        path.addArc(tangent1End: CGPoint(x:rect.maxX - offsetX, y:rect.maxY), tangent2End: CGPoint(x:rect.minX, y:rect.maxY), radius: CGFloat(radius))
        //bottom towards left side
        path.addArc(tangent1End: CGPoint(x:rect.minX + offsetX, y:rect.maxY), tangent2End: CGPoint(x:rect.minX + offsetX, y:rect.maxY - offsetY + deltaY), radius: CGFloat(radius))
        //yoffset up
        path.addArc(tangent1End: CGPoint(x:rect.minX + offsetX, y:rect.maxY - offsetY + deltaY), tangent2End: CGPoint(x:rect.minX, y:rect.maxY - offsetY), radius: CGFloat(radius + more))
        //xoffset to left side
        path.addArc(tangent1End: CGPoint(x:rect.minX, y:rect.maxY - offsetY), tangent2End: CGPoint(x:rect.minX, y:rect.minY), radius: CGFloat(radius + more))
        //left side up to top
        path.addArc(tangent1End: CGPoint(x:rect.minX, y:rect.minY), tangent2End: CGPoint(x:rect.maxX, y:rect.minY), radius: CGFloat(radius))
        //close to middle
        path.closeSubpath()
        
        return path
    }
 /*
    func createDepressedButtonForRectOld(rect:CGRect, radius:CGFloat ) -> CGMutablePath
    {
        let inset:CGFloat = 8
        let topHeight:CGFloat = rect.size.height / 2
        let midHeight:CGFloat = rect.size.height / 4
    
        let path:CGMutablePath = CGMutablePath()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        
        //NE
        path.addArc(tangent1End: CGPoint(x:rect.maxX, y:rect.minY), tangent2End: CGPoint(x:rect.maxX, y:rect.maxY), radius: radius)
        
        path.addLine(to: CGPoint(x:rect.maxX, y:rect.minY + topHeight))
        path.addLine(to: CGPoint(x:rect.maxX - inset, y:rect.minY + topHeight + midHeight))
        
        //SE
        path.addArc(tangent1End: CGPoint(x:rect.maxX - inset, y:rect.maxY), tangent2End: CGPoint(x:rect.minX - inset, y:rect.maxY), radius: radius)
        //SW
        path.addArc(tangent1End: CGPoint(x:rect.minX + inset, y:rect.maxY), tangent2End: CGPoint(x:rect.minX, y:rect.minY), radius: radius)

        path.addLine(to: CGPoint(x:rect.minX + inset, y: rect.minY + topHeight + midHeight))
        path.addLine(to: CGPoint(x:rect.minX, y:rect.minY + topHeight))

        //NW
        path.addArc(tangent1End: CGPoint(x:rect.minX, y:rect.minY), tangent2End: CGPoint(x:rect.maxX, y:rect.minY), radius: radius)
    
        path.closeSubpath()
    
        return path;
    }
 */
}
