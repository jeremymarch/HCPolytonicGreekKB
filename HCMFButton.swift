//
//  HCAccentButton.swift
//  HCPolytonicGreekKBapp
//
//  Created by Jeremy March on 1/14/17.
//  Copyright © 2017 Jeremy March. All rights reserved.
//

import UIKit

class HCMFButton: UIButton {
    /*
     var bgColor:UIColor = .gray
     var bgDownColor:UIColor = .black
     var textColor:UIColor = .white
     var textDownColor:UIColor = .white
     */
    var bgColor = HopliteConstants.accentBGColor
    var textColor = HopliteConstants.accentTextColor
    var bgDownColor = HopliteConstants.accentBGColorDown
    var textDownColor = HopliteConstants.accentTextColorDown
    var buttonDown = false
    
    let hcorange = UIColor(red: 1.0, green: 0.2196, blue: 0, alpha: 1)
    
    var btype: Int? = nil
    var isDepressed:Bool = false
    
    required init(buttonType: Int = 0) {
        // set myValue before super.init is called
        self.btype = buttonType
        
        super.init(frame: .zero)
        
        // set other operations after super.init, if required
        
        backgroundColor = UIColor.white
        setTitleColor(hcorange, for: [])
        
        self.addTarget(self, action: #selector(touchUpInside(sender:)), for: .touchUpInside)
        self.addTarget(self, action: #selector(touchUpOutside(sender:)), for: .touchUpOutside)
        self.addTarget(self, action: #selector(touchDown(sender:)), for: .touchDown)
        
        self.addTarget(self, action: #selector(touchDown(sender:)), for: .touchDragEnter)
        self.addTarget(self, action: #selector(touchUpOutside(sender:)), for: .touchDragExit)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func touchUpInside(sender: UIButton!) {

        isDepressed = true
        buttonDown = false
        layer.borderColor = hcorange.cgColor
        layer.borderWidth = 2.0
        
        backgroundColor = UIColor.white
        setTitleColor(hcorange, for: [])
        
        setNeedsDisplay()
    }
    
    @objc func touchUpOutside(sender: UIButton!) {

        isDepressed = false
        buttonDown = false
        layer.borderColor = nil
        layer.borderWidth = 0.0
        
        backgroundColor = hcorange
        setTitleColor(UIColor.white, for: [])
        setNeedsDisplay()
    }
    
    @objc func touchDown(sender: UIButton!) {

        isDepressed = true
        buttonDown = true
        layer.borderColor = hcorange.cgColor
        layer.borderWidth = 2.0
        
        backgroundColor = UIColor.white
        setTitleColor(hcorange, for: [])
        setNeedsDisplay()
    }
    
    func reset()
    {
        isDepressed = false
        buttonDown = false
        layer.borderColor = nil
        layer.borderWidth = 0.0
        setTitle("MF", for: [])
        
        backgroundColor = hcorange
        setTitleColor(UIColor.white, for: [])
        setNeedsDisplay()
    }
}
