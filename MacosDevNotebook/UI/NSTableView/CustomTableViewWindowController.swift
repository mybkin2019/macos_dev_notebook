//
//  CustomTableViewWindowController.swift
//  MacosDevNotebook
//
//  Created by mabs on 04/12/2022.
//

import Cocoa

class CustomTableViewWindowController: NSWindowController {

    @IBOutlet var myContentViewController: NSViewController!
    
    private var webVC: CustomWebViewViewController?
    
    @IBAction func onClickedAction(_ sender: Any) {
        webVC = CustomWebViewViewController(nibName: nil, bundle: nil)
        contentViewController?.presentAsSheet(webVC!)
    }
    
    override func windowDidLoad() {
        super.windowDidLoad()
        
        // window?.contentViewController
        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
         if nil == contentViewController {
            print("contentViewController == nil")
         }
         print(contentViewController?.view)
        myContentViewController.sourceItemView
        window?.contentViewController = myContentViewController
        print(window?.contentView)
        print(window?.contentViewController)
        print(window?.contentViewController?.view)
        
        
        
    }
    
}
