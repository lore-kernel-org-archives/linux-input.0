From: "Gavin Lambert" <gavinl@compacsort.com>
Subject: [eGalax] no click events with touchscreen
Date: Thu, 8 Jan 2015 16:40:04 +1300
Message-ID: <000701d02af4$cab68350$602389f0$@compacsort.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.compacsort.com ([202.180.125.98]:6004 "EHLO
	mail.compacsort.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751082AbbAHDw4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 7 Jan 2015 22:52:56 -0500
Received: from gavinl7 ([172.20.48.65])
        by mail.compacsort.com (IceWarp 11.1.0.1 x64) with ASMTP id 201501081640042318
        for <linux-input@vger.kernel.org>; Thu, 08 Jan 2015 16:40:04 +1300
Content-Language: en-nz
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hi,

I have a new eGalax touchscreen (came with driver cd 5.1.0, if that hel=
ps).  I'm trying to use it from a Raspberry Pi, so I can't use the preb=
uilt drivers on that CD.  I've found the ARM-specific vendor drivers bu=
t I haven't installed them yet as I remember this working without them =
on an older model of eGalax touchscreen.

Even without those, it still seems to autodetect the touchscreen and it=
 loads the hid_multitouch driver, and within X the pointer moves accord=
ing to touches as expected.  However it does not perform any "click" ac=
tion when the screen is touched.  (I'm ok with it behaving like a singl=
e-touch mouse -- I just want it to actually do something when touched.)

Is this a known issue, or something that can be fixed, or just a config=
uration error?  I've included some diagnostic output from various tools=
 below in the hope that it may be useful to identify and/or fix the iss=
ue; please let me know if you need more information.

Note that at present I do not have anything specific in xorg.conf or xo=
rg.conf.d related to the touchscreen; this did not seem to be necessary=
 with the older hardware.

Regards,
Gavin Lambert


# uname -rm
3.12.34+ armv6l

# lsmod
=2E..
hid_multitouch         9095  0
=2E..
(usbtouchscreen does exist but is not loaded)

# lsusb
Bus 001 Device 002: ID 0424:9514 Standard Microsystems Corp.
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 001 Device 003: ID 0424:ec00 Standard Microsystems Corp.
Bus 001 Device 004: ID 046d:c315 Logitech, Inc. Classic New Touch Keybo=
ard
Bus 001 Device 005: ID 0eef:0001 D-WAV Scientific Co., Ltd eGalax Touch=
Screen

# lsusb -vv
=2E..
Bus 001 Device 005: ID 0eef:0001 D-WAV Scientific Co., Ltd eGalax Touch=
Screen
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass            0 (Defined at Interface level)
  bDeviceSubClass         0=20
  bDeviceProtocol         0=20
  bMaxPacketSize0        64
  idVendor           0x0eef D-WAV Scientific Co., Ltd
  idProduct          0x0001 eGalax TouchScreen
  bcdDevice            1.00
  iManufacturer           1=20
  iProduct                2=20
  iSerial                 0=20
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           59
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          1=20
    bmAttributes         0xa0
      (Bus Powered)
      Remote Wakeup
    MaxPower              100mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         3 Human Interface Device
      bInterfaceSubClass      1 Boot Interface Subclass
      bInterfaceProtocol      2 Mouse
      iInterface              0=20
        HID Device Descriptor:
          bLength                 9
          bDescriptorType        33
          bcdHID               2.10
          bCountryCode            0 Not supported
          bNumDescriptors         1
          bDescriptorType        34 Report
          wDescriptorLength     341
         Report Descriptors:=20
           ** UNAVAILABLE **
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               3
        ** UNRECOGNIZED:  19 ff 42 49 53 54 00 01 02 03 ff 00 00 00 00 =
00 01 04 b8 0b 02 05 b8 0b 00

# cat /proc/bus/input/devices
=2E..
I: Bus=3D0003 Vendor=3D0eef Product=3D0001 Version=3D0210
N: Name=3D"eGalax Inc. USB TouchController Pen"
P: Phys=3Dusb-bcm2708_usb-1.5/input0
S: Sysfs=3D/devices/platform/bcm2708_usb/usb1/1-1/1-1.5/1-1.5:1.0/input=
/input1
U: Uniq=3D
H: Handlers=3Dmouse0 event1=20
B: PROP=3D0
B: EV=3D1b
B: KEY=3Dc01 0 0 0 0 0 0 0 0 0 0
B: ABS=3D3
B: MSC=3D10

I: Bus=3D0003 Vendor=3D0eef Product=3D0001 Version=3D0210
N: Name=3D"eGalax Inc. USB TouchController"
P: Phys=3Dusb-bcm2708_usb-1.5/input0
S: Sysfs=3D/devices/platform/bcm2708_usb/usb1/1-1/1-1.5/1-1.5:1.0/input=
/input2
U: Uniq=3D
H: Handlers=3Dmouse1 event2=20
B: PROP=3D2
B: EV=3Db
B: KEY=3D400 0 0 0 0 0 0 0 0 0 0
B: ABS=3Da608000 3

# xinput
=E2=8E=A1 Virtual core pointer                    	id=3D2	[master point=
er  (3)]
=E2=8E=9C   =E2=86=B3 Virtual core XTEST pointer              	id=3D4	[=
slave  pointer  (2)]
=E2=8E=9C   =E2=86=B3 eGalax Inc. USB TouchController         	id=3D8	[=
slave  pointer  (2)]
=E2=8E=9C   =E2=86=B3 eGalax Inc. USB TouchController Pen     	id=3D7	[=
slave  pointer  (2)]
=E2=8E=A3 Virtual core keyboard                   	id=3D3	[master keybo=
ard (2)]
    =E2=86=B3 Virtual core XTEST keyboard             	id=3D5	[slave  k=
eyboard (3)]
    =E2=86=B3 Logitech Logitech USB Keyboard          	id=3D6	[slave  k=
eyboard (3)]

# evtest /dev/input/event2
Input driver version is 1.0.1
Input device ID: bus 0x3 vendor 0xeef product 0x1 version 0x210
Input device name: "eGalax Inc. USB TouchController"
Supported events:
  Event type 0 (EV_SYN)
  Event type 1 (EV_KEY)
    Event code 330 (BTN_TOUCH)
  Event type 3 (EV_ABS)
    Event code 0 (ABS_X)
      Value   2866
      Min        0
      Max     4095
    Event code 1 (ABS_Y)
      Value   1832
      Min        0
      Max     4095
    Event code 47 (ABS_MT_SLOT)
      Value      0
      Min        0
      Max        7
   Event code 53 (ABS_MT_POSITION_X)
      Value      0
      Min        0
      Max     4095
    Event code 54 (ABS_MT_POSITION_Y)
      Value      0
      Min        0
      Max     4095
    Event code 57 (ABS_MT_TRACKING_ID)
      Value      0
      Min        0
      Max    65535
    Event code 59 (?)
      Value      0
      Min        0
      Max        1
Properties:
  Property type 1 (INPUT_PROP_DIRECT)
Testing ... (interrupt to exit)
Event: time 1420680910.586895, type 3 (EV_ABS), code 53 (ABS_MT_POSITIO=
N_X), value 2056
Event: time 1420680910.586895, type 3 (EV_ABS), code 54 (ABS_MT_POSITIO=
N_Y), value 1992
Event: time 1420680910.586895, type 3 (EV_ABS), code 59 (?), value 0
Event: time 1420680910.586895, type 3 (EV_ABS), code 0 (ABS_X), value 2=
056
Event: time 1420680910.586895, type 3 (EV_ABS), code 1 (ABS_Y), value 1=
992
Event: time 1420680910.586895, -------------- SYN_REPORT ------------
Event: time 1420680910.592882, type 3 (EV_ABS), code 53 (ABS_MT_POSITIO=
N_X), value 2054
Event: time 1420680910.592882, type 3 (EV_ABS), code 0 (ABS_X), value 2=
054
Event: time 1420680910.592882, -------------- SYN_REPORT ------------
Event: time 1420680910.596879, type 3 (EV_ABS), code 53 (ABS_MT_POSITIO=
N_X), value 2052
Event: time 1420680910.596879, type 3 (EV_ABS), code 0 (ABS_X), value 2=
052
Event: time 1420680910.596879, -------------- SYN_REPORT ------------
Event: time 1420680910.602928, type 3 (EV_ABS), code 53 (ABS_MT_POSITIO=
N_X), value 2050
Event: time 1420680910.602928, type 3 (EV_ABS), code 0 (ABS_X), value 2=
050
Event: time 1420680910.602928, -------------- SYN_REPORT ------------
Event: time 1420680910.608902, type 3 (EV_ABS), code 53 (ABS_MT_POSITIO=
N_X), value 2048
Event: time 1420680910.608902, type 3 (EV_ABS), code 0 (ABS_X), value 2=
048
Event: time 1420680910.608902, -------------- SYN_REPORT ------------
Event: time 1420680910.662871, type 3 (EV_ABS), code 59 (?), value 1
Event: time 1420680910.662871, -------------- SYN_REPORT ------------

# evtest /dev/input/event1
Input driver version is 1.0.1
Input device ID: bus 0x3 vendor 0xeef product 0x1 version 0x210
Input device name: "eGalax Inc. USB TouchController Pen"
Supported events:
  Event type 0 (EV_SYN)
  Event type 1 (EV_KEY)
    Event code 320 (BTN_TOOL_PEN)
    Event code 330 (BTN_TOUCH)
    Event code 331 (BTN_STYLUS)
  Event type 3 (EV_ABS)
    Event code 0 (ABS_X)
      Value      0
      Min        0
      Max     4095
    Event code 1 (ABS_Y)
      Value      0
      Min        0
      Max     4095
  Event type 4 (EV_MSC)
    Event code 4 (MSC_SCAN)
Properties:
Testing ... (interrupt to exit)

The above was the output from a single touch at approximately the centr=
e of the screen, in each test.  The "Pen" device does not seem to be ge=
nerating any events on touch (but then I don't have a magic touch pen, =
just a finger or passive stylus; I'm not sure if that makes a differenc=
e).


--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
