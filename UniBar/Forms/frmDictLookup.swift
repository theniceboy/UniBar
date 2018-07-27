//
//  frmDictLookup.swift
//  UniBar
//
//  Created by David Chen on 7/27/18.
//  Copyright © 2018 David Chen. All rights reserved.
//

import Cocoa

class frmDictLookup: NSViewController, NSTextFieldDelegate {

    // Outlets
    @IBOutlet weak var vSearch: NSView!
    @IBOutlet weak var tfSearch: NSTextField!
    @IBOutlet weak var v_tfSearch: NSView!
    @IBOutlet weak var lbWebSearchHint: NSTextField!
    @IBOutlet weak var _layout_v_tfSearch_vSearch: NSLayoutConstraint!
    
    @IBOutlet weak var vDictResult: NSView!
    @IBOutlet weak var _layout_vDictResultHeight: NSLayoutConstraint!
    
    // Initialization
    func uiInitialization () {
        self.view.wantsLayer = true
        v_tfSearch.wantsLayer = true
        tfSearch.wantsLayer = true
        
        self.view.layer?.backgroundColor = CGColor.white
        v_tfSearch.layer?.backgroundColor = colorLightGray1
        v_tfSearch.layer?.cornerRadius = 4
        
        // Create/customize Dictionary result area
        vDictResult.wantsLayer = true
        vDictResult.layer?.backgroundColor = colorLightGray1
        vDictResult.layer?.cornerRadius = 6
        
        let resultitem = NSView()
        vDictResult.translatesAutoresizingMaskIntoConstraints = false
        resultitem.translatesAutoresizingMaskIntoConstraints = false
        resultitem.wantsLayer = true
        resultitem.layer?.backgroundColor = CGColor.white
        resultitem.layer?.cornerRadius = 5
        //vDictResult.removeConstraints(vDictResult.constraints)
        vDictResult.addSubview(resultitem)
        vDictResult.addConstraint(NSLayoutConstraint(item: vDictResult, attribute: .top, relatedBy: .equal, toItem: resultitem, attribute: .top, multiplier: 1, constant: -5))
        vDictResult.addConstraint(NSLayoutConstraint(item: resultitem, attribute: .leading, relatedBy: .equal, toItem: vDictResult, attribute: .leading, multiplier: 1, constant: 8))
        vDictResult.addConstraint(NSLayoutConstraint(item: resultitem, attribute: .trailing, relatedBy: .equal, toItem: vDictResult, attribute: .trailing, multiplier: 1, constant: -8))
        vDictResult.addConstraint(NSLayoutConstraint(item: resultitem, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 30))
 
        vDictResult.layout()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Needed setups
        tfSearch.delegate = self
        
        // Visual customization
        uiInitialization()
    }
    
    override func viewDidAppear() {
        // User comfort
        tfSearch.becomeFirstResponder()
    }
    
    // MARK: - Textfild handling
    
    override func controlTextDidChange(_ obj: Notification) {
        // Visual customizations
        self.v_tfSearch.layer?.animate(color: (self.tfSearch.stringValue == "" ? colorLightGray1 : colorLightGray2), keyPath: "backgroundColor", duration: 0.15)
        // why?
        
        // Look up dictionary
        if (tfSearch.stringValue != "") {
            if let json = dictQuery(pattern: tfSearch.stringValue.trimmingCharacters(in: .whitespacesAndNewlines) + "*") {
                for dictword in json {
                    print(dictword.key)
                }
            }
            //label.stringValue = (dict.entries(forSearchTerm: tfSearch.stringValue)?.first as! TTTDictionaryEntry).text
        }
    }
    
}

extension frmDictLookup {
    // MARK: Storyboard instantiation
    static func freshController() -> frmDictLookup {
        //1.
        let storyboard = NSStoryboard(name: NSStoryboard.Name("Main"), bundle: nil)
        //2.
        let identifier = NSStoryboard.SceneIdentifier("frmDictLookup")
        //3.
        guard let viewcontroller = storyboard.instantiateController(withIdentifier: identifier) as? frmDictLookup else {
            fatalError("Why cant i find frmUniMain? - Check Main.storyboard")
        }
        return viewcontroller
    }
}
