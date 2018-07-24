//
//  uniSearchBar.swift
//  UniBar
//
//  Created by David Chen on 7/22/18.
//  Copyright © 2018 David Chen. All rights reserved.
//

import Cocoa

class uniSearchBar: NSView, NSTextFieldDelegate {

    @IBOutlet weak var tfSearchBar: NSTextField!
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        //tfSearchBar.becomeFirstResponder()
        // Drawing code here.
    }
    
    @IBAction func btnTapped(_ sender: Any) {
        printView("tapped")
    }
    
    
    override func viewDidChangeEffectiveAppearance() {
        print("ap")
    }
    
}
