//
//  UseViewControllerPresentationInWCWindowController.swift
//  MacosDevNotebook
//
//  Created by mabs on 04/12/2022.
//

import Cocoa

class UseViewControllerPresentationInWCWindowController: NSWindowController {

    // 使用ViewController Present 配置
    // 1. xib 文件中 添加 viewController 对象
    // 2. viewController 中的 view 连接 Window.view
    // 3. IBOutlet 注入 xib 中的 viewController 到绑定的 WindowController 文件中
    @IBOutlet var myContentViewController: NSViewController!
    // 由于默认 windowController 中会有 contentViewController? 属性 默认为nil
    // 4. 绑定 windowController.contentViewController = myContentViewController
    private func setBinding() {
        contentViewController = myContentViewController
    }
    
    @IBOutlet weak var boxView: NSBox!
    // 强引用保证 view controller 不被立马释放
    private var forPresentViewController: ForPresentViewController?
    @IBAction func onClickedPresentAsSheetNewViewControllerInWindowControllerBtnAction(_ sender: Any) {
        // 5. 通过 contentViewController present
        forPresentViewController = ForPresentViewController(nibName: nil, bundle: nil)
        guard let forPresentViewController = forPresentViewController else { return }
        contentViewController?.presentAsSheet(forPresentViewController)
    }
    
    @IBAction func onClickedPresentAsModelNewViewControllerBtnAction(_ sender: Any) {
        forPresentViewController = ForPresentViewController(nibName: nil, bundle: nil)
        guard let forPresentViewController = forPresentViewController else { return }
        contentViewController?.presentAsModalWindow(forPresentViewController)
        forPresentViewController.view.window?.title = "AsModal"
    }
    
    @IBAction func onClickedPresentWithCustomAnimatorBtnAction(_ sender: Any) {
        forPresentViewController = ForPresentViewController(nibName: nil, bundle: nil)
        guard let forPresentViewController = forPresentViewController else { return }
        let animator = MyCustomAnimator()
        contentViewController?.present(forPresentViewController, animator: animator)
    }
    
    @IBAction func onClickedPopRelativePresentBtnAction(_ sender: NSButton) {
        forPresentViewController = ForPresentViewController(nibName: nil, bundle: nil)
        guard let forPresentViewController = forPresentViewController else { return }
        /* ⚠️ 这里的 frame 跟 of view 必须是对应的 父子view 关系*/
        contentViewController?.present(forPresentViewController,
                                       asPopoverRelativeTo: sender.frame,
                                       of: boxView,
                                       preferredEdge: NSRectEdge.minX,
                                       behavior: .transient)
    }
    
    override func windowDidLoad() {
        super.windowDidLoad()
        setBinding()
    }
    
    deinit {
        print("UseViewControllerPresentationInWCWindowController 释放了")
    }
}
