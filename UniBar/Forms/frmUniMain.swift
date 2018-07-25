//
//  frmUniMain.swift
//  UniBar
//
//  Created by David Chen on 7/23/18.
//  Copyright © 2018 David Chen. All rights reserved.
//

import Cocoa
import Python


var curShowingStatus: Int = 0

class frmUniMain: NSViewController, NSTextFieldDelegate {

    // Outlets
    @IBOutlet weak var tfSearch: NSTextField!
    
    @IBOutlet weak var btnSettings: FlatButton!
    @IBOutlet weak var btnQuitUibar: FlatButton!
    @IBOutlet weak var v_tfSearch: NSView!
    
    // In-class variables
    var dict: TTTDictionary = TTTDictionary(named: "Apple Dictionary")
    
    // Initialization
    func uiInitialization () {
        self.view.wantsLayer = true
        v_tfSearch.wantsLayer = true
        tfSearch.wantsLayer = true
        
        self.view.layer?.backgroundColor = CGColor.white
        v_tfSearch.layer?.backgroundColor = colorLightGray1
        v_tfSearch.layer?.cornerRadius = 4
        
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Needed setups
        tfSearch.delegate = self
        
        // Setup dictionary
        Py_Initialize()
        
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
        
        
        
        // User comfort
        tfSearch.becomeFirstResponder()
    }
    
    
    @IBAction func btnSettings_Clicked(_ sender: Any) {
        statusbutton = UnibarIcon.button!
    }
    
    @IBAction func btnQuit_Clicked(_ sender: Any) {
        NSApplication.shared.terminate(self)
    }
    @IBOutlet weak var label: NSTextField!
    
    // MARK: - Textfild handling
    
    override func controlTextDidChange(_ obj: Notification) {
        // Visual customizations
        self.v_tfSearch.layer?.animate(color: (self.tfSearch.stringValue == "" ? colorLightGray1 : colorLightGray2), keyPath: "backgroundColor", duration: 0.15)
        // why?
        
        // Look up dictionary
        if (tfSearch.stringValue != "") {
            if let entries = dict.entries(forSearchTerm: "apple") {
                for entry in entries {
                    print(entry)
                }
            }
            //label.stringValue = (dict.entries(forSearchTerm: tfSearch.stringValue)?.first as! TTTDictionaryEntry).text
        }
    }
    
    
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
