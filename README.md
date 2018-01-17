# CircleProgressView
支持自定义环形进度条，支持Xib，纯代码

使用

初始化

`let  progressView = CircleProgressView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))`

设置进度

`        progressView.progress = 0.3
`

设置起点和终点
````
        progressView.startAngle = CGFloat(Double.pi * 0.25 + Double.pi * 0.5)
        progressView.endAngle = CGFloat(Double.pi * 0.25 )
````
设置背景色

`progressView2.setProgressWithAnimation(0.6, rate: 1)`

设置进度颜色

`progressView3.progressColor = UIColor.green`


