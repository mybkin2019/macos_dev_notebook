//
//  LoadViewFromXibViewController.swift
//  MacosDevNotebook
//
//  Created by mabs on 30/11/2022.
//

import Cocoa

/**
 通过创建 CocoaClass 会自动绑定 Xib 跟 LoadViewFromXibViewController Swift文件
 主要
 */

class LoadViewFromXibViewController: NSViewController {
    
    @IBAction func onClickedConfirmButtonAction(_ sender: Any) {
        dismiss(self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        print(#function, #line)
    }
    
    override class func awakeFromNib() {
        super.awakeFromNib()
        print(#function, #line)
    }
    
    // 绑定对应的 Xib 的使用方法
    // LoadViewFromXibViewController(nibName: nil bundle: nil)
}
