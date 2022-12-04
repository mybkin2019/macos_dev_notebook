//
//  ForPresentViewController.swift
//  MacosDevNotebook
//
//  Created by mabs on 04/12/2022.
//

import Cocoa

class ForPresentViewController: NSViewController {

    @IBOutlet weak var contentView: NSView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        // print(#function)
        // print(view.layer) // -> nil layer 并未加载出来
        // contentView.layer?.backgroundColor = NSColor.cyan.cgColor
        // print("contentView.layer => ", contentView.layer) => nil
        // layer 并不会在跟iOS一样 在 viewDidLoad 阶段加载出来
        
        // 只要不设置 wantsLayer 后面全部都不会加载出 layer 也就不能代码改变 layer 的外观
        // 但 自定义 contentView 则后续会自己加载出 layer 但在 viewDidLoad 中不会加载出 layer
        // view.wantsLayer = true
        // view.canDrawSubviewsIntoLayer = true
        // view.canDrawConcurrently = true // background thread can draw
        // 设置了 wantsLayer 之后 马上就会有 layer 加载出来
        // print(#function)
        // print(view.layer)
        
        // print("contentView.layer: ", contentView.layer) => nil
    }
    
    @IBAction func onClickedDismissBtnAction(_ sender: Any) {
        dismiss(self)
    }
    
    override func viewWillLayout() {
        super.viewWillLayout()
        print(#function)
        // print(view.layer)
        print("contentView.layer: ", contentView.layer)
    }
    
    override func viewDidLayout() {
        super.viewDidLayout()
        print(#function)
        // print(view.layer) // 只要不设置 wantsLayer 都会返回 nil
        // print("contentView.layer: ", contentView.layer) // nil
    }
    
    override func viewWillAppear() {
        super.viewWillDisappear()
        print(#function)
        // print(view.layer)
        // print("contentView.layer: ", contentView.layer) // 有值
        // ❤️结论: viewDidLayout 之后 viewWillAppear 就会给 subviews 创建 layer 渲染
        // 默认 view layer 是不加载 不渲染 透明呈现的, 只要 wantsLayer = false
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        print(#function)
        print("contentView.layer: ", contentView.layer) // 有值了
        // print(view.layer) => 有值了
        contentView.layer?.borderWidth = 2
        contentView.layer?.borderColor = .black
        contentView.layer?.cornerRadius = 10
        contentView.layer?.backgroundColor = NSColor.gray.cgColor
        contentView.layer?.shadowColor = .black
        contentView.layer?.shadowRadius = 20
        contentView.layer?.shadowOpacity = 0.1
        contentView.layer?.shadowOffset = CGSize(width: -5, height: 5)
        // view.layer?.backgroundColor = NSColor.gray.cgColor
        // view.layer?.cornerRadius = 10
    }
}
