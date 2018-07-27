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
var windowUniMain: NSWindowController = NSWindowController()
var _previousActivatedApp: NSRunningApplication!

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
        if (curShowingStatus == 0) {
            openUnibar(btn: UnibarIcon.button!)
        } else {
            hideUnibar(resetFocus: true)
        }
    }
    
    @objc public func hideUnibar (resetFocus: Bool) {
        curShowingStatus = 0
        windowUniMain.window?.close()
        if (resetFocus) {
            _previousActivatedApp.activate(options: .activateIgnoringOtherApps)
        }
    }
    
    @objc func openUnibar (btn: NSStatusBarButton) {
        // Save previously activated app
        _previousActivatedApp = NSWorkspace.shared.frontmostApplication
        
        // Create and present the UniBar main menu
        windowUniMain = NSStoryboard(name : "Main", bundle: nil).instantiateController(withIdentifier: "windowDefault") as! NSWindowController
        windowUniMain.window?.contentViewController = vcUniMain
        windowUniMain.window?.makeKeyAndOrderFront(self)
        windowUniMain.window?.level = NSWindow.Level(rawValue: Int(CGWindowLevelForKey(.mainMenuWindow)))
        windowUniMain.window?.collectionBehavior = [.stationary, .ignoresCycle, .canJoinAllSpaces, .fullScreenAuxiliary]
        windowUniMain.window?.setFrameOrigin(NSPoint(
            x: (NSScreen.main?.visibleFrame.origin.x)! + (NSScreen.main?.visibleFrame.size.width)! - (windowUniMain.window?.frame.size.width)!,
            y: (NSScreen.main?.visibleFrame.origin.y)! + (NSScreen.main?.visibleFrame.size.height)! - (windowUniMain.window?.frame.size.height)!))
        windowUniMain.window?.makeKey()
        
        // Visual initialization of the window
        windowUniMain.window?.isMovable = false
    }

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        
        // Create & assign viewcontrollers
        vcUniMain = frmUniMain.freshController()
        vcDictLookup = frmDictLookup.freshController()
        vcTestingOnly = frmTestingOnly.freshController()
        
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
        popUniMain.contentViewController = vcUniMain
        
        // Set Icon
        let menuIcon = NSImage(named: "MenuIcon")
        menuIcon?.isTemplate = true
        UnibarIcon.image = menuIcon
//        UnibarIcon.menu = UnibarMain
        UnibarIcon.target = self
        UnibarIcon.action = #selector(AppDelegate.hotkeyTriggered)
//        uniSearchBar.view = vSearchBar
        statusbutton = UnibarIcon.button!
        
        // Setup for exiting event
        NSEvent.addGlobalMonitorForEvents(matching: .leftMouseDown) { (e) in
            self.outsideClick(event: e)
        }
        NSEvent.addGlobalMonitorForEvents(matching: .otherMouseDown) { (e) in
            self.outsideClick(event: e)
        }
        NSEvent.addGlobalMonitorForEvents(matching: .rightMouseDown) { (e) in
            self.outsideClick(event: e)
        }
    }
    var _e1: NSEvent!, _e2: NSEvent!, _e3: NSEvent!
    func outsideClick (event: NSEvent) {
        hideUnibar(resetFocus: false)
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

