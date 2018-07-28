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
    
    @IBOutlet weak var vRuler: NSView!
    
    // In class constants
    let _lcDictWordItemHeight: CGFloat = 45
    let _lcDictWordItemDistance: CGFloat = 5
    let _lcDictWordLabeMarginHor: CGFloat = 6
    let _lcDictWordLabeMarginVer: CGFloat = 6
    let _lcDictWordLabeMarginBetw: CGFloat = 4
    
    // In class variables
    var dictResults: [DictWord] = []
    var viewHeight: CGFloat = 0
    
    // UI work
    
    func updateParentViewHeight () {
        //self.preferredContentSize = NSSize(width: self.preferredContentSize.width, height: vRuler.frame.height)
        
        vcUniMain.cvDictLookup.wantsLayer = true
        vcUniMain.cvDictLookup.layer?.backgroundColor = NSColor.blue.cgColor
        
        self.view.layoutSubtreeIfNeeded()
        vcUniMain.view.layoutSubtreeIfNeeded()
        if #available(OSX 10.12, *) {
            NSAnimationContext.runAnimationGroup { (context) in
                context.duration = 0.25
                context.allowsImplicitAnimation = true
                
                vcUniMain._layout_cvDictLookupHeight.constant = viewHeight
                vcUniMain.view.layoutSubtreeIfNeeded()
            }
        } else {
            vcUniMain._layout_cvDictLookupHeight.animator().constant = viewHeight
        }
        
        self.view.frame = vcUniMain.cvDictLookup.bounds
        vcUniMain.updateWindowHeight(containerHeight: viewHeight)
    }
    
    func createLabel () -> NSTextField {
        let _label: NSTextField = NSTextField()
        _label.wantsLayer = true
        _label.isBezeled = false
        _label.drawsBackground = false
        _label.isEditable = false
        _label.isSelectable = false
        return _label
    }
    func updateDictResult () {
        vDictResult.wantsLayer = true
        vDictResult.layer?.backgroundColor = colorLightGray1
        vDictResult.layer?.cornerRadius = 6
        vDictResult.translatesAutoresizingMaskIntoConstraints = false
        vDictResult.subviews.removeAll()
        //vDictResult.removeConstraints(vDictResult!.constraints)
        var curHeight: CGFloat = 0
        
        if (dictResults.count == 0) {
            //vDictResult.addConstraint(_layout_vDictResultHeight)
            _layout_vDictResultHeight.constant = 0
            //vDictResult.addConstraint(NSLayoutConstraint(item: vDictResult, attribute: .top, relatedBy: .equal, toItem: vDictResult, attribute: .bottom, multiplier: 1, constant: 0))
            //vDictResult.bounds = NSRect(x: 0, y: 0, width: 0, height: 0)
        } else {
            //vDictResult.removeConstraint(_layout_vDictResultHeight)
            var previousResultView: NSView = vDictResult
            var firstWord: Bool = true
            for dictword in dictResults {
                // Create the view for the key term
                let resultView = NSView()
                resultView.translatesAutoresizingMaskIntoConstraints = false
                resultView.wantsLayer = true
                resultView.layer?.backgroundColor = CGColor.white
                resultView.layer?.cornerRadius = 5
                vDictResult.addSubview(resultView)
                
                vDictResult.addConstraint(NSLayoutConstraint(item: previousResultView, attribute: (firstWord ? .top : .bottom), relatedBy: .equal, toItem: resultView, attribute: .top, multiplier: 1, constant: -_lcDictWordItemDistance))
                vDictResult.addConstraint(NSLayoutConstraint(item: resultView, attribute: .leading, relatedBy: .equal, toItem: vDictResult, attribute: .leading, multiplier: 1, constant: 8))
                vDictResult.addConstraint(NSLayoutConstraint(item: resultView, attribute: .trailing, relatedBy: .equal, toItem: vDictResult, attribute: .trailing, multiplier: 1, constant: -8))
                vDictResult.addConstraint(NSLayoutConstraint(item: resultView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: _lcDictWordItemHeight))
                curHeight = curHeight + _lcDictWordItemHeight + _lcDictWordItemDistance
 
                // Create labels for term and definition
                let lbTerm: NSTextField = createLabel()
                lbTerm.translatesAutoresizingMaskIntoConstraints = false
                lbTerm.stringValue = dictword.term
                lbTerm.textColor = NSColor(cgColor: colorGrayTextTitle)
                lbTerm.usesSingleLineMode = true
                resultView.addSubview(lbTerm)
                resultView.addConstraint(NSLayoutConstraint(item: lbTerm, attribute: .top, relatedBy: .equal, toItem: resultView, attribute: .top, multiplier: 1, constant: _lcDictWordLabeMarginVer))
                resultView.addConstraint(NSLayoutConstraint(item: resultView, attribute: .leading, relatedBy: .equal, toItem: lbTerm, attribute: .leading, multiplier: 1, constant: -_lcDictWordLabeMarginHor))
                resultView.addConstraint(NSLayoutConstraint(item: resultView, attribute: .trailing, relatedBy: .equal, toItem: lbTerm, attribute: .trailing, multiplier: 1, constant: _lcDictWordLabeMarginHor))
                
                let lbDef: NSTextField = createLabel()
                lbDef.translatesAutoresizingMaskIntoConstraints = false
                lbDef.stringValue = dictword.plain.trimmingCharacters(in: .whitespacesAndNewlines)
                lbDef.textColor = NSColor(cgColor: colorGrayTextBody)
                lbDef.usesSingleLineMode = true
                resultView.addSubview(lbDef)
                resultView.addConstraint(NSLayoutConstraint(item: lbDef, attribute: .top, relatedBy: .equal, toItem: lbTerm, attribute: .bottom, multiplier: 1, constant: _lcDictWordLabeMarginBetw))
                resultView.addConstraint(NSLayoutConstraint(item: resultView, attribute: .leading, relatedBy: .equal, toItem: lbDef, attribute: .leading, multiplier: 1, constant: -_lcDictWordLabeMarginHor))
                resultView.addConstraint(NSLayoutConstraint(item: resultView, attribute: .trailing, relatedBy: .equal, toItem: lbDef, attribute: .trailing, multiplier: 1, constant: _lcDictWordLabeMarginHor))
                
                if (dictword.term == "train")
                { print(dictword.term)
                    print(dictword.plain)}
 
                // Last step
                previousResultView = resultView
                firstWord = false
            }
            _layout_vDictResultHeight.constant = curHeight
            vDictResult.layoutSubtreeIfNeeded()
        }
        
        viewHeight = vSearch.frame.height + curHeight
        
        // Update parent viewcontroller
        updateParentViewHeight()
        //vDictResult.layout()
    }
    
    func uiInitialization () {
        self.view.wantsLayer = true
        v_tfSearch.wantsLayer = true
        tfSearch.wantsLayer = true
        
        self.view.layer?.backgroundColor = CGColor.white
        v_tfSearch.layer?.backgroundColor = colorLightGray1
        v_tfSearch.layer?.cornerRadius = 4
        
        //_layout_vDictResultHeight
        vRuler.wantsLayer = true
        vRuler.layer?.backgroundColor = NSColor.yellow.cgColor
        
        // Create/customize Dictionary result area
        updateDictResult()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Needed setups
        tfSearch.delegate = self
        
        // Visual customization
        uiInitialization()
        updateParentViewHeight()
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
        dictResults = []
        if (tfSearch.stringValue != "") {
            if let json = dictQuery(pattern: tfSearch.stringValue.trimmingCharacters(in: .whitespacesAndNewlines) + "*") {
                for item in json {
                    let dictword: DictWord = DictWord(word: item.key, definition: item.value)
                    dictResults.append(dictword)
                }
            }
            //label.stringValue = (dict.entries(forSearchTerm: tfSearch.stringValue)?.first as! TTTDictionaryEntry).text
        }
        updateDictResult()
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
