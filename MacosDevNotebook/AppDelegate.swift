//
//  AppDelegate.swift
//  MacosDevNotebook
//
//  Created by mabs on 08/11/2022.
//


import Cocoa

@main
class AppDelegate: NSObject, NSApplicationDelegate {
    
//    @IBOutlet weak var window: NSWindow!

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        // 初始化操作
        let window = NSApplication.shared.windows.first
        // Moves the window to the front of the screen list, within its level, and makes it the key window; that is, it shows the window.
        // 窗口前置并显示
//        window?.makeKeyAndOrderFront(self)
        
        
        // 增加stopModal监听
        NotificationCenter.default.addObserver(self, selector: #selector(self.windowClose(_:)), name: NSWindow.willCloseNotification, object: nil)
    }
    
    @objc func windowClose(_ aNotification: NSNotification) {
        print(aNotification)
        if let window = aNotification.object as? NSWindow {
            print(window)
            print(window.frame)
        }
        
        // stopModal 的window必须还拥有引用 否则会直接崩溃
        NSApplication.shared.stopModal()
        // 已经自动结束模态了
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
        // 全局性数据区/资源等在程序关闭前回收♻️
    }

    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        // 支持安全恢复状态
        return true
        // false之后重新打开程序不会恢复到原来的位置跟状态
//        return false
    }

    // 最后一个窗口关闭时是否退出程序
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }
}

