##UIWindow的作用

和Mac OS X的应用程序有所不同，iPhone应用程序通常只有一个窗口，表示为一个UIWindow类的实例。您的应用程序在启动时创建这个窗口（或者从nib文件进行装载），并往窗口中加入一或多个视图，然后将它显示出来。窗口显示出来之后，您很少需要再次引用它。

在iPhone OS中，窗口对象并没有像关闭框或标题栏这样的视觉装饰，用户不能直接对其进行关闭或其它操作。所有对窗口的操作都需要通过其编程接口来实现。应用程序可以借助窗口对象来进行事件传递。窗口对象会持续跟踪当前的第一响应者对象，并在UIApplication对象提出请求时将事件传递它。

还有一件可能让有经验的Mac OS X开发者觉得奇怪的事是UIWindow类的继承关系。在Mac OS X中，NSWindow的父类是NSResponder；而在iPhone OS中，UIWindow的父类是UIView。因此，窗口在iPhone OS中也是一个视图对象。不管其起源如何，您通常可以将iPhone OS上的窗口和Mac OS X的窗口同样对待。也就是说，您通常不必直接操作UIWindow对象中与视图有关的属性变量。

在创建应用程序窗口时，您应该总是将其初始的边框尺寸设置为整个屏幕的大小。如果您的窗口是从nib文件装载得到，Interface Builder并不允许创建比屏幕尺寸小的窗口；然而，如果您的窗口是通过编程方式创建的，则必须在创建时传入期望的边框矩形。除了屏幕矩形之外，没有理由传入其它边框矩形。屏幕矩形可以通过UIScreen对象来取得，具体代码如下所示：

UIWindow* aWindow = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];

虽然iPhone OS支持将一个窗口叠放在其它窗口的上方，但是您的应用程序永远不应创建多个窗口。系统自身使用额外的窗口来显示系统状态条、重要的警告、以及位于应用程序窗口上方的其它消息。如果您希望在自己的内容上方显示警告，可以使用UIKit提供的警告视图，而不应创建额外的窗口。