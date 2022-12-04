//
//  ViewController.swift
//  MacosDevNotebook
//
//  Created by mabs on 08/11/2022.
//

import Cocoa

class MacosDevNotebookMainViewController: NSViewController {
    
    var realmWindowController: RealmDBUsageWindowController?
    
    @IBAction func onClickedRealmDBUsageBtnAction(_ sender: Any) {
        // 需要强引用 保证 window controller 不被释放
        let wc = RealmDBUsageWindowController(windowNibName: "RealmDBUsageWindowController")
        realmWindowController = wc
        wc.showWindow(nil)
    }
    
    @IBAction func onClickedShowOneXibBindManyCustomClassAndViewBtnAction(_ sender: Any) {
        let oneXibBindVC = OneXibBindManyCustomClassFileVC(nibName: nil, bundle: nil)
        presentAsModalWindow(oneXibBindVC)
    }
    
    private var customTableViewWindowController: CustomTableViewWindowController?
    // 纯代码创建 NSTableView
    @IBAction func onClickedPureInCodeCreateNSTableViewBtnAction(_ sender: Any) {
        let wc = CustomTableViewWindowController(windowNibName: "CustomTableViewWindowController")
        customTableViewWindowController = wc
        customTableViewWindowController?.showWindow(nil)
    }
    
    private var useViewControllerPresentationInWindowControllerWC: UseViewControllerPresentationInWCWindowController?
    @IBAction func onClickedPresentVCInWindowControllerBtnAction(_ sender: Any) {
        let wc = UseViewControllerPresentationInWCWindowController(windowNibName: "UseViewControllerPresentationInWCWindowController")
        useViewControllerPresentationInWindowControllerWC = wc
        wc.showWindow(nil)
    }
    
    private var unexpectedBUGWindowController: UnexpectedBUGWIndowController?
    @IBAction func onClickedUnexpectedBUGBtnAction(_ sender: Any) {
        let wc = UnexpectedBUGWIndowController(windowNibName: "UnexpectedBUGWIndowController")
        unexpectedBUGWindowController = wc
        wc.showWindow(nil)
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

