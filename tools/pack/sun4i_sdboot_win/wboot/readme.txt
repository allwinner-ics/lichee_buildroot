20090520 v8338
    中间版本，用于客户调试板子，增加480 272支持，hdmi支持

20090513 v8118
    515量产前测试版
    解决资源的问题
    解决一些兼容性问题

20090505 v7523
    量产第二版
    解决掉码问题
    解决兰屏幕问题
    解决主界面的各种小问题
    解决睡眠关机等问题
    注册表放到z盘
    兼容性得到进一步加强
    电子书黑屏幕问题
    livesuit加密功能0.1版

20090421 v6938
    冒烟测试第一版。
    解决sd card问题
    解决部分图片死机问题
    文件系统设备文件系统bug
    orchid内置
    fw 包加密系统启用
    发布版启用游戏功能
    开机画面bug
    开机电量检测功能
    其他一些小bug

20090407: v6342
1: 修改了拔出udisk会挂机的问题
2：修改了一些界面问题

20090405: v6317
1: 修改了papa声,启用新的键盘音
2：增加了hdmi
3：修改了一些媒体兼容性问题
4：更新了nand flash驱动，兼容性改善, 掉码问题有很大改善
5：新文件系统架构加入, ntfs支持中文;
6: power bug修改;
7: 新的usb插拔机制以及全速usb支持
8: 1080i支持
9: 电子书增加书签功能
10: 支持sdcard, 同时支持usbdisk 和 card.
11: 字体阴影支持
12：其他一些bug


20090319：v5636
1：修改了一些bug。界面更加人性化了.
2: 工具有了改变，由原来的批处理改为了批处理加图形工具

    a: 请更新software目录,并运行D:\Winners\eStudio\Softwares\PhoenixPro\PhoenixPack100.exe(自解包程序)
    b：运行D:\Winners\eStudio\Softwares\PhoenixPro\PhoenixPro.exe
    c: 选择认证文件D:\Winners\eStudio\Softwares\PhoenixPro\proxypid1_solution_net_141516D2-8AC7-4a7a-8D0A-1E49BE70842E.key
    d: 选择固件包D:\Winners\ePDK\workspace\aw1610\ePDKv100.img,并启动;
    e: 将小机进入升级状态,插上usb线,系统将自动升级,升级完成后,拔线或reset系统,升级完成.
    f: 再次升级,只需要先运行image.bat,然后让小机进入升级状态,插入usb线,升级将自动开始,完成后拔线或reset就ok了

    注意事项：1: 如果需要运行config.bat，运行后, 需要运行image.bat, config的内容才能生效。
              2: 如果用户修改了sys_config.ini文件(运行config.bat文件也会导致sys_config.ini改变),务必要运行imag.bat,
                 并关闭PhoenixPro软件,再重新打开,并执行d到f三步
              3: 软件必须先启动后,才能插入小机usb线.
              4: 第一次使用epheonix必须重新安装新的驱动，新的驱动在"..\PhoenixPro\UsbDriver"目录下，
                 其安装方法请参考..\PhoenixPro\PhoenixPro新版驱动安装.doc


