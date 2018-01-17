//
//  ViewController.swift
//  CircleProgressView
//
//  Created by 聂康 on 2018/1/17.
//  Copyright © 2018年 niekang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var progressView1: CircleProgressView!
    
    @IBOutlet weak var progressView2: CircleProgressView!

    @IBOutlet weak var progressView3: CircleProgressView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        //自定义起点和终点
        progressView1.startAngle = CGFloat(Double.pi * 0.25 + Double.pi * 0.5)
        progressView1.endAngle = CGFloat(Double.pi * 0.25 )
        progressView1.progress = 0.3
        //动画
        progressView2.setProgressWithAnimation(0.6, rate: 1)
        
        //设置背景颜色
        progressView3.trackColor = UIColor.red
        //设置进度颜色
        progressView3.progressColor = UIColor.green
        progressView3.progress = 0.3
        
        //设置断点样式
        progressView3.lineCapStyle = .square
    }

}

