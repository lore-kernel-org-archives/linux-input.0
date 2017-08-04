From: Teika Kazura <teika@gmx.com>
Subject: My touchpad needs explicit kernel parameter
 "psmouse.synaptics_intertouch=1" (kernel 4.12.3)
Date: Fri, 04 Aug 2017 16:32:22 +0900 (JST)
Message-ID: <20170804.163222.1710020857391315492.teika@gmx.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.15]:60649 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751414AbdHDHc6 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 4 Aug 2017 03:32:58 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hi. Following dmesg's suggestion to report this issue:
"Your touchpad (PNP: SYN3221 PNP0f03) says it can support a different bus. If i2c-hid and hid-rmi are not used, you might want to try setting psmouse.synaptics_intertouch to 1 and report this to linux-input@vger.kernel.org"

My kernel config surely has:
  CONFIG_I2C_HID=y
  CONFIG_HID_RMI=y
  CONFIG_RMI4_***=y
but dmesg emits the above message without the kernel boot parameter.

dmesg has the following lines; w/o the boot parameter:
  psmouse serio1: synaptics: Touchpad model: 1, fw: 8.1, id: 0x1e2b1, caps: 0xf00123/0x840300/0x2e800/0x0, board id: 3127, fw id: 8526786

with the boot parameter:
  rmi4_smbus 4-002c: registering SMbus-connected sensor
  rmi4_f01 rmi4-00.fn01: found RMI device, manufacturer: Synaptics, product: TM3127-001, fw id: 1819280

/proc/bus/input/devices, w/ the boot parameter:
------------------------------------------------------------------------
I: Bus=001d Vendor=06cb Product=0000 Version=0000
N: Name="Synaptics TM3127-001"
P: Phys=rmi4-00/input0
S: Sysfs=/devices/rmi4-00/input/input10
U: Uniq=
H: Handlers=mouse0 event8 
B: PROP=1
B: EV=b
B: KEY=e520 30000 0 0 0 0
B: ABS=6f3800001000003
------------------------------------------------------------------------

/proc/bus/input/devices, w/o the boot parameter
------------------------------------------------------------------------
I: Bus=0011 Vendor=0002 Product=0007 Version=01b1
N: Name="SynPS/2 Synaptics TouchPad"
P: Phys=isa0060/serio1/input0
S: Sysfs=/devices/platform/i8042/serio1/input/input4
U: Uniq=
H: Handlers=mouse0 event3 
B: PROP=1
B: EV=b
B: KEY=e520 30000 0 0 0 0
B: ABS=660800011000003
------------------------------------------------------------------------

Output of "$ hwinfo":
------------------------------------------------------------------------
55: PS/2 00.0: 10500 PS/2 Mouse
  [Created at input.249]
  Unique ID: AH6Q.ZHI3OT7LsxA
  Hardware Class: mouse
  Model: "SynPS/2 Synaptics TouchPad"
  Vendor: 0x0002
  Device: 0x0007 "SynPS/2 Synaptics TouchPad"
  Compatible to: int 0x0210 0x0002
  Device File: /dev/input/mice (/dev/input/mouse0)
  Device Files: /dev/input/mice, /dev/input/mouse0, /dev/input/event7, /dev/input/by-path/platform-i8042-serio-1-event-mouse, /dev/input/by-path/platform-i8042-serio-1-mouse
  Device Number: char 13:63 (char 13:32)
  Driver Info #0:
    Buttons: 2
    Wheels: 0
    XFree86 Protocol: explorerps/2
    GPM Protocol: exps2
  Config Status: cfg=new, avail=yes, need=no, active=unknown
------------------------------------------------------------------------

Xorg.log. Diff w/ and w/o psmouse.synaptics_intertouch=1
------------------------------------------------------------------------
--- Xorg.0.log.old	2017-07-29 07:51:29.602511165 +0900
+++ Xorg.0.log	2017-07-29 07:51:20.561510734 +0900
@@ -348,29 +348,29 @@
 (**) Option "xkb_model" "pc"
 (**) Option "xkb_layout" "hp"
 (**) Option "xkb_options" "terminate:ctrl_alt_bksp"
-(II) config/udev: Adding input device SynPS/2 Synaptics TouchPad (/dev/input/event8)
-(**) SynPS/2 Synaptics TouchPad: Applying InputClass "evdev touchpad catchall"
-(**) SynPS/2 Synaptics TouchPad: Applying InputClass "libinput touchpad catchall"
-(**) SynPS/2 Synaptics TouchPad: Applying InputClass "touchpad catchall"
-(**) SynPS/2 Synaptics TouchPad: Applying InputClass "Default clickpad buttons"
-(**) SynPS/2 Synaptics TouchPad: Applying InputClass "libinput touchpad catchall"
-(**) SynPS/2 Synaptics TouchPad: Applying InputClass "my config for: libinput synaptics"
-(**) SynPS/2 Synaptics TouchPad: Applying InputClass "Synaptics"
+(II) config/udev: Adding input device Synaptics TM3127-001 (/dev/input/event8)
+(**) Synaptics TM3127-001: Applying InputClass "libinput touchpad catchall"
+(**) Synaptics TM3127-001: Applying InputClass "Synaptics"
 (II) LoadModule: "synaptics"
 (II) Loading /usr/lib64/xorg/modules/input/synaptics_drv.so
 (II) Module synaptics: vendor="X.Org Foundation"
 	compiled for 1.19.2, module version = 1.9.0
 	Module class: X.Org XInput Driver
 	ABI class: X.Org XInput driver, version 24.1
