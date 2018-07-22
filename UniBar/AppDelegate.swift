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

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate, NSMenuDelegate, NSTextFieldDelegate {
    
    @IBOutlet weak var UnibarMain: NSMenu!
    @IBOutlet weak var uniSearchBar: NSMenuItem!
    @IBOutlet weak var vSearchBar: NSView!
    @IBOutlet weak var tfSearch: NSTextField!
    
    let UnibarIcon = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
    let keycode = UInt16(kVK_ANSI_X)
    let keymask: NSEvent.ModifierFlags = .command
    
    var menuAppearing: Bool = false
    
    // ... to set it up ...
    

    @objc func openUnibar () {
        if (menuAppearing) {
            //return
        } else {
            print ("opening")
            UnibarIcon.popUpMenu(UnibarMain)
            //menuItemsInit_afterAppearance()
        }
    }

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Initialization
        UnibarMain.delegate = self
        
        // Set Hotkey
        print("adding hotkey")
        /*
        var myeventref = EventHotKeyRef(bitPattern: 0), myhotkeyid = EventHotKeyID(signature: FourCharCode(exactly: 1)!, id: 1)
        AEInstallEventHandler(kCoreEventClass, 1, { (event, eventMutable, refCon) -> OSErr in
            print("Event")
            return OSErr(exactly: 0)!
        }, UnsafeMutablePointer(bitPattern: 0), true)
        RegisterEventHotKey(49, UInt32(optionKey), myhotkeyid, GetApplicationEventTarget(), 0, &myeventref)
       */
        if let keyCombo = KeyCombo(keyCode: 49, cocoaModifiers: [.option]) {
            print("cool")
            let hotKey = HotKey(identifier: "OptionSpace",
                                keyCombo: keyCombo,
                                target: self,
                                action: #selector(self.openUnibar), actionQueue: HotKey.ActionQueue.main)
            hotKey.register()
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
        print("menuwillopen")
        /*
        let queue = TaskQueue()
        queue.tasks +=! {
            print("dispatch")
            self.menuItemsInit_afterAppearance()
        }
        queue.run()
 */
        if #available(OSX 10.12, *) {
            print("t")
            let timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) { (timer) in
                print("timer")
                self.menuItemsInit_afterAppearance()
            }
            
        } else {
            // Fallback on earlier versions
        }
        menuAppearing = true
    }
    func menuDidClose(_ menu: NSMenu) {
        menuAppearing = false
    }
    func menuItemsInit_afterAppearance () {
        print("right there")
        self.tfSearch.becomeFirstResponder()
    }
    
    
    // MARK: - Menu Items
    
    
    @IBAction func preferences_Clicked(_ sender: Any) {
    }
    
    @IBAction func quit_Clicked(_ sender: Any) {
        NSApplication.shared.terminate(self)
    }
    


}

