//
//  MyCustomAnimator.swift
//  MacosDevNotebook
//
//  Created by mabs on 04/12/2022.
//

import Cocoa

class MyCustomAnimator: NSObject, NSViewControllerPresentationAnimator {
    func animatePresentation(of viewController: NSViewController, from fromViewController: NSViewController) {
        let sourceViewController = fromViewController
        
        // 将要出现的 viewController
        let toDestinationViewController = viewController
        
        // toDestinationViewController.view.wantsLayer = true
        toDestinationViewController.view.canDrawSubviewsIntoLayer = true
        toDestinationViewController.view.layerContentsRedrawPolicy = .onSetNeedsDisplay
        
        toDestinationViewController.view.alphaValue = 0
        
        sourceViewController.view.addSubview(toDestinationViewController.view)
        
        // size and colour
        let sourceframe = sourceViewController.view.frame
        print("sourceViewController view frame: => ", sourceframe)
        let destframe = toDestinationViewController.view.frame
        print("toDestinationViewController view frame: => ", destframe)
        // sourceViewController.view.frame = bottomViewController.view.frame
        /* 需要显示的frame 默认的size为从xib加载的width height, xy 默认为 0 0 */
        let centerFrame = NSRect(x: (sourceframe.width - destframe.width) / 2, y: (sourceframe.height - destframe.height) / 2, width: destframe.width, height: destframe.height)
        toDestinationViewController.view.frame = centerFrame
        // toDestinationViewController.view.layer?.backgroundColor = NSColor.gray.cgColor
        
        NSAnimationContext.runAnimationGroup { context in
            context.duration = 2
            // 设置将要出现的 viewController 不透明度 = 1
            toDestinationViewController.view.animator().alphaValue = 1
            
            print("context 中 toDestinationViewController.view.layer: ", toDestinationViewController.view.layer)
            
        } completionHandler: {
            print("动画 present 结束")
        }
    }
    
    // dismiss动画的时候 srcVC 跟 destVC 会调转过来
    func animateDismissal(of viewController: NSViewController, from fromViewController: NSViewController) {
        //
        let toDestinationViewController = fromViewController
        
        let topViewController = viewController
        // 动画中的 vc 必须拥有 layer 才会显示
        topViewController.view.wantsLayer = true
        
        //
        topViewController.view.layerContentsRedrawPolicy = .onSetNeedsDisplay
        // .never
        // .duringViewResize
        // .crossfade
        // .beforeViewResize
        
        NSAnimationContext.runAnimationGroup { (context: NSAnimationContext) -> () in
            context.duration = 0.5
            topViewController.view.animator().alphaValue = 0
        } completionHandler: {
            topViewController.view.removeFromSuperview()
            print("动画 dismiss 结束")
        }
    }
}
