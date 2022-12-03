//
//  popoverTipsViewController.swift
//  MacosDevNotebook
//
//  Created by mabs on 03/12/2022.
//

import Cocoa

class PopoverTipsViewController: NSViewController {

    @IBOutlet weak var tipsLabel: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    deinit {
        print("类对象: ", self.className, ", 已经释放内存")
    }
}
