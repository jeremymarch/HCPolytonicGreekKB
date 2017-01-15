//
//  KeyboardViewController.swift
//  HCPolytonicGreekKB
//
//  Created by Jeremy March on 12/24/16.
//  Copyright © 2016 Jeremy March. All rights reserved.
//

import UIKit
/*
//http://norbertlindenberg.com/2014/12/developing-keyboards-for-ios/
extension UIInputView: UIInputViewAudioFeedback {
    
    public var enableInputClicksWhenVisible: Bool { get { return true } }
    
    func playInputClick​() {
        UIDevice.current.playInputClick()
    }
}
*/
class KeyboardViewController: UIInputViewController {

    var capsLockOn = true
    let bgColor = UIColor.white
    let keyTextColor = UIColor.black
    let useAnimation = false
    var deleteHoldTimer:Timer? = nil
    //var deleteButton:UIButton? = nil
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        // Add custom view sizing constraints here
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSLog("kb view did load")
        self.view.translatesAutoresizingMaskIntoConstraints = true //this is needed
        self.view.isUserInteractionEnabled = true
        self.view.backgroundColor = bgColor
        
        let buttonSpacing:CGFloat = 4.0

        /*
         let upperBorder: CALayer = CALayer()
         upperBorder.backgroundColor = UIColor.green.cgColor
         upperBorder.frame = CGRect(x:0,y:0,width:self.view.frame.width,height:4)
         self.view.layer.addSublayer(upperBorder)
         */
        
        //is this needed?  it seems to be
        /*
        self.view.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width).isActive = true
        self.view.heightAnchor.constraint(equalToConstant: 315).isActive = true
        let margins = view.layoutMarginsGuide
        self.view.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        self.view.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        
        self.view.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor).isActive = true
        self.view.bottomAnchor.constraint(equalTo: self.view.layoutMarginsGuide.bottomAnchor).isActive = true
        */


        //Stack View
        let stackView1   = UIStackView()
        stackView1.axis  = UILayoutConstraintAxis.horizontal
        stackView1.distribution  = UIStackViewDistribution.equalSpacing
        stackView1.alignment = UIStackViewAlignment.center
        stackView1.spacing   = buttonSpacing
        
        let stackView2   = UIStackView()
        stackView2.axis  = UILayoutConstraintAxis.horizontal
        stackView2.distribution  = UIStackViewDistribution.equalSpacing
        stackView2.alignment = UIStackViewAlignment.center
        stackView2.spacing   = buttonSpacing
        
        let stackView3   = UIStackView()
        stackView3.axis  = UILayoutConstraintAxis.horizontal
        stackView3.distribution  = UIStackViewDistribution.equalSpacing
        stackView3.alignment = UIStackViewAlignment.center
        stackView3.spacing   = buttonSpacing
        
        let stackView4   = UIStackView()
        stackView4.axis  = UILayoutConstraintAxis.horizontal
        stackView4.distribution  = UIStackViewDistribution.equalSpacing
        stackView4.alignment = UIStackViewAlignment.center
        stackView4.spacing   = buttonSpacing
        
        let stackView5   = UIStackView()
        stackView5.axis  = UILayoutConstraintAxis.horizontal
        stackView5.distribution  = UIStackViewDistribution.equalSpacing
        stackView5.alignment = UIStackViewAlignment.center
        stackView5.spacing   = buttonSpacing
        
        let stackViewV  = UIStackView()
        stackViewV.axis  = UILayoutConstraintAxis.vertical
        stackViewV.distribution  = UIStackViewDistribution.equalSpacing
        stackViewV.alignment = UIStackViewAlignment.center
        stackViewV.spacing   = buttonSpacing
        
        stackView1.translatesAutoresizingMaskIntoConstraints = false;
        stackView2.translatesAutoresizingMaskIntoConstraints = false;
        stackView3.translatesAutoresizingMaskIntoConstraints = false;
        stackView4.translatesAutoresizingMaskIntoConstraints = false;
        stackView5.translatesAutoresizingMaskIntoConstraints = false;
        stackViewV.translatesAutoresizingMaskIntoConstraints = false;
        
        stackViewV.addArrangedSubview(stackView1)
        stackViewV.addArrangedSubview(stackView2)
        stackViewV.addArrangedSubview(stackView3)
        stackViewV.addArrangedSubview(stackView4)
        stackViewV.addArrangedSubview(stackView5)
        
