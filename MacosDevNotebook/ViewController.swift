//
//  ViewController.swift
//  MacosDevNotebook
//
//  Created by mabs on 08/11/2022.
//

import Cocoa

class ViewController: NSViewController {
    
    var modalWindow: NSWindow = NSWindow(contentRect: NSRect(x: 0, y: 0, width: 300, height: 300), styleMask: [.titled, .resizable, .closable], backing: NSWindow.BackingStoreType.buffered, defer: false)
    
    var realmWindowController: RealmDBUsageWindowController!
    
    @IBAction func onNewWindowBtnClicked(_ sender: Any) {
//        let newWindow = NSWindow(contentRect: NSRect(x: 0, y: 0, width: 300, height: 300), styleMask: NSWindow.StyleMask.titled, backing: NSWindow.BackingStoreType.buffered, defer: false)
        
        
//        let vc = NSViewController()
//        vc.view.layer?.backgroundColor = .white
//        newWindow.contentViewController = vc
//        newWindow.makeKeyAndOrderFront(nil)
//        print(NSApplication.shared.modalWindow)
//        modalWindow = nil
//        print(modalWindow)
//        modalWindow?.close()
//        if ((modalWindow == nil)) {
//            modalWindow = NSWindow(contentRect: NSRect(x: 0, y: 0, width: 300, height: 300), styleMask: [.titled, .resizable, .closable], backing: NSWindow.BackingStoreType.buffered, defer: false)
//            modalWindow.backgroundColor = .systemPink
//        } else {
//            modalWindow = NSWindow(contentRect: NSRect(x: 0, y: 0, width: 250, height: 250), styleMask: NSWindow.StyleMask.closable, backing: NSWindow.BackingStoreType.buffered, defer: false)
//            modalWindow.backgroundColor = .blue
//        }
        
//        let modalWin = NSWindow(contentRect: NSRect(x: 0, y: 0, width: 250, height: 250), styleMask: [.titled, .closable, .resizable, .miniaturizable], backing: NSWindow.BackingStoreType.buffered, defer: false)
//        modalWin.backgroundColor = .brown
        
        // 关键代码
//        modalWindow.isReleasedWhenClosed = false
//        NSApplication.shared.runModal(for: modalWindow)
//        NSApplication.shared.runModal(for: modalWin)
        
//        let flag = DispatchWorkItemFlags(rawValue: 1)
//        let item = DispatchWorkItem(flags: flag) {
//            NSApplication.shared.stopModal()
//        }
        
//        let newWindowController = AboutWindowWindowController(windowNibName: "AboutWindowWindowController")
//        Logger.shared.logToConsole("🚀")
//        Logger.shared.logToConsole("🚀")
//        NSApplication.shared.runModal(for: newWindowController.window!)
        
        // 需要强引用 保证 window controller 不被释放
        let wc = RealmDBUsageWindowController(windowNibName: "RealmDBUsageWindowController")
        realmWindowController = wc
        wc.showWindow(nil)
    }
    
    @IBAction func onClickedShowOneXibBindManyCustomClassAndViewBtnAction(_ sender: Any) {
        let oneXibBindVC = OneXibBindManyCustomClassFileVC(nibName: nil, bundle: nil)
        presentAsModalWindow(oneXibBindVC)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.view.window?.backgroundColor = .systemPink
        self.view.layer?.backgroundColor = .clear
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    override func viewWillAppear() {
        super.viewWillAppear()
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
    }
}

