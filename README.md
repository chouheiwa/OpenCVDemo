# OpenCVDemo
这是一个关于OpenCV的demo，包含了视频转字符串动画，摄像头拍摄转字符串动画的相关流程

## 视频下载地址

### Bad Apple
> 链接:https://pan.baidu.com/s/1GjSzUKInWn2cMliWRsmiNg  密码:lojq

视频下载后请直接移动OpenCVDemo目录下
### CXK 打篮球
> 链接:https://pan.baidu.com/s/1DvYt2y8Lr6p3xGDbHKUF4Q  密码:tuh2

视频下载后请移动到OpenCVDemo/Sketch目录下

## Framework下载地址
> https://sourceforge.net/projects/opencvlibrary/files/opencv-ios/3.2.0/opencv-3.2.0-ios-framework.zip/download

Framework下载后请移动到OpenCVDemo/OpenCV/目录下

## 功能
### 支持功能
- [x] 字符串动画
- [x] 素描画(勾边画)
- [x] 手绘(适用画面相对比较大气的)
- [x] 卡通效果(目前如果图片对比度太高存在较大问题，对于风景画效果较好，需要优化相关效果) 
### 未来预计加入功能
- [ ] 加入训练模型导入教程(风格迁移相关图片处理)


## 其他事项
若想更换其他视频，请下载视频并导入。

1. 视频不要过长，未做解析转本地处理，目前全部在内存中加载，所以视频过大很可能会造成OOM
2. 点击进入视频页面后，请不要点击返回键，等待视频加载完毕。未做中断加载处理，所以重复进入也会出现OOM
