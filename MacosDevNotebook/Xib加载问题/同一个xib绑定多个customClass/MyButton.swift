//
//  MyButton.swift
//  MacosDevNotebook
//
//  Created by mabs on 03/12/2022.
//

import Cocoa

class MyButton: NSButton {

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        print("MyButton draw: ", #function)
        // Drawing code here.
    }
    
}
