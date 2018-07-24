//
//  frmUniMain.swift
//  UniBar
//
//  Created by David Chen on 7/23/18.
//  Copyright © 2018 David Chen. All rights reserved.
//

import Cocoa

var curShowingStatus: Int = 0

class frmUniMain: NSViewController {

    @IBOutlet weak var tfSearch: NSTextField!
    
    @IBOutlet weak var btnSettings: FlatButton!
    @IBOutlet weak var btnQuitUibar: FlatButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tfSearch.layer?.borderWidth = 0
        tfSearch.layer?.allowsEdgeAntialiasing = true
        
        if (curShowingStatus == 0) {
            NSApplication.shared.hide(nil)
        } else if (curShowingStatus == 1) {
            curShowingStatus = 0
        }
    }
    
    override func viewDidAppear() {
        tfSearch.becomeFirstResponder()
    }
    
    
    @IBAction func btnSettings_Clicked(_ sender: Any) {
        statusbutton = UnibarIcon.button!
    }
    
    @IBAction func btnQuit_Clicked(_ sender: Any) {
        NSApplication.shared.terminate(self)
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
