//
//  frmTestingOnly.swift
//  UniBar
//
//  Created by David Chen on 7/27/18.
//  Copyright © 2018 David Chen. All rights reserved.
//

import Cocoa

class frmTestingOnly: NSViewController {

    @IBOutlet weak var lbTest: NSTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.wantsLayer = true
        lbTest.wantsLayer = true
        self.view.layer?.backgroundColor = colorLightGray1
        print("frmTestingOnlyLoaded")
        // Do view setup here.
    }
    
    override func viewDidAppear() {
        print("frmTestingOnly appeared!")
        lbTest.stringValue = "\(NSDate())"
    }
    
}

extension frmTestingOnly {
    // MARK: Storyboard instantiation
    static func freshController() -> frmTestingOnly {
        //1.
        let storyboard = NSStoryboard(name: NSStoryboard.Name("Main"), bundle: nil)
        //2.
        let identifier = NSStoryboard.SceneIdentifier("frmTestingOnly")
        //3.
        guard let viewcontroller = storyboard.instantiateController(withIdentifier: identifier) as? frmTestingOnly else {
            fatalError("Why cant i find frmUniMain? - Check Main.storyboard")
        }
        return viewcontroller
    }
}

