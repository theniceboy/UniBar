//
//  AppDelegate.swift
//  UniBar
//
//  Created by David Chen on 7/21/18.
//  Copyright © 2018 David Chen. All rights reserved.
//

import Cocoa
import HotKey

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate, NSMenuDelegate, NSTextFieldDelegate {
    
    @IBOutlet weak var UnibarMain: NSMenu!
    @IBOutlet weak var uniSearchBar: NSMenuItem!
    @IBOutlet weak var vSearchBar: NSView!
    @IBOutlet weak var tfSearch: NSTextField!
    
    let UnibarIcon = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Initialization
        UnibarMain.delegate = self
        
        // Set Hotkey
        let openHotkey = HotKey(key: .space, modifiers: [.option, .command])
        openHotkey.keyDownHandler = {
            print("pressed")
        }
        
        // Set Icon
        let menuIcon = NSImage(named: "MenuIcon")
        menuIcon?.isTemplate = true
        UnibarIcon.image = menuIcon
        UnibarIcon.menu = UnibarMain
        uniSearchBar.view = vSearchBar
    }

    func applicationWillTerminate(_ aNotification: Notification) {
    }
    
    // MARK: - Menu Events
    
    func menuWillOpen(_ menu: NSMenu) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
            self.menuItemsInit_afterAppearance()
        }
    }
    func menuItemsInit_afterAppearance () {
        tfSearch.becomeFirstResponder()
    }
    
    
    // MARK: - Menu Items
    
    
    @IBAction func preferences_Clicked(_ sender: Any) {
    }
    
    @IBAction func quit_Clicked(_ sender: Any) {
        NSApplication.shared.terminate(self)
    }
    


}