-(II) Using input driver 'synaptics' for 'SynPS/2 Synaptics TouchPad'
-(**) SynPS/2 Synaptics TouchPad: always reports core events
+(II) Using input driver 'synaptics' for 'Synaptics TM3127-001'
+(**) Synaptics TM3127-001: always reports core events
 (**) Option "Device" "/dev/input/event8"
-(--) synaptics: SynPS/2 Synaptics TouchPad: x-axis range 1330 - 5652 (res 40)
-(--) synaptics: SynPS/2 Synaptics TouchPad: y-axis range 1094 - 4846 (res 89)
-(--) synaptics: SynPS/2 Synaptics TouchPad: pressure range 0 - 255
-(--) synaptics: SynPS/2 Synaptics TouchPad: finger width range 0 - 15
-(--) synaptics: SynPS/2 Synaptics TouchPad: buttons: left right double triple
-(--) synaptics: SynPS/2 Synaptics TouchPad: Vendor 0x2 Product 0x7
+(--) synaptics: Synaptics TM3127-001: x-axis range 0 - 2152 (res 20)
+(--) synaptics: Synaptics TM3127-001: y-axis range 0 - 842 (res 20)
+(--) synaptics: Synaptics TM3127-001: pressure range 0 - 255
+(II) synaptics: Synaptics TM3127-001: device does not report finger width.
+(--) synaptics: Synaptics TM3127-001: buttons: left right double triple
+(--) synaptics: Synaptics TM3127-001: Vendor 0x6cb Product 0
+(--) synaptics: Synaptics TM3127-001: invalid finger width range.  defaulting to 0 - 15
 (**) Option "VertTwoFingerScroll" "1"
 (**) Option "HorizTwoFingerScroll" "1"
 (**) Option "LockedDrags" "true"
@@ -378,20 +378,20 @@
 (**) Option "TapButton2" "3"
 (**) Option "TapButton3" "2"
 (**) Option "AccelFactor" "1.0"
-(--) synaptics: SynPS/2 Synaptics TouchPad: touchpad found
-(**) SynPS/2 Synaptics TouchPad: always reports core events
-(**) Option "config_info" "udev:/sys/devices/platform/i8042/serio1/input/input5/event8"
-(II) XINPUT: Adding extended input device "SynPS/2 Synaptics TouchPad" (type: TOUCHPAD, id 11)
-(**) synaptics: SynPS/2 Synaptics TouchPad: (accel) MinSpeed is now constant deceleration 2.5
-(**) synaptics: SynPS/2 Synaptics TouchPad: (accel) MaxSpeed is now 1.75
-(**) synaptics: SynPS/2 Synaptics TouchPad: (accel) AccelFactor is now 1.000
-(**) SynPS/2 Synaptics TouchPad: (accel) keeping acceleration scheme 1
-(**) SynPS/2 Synaptics TouchPad: (accel) acceleration profile 1
-(**) SynPS/2 Synaptics TouchPad: (accel) acceleration factor: 2.000
-(**) SynPS/2 Synaptics TouchPad: (accel) acceleration threshold: 4
-(--) synaptics: SynPS/2 Synaptics TouchPad: touchpad found
-(II) config/udev: Adding input device SynPS/2 Synaptics TouchPad (/dev/input/mouse0)
-(**) SynPS/2 Synaptics TouchPad: Ignoring device from InputClass "touchpad ignore duplicates"
+(--) synaptics: Synaptics TM3127-001: touchpad found
+(**) Synaptics TM3127-001: always reports core events
+(**) Option "config_info" "udev:/sys/devices/rmi4-00/input/input10/event8"
+(II) XINPUT: Adding extended input device "Synaptics TM3127-001" (type: TOUCHPAD, id 11)
+(**) synaptics: Synaptics TM3127-001: (accel) MinSpeed is now constant deceleration 2.5
+(**) synaptics: Synaptics TM3127-001: (accel) MaxSpeed is now 1.75
+(**) synaptics: Synaptics TM3127-001: (accel) AccelFactor is now 1.000
+(**) Synaptics TM3127-001: (accel) keeping acceleration scheme 1
+(**) Synaptics TM3127-001: (accel) acceleration profile 1
+(**) Synaptics TM3127-001: (accel) acceleration factor: 2.000
+(**) Synaptics TM3127-001: (accel) acceleration threshold: 4
+(--) synaptics: Synaptics TM3127-001: touchpad found
+(II) config/udev: Adding input device Synaptics TM3127-001 (/dev/input/mouse0)
+(**) Synaptics TM3127-001: Ignoring device from InputClass "touchpad ignore duplicates"
 (II) config/udev: Adding input device HP Wireless hotkeys (/dev/input/event4)
 (**) HP Wireless hotkeys: Applying InputClass "evdev keyboard catchall"
 (**) HP Wireless hotkeys: Applying InputClass "libinput keyboard catchall"
------------------------------------------------------------------------

Not sure what to report; sorry if this email is not sufficient. 

Thanks & best regards, linux-input.

Teika (Teika kazura)
