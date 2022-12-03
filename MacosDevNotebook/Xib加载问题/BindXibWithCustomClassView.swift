//
//  BindXibWithCustomClassView.swift
//  MacosDevNotebook
//
//  Created by mabs on 30/11/2022.
//

import Cocoa

class BindXibWithCustomClassView: NSView {

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
    }
    
    // 这个方法一旦写了会提示你要实现 initWithCoder fatalError
    // 避免走 initWithCoder 加载 Xib 文件
    // 实际上可以共存两个方法 只是 initWithFrame 更偏向纯代码
    // initWithCoder 会走系统加载xib 绑定各种 @IBOutlet 跟 @IBAction
    // 如果绑定文件失效 console 将会出现 Loding Nib Connection 失效...
    // 失效原因可能: 1. xib 文件的 fileOwner 指定了 (这种情况只特定于 View, 如果是 ViewController, WindowController 就会默认创建绑定的 Xib 文件的时候 fileOwner 绑定对应的 custom controller class .swift 文件)
    // 2. 拖拽的时候 fileOwner 莫名其妙被指定了
    // 3. 实例化的时候 onwer 没写 nil
    // 4. 通过了错误的实例化方法
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        print(#function, #line)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 加载方法:
    // let v = Bundle.main.loadNibNamed("BindXibWithCustomClassView", owner: nil, options: nil)?.first as! BindXibWithCustomClassView
    // let nib = UINib(nibName: "BindXibWithCustomClassView", bundle: nil)
    // let v = nib.instantiate(withOwner: nil, options: nil)[0] as! BindXibWithCustomClassView
}

//
protocol NibloadProtocol {
    
}

extension NibloadProtocol where Self : NSView{
    /*
     static func loadNib(_ nibNmae :String = "") -> Self{
     let nib = nibNmae == "" ? "\(self)" : nibNmae
     return Bundle.main.loadNibNamed(nib, owner: nil, options: nil)?.first as! Self
     }
     */
    // static func loadNib(_ nibName :String? = nil) -> Self{
       // return Bundle.main.loadNibNamed(nibName ?? "\(self)", owner: nil, options: nil)?.first as! Self
    // }
}
