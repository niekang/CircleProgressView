
//
//  ProgressVIew.swift
//  Will
//
//  Created by 聂康 on 2018/1/16.
//  Copyright © 2018年 com.rdhy.will. All rights reserved.
//

import UIKit

class CircleProgressView: UIView {
    
    //进度 0~1
    var progress: CGFloat = 0 {
        didSet {
            if progress < 0 {
                progress = 0
                return
            }
            if progress > 1 {
                progress = 1
                return
            }
            setNeedsDisplay()
        }
    }
    
    //动画的速度
    var rate: CGFloat = 1
    
    //背景色
    var trackColor: UIColor = UIColor.yellow {
        didSet {
            setNeedsDisplay()
        }
    }
    //进度条颜色
    var progressColor: UIColor = UIColor.green {
        didSet {
            setNeedsDisplay()
        }
    }
    //进度条宽度
    var lineWidth: CGFloat = 5 {
        didSet {
            setNeedsDisplay()
        }
    }
    //其实位置 弧度
    var startAngle: CGFloat = 0 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    //结束位置 弧度
    var endAngle: CGFloat = CGFloat(Double.pi * 2) {
        didSet {
            setNeedsDisplay()
        }
    }
    
    //线两端点的样式
    var lineCapStyle: CGLineCap = .round {
        didSet {
            setNeedsDisplay()
        }
    }
    
    //刷屏器
    private lazy var displayLink: CADisplayLink = {        
        let displayLink = CADisplayLink.displayLink { [weak self] in
            self?.displayLinkDidUpdate()
        }
        displayLink.add(to: RunLoop.main, forMode: .commonModes)
        displayLink.isPaused = true
        return displayLink
    }()
    
    //动画要设置的进度
    private var animaProgress: CGFloat = 0 {
        didSet {
            displayLink.isPaused = false
        }
    }

    //刷新进度
    @objc private func displayLinkDidUpdate() {
        if animaProgress > progress {
            progress = CGFloat(displayLink.duration) * rate + progress
        } else {
            displayLink.isPaused = true
            //更新实际进度
            progress = animaProgress
        }
    }
    
    
    /// 动画设置进度
    ///
    /// - Parameters:
    ///   - progress: 进度值
    ///   - rate: 动画的速率 默认为1
    public func setProgressWithAnimation(_ progress: CGFloat, rate: CGFloat = 1) {
        if progress < 0 || progress > 1 || rate <= 0 || rate > 1{
            return
        }
        animaProgress = progress
    }
    
    deinit {
        print("进度条释放")
    }
    
    override func draw(_ rect: CGRect) {
        //进度条中心
        let center = CGPoint(x: rect.width/2, y: rect.height/2)
        //进度条半径
        let radius = rect.width/2 - lineWidth
        //根据进度计算终点弧度
        let progressAngle = startAngle + progress * fabs(endAngle - startAngle)
        //背景
        let track = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        track.lineWidth = lineWidth
        track.lineCapStyle = lineCapStyle
        trackColor.setStroke()
        track.stroke()
        //进度条
        let progressPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: progressAngle, clockwise: true)
        progressPath.lineWidth = lineWidth
        progressPath.lineCapStyle = lineCapStyle
        progressColor.setStroke()
        progressPath.stroke()
        
    }
    
}

//处理CADisplayLink 不能自动释放问题
class CADisplayLinkProxy {
    
    typealias CADisplayLinkProxyExcute = () -> ()
    
    var excute: CADisplayLinkProxyExcute!
    
    init(excute: @escaping CADisplayLinkProxyExcute) {
        self.excute = excute
    }
    
    @objc public func excuteBlock() {
        self.excute()
    }
    
}

extension CADisplayLink {
    
    class func displayLink(excute: @escaping CADisplayLinkProxy.CADisplayLinkProxyExcute) -> CADisplayLink{
        let target = CADisplayLinkProxy(excute: excute)
        return CADisplayLink(target: target, selector: #selector(target.excuteBlock))
    }
}


