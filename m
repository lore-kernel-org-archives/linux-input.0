From: Andrew Rodland <andrew@cleverdomain.org>
Subject: Mayflash / Dragonrise GameCube controller adapter recognized as
 tablet, not joystick
Date: Wed, 4 Feb 2015 19:34:23 -0500
Message-ID: <CABFQKmN7Lzr2GzZ4d+HgbzMRDe_NBxJDL81qMpaOGOV07LYwag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:55360 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755396AbbBEAeZ (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 4 Feb 2015 19:34:25 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 18B66363CD
	for <linux-input@vger.kernel.org>; Wed,  4 Feb 2015 19:34:24 -0500 (EST)
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 10CBF363CC
	for <linux-input@vger.kernel.org>; Wed,  4 Feb 2015 19:34:24 -0500 (EST)
Received: from mail-ie0-f180.google.com (unknown [209.85.223.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 94F52363CB
	for <linux-input@vger.kernel.org>; Wed,  4 Feb 2015 19:34:23 -0500 (EST)
Received: by mail-ie0-f180.google.com with SMTP id rl12so6419655iec.11
        for <linux-input@vger.kernel.org>; Wed, 04 Feb 2015 16:34:23 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hi all,

I recently bought a "Mayflash GameCube Controller Adapter for Wii U &
PC USB". It has 4 GameCube controller ports, and a switch to tell it
whether you're plugging it into a Wii or a PC. The docs say that in PC
mode it works out of the box on Windows & Mac, with their driver being
required for force-feedback, so it's a semi-standard HID device.

With the switch set to "WII U", it's recognized as a hid-generic
device, but the descriptors are nonsense and it doesn't generate any
events. Fair enough.

With the switch set to "PC" it's recognized, the descriptors make a
lot more sense, and it sends events -- in fact it moves the cursor on
my X display! For some reason it's getting recognized as a
mouse/tablet instead of a joystick, so joydev refuses to take
ownership of it, and X's evdev driver does. I suspect it's due to some
mistake in the report descriptors, but I'm not quite expert enough to
say.

I'd like to get this working so I've attached as much useful
information as I can muster. Let me know if there's anything I can do
to help further; I'm not allergic to compiling a kernel.

Thanks

Andrew

=== dmesg notification ===

[108762.808904] hid-generic 0003:0079:1843.000D: input,hidraw6: USB
HID v1.10 Joystick [mayflash limited MAYFLASH GameCube Controller
Adapter] on usb-0000:00:13.0-4/input0

=== udevadm info --attribute-walk ===

  looking at device
'/devices/pci0000:00/0000:00:13.0/usb5/5-4/5-4:1.0/input/input16/mouse3':
    KERNEL=="mouse3"
    SUBSYSTEM=="input"
    DRIVER==""

  looking at parent device
'/devices/pci0000:00/0000:00:13.0/usb5/5-4/5-4:1.0/input/input16':
    KERNELS=="input16"
    SUBSYSTEMS=="input"
    DRIVERS==""
    ATTRS{name}=="mayflash limited MAYFLASH GameCube Controller Adapter"
    ATTRS{phys}=="usb-0000:00:13.0-4/input0"
    ATTRS{uniq}==""
    ATTRS{properties}=="0"

  looking at parent device '/devices/pci0000:00/0000:00:13.0/usb5/5-4/5-4:1.0':
    KERNELS=="5-4:1.0"
    SUBSYSTEMS=="usb"
    DRIVERS=="usbhid"
    ATTRS{bInterfaceClass}=="03"
    ATTRS{bInterfaceSubClass}=="00"
    ATTRS{bInterfaceProtocol}=="00"
    ATTRS{bNumEndpoints}=="02"
    ATTRS{supports_autosuspend}=="1"
    ATTRS{bAlternateSetting}==" 0"
    ATTRS{bInterfaceNumber}=="00"

  looking at parent device '/devices/pci0000:00/0000:00:13.0/usb5/5-4':
    KERNELS=="5-4"
    SUBSYSTEMS=="usb"
    DRIVERS=="usb"
    ATTRS{bDeviceSubClass}=="00"
    ATTRS{bDeviceProtocol}=="00"
    ATTRS{devpath}=="4"
    ATTRS{idVendor}=="0079"
    ATTRS{speed}=="12"
    ATTRS{bNumInterfaces}==" 1"
    ATTRS{bConfigurationValue}=="1"
    ATTRS{bMaxPacketSize0}=="64"
    ATTRS{busnum}=="5"
    ATTRS{devnum}=="9"
    ATTRS{configuration}==""
    ATTRS{bMaxPower}=="500mA"
    ATTRS{authorized}=="1"
    ATTRS{bmAttributes}=="c0"
    ATTRS{bNumConfigurations}=="1"
    ATTRS{maxchild}=="0"
    ATTRS{bcdDevice}=="0100"
    ATTRS{avoid_reset_quirk}=="0"
    ATTRS{quirks}=="0x0"
    ATTRS{version}==" 2.00"
    ATTRS{urbnum}=="129809"
    ATTRS{ltm_capable}=="no"
    ATTRS{manufacturer}=="mayflash limited"
    ATTRS{removable}=="unknown"
    ATTRS{idProduct}=="1843"
    ATTRS{bDeviceClass}=="00"
    ATTRS{product}=="MAYFLASH GameCube Controller Adapter"

(snipped the bus and pci parts)

=== cat /debug/hid/0003:0079:1843.000D/rdesc ===

05 01 09 04 a1 01 85 01 09 01 a1 00 05 09 19 01 29 10 15 00 25 01 75
01 95 10 81 02 05 01 09 30 09 31 09 32 09 35 15 00 26 ff 00 75 08 95
04 81 02 05 01 09 33 09 34 95 02 81 02 05 01 09 39 15 00 25 07 35 00
46 3b 01 65 14 75 04 95 01 81 02 75 04 95 01 81 01 06 00 ff 09 01 75
08 95 02 91 02 c0 c0 05 01 09 04 a1 01 85 02 09 01 a1 00 05 09 19 01
29 10 15 00 25 01 75 01 95 10 81 02 05 01 09 30 09 31 09 32 09 35 15
00 26 ff 00 75 08 95 04 81 02 05 01 09 33 09 34 95 02 81 02 05 01 09
39 15 00 25 07 35 00 46 3b 01 65 14 75 04 95 01 81 02 75 04 95 01 81
01 06 00 ff 09 01 75 08 95 02 91 02 c0 c0 05 01 09 04 a1 01 85 03 09
01 a1 00 05 09 19 01 29 10 15 00 25 01 75 01 95 10 81 02 05 01 09 30
09 31 09 32 09 35 15 00 26 ff 00 75 08 95 04 81 02 05 01 09 33 09 34
95 02 81 02 05 01 09 39 15 00 25 07 35 00 46 3b 01 65 14 75 04 95 01
81 02 75 04 95 01 81 01 06 00 ff 09 01 75 08 95 02 91 02 c0 c0 05 01
09 04 a1 01 85 04 09 01 a1 00 05 09 19 01 29 10 15 00 25 01 75 01 95
10 81 02 05 01 09 30 09 31 09 32 09 35 15 00 26 ff 00 75 08 95 04 81
02 05 01 09 33 09 34 95 02 81 02 05 01 09 39 15 00 25 07 35 00 46 3b
01 65 14 75 04 95 01 81 02 75 04 95 01 81 01 06 00 ff 09 01 75 08 95
02 91 02 c0 c0

  INPUT(1)[INPUT]
    Field(0)
      Physical(GenericDesktop.Pointer)
      Application(GenericDesktop.Joystick)
      Usage(16)
        Button.0001
        Button.0002
        Button.0003
        Button.0004
        Button.0005
        Button.0006
        Button.0007
        Button.0008
        Button.0009
        Button.000a
        Button.000b
        Button.000c
        Button.000d
        Button.000e
        Button.000f
        Button.0010
      Logical Minimum(0)
      Logical Maximum(1)
      Report Size(1)
      Report Count(16)
      Report Offset(0)
      Flags( Variable Absolute )
    Field(1)
      Physical(GenericDesktop.Pointer)
      Application(GenericDesktop.Joystick)
      Usage(4)
        GenericDesktop.X
        GenericDesktop.Y
        GenericDesktop.Z
        GenericDesktop.Rz
      Logical Minimum(0)
      Logical Maximum(255)
      Report Size(8)
      Report Count(4)
      Report Offset(16)
      Flags( Variable Absolute )
    Field(2)
      Physical(GenericDesktop.Pointer)
      Application(GenericDesktop.Joystick)
      Usage(2)
        GenericDesktop.Rx
        GenericDesktop.Ry
      Logical Minimum(0)
      Logical Maximum(255)
      Report Size(8)
      Report Count(2)
      Report Offset(48)
      Flags( Variable Absolute )
    Field(3)
      Physical(GenericDesktop.Pointer)
      Application(GenericDesktop.Joystick)
      Usage(1)
        GenericDesktop.HatSwitch
      Logical Minimum(0)
      Logical Maximum(7)
      Physical Minimum(0)
      Physical Maximum(315)
      Unit(English Rotation : Degrees)
      Report Size(4)
      Report Count(1)
      Report Offset(64)
      Flags( Variable Absolute )
  INPUT(2)[INPUT]
    Field(0)
      Physical(GenericDesktop.Pointer)
      Application(GenericDesktop.Joystick)
      Usage(16)
        Button.0001
        Button.0002
        Button.0003
        Button.0004
        Button.0005
        Button.0006
        Button.0007
        Button.0008
        Button.0009
        Button.000a
        Button.000b
        Button.000c
        Button.000d
        Button.000e
        Button.000f
        Button.0010
      Logical Minimum(0)
      Logical Maximum(1)
      Physical Minimum(0)
      Physical Maximum(315)
      Unit(English Rotation : Degrees)
      Report Size(1)
      Report Count(16)
      Report Offset(0)
      Flags( Variable Absolute )
    Field(1)
      Physical(GenericDesktop.Pointer)
      Application(GenericDesktop.Joystick)
      Usage(4)
        GenericDesktop.X
        GenericDesktop.Y
        GenericDesktop.Z
        GenericDesktop.Rz
      Logical Minimum(0)
      Logical Maximum(255)
      Physical Minimum(0)
      Physical Maximum(315)
      Unit(English Rotation : Degrees)
      Report Size(8)
      Report Count(4)
      Report Offset(16)
      Flags( Variable Absolute )
    Field(2)
      Physical(GenericDesktop.Pointer)
      Application(GenericDesktop.Joystick)
      Usage(2)
        GenericDesktop.Rx
        GenericDesktop.Ry
      Logical Minimum(0)
      Logical Maximum(255)
      Physical Minimum(0)
      Physical Maximum(315)
      Unit(English Rotation : Degrees)
      Report Size(8)
      Report Count(2)
      Report Offset(48)
      Flags( Variable Absolute )
    Field(3)
      Physical(GenericDesktop.Pointer)
      Application(GenericDesktop.Joystick)
      Usage(1)
        GenericDesktop.HatSwitch
      Logical Minimum(0)
      Logical Maximum(7)
      Physical Minimum(0)
      Physical Maximum(315)
      Unit(English Rotation : Degrees)
      Report Size(4)
      Report Count(1)
      Report Offset(64)
      Flags( Variable Absolute )
  INPUT(3)[INPUT]
    Field(0)
      Physical(GenericDesktop.Pointer)
      Application(GenericDesktop.Joystick)
      Usage(16)
        Button.0001
        Button.0002
        Button.0003
        Button.0004
        Button.0005
        Button.0006
        Button.0007
        Button.0008
        Button.0009
        Button.000a
        Button.000b
        Button.000c
        Button.000d
        Button.000e
        Button.000f
        Button.0010
      Logical Minimum(0)
      Logical Maximum(1)
      Physical Minimum(0)
      Physical Maximum(315)
      Unit(English Rotation : Degrees)
      Report Size(1)
      Report Count(16)
      Report Offset(0)
      Flags( Variable Absolute )
    Field(1)
      Physical(GenericDesktop.Pointer)
      Application(GenericDesktop.Joystick)
      Usage(4)
        GenericDesktop.X
        GenericDesktop.Y
        GenericDesktop.Z
        GenericDesktop.Rz
      Logical Minimum(0)
      Logical Maximum(255)
      Physical Minimum(0)
      Physical Maximum(315)
      Unit(English Rotation : Degrees)
      Report Size(8)
      Report Count(4)
      Report Offset(16)
      Flags( Variable Absolute )
    Field(2)
      Physical(GenericDesktop.Pointer)
      Application(GenericDesktop.Joystick)
      Usage(2)
        GenericDesktop.Rx
        GenericDesktop.Ry
      Logical Minimum(0)
      Logical Maximum(255)
      Physical Minimum(0)
      Physical Maximum(315)
      Unit(English Rotation : Degrees)
      Report Size(8)
      Report Count(2)
      Report Offset(48)
      Flags( Variable Absolute )
    Field(3)
      Physical(GenericDesktop.Pointer)
      Application(GenericDesktop.Joystick)
      Usage(1)
        GenericDesktop.HatSwitch
      Logical Minimum(0)
      Logical Maximum(7)
      Physical Minimum(0)
      Physical Maximum(315)
      Unit(English Rotation : Degrees)
      Report Size(4)
      Report Count(1)
      Report Offset(64)
      Flags( Variable Absolute )
  INPUT(4)[INPUT]
    Field(0)
      Physical(GenericDesktop.Pointer)
      Application(GenericDesktop.Joystick)
      Usage(16)
        Button.0001
        Button.0002
        Button.0003
        Button.0004
        Button.0005
        Button.0006
        Button.0007
        Button.0008
        Button.0009
        Button.000a
        Button.000b
        Button.000c
        Button.000d
        Button.000e
        Button.000f
        Button.0010
      Logical Minimum(0)
      Logical Maximum(1)
      Physical Minimum(0)
      Physical Maximum(315)
      Unit(English Rotation : Degrees)
      Report Size(1)
      Report Count(16)
      Report Offset(0)
      Flags( Variable Absolute )
    Field(1)
      Physical(GenericDesktop.Pointer)
      Application(GenericDesktop.Joystick)
      Usage(4)
        GenericDesktop.X
        GenericDesktop.Y
        GenericDesktop.Z
        GenericDesktop.Rz
      Logical Minimum(0)
      Logical Maximum(255)
      Physical Minimum(0)
      Physical Maximum(315)
      Unit(English Rotation : Degrees)
      Report Size(8)
      Report Count(4)
      Report Offset(16)
      Flags( Variable Absolute )
    Field(2)
      Physical(GenericDesktop.Pointer)
      Application(GenericDesktop.Joystick)
      Usage(2)
        GenericDesktop.Rx
        GenericDesktop.Ry
      Logical Minimum(0)
      Logical Maximum(255)
      Physical Minimum(0)
      Physical Maximum(315)
      Unit(English Rotation : Degrees)
      Report Size(8)
      Report Count(2)
      Report Offset(48)
      Flags( Variable Absolute )
    Field(3)
      Physical(GenericDesktop.Pointer)
      Application(GenericDesktop.Joystick)
      Usage(1)
        GenericDesktop.HatSwitch
      Logical Minimum(0)
      Logical Maximum(7)
      Physical Minimum(0)
      Physical Maximum(315)
      Unit(English Rotation : Degrees)
      Report Size(4)
      Report Count(1)
      Report Offset(64)
      Flags( Variable Absolute )
  OUTPUT(1)[OUTPUT]
    Field(0)
      Physical(GenericDesktop.Pointer)
      Application(GenericDesktop.Joystick)
      Usage(2)
        ff00.0001
        ff00.0001
      Logical Minimum(0)
      Logical Maximum(7)
      Physical Minimum(0)
      Physical Maximum(315)
      Unit(English Rotation : Degrees)
      Report Size(8)
      Report Count(2)
      Report Offset(0)
      Flags( Variable Absolute )
  OUTPUT(2)[OUTPUT]
    Field(0)
      Physical(GenericDesktop.Pointer)
      Application(GenericDesktop.Joystick)
      Usage(2)
        ff00.0001
        ff00.0001
      Logical Minimum(0)
      Logical Maximum(7)
      Physical Minimum(0)
      Physical Maximum(315)
      Unit(English Rotation : Degrees)
      Report Size(8)
      Report Count(2)
      Report Offset(0)
      Flags( Variable Absolute )
  OUTPUT(3)[OUTPUT]
    Field(0)
      Physical(GenericDesktop.Pointer)
      Application(GenericDesktop.Joystick)
      Usage(2)
        ff00.0001
        ff00.0001
      Logical Minimum(0)
      Logical Maximum(7)
      Physical Minimum(0)
      Physical Maximum(315)
      Unit(English Rotation : Degrees)
      Report Size(8)
      Report Count(2)
      Report Offset(0)
      Flags( Variable Absolute )
  OUTPUT(4)[OUTPUT]
    Field(0)
      Physical(GenericDesktop.Pointer)
      Application(GenericDesktop.Joystick)
      Usage(2)
        ff00.0001
        ff00.0001
      Logical Minimum(0)
      Logical Maximum(7)
      Physical Minimum(0)
      Physical Maximum(315)
      Unit(English Rotation : Degrees)
      Report Size(8)
      Report Count(2)
      Report Offset(0)
      Flags( Variable Absolute )

Button.0001 ---> Key.Trigger
Button.0002 ---> Key.ThumbBtn
Button.0003 ---> Key.ThumbBtn2
Button.0004 ---> Key.TopBtn
Button.0005 ---> Key.TopBtn2
Button.0006 ---> Key.PinkieBtn
Button.0007 ---> Key.BaseBtn
Button.0008 ---> Key.BaseBtn2
Button.0009 ---> Key.BaseBtn3
Button.000a ---> Key.BaseBtn4
Button.000b ---> Key.BaseBtn5
Button.000c ---> Key.BaseBtn6
Button.000d ---> Key.?
Button.000e ---> Key.?
Button.000f ---> Key.?
Button.0010 ---> Key.BtnDead
GenericDesktop.X ---> Absolute.X
GenericDesktop.Y ---> Absolute.Y
GenericDesktop.Z ---> Absolute.Z
GenericDesktop.Rz ---> Absolute.Rz
GenericDesktop.Rx ---> Absolute.Rx
GenericDesktop.Ry ---> Absolute.Ry
GenericDesktop.HatSwitch ---> Absolute.Hat0X
Button.0001 ---> Key.BtnA
Button.0002 ---> Key.BtnB
Button.0003 ---> Key.BtnC
Button.0004 ---> Key.BtnX
Button.0005 ---> Key.BtnY
Button.0006 ---> Key.BtnZ
Button.0007 ---> Key.BtnTL
Button.0008 ---> Key.BtnTR
Button.0009 ---> Key.BtnTL2
Button.000a ---> Key.BtnTR2
Button.000b ---> Key.BtnSelect
Button.000c ---> Key.BtnStart
Button.000d ---> Key.BtnMode
Button.000e ---> Key.BtnThumbL
Button.000f ---> Key.BtnThumbR
Button.0010 ---> Key.?
GenericDesktop.X ---> Absolute.Throttle
GenericDesktop.Y ---> Absolute.Rudder
GenericDesktop.Z ---> Absolute.Wheel
GenericDesktop.Rz ---> Absolute.Gas
GenericDesktop.Rx ---> Absolute.Brake
GenericDesktop.Ry ---> Absolute.?
GenericDesktop.HatSwitch ---> Absolute.Hat1X
Button.0001 ---> Key.ToolPen
Button.0002 ---> Key.ToolRubber
Button.0003 ---> Key.ToolBrush
Button.0004 ---> Key.ToolPencil
Button.0005 ---> Key.ToolAirbrush
Button.0006 ---> Key.ToolFinger
Button.0007 ---> Key.ToolMouse
Button.0008 ---> Key.ToolLens
Button.0009 ---> Key.?
Button.000a ---> Key.?
Button.000b ---> Key.Touch
Button.000c ---> Key.Stylus
Button.000d ---> Key.Stylus2
Button.000e ---> Key.ToolDoubleTap
Button.000f ---> Key.ToolTripleTap
Button.0010 ---> Key.?
GenericDesktop.X ---> Absolute.?
GenericDesktop.Y ---> Absolute.?
GenericDesktop.Z ---> Absolute.?
GenericDesktop.Rz ---> Absolute.?
GenericDesktop.Rx ---> Absolute.Hat2X
GenericDesktop.Ry ---> Absolute.Hat2Y
GenericDesktop.HatSwitch ---> Absolute.Hat3X
Button.0001 ---> Key.WheelBtn
Button.0002 ---> Key.Gear up
Button.0003 ---> Key.?
Button.0004 ---> Key.?
Button.0005 ---> Key.?
Button.0006 ---> Key.?
Button.0007 ---> Key.?
Button.0008 ---> Key.?
Button.0009 ---> Key.?
Button.000a ---> Key.?
Button.000b ---> Key.?
Button.000c ---> Key.?
Button.000d ---> Key.?
Button.000e ---> Key.?
Button.000f ---> Key.?
Button.0010 ---> Key.?
GenericDesktop.X ---> Absolute.Pressure
GenericDesktop.Y ---> Absolute.Distance
GenericDesktop.Z ---> Absolute.XTilt
GenericDesktop.Rz ---> Absolute.YTilt
GenericDesktop.Rx ---> Absolute.ToolWidth
GenericDesktop.Ry ---> Absolute.?
GenericDesktop.HatSwitch ---> Absolute.?
ff00.0001 ---> Sync.Report
ff00.0001 ---> Sync.Report
ff00.0001 ---> Sync.Report
ff00.0001 ---> Sync.Report
ff00.0001 ---> Sync.Report
ff00.0001 ---> Sync.Report
ff00.0001 ---> Sync.Report
ff00.0001 ---> Sync.Report
