//
//  AboutWindowWindowController.swift
//  MacosDevNotebook
//
//  Created by mabs on 28/11/2022.
//

import Cocoa

class AboutWindowWindowController: NSWindowController {

    /*
     加载流程:
     通过 initWithNib Bundle nil
     自动查询主包中同名的 xib 文件解析 然后根据对应的 owner 给绑定到特定 Swift 文件 WindowController 上
     */
    
    @IBAction func onChangeWindowTitleBtnClicked(_ sender: Any) {
        window?.title = "ChangedTitle"
    }
    
    override func windowDidLoad() {
        super.windowDidLoad()

        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
        
        window?.title = "CurrentWindow"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // print(#function, #file, #line)
    }
    
}
