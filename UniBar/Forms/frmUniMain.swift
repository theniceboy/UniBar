//
//  frmUniMain.swift
//  UniBar
//
//  Created by David Chen on 7/23/18.
//  Copyright © 2018 David Chen. All rights reserved.
//

import Cocoa


var curShowingStatus: Int = 0

class frmUniMain: NSViewController, NSTextFieldDelegate {

    // Outlets
    //    Containers
    @IBOutlet weak public var vcvDictLookup: NSView! // Father
    @IBOutlet weak public var cvDictLookup: NSView!
    @IBOutlet weak public var _layout_cvDictLookupHeight: NSLayoutConstraint!
    
    @IBOutlet weak var vTestingOnly: NSView!
    
    @IBOutlet weak var btnSettings: FlatButton!
    @IBOutlet weak var btnQuitUibar: FlatButton!
    
    // In-class variables
    
    // Initialization
    func uiInitialization () {
        self.view.wantsLayer = true
        self.view.layer?.backgroundColor = NSColor.yellow.cgColor
    }
    
    /*
 NSAnimationContext.runAnimationGroup({_in
 
 //Indicate the duration of the animation
 
 NSAnimationContext.current().duration = 5.0
 
 //What is being animated? In this example I’m making a view transparent
 
 someView.animator().alphaValue = 0.0
 
 }, completionHandler:{
 
 //In here we add the code that should be triggered after the animation completes.
 
 print(“Animation completed”)
 
 })
 */
    
    public func updateWindowHeight(containerHeight: CGFloat) {
        let newHeight = containerHeight + 400
        let newOrigin = getWindowOriginWithSize(newSize: NSSize(width: self.view.frame.width, height: newHeight))
        windowUniMain.window?.setFrame(NSRect(x: newOrigin.x, y: newOrigin.y, width: (windowUniMain.window?.frame.width)!, height: newHeight), display: true, animate: true)
        //self.preferredContentSize = NSSize(width: self.preferredContentSize.width, height: containerHeight + 400)
    }
    
    public func updateLookup (height: CGFloat) {
        _layout_cvDictLookupHeight.constant = height
        //self.view.layout()
        //cvDictLookup.subviews.removeAll()
        //print("removed, ez")
        //loadDictLookup()
        //vcDictLookup.view.frame = NSRect(x: 0, y: -500, width: self.view.frame.width, height: 100)
    }
    
    func loadDictLookup () {
        self.addChild(vcDictLookup)
        cvDictLookup.addSubview(vcDictLookup.view)
        let f = cvDictLookup.bounds
        //print(f)
        vcDictLookup.view.frame = f
        //print(vcDictLookup.view.frame)
        /*
        cvDictLookup.addConstraint(NSLayoutConstraint(item: cvDictLookup, attribute: .top, relatedBy: .equal, toItem: vcDictLookup.view, attribute: .top, multiplier: 1, constant: 0))
        cvDictLookup.addConstraint(NSLayoutConstraint(item: cvDictLookup, attribute: .bottom, relatedBy: .equal, toItem: vcDictLookup.view, attribute: .bottom, multiplier: 1, constant: 0))
        cvDictLookup.addConstraint(NSLayoutConstraint(item: cvDictLookup, attribute: .left, relatedBy: .equal, toItem: vcDictLookup.view, attribute: .left, multiplier: 1, constant: 0))
        cvDictLookup.addConstraint(NSLayoutConstraint(item: cvDictLookup, attribute: .right, relatedBy: .equal, toItem: vcDictLookup.view, attribute: .right, multiplier: 1, constant: 0))
 */
        //cvDictLookup.layout()
    }
    
    func forTestingOnly () {
        self.addChild(vcTestingOnly)
        vTestingOnly.addSubview(vcTestingOnly.view)
        vcTestingOnly.view.frame = vTestingOnly.bounds
        vTestingOnly.wantsLayer = true
        
        //vcTestingOnly.didMove(toParentViewController: self)

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Needed setups
        
        // Add & load subviewcontrollers
        loadDictLookup()
        forTestingOnly() // for testing only
        
        // Visual customization
        uiInitialization()
    }
    
    
    override func viewDidAppear() {
        print("appeared")
        
        // Change flages and status
        curShowingStatus = 1
        
        // Activate window and order front
        windowUniMain.window?.makeKey()
        windowUniMain.window?.makeMain()
        becomeFirstResponder()
        NSApplication.shared.activate(ignoringOtherApps: true)
        
    }
    
    
    @IBAction func btnSettings_Clicked(_ sender: Any) {
        statusbutton = UnibarIcon.button!
    }
    
    @IBAction func btnQuit_Clicked(_ sender: Any) {
        NSApplication.shared.terminate(self)
    }
    @IBOutlet weak var label: NSTextField!
    

    
    
}

extension frmUniMain {
    // MARK: Storyboard instantiation
    static func freshController() -> frmUniMain {
        //1.
        let storyboard = NSStoryboard(name: NSStoryboard.Name("Main"), bundle: nil)
        //2.
        let identifier = NSStoryboard.SceneIdentifier("frmUniMain")
        //3.
        guard let viewcontroller = storyboard.instantiateController(withIdentifier: identifier) as? frmUniMain else {
            fatalError("Why cant i find frmUniMain? - Check Main.storyboard")
        }
        return viewcontroller
    }
}
