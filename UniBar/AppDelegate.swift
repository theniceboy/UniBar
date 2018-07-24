//
//  AppDelegate.swift
//  UniBar
//
//  Created by David Chen on 7/21/18.
//  Copyright © 2018 David Chen. All rights reserved.
//

import Cocoa
import Carbon
import Magnet
import TaskQueue

var statusbutton: NSStatusBarButton = NSStatusBarButton()
let UnibarIcon = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate, NSMenuDelegate, NSTextFieldDelegate {
    
    @IBOutlet weak var UnibarMain: NSMenu!
    //@IBOutlet weak var uniSearchBar: NSMenuItem!
    //@IBOutlet weak var vSearchBar: NSView!
    
    var popUniMain: NSPopover = NSPopover()
    //@IBOutlet weak var tfSearch: NSTextField!
   // @IBOutlet weak var tfSearchCell: NSTextFieldCell!
    
    let keycode = UInt16(kVK_ANSI_X)
    let keymask: NSEvent.ModifierFlags = .command
    
    var menuAppearing: Bool = false
    
    // ... to set it up ...
    
    @objc func hotkeyTriggered() {
        openUnibar(btn: UnibarIcon.button!)
    }
    
    var main: NSWindowController!
    @objc func openUnibar (btn: NSStatusBarButton) {
        print ("open!")
        print(btn.bounds)
        
        curShowingStatus = 1
        main = NSStoryboard(name : "Main", bundle: nil).instantiateController(withIdentifier: "MainWindow") as! NSWindowController
        let mainVc = NSStoryboard(name:"Main", bundle: nil).instantiateController(withIdentifier: "MainViewController") as! ViewController
        main.window?.contentViewController = mainVc
        main.window?.makeKeyAndOrderFront(nil)
        
        
        //popUniMain.show(relativeTo: statusbutton.bounds, of: statusbutton, preferredEdge: NSRectEdge.minY)
        

        /*
       // tfSearch.layout()
        if (menuAppearing) {
            //return
        } else {
            print ("opening")
            var queue = TaskQueue()
            queue.tasks +=! {
                    print("timer")
                    self.menuItemsInit_afterAppearance()
                }
            
            UnibarIcon.popUpMenu(UnibarMain)
            //menuItemsInit_afterAppearance()
        }
 */
    }

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        
        
        
        // Initialization
        UnibarMain.delegate = self
        //tfSearch.layout()
        
        // Set Hotkey
        print("adding hotkey")
        if let keyCombo = KeyCombo(keyCode: 49, cocoaModifiers: [.option]) {
            print("cool")
            let hotKey = HotKey(identifier: "OptionSpace",
                                keyCombo: keyCombo,
                                target: self,
                                action: #selector(self.hotkeyTriggered), actionQueue: HotKey.ActionQueue.main)
            hotKey.register()
        }
        
        // Initialize UniMain Popover
        popUniMain.behavior = .transient
        popUniMain.animates = false
        popUniMain.appearance = NSAppearance(named: NSAppearance.Name.vibrantDark)
        popUniMain.contentViewController = frmUniMain.freshController()
        
        // Set Icon
        let menuIcon = NSImage(named: "MenuIcon")
        menuIcon?.isTemplate = true
        UnibarIcon.image = menuIcon
        //UnibarIcon.menu = UnibarMain
        UnibarIcon.target = self
        UnibarIcon.action = #selector(AppDelegate.openUnibar)
        //uniSearchBar.view = vSearchBar
        
        
        statusbutton = UnibarIcon.button!
    }

    func applicationWillTerminate(_ aNotification: Notification) {
    }
    
    // MARK: - Menu Events
    
    func menuWillOpen(_ menu: NSMenu) {
        print("menuwillopen")
        /*
        let queue = TaskQueue()
        queue.tasks +=! {
            print("dispatch")
            self.menuItemsInit_afterAppearance()
        }
        queue.run()
 */        menuAppearing = true
    }
    func menuDidClose(_ menu: NSMenu) {
        menuAppearing = false
    }
    func menuItemsInit_afterAppearance () {
        print("right there")
        //self.tfSearch.becomeFirstResponder()
    }
    
    
    // MARK: - Menu Items
    
    @IBAction func tfSearchBecomeFirstResponder(_ sender: Any) {
        /*
        tfSearch.becomeFirstResponder()
        tfSearch.layout()
        tfSearch.isBordered = !tfSearch.isBordered
        tfSearch.backgroundColor = NSColor.white
        //tfSearchCell.firstr*/
    }


}