        /*
        Also need:
            period
            comma
            raised dot, ano teleia
            question mark
        */
        let keys: [[String]] = [["(", ")", "/", "\\", "=", "-", "|", "()"],
                                ["ε", "ρ", "τ", "υ", "θ", "ι", "ο", "π"],
                               ["α", "σ", "δ", "φ", "γ", "η", "ξ", "κ", "λ"],
                               ["ζ", "χ", "ψ", "ω", "β", "ν", "μ", "ς"],
                               ["CP", "KB", "SP", "RT", "BK"]]

        //var lastRow: NSLayoutYAxisAnchor?
        //lastRow = nil
        for row in keys
        {
            //var lastKey:NSLayoutXAxisAnchor?
            //lastKey = nil

            var b:UIButton

            for key in row
            {
                b = HCButton(type: .system)
                
                b.layer.borderWidth = 1.0
                b.layer.borderColor = UIColor.blue.cgColor
                b.layer.cornerRadius = 4.0
                b.titleLabel?.textColor = UIColor.black
                b.setTitleColor(keyTextColor, for: [])
                b.titleLabel!.font = UIFont(name: b.titleLabel!.font.fontName, size: 24)
                //b.layer.backgroundColor = UIColor.brown.cgColor
                b.setTitle(key, for: [])
                
                b.isUserInteractionEnabled = true
                b.translatesAutoresizingMaskIntoConstraints = false
                
                if row == keys[0]
                {
                    b.addTarget(self, action: #selector(accentPressed(_:)), for: .touchUpInside)
                }
                else if row == keys[1] || row == keys[2] || row == keys[3]
                {
                    b.addTarget(self, action: #selector(self.keyPressed(button:)), for: .touchUpInside)
                }
                else if key == "KB"
                {
                    b.addTarget(self, action: #selector(handleInputModeList(from:with:)), for: .touchUpInside)
                }
                else if key == "RT"
                {
                    b.addTarget(self, action: #selector(returnPressed(_:)), for: .touchUpInside)
                }
                else if key == "SP"
                {
                    b.addTarget(self, action: #selector(spacePressed(_:)), for: .touchUpInside)
                }
                else if key == "BK"
                {
                    let lpgr = UILongPressGestureRecognizer(target: self, action: #selector(longDeletePressGesture))
                    lpgr.minimumPressDuration = 0.5
                    lpgr.delaysTouchesBegan = true
                    lpgr.allowableMovement = 50.0
                    b.addGestureRecognizer(lpgr)
                    
                    //need both long and normal
                    b.addTarget(self, action: #selector(backSpacePressed(_:)), for: .touchUpInside)
                    
                    //deleteButton = b
                }
                /*
                if lastKey == nil
                {
                    lastKey = self.view.layoutMarginsGuide.leftAnchor //self.view.leftAnchor
                }
                if lastRow == nil
                {
                    lastRow = self.view.layoutMarginsGuide.topAnchor// topAnchor
                }
                */
                
                //b.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.11).isActive = true
                //NSLog("width: %f", self.view.bounds.width)
                //b.widthAnchor.constraint(equalToConstant: 42.0)
                //self.view.leftAnchor.constraint(equalTo: self.view.p)

                
                //this works, but doesn't rotate
                //let bWidth3:CGFloat = UIScreen.main.bounds.size.width / 9
                //b.addConstraint(NSLayoutConstraint(item: b, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0, constant:bWidth3))
                
                //or
                /*
                self.view.addConstraint(NSLayoutConstraint(item: b, attribute: .width, relatedBy: .equal, toItem: self.view, attribute: .width, multiplier: 1/9, constant: 0.0))
                
                
                b.leftAnchor.constraint(equalTo: lastKey!).isActive = true
                b.topAnchor.constraint(equalTo: lastRow!).isActive = true
                
                lastKey = b.rightAnchor
                if key == row[row.count - 1]
                {
                    b.rightAnchor.constraint(equalTo: self.view.layoutMarginsGuide.rightAnchor).isActive = true
                    lastRow = b.bottomAnchor
                }
                if row == keys[keys.count - 1]
                {
                    b.bottomAnchor.constraint(equalTo: self.view.layoutMarginsGuide.bottomAnchor).isActive = true
                }
                */
                let widthMultiple:CGFloat = 0.10
                if row == keys[0]
                {
                    stackView1.addArrangedSubview(b)
                    b.widthAnchor.constraint(equalTo: stackViewV.widthAnchor, multiplier: widthMultiple).isActive = true
                }
                else if row == keys[1]
                {
                    stackView2.addArrangedSubview(b)
                    b.widthAnchor.constraint(equalTo: stackViewV.widthAnchor, multiplier: widthMultiple).isActive = true
                }
                else if row == keys[2]
                {
                    stackView3.addArrangedSubview(b)
                    b.widthAnchor.constraint(equalTo: stackViewV.widthAnchor, multiplier: widthMultiple).isActive = true
                }
                else if row == keys[3]
                {
                    stackView4.addArrangedSubview(b)
                    b.widthAnchor.constraint(equalTo: stackViewV.widthAnchor, multiplier: widthMultiple).isActive = true
                }
                else if row == keys[4]
                {
                    stackView5.addArrangedSubview(b)
                    b.widthAnchor.constraint(equalTo: stackViewV.widthAnchor, multiplier: widthMultiple).isActive = true
                }
                
            }
        }
        
        self.view.addSubview(stackViewV)
        
        stackViewV.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        stackViewV.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        stackViewV.topAnchor.constraint(equalTo: self.view.topAnchor, constant:4.0).isActive = true
        stackViewV.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant:-4.0).isActive = true
        
        //charSet2.isHidden = true
        /*
        capsLockOn = !capsLockOn
        changeCaps(row1)
        changeCaps(row2)
        changeCaps(row3)
        changeCaps(row4)
 */
 
    }
    /*
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        updateViewConstraints()
    }
    */
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated
    }
    
    override func textWillChange(_ textInput: UITextInput?) {
        // The app is about to change the document's contents. Perform any preparation here.
    }
    
    override func textDidChange(_ textInput: UITextInput?) {
        // The app has just changed the document's contents, the document context has been updated.
        
        var textColor: UIColor
        let proxy = self.textDocumentProxy
        if proxy.keyboardAppearance == UIKeyboardAppearance.dark {
            textColor = UIColor.white
        } else {
            textColor = UIColor.black
        }
        //self.nextKeyboardButton.setTitleColor(textColor, for: [])
    }
    
    let COMBINING_GRAVE =            0x0300
    let COMBINING_ACUTE =            0x0301
    let COMBINING_CIRCUMFLEX =       0x0302
    let COMBINING_MACRON =           0x0304
    let COMBINING_DIAERESIS =        0x0308
    let COMBINING_SMOOTH_BREATHING = 0x0313
    let COMBINING_ROUGH_BREATHING =  0x0314
    let COMBINING_IOTA_SUBSCRIPT =   0x0345
    let EM_DASH =                    0x2014
    let LEFT_PARENTHESIS =           0x0028
    let RIGHT_PARENTHESIS =          0x0029
    let SPACE =                      0x0020
    let EN_DASH =                    0x2013
    let HYPHEN =                     0x2010
    let COMMA =                      0x002C
    
    func accentPressed(_ button: UIButton) {
        let whichAccent = button.titleLabel!.text
        var accent = -1
        if whichAccent == "/"
        {
            accent = 1
        }
        else if whichAccent == "="
        {
            accent = 2
        }
        else if whichAccent == "\\"
        {
            accent = 3
        }
        else if whichAccent == "-"
        {
            accent = 4
        }
        else if whichAccent == "("
        {
            accent = 5
        }
        else if whichAccent == ")"
        {
            accent = 6
        }
        else if whichAccent == "|"
        {
            accent = 7
        }
        else if whichAccent == "()"
        {
            accent = 8
        }
        else
        {
            return;
        }
        
        
        let context = self.textDocumentProxy.documentContextBeforeInput
        let len = context?.characters.count
        if len == nil || len! < 1
        {
            return;
        }
        
        //accentSyllable(&context?.utf16, context.count, &context.count, 1, false);
        /*
         let bufferSize = 200
         var nameBuf = [Int8](repeating: 0, count: bufferSize) // Buffer for C string
         nameBuf[0] = Int8(context![context!.index(before: context!.endIndex)])
         accentSyllableUtf8(&nameBuf, 1, false)
         let name = String(cString: nameBuf)
         */
        
        let combiningChars = [COMBINING_GRAVE,COMBINING_ACUTE,COMBINING_CIRCUMFLEX,COMBINING_MACRON,COMBINING_DIAERESIS,COMBINING_SMOOTH_BREATHING,COMBINING_ROUGH_BREATHING,COMBINING_IOTA_SUBSCRIPT]
        
        let bufferSize16 = 5
        var buffer16 = [UInt16](repeating: 0, count: bufferSize16) // Buffer for C string
        
        var lenToSend = 1
        let maxCombiningChars = 5
        for a in (context!.unicodeScalars).reversed()
        {
            if lenToSend < maxCombiningChars && combiningChars.contains(Int(a.value))
            {
                lenToSend += 1
            }
            else
            {
                break
            }
        }
        
        let suf = context!.unicodeScalars.suffix(lenToSend)
        var j = 0
        for i in (1...lenToSend).reversed()
        {
            buffer16[j] = UInt16(suf[suf.index(suf.endIndex, offsetBy: -i)].value)
            j += 1
        }
        var len16:Int32 = Int32(lenToSend)
        
        accentSyllable16(&buffer16, 0, &len16, Int32(accent), true)
        
        let newLetter = String(utf16CodeUnits: buffer16, count: Int(len16))
        
        (textDocumentProxy as UIKeyInput).deleteBackward() //seems to include any combining chars
        (textDocumentProxy as UIKeyInput).insertText("\(newLetter)")
        
        if useAnimation
        {
            UIView.animate(withDuration: 0.2, animations: {
                button.transform = CGAffineTransform.identity.scaledBy(x: 2.0, y: 2.0)
            }, completion: {(_) -> Void in
                button.transform =
                    CGAffineTransform.identity.scaledBy(x: 1, y: 1)
            })
        }
    }
    
    func keyPressed(button: UIButton) {
        //NSLog("key pressed")
        let string = button.titleLabel!.text
        (textDocumentProxy as UIKeyInput).insertText("\(string!)")
        UIDevice.current.playInputClick()
        
        if useAnimation
        {
            UIView.animate(withDuration: 0.2, animations: {
                button.transform = CGAffineTransform.identity.scaledBy(x: 2.0, y: 2.0)
            }, completion: {(_) -> Void in
                button.transform =
                    CGAffineTransform.identity.scaledBy(x: 1, y: 1)
            })
        }
    }
    
    func backSpacePressed(_ button: UIButton) {
        (textDocumentProxy as UIKeyInput).deleteBackward()
    }
    
    func longDeletePressGesture(gestureReconizer: UILongPressGestureRecognizer) {
        
        if ( gestureReconizer.state == UIGestureRecognizerState.began )
        {
            self.deleteHoldTimer = Timer.scheduledTimer(timeInterval: 0.085, target: self, selector: #selector(backSpacePressed(_:)), userInfo: nil, repeats: true)
            
            let theRunLoop = RunLoop.current
            theRunLoop.add(self.deleteHoldTimer!, forMode: RunLoopMode.defaultRunLoopMode)
        }
        else if ( gestureReconizer.state == UIGestureRecognizerState.ended )
        {
            self.deleteHoldTimer!.invalidate();
            self.deleteHoldTimer = nil
            
            //need this or it stays in the down state
            //[self.deleteButton touchUpInside:self.deleteButton];
        }
        //NSLog(@"lg: %ld", (long)gesture.state);
    }
    
    func spacePressed(_ button: UIButton) {
        (textDocumentProxy as UIKeyInput).insertText(" ")
    }
    
    func returnPressed(_ button: UIButton) {
        (textDocumentProxy as UIKeyInput).insertText("\n")
    }
    
    func changeCaps(_ containerView: UIView) {
        for view in containerView.subviews {
            if let button = view as? UIButton {
                let buttonTitle = button.titleLabel!.text
                if capsLockOn {
                    let text = buttonTitle!.uppercased()
                    button.setTitle("\(text)", for: UIControlState())
                } else {
                    let text = buttonTitle!.lowercased()
                    button.setTitle("\(text)", for: UIControlState())
                }
            }
        }
    }
 
    func nextKeyboardPressed(_ button: UIButton) {
        advanceToNextInputMode()
    }
}
