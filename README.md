

[![SPM](https://img.shields.io/badge/SPM-supported-DE5C43.svg?style=flat)](https://swift.org/package-manager/)
![Xcode 11.0+](https://img.shields.io/badge/Xcode-11.0%2B-blue.svg)
![iOS 13.0+](https://img.shields.io/badge/iOS-14.0%2B-blue.svg)
![Swift 5.0+](https://img.shields.io/badge/Swift-5.0%2B-orange.svg)

HUD是基于SwiftUI开发的Loading弹窗工具，样式参考[ProgressHUD](https://github.com/relatedcode/ProgressHUD)  和  [PopupView](https://github.com/Mijick/PopupView)。

目前功能有 Loading，Progress，Success，Failed，Toast，PopupView，支持继承协议自定义样式以及弹出动画。

下一步：

更新支持暗色模式

| ![](Image/top.png)     | ![](Image/bottom.png)   | ![](Image/center.png)   | ![](Image/toast.png)    | ![](Image/toast2.png)    |
| ---------------------- | ----------------------- | ----------------------- | ----------------------- | ------------------------ |
| ![](Image/loading.png) | ![](Image/loading2.png) | ![](Image/loading3.png) | ![](Image/progress.png) | ![](Image/progress2.png) |
| ![](Image/succ.png)    | ![](Image/succ2.png)    | ![](Image/fail.png)     | ![](Image/fail2.png)    |                          |



## 功能

在需要使用Loading或弹窗的的页面添加

```Swift
.addHudView()
```

各种内置弹窗

```swift
		//声明弹窗
    @State var loading = LoadingView()

    @State var loadingText = LoadingView(text: "loading...")

    @State var toast = ToastView(text: "Hello world")
    @State var toast = ToastView(position: .top, text: "Compares")
    
    @State var fail = FailedView()
    @State var succ = SuccessView()

```

Progress有点特殊需要绑定进度

```swift
    @State var progress: CGFloat = 0
    @State var progressView: ProgressHudView?
    //在适当的位置绑定进度
    .onAppear {
        progressView = ProgressHudView(progress: $progress)
    }

		progressView?.show()
```

剩下的只需要在触发位置

```swift
   Button {
       loading.show()
   } label: {
       Text("Loading Short Text")
   }
```

 或者根据状态控制

```swift
  .onChange(of: revenueCat.isPurchasing) { newValue in
       if newValue{
            loading.show()
       }else{
            loading.dismiss()
       }
   }
```

关闭HUD

```
.dismiss()
```

适配器内有超多自定义功能

```Swift
    //是否需要遮罩
    var needMask: Bool = true
    //弹窗背景颜色
    var backgroundColour: Color = .clear
    //弹窗忽略安全区域
    var ignoresSafeArea: Bool = false
    //点击区域外关闭弹窗
    var touchOutsideToDismiss: Bool = false
    //圆角弧度
    var cornerRadius: CGFloat = 10
    //手势关闭
    var dragGestureProgressToClose: CGFloat = 1/3
    //手势关闭动画
    var dragGestureAnimation: Animation = .interactiveSpring()
    
    //弹窗背景阴影颜色
    var shadowColour: Color = .black.opacity(0.2)
    var shadowRadius: CGFloat = 5
    var shadowOffsetX: CGFloat = 0
    var shadowOffsetY: CGFloat = 0
    
    //距离顶部的padding,默认为0,Top Popup会用到
    var topPadding: CGFloat = 0
    //距离底部的padding,默认为0,Bottom Popup会用到
    var bottomPadding: CGFloat = 0
    //Bottom PopupView自动添加安全区域高度
    var bottomAutoHeight: Bool = false
    
    
    //横向的padding,默认为0,大部分情况Center Popup会用到
    var horizontalPadding: CGFloat = 0
    //中间弹出动画执行时间
    var centerAnimationTime: CGFloat = 0.1
    //Center PopupView弹出动画比例
    var centerTransitionExitScale: CGFloat = 0.86
    //Center PopupView弹出动画比例
    var centerTransitionEntryScale: CGFloat = 1.1
    
    
    //弹出动画
    var transitionAnimation: Animation = .spring(response: 0.32, dampingFraction: 1, blendDuration: 0.32)

    //堆栈样式--露出位置--默认6
    var stackViewsOffset: CGFloat = 6
    //堆栈样式--比例
    var stackViewsScale: CGFloat = 0.06
    //堆栈样式--圆角
    var stackViewsCornerRadius: CGFloat = 10
    //堆栈样式--最大堆展示数量
    var maxStackCount: Int = 3
    
    
    //是否需要自动关闭
    var autoDismiss: Bool = false
    //自动关闭等候时长
    var autoDismissTime: TimeInterval = 3
```



## 安装

### cocoapods

1.在 Podfile 中添加 `pod ‘SwiftUIHUD’`

2.执行 `pod install 或 pod update`

3.导入 `import SwiftUIHUD`

### Swift Package Manager

从 Xcode 11 开始，集成了 Swift Package Manager，使用起来非常方便。HUD 也支持通过 Swift Package Manager 集成。

在 Xcode 的菜单栏中选择 `File > Swift Packages > Add Pacakage Dependency`，然后在搜索栏输入

`https://github.com/jackiehu/HUD`，即可完成集成

### 手动集成

HUD 也支持手动集成，只需把Sources文件夹中的HUD文件夹拖进需要集成的项目即可



具体使用代码api以及详细效果参见Demo



## 更多砖块工具加速APP开发

[![ReadMe Card](https://github-readme-stats.vercel.app/api/pin/?username=jackiehu&repo=SwiftMediator&theme=radical&locale=cn)](https://github.com/jackiehu/SwiftMediator)

[![ReadMe Card](https://github-readme-stats.vercel.app/api/pin/?username=jackiehu&repo=SwiftShow&theme=radical&locale=cn)](https://github.com/jackiehu/SwiftShow)

[![ReadMe Card](https://github-readme-stats.vercel.app/api/pin/?username=jackiehu&repo=SwiftLog&theme=radical&locale=cn)](https://github.com/jackiehu/SwiftLog)

[![ReadMe Card](https://github-readme-stats.vercel.app/api/pin/?username=jackiehu&repo=SwiftyForm&theme=radical&locale=cn)](https://github.com/jackiehu/SwiftyForm)

[![ReadMe Card](https://github-readme-stats.vercel.app/api/pin/?username=jackiehu&repo=SwiftEmptyData&theme=radical&locale=cn)](https://github.com/jackiehu/SwiftEmptyData)

[![ReadMe Card](https://github-readme-stats.vercel.app/api/pin/?username=jackiehu&repo=SwiftPageView&theme=radical&locale=cn)](https://github.com/jackiehu/SwiftPageView)

[![ReadMe Card](https://github-readme-stats.vercel.app/api/pin/?username=jackiehu&repo=JHTabBarController&theme=radical&locale=cn)](https://github.com/jackiehu/JHTabBarController)

[![ReadMe Card](https://github-readme-stats.vercel.app/api/pin/?username=jackiehu&repo=SwiftMesh&theme=radical&locale=cn)](https://github.com/jackiehu/SwiftMesh)

[![ReadMe Card](https://github-readme-stats.vercel.app/api/pin/?username=jackiehu&repo=SwiftNotification&theme=radical&locale=cn)](https://github.com/jackiehu/SwiftNotification)

[![ReadMe Card](https://github-readme-stats.vercel.app/api/pin/?username=jackiehu&repo=SwiftNetSwitch&theme=radical&locale=cn)](https://github.com/jackiehu/SwiftNetSwitch)

[![ReadMe Card](https://github-readme-stats.vercel.app/api/pin/?username=jackiehu&repo=SwiftButton&theme=radical&locale=cn)](https://github.com/jackiehu/SwiftButton)

[![ReadMe Card](https://github-readme-stats.vercel.app/api/pin/?username=jackiehu&repo=SwiftDatePicker&theme=radical&locale=cn)](https://github.com/jackiehu/SwiftDatePicker)

