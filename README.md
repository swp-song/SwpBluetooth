# SwpBluetooth

[![Xcode](https://img.shields.io/badge/Xcode-9.3-25B1F6.svg)](https://developer.apple.com/xcode)
[![iOS](https://img.shields.io/badge/iOS-8.0+-1C75AF.svg)](https://developer.apple.com/xcode)
[![CIStatus](http://img.shields.io/travis/swp-song/SwpBluetooth.svg?style=flat)](https://travis-ci.org/swp-song/SwpBluetooth)
[![Version](https://img.shields.io/cocoapods/v/SwpBluetooth.svg?style=flat)](http://cocoapods.org/pods/SwpBluetooth)
[![License](https://img.shields.io/cocoapods/l/SwpBluetooth.svg?style=flat)](http://cocoapods.org/pods/SwpBluetooth)
[![Platform](https://img.shields.io/cocoapods/p/SwpBluetooth.svg?style=flat)](http://cocoapods.org/pods/SwpBluetooth)
[![SwpBluetoothAPI](https://img.shields.io/badge/SwpBluetoothAPI-v1.0.0-44E0D3.svg)](https://swp-song.com/docs/SwpBluetooth/)

-------

### 导入

> * 手动导入：
>
>> * **SwpBluetooth** 文件夹导入项目中。
>> * **`#import "SwpBluetoothHeader.h`**
>>
> -------

> * CocoaPods 导入:
>
>> * **pod search SwpBluetooth**
>> * **pod 'SwpBluetooth'**
>> * **`#import <SwpBluetooth/SwpBluetoothHeader.h>`**
>>
> -------

-------

### 代码示例:

```Objective-C
 SwpBluetooth
.swpBluetoothManagerChain()
//  扫描设备
.swpBluetoothPeripheralBeginScanningChain(^(SwpBluetooth * _Nonnull swpBluetooth, NSArray<SwpBluetoothModel *> * _Nonnull models, NSArray<NSDictionary<NSString *,id> *> * _Nonnull metaDatas) {
    //  
})
//  设备断开链接回调
.swpBluetoothPeripheralDisconnectChain(^(SwpBluetooth * _Nonnull swpBluetooth, CBPeripheral * _Nonnull perpheral, NSArray<SwpBluetoothModel *> * _Nonnull models, NSArray<NSDictionary<NSString *,id> *> * _Nonnull metaDatas, NSError * _Nonnull error) {
    //
})

//  无法链接设备回调
.swpBluetoothConnectPeripheralFailChain(^(SwpBluetooth * _Nonnull swpBluetooth, CBPeripheral * _Nonnull perpheral, NSError * _Nonnull error){
    //
})

//  设备写入数据
.swpBluetoothPeripheralWriteDataCompletionChain(^(SwpBluetooth *swpBluetooth, BOOL completion, CBPeripheral * _Nonnull perpheral, NSError * _Nullable error, NSString * _Nullable errorMessage){
    NSLog(@"%@", completion ? @"写入成功" : @"写入失败");
})
```

-------

```Objective-C
SwpBluetooth
.swpBluetoothManagerChain()
// 自动连接设备回调
.swpBluetoothPeripheralAutomaticlConnectChain(^(SwpBluetooth * _Nonnull swpBluetooth, CBPeripheral * _Nonnull perpheral, NSArray<SwpBluetoothModel *> * _Nonnull models, NSArray<NSDictionary<NSString *,id> *> * _Nonnull metaDatas){
    //
});
```
-------

```Objective-C
SwpBluetooth
.swpBluetoothManagerChain()
//  连接设备，成功回调
.swpBluetoothConnectPeripheralChain(model.peripheral, ^(SwpBluetooth *swpBluetooth, CBPeripheral * _Nonnull perpheral, NSArray<SwpBluetoothModel *> * _Nonnull models, NSArray<NSDictionary<NSString *,id> *> * _Nonnull datas){

});
```

-------

### SwpLocation 文档

> * [SwpLocation 文档](https://swp-song.com/docs/SwpLocation/)

-------

### 注意：

**请在 项目中 Info.plist 配置蓝牙权限：**

> * **Privacy - Bluetooth Peripheral Usage Description**  :  是否许允此App使用蓝牙？

-------

### 版本记录

> * 版本版本：1.0.0
> * 更新时间：2018-04-14 00:44:33
> * 更新内容：
> 
>>  *  第一个版本完成，上传 pod 的。

>> -------

> * 版本版本：0.0.1
> * 更新时间：2018-04-13 01:03:46
> * 更新内容：
> 
>>  *  第一次上传 Git, 开发版，功能暂未完成，不上传 pod 

>> -------

-------

### 备注

> * 持续更新, 如果喜欢, 欢迎 Star

-------

### 声明

 > * **著作权归 ©swp_song，如需转载请标明出处**

-------

