

[![SPM](https://img.shields.io/badge/SPM-supported-DE5C43.svg?style=flat)](https://swift.org/package-manager/)
![Xcode 11.0+](https://img.shields.io/badge/Xcode-11.0%2B-blue.svg)
![iOS 13.0+](https://img.shields.io/badge/iOS-14.0%2B-blue.svg)
![Swift 5.0+](https://img.shields.io/badge/Swift-5.0%2B-orange.svg)

HUD是基于SwiftUI开发的Loading弹窗工具，样式参考[ProgressHUD](https://github.com/relatedcode/ProgressHUD) 。

目前功能有 Loading，Progress，Success，Failed，Toast

| ![Simulator Screen Shot - iPhone 14 Pro - 2023-04-28 at 14.01.21](Image/1.png) | ![Simulator Screen Shot - iPhone 14 Pro - 2023-04-28 at 14.01.24](Image/2.png) | ![Simulator Screen Shot - iPhone 14 Pro - 2023-04-28 at 14.01.30](Image/3.png) |
| ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ |
| ![Simulator Screen Shot - iPhone 14 Pro - 2023-04-28 at 14.01.43](Image/4.png) | ![Simulator Screen Shot - iPhone 14 Pro - 2023-04-28 at 14.01.48](Image/5.png) | ![Simulator Screen Shot - iPhone 14 Pro - 2023-04-28 at 14.01.48](Image/6.png) |



## 功能

在适当位置添加可观察的管理器

```Swift
    @StateObject private var loading = LoadingManager()
    @StateObject private var toast = ToastManager()
                 toast.position = .bottom / .top //在适当位置添加Toast出现位置 
								 toast.duration = 3 //Toast停留时长
```

如果是页面传递请

```Swift
ContentView()
       .environmentObject(loading)
       .environmentObject(toast)
//然后内部页面
    @EnvironmentObject private var loading: LoadingManager
    @EnvironmentObject private var toast: ToastManager
```

在需要使用Loading的页面添加

```swift
.addLoading(loading)
.addToast(toast)
```

剩下的只需要在触发位置

```swift
                Button {
                    loading.text = "Please wait..."
                    loading.showLoading()
                } label: {
                    Text("Loading Short Text")
                }
```

 或者根据状态控制

```swift
        .onChange(of: revenueCat.isPurchasing) { newValue in
            if newValue{
                loading.showLoading()
            }else{
                loading.dismiss()
            }
        }
```

关闭HUD

```
loading.dismiss()
```

内置的其他HUD

```swift
loading.showLoading()
loading.showProgress()
loading.showSuccess()
loading.showFailed()
```

添加Toast

```swift
toast.showText("Toast at bottom")
或者展示自定义Toast
toast.show{
  XXXView()
}
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

