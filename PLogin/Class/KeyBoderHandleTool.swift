//
//  KeyBoderHandleTool.swift
//  cbdp-ios
//
//  Created by os on 2019/11/18.
//  Copyright © 2019 os. All rights reserved.
//

import UIKit
class KeyBoderHandleTool: NSObject {
    //可能会被遮盖的view
    private var keyBoderHandleView :UIView?
    
    //可能会被遮盖的view 的遮盖高度
    private var keyBoderHandleHeigt :CGFloat = 0.0
    
    //单利对象
    private static var sharedTool :KeyBoderHandleTool?
    //获取单利对象
    class func getSharedKeyBoderTool() ->KeyBoderHandleTool{
        
        guard let instance = sharedTool else {
            sharedTool = KeyBoderHandleTool()
            return sharedTool!
        }
        return instance
    }
    
    //销毁单利对象
    class func destroy() {
        sharedTool = nil
    }
    // 私有化init 初始方法
    private override init() {}
    
    //监听键盘弹出
    /// 处理键盘 遮盖问题
    ///
    /// - Parameters:
    ///   - handleView: 需要处理的视图
    ///   - offsetY: 如果是 可滑动的view  就传入 y 轴上的偏移量
    func handleKeyBoderAction(handleView :UIView, offsetY :CGFloat?){
        
        if keyBoderHandleView != nil {
            //更换遮盖view
            self.keyBoderHandleView = handleView
            return
        }
        
        print("开始了****************")
        self.keyBoderHandleView = handleView
        
        //监听键盘出现
        weak var weakSelf = self
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardDidShowNotification, object: nil, queue: OperationQueue.main) { (notification) in
            
            let info = notification.userInfo
            
            //键盘动画时间
            let duration = (info?[UIResponder.keyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
            
            //键盘坐标尺寸
            let keyBoderRect = (info?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
            //获取键盘被遮盖部分的高度
            let keyBoderHeight = keyBoderRect.size.height      //获取键盘高度
            let boundHeight = UIScreen.main.bounds.size.height  //屏幕高度
            
            let viewMaxY :CGFloat = offsetY == nil ? weakSelf!.keyBoderHandleView!.frame.maxY : (weakSelf!.keyBoderHandleView!.frame.maxY-offsetY!)
            //需要处理的 view 的绝对 Y 坐标
            
            //计算出被遮盖部分的高度
            weakSelf!.keyBoderHandleHeigt = viewMaxY - (boundHeight-keyBoderHeight)
            if weakSelf!.keyBoderHandleHeigt <= 0 {
                return
            }
            
            //将其父视图 上移被遮盖的高度
            if let superView = weakSelf!.keyBoderHandleView!.superview {
                
                UIView.animate(withDuration: duration, animations: {
                    weakSelf!.keyBoderHandleView!.superview!.frame = CGRect.init(x: superView.frame.origin.x, y: superView.frame.origin.y - weakSelf!.keyBoderHandleHeigt, width: superView.bounds.size.width, height: superView.bounds.size.height)
                    
                })
                
            }
            print("打印数据--消失--\(weakSelf!.keyBoderHandleHeigt)----\(weakSelf!.keyBoderHandleView!.tag)")
            
        }
        
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: OperationQueue.main) { (notification) in
            
            let info = notification.userInfo
            if weakSelf!.keyBoderHandleHeigt <= 0{
                return
            }
            
            //键盘动画时间
            let duration = (info?[UIResponder.keyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
            
            //将高度还原
            if let superView = weakSelf!.keyBoderHandleView!.superview {
                UIView.animate(withDuration: duration, animations: {
                    weakSelf!.keyBoderHandleView!.superview!.frame = CGRect.init(x: superView.frame.origin.x, y: superView.frame.origin.y + weakSelf!.keyBoderHandleHeigt, width: superView.bounds.size.width, height: superView.bounds.size.height)
                    
                })
            }
            
            print("打印数据--消失--\(weakSelf!.keyBoderHandleHeigt)----\(weakSelf!.keyBoderHandleView!.tag)")
            
        }
    }
    
    deinit {
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardDidShowNotification, object: nil)
    }
}


