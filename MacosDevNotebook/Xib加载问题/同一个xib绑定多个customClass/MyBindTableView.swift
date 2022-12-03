//
//  MyBindTableView.swift
//  MacosDevNotebook
//
//  Created by mabs on 03/12/2022.
//

import Cocoa

class MyBindTableView: NSTableView {

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        print("MyBindTableView: ", #function)
        // Drawing code here.
    }
    
    // 通过重写此方法可以返回特定的 选中cell 逻辑
    // ⚠️但已经 deprecated
    override func selectedCell() -> NSCell? {
        return nil
    }
}
