# Invoker
![Language](https://img.shields.io/badge/language-objc-orange.svg)
![License](https://img.shields.io/badge/license-MIT-blue.svg)  

Invoker for Objective-C  
集合[OCRuntime](https://github.com/silence0201/OCRuntime)来调用`私有函数`

## 使用说明

### 安装
将项目中`Invoker`目录导入项目中

###Pod安装

	pod 'Invoker', '~> 1.0'

### 使用
具体查看`ViewController.m`
```objc
- (void)viewDidLoad {
  	[super viewDidLoad];

  	// 调用公开的方法
  	CGRect rect = [[self invoke:@"aRect"] CGRectValue];
  	NSLog(@"rect: %@", NSStringFromCGRect(rect));

  	// 调用公开的方法并传入参数
  	[self.view invoke:@"setBackgroundColor:" arguments:@[ [UIColor whiteColor] ]];
  	[self.view invoke:@"setAlpha:" arguments:@[@(0.5)]];
  	[UIView animateWithDuration:3 animations:^{
      	[self.view invoke:@"setAlpha:" arguments:@[@(1.0)]];
  	}];

  	// 调用私有方法
  	int sizeClass = [[self invoke:@"_verticalSizeClass"] intValue];
  	NSLog(@"sizeClass: %d", sizeClass);

  	// 调用私有方法并传入参数
  	[self invoke:@"_setShowingLinkPreview:" arguments:@[@(NO)]];

  	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
      	[self invoke:@"_setShowingLinkPreview:" arguments:@[@(YES)]];
  	});

  	// 调用类方法
  	UIEdgeInsets insets = [[self.class invoke:@"aInsets:" arguments:@[@"Test"]] UIEdgeInsetsValue];
    NSLog(@"insets: %@", NSStringFromUIEdgeInsets(insets));

  	// 调用类方法并传入参数
  	UIColor *color = [UIColor invoke:@"colorWithRed:green:blue:alpha:" arguments:@[@(0), @(0.5), @(1),@(1)]] ;
    NSLog(@"color: %@", color);
}
```

## Invoker
Invoker is available under the MIT license. See the LICENSE file for more info.
