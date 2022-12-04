//
//  UnexpectedBUGWIndowController.swift
//  MacosDevNotebook
//
//  Created by mabs on 05/12/2022.
//

import Cocoa

// 另一个app上面发生操作文件 挺意外灾难的
class UnexpectedBUGWIndowController: NSWindowController {
    
    var timerAA: Timer?
    var timerBB: Timer?

    override func windowDidLoad() {
        super.windowDidLoad()
    }
    
    @IBAction func onClickedTimerAABtnAction(_ sender: Any) {
        var count = 0
        
        // ⚠️ 只return 不加; 会自动执行 return紧跟的第一行代码...
        // 例如下面 timerAA 就会被启动
        // Xcode 警告: Expression following 'return' is treated as an argument of the 'return' 下面的声明会被当成一个参数返回...
        return
        timerAA = Timer(timeInterval: 1,
                        repeats: true,
                        block: { timer in
                count += 1
                if count <= 10 {
                    print("timerAA: ", count)
                } else {
                    print("timerAA 结束")
                    timer.invalidate()
                }
            })
    }
    
    @IBAction func onClickedTimerBBBtnAction(_ sender: Any) {
        var count = 0
        
        // ⚠️ 如果 return 后面加上 ; 则可以明确确定后面的代码才不再执行
        return;
        // ⚠️ Code after 'return' will never be executed
        print("timerBB执行")
        timerAA = Timer(timeInterval: 1,
                        repeats: true,
                        block: { timer in
            count += 1
            if count <= 10 {
                print("timerBB: ", count)
            } else {
                print("timerBB 结束")
                timer.invalidate()
            }
        })
    }
}
