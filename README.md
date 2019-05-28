# 说明

* [支付宝客户端架构解析：iOS 容器化框架初探](https://juejin.im/post/5bdc19cbf265da614b117217)
	- 其中的思想，与_Modules/Application, _Modules/Midwares, _Modules/Services, 以至于 _Foundation/Modular, _Modules/Components
	- 类似

## [Foundation 基础](Framework/Foundation/README.md)

## [Core 工具核心库](Framework/Core/README.md)

## [UIKit UI扩展库](Framework/UIKit)

## [Component UI组件](Framework/Component)

## [Module 通用业务组件](Framework/Module/README.md)

## qy的iOS框架设计解读

* 业务模块 _Building/Architect 未完成
	- 页面
	- 数据模型
		> 原始模型
		> 业务模型
		> 试图模型
	- 数据源
	- 页面控制器
	- 动态部署
* 应用基础模块
	- Hybrid _Hybrid, _Modules/Components/WebBrowser 未完成
		> 页面交互
		> JS交互
	- 用户体验 ??????? 空缺
		> 皮肤/外观
		> 字体
	- 应用能力 _Modules/Components,Services/Login, _Modules/Components,Services/Share, _Modules/Components,Services/Pay
		> 登录
		> 分享
		> 支付
	- 页面路由 _Modular/Router
		> 静态路由
		> 动态路由
* 通用基础模块 
	- 数据 _Tool/Network, _Tool/Network-lit, _Tool/Database, _Tool/Cache
		> 网络
		> 本地
	- 多媒体 _Tool/Media ???? 未迁移
		> 音频
		> 视频
		> 富文本 ?????? 空缺
	- 通用工具 _Tool/Utility
	- 自定义视图 _Building/UI, _Components
	- 测试 _Test
		> 自动化
		> 单元测试
	- 数据分析 _Monitor 未完成 / ???? 是否将日志整合呢？？？
		> 统计
		> 日志

* 交互模块 _Building/UI, _Building/Core, _Building/Animation
	- 视觉
		> 动效
		> 渲染
	- 事件
		> 交互控制器
		> 响应链
		- "原先想法是把交互事件（比如点击、手势等）管理起来，让原生和H5页面无缝链接，还有对原生交互事件的分发，省去写touchtest的代码"
		- 给 touchBegin hit test 相关方法，封装一些语法糖

