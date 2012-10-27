From: Chris MacDonald <chris@fourthandvine.com>
Subject: TPV OpticalTouchScreen (25aa:8883) Support
Date: Fri, 26 Oct 2012 17:27:03 -0700
Message-ID: <CAMAQbHANvBz8UBJZjpWX++13wOnF4Mi_33x-EgC_+oVR1kBkig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:42519 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755978Ab2J0A1E (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 26 Oct 2012 20:27:04 -0400
Received: by mail-vc0-f174.google.com with SMTP id fk26so3659220vcb.19
        for <linux-input@vger.kernel.org>; Fri, 26 Oct 2012 17:27:03 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hi All -

Firstly, apologies if this is the wrong forum for this type of
problem, (maybe linux-usb?) if this is the case please let me know.

I've got an Ubuntu 12.04 install and updated the kernel to 3.6.3 (I
did this after looking at
http://lii-enac.fr/en/architecture/linux-input/multitouch-devices.html
and assuming support for my touchscreen monitor would be better the
newer the kernel):

Linux parsnip 3.6.3-030603-generic #201210211349 SMP Sun Oct 21
17:57:45 UTC 2012 i686 i686 i386 GNU/Linux

and an HP Compaq L2206tm touchscreen monitor that gets detected like this:

Oct 26 15:28:12 parsnip kernel: [   98.500012] usb 1-2: new high-speed
USB device number 5 using ehci_hcd
Oct 26 15:28:12 parsnip kernel: [   98.632382] usb 1-2: New USB device
found, idVendor=0424, idProduct=2514
Oct 26 15:28:12 parsnip kernel: [   98.632386] usb 1-2: New USB device
strings: Mfr=0, Product=0, SerialNumber=0
Oct 26 15:28:12 parsnip kernel: [   98.632542] hub 1-2:1.0: USB hub found
Oct 26 15:28:12 parsnip kernel: [   98.632625] hub 1-2:1.0: 4 ports detected
Oct 26 15:28:12 parsnip kernel: [   98.904119] usb 1-2.1: new
full-speed USB device number 6 using ehci_hcd
Oct 26 15:28:12 parsnip kernel: [   98.997072] usb 1-2.1: New USB
device found, idVendor=25aa, idProduct=8883
Oct 26 15:28:12 parsnip kernel: [   98.997075] usb 1-2.1: New USB
device strings: Mfr=1, Product=2, SerialNumber=4
Oct 26 15:28:12 parsnip kernel: [   98.997078] usb 1-2.1: Product:
OpticalTouchScreen
Oct 26 15:28:12 parsnip kernel: [   98.997080] usb 1-2.1: Manufacturer: TPV
Oct 26 15:28:12 parsnip kernel: [   98.997083] usb 1-2.1: SerialNumber: 0000
Oct 26 15:28:22 parsnip kernel: [  109.000075] hid-multitouch
0003:25AA:8883.0004: usb_submit_urb(ctrl) failed: -1
Oct 26 15:28:22 parsnip kernel: [  109.000082] hid-multitouch
0003:25AA:8883.0004: timeout initializing reports
Oct 26 15:28:22 parsnip kernel: [  109.000183] input: TPV
OpticalTouchScreen as
/devices/pci0000:00/0000:00:1d.7/usb1/1-2/1-2.1/1-2.1:1.0/input/input8
Oct 26 15:28:22 parsnip kernel: [  109.000282] hid-multitouch
0003:25AA:8883.0004: input,hiddev0,hidraw2: USB HID v1.10 Mouse [TPV
OpticalTouchScreen] on usb-0000:00:1d.7-2.1/input0

X happily detects the device as well:

[  5987.987] (II) config/udev: Adding input device TPV
OpticalTouchScreen (/dev/input/mouse1)
[  5987.987] (II) No input driver specified, ignoring this device.
[  5987.987] (II) This device may have been added with another device file.
[  5987.987] (II) config/udev: Adding input device TPV
OpticalTouchScreen (/dev/input/event7)
[  5987.987] (**) TPV OpticalTouchScreen: Applying InputClass "evdev
touchscreen catchall"
[  5987.987] (II) Using input driver 'evdev' for 'TPV OpticalTouchScreen'
[  5987.987] (II) Loading /usr/lib/xorg/modules/input/evdev_drv.so
[  5987.987] (**) TPV OpticalTouchScreen: always reports core events
[  5987.987] (**) evdev: TPV OpticalTouchScreen: Device: "/dev/input/event7"
[  5987.987] (--) evdev: TPV OpticalTouchScreen: Vendor 0x25aa Product 0x8883
[  5987.987] (--) evdev: TPV OpticalTouchScreen: Found absolute axes
[  5987.987] (--) evdev: TPV OpticalTouchScreen: Found absolute multitouch axes
[  5987.987] (--) evdev: TPV OpticalTouchScreen: Found x and y absolute axes
[  5987.987] (--) evdev: TPV OpticalTouchScreen: Found absolute touchscreen
[  5987.987] (II) evdev: TPV OpticalTouchScreen: Configuring as touchscreen
[  5987.987] (**) evdev: TPV OpticalTouchScreen: YAxisMapping: buttons 4 and 5
[  5987.987] (**) evdev: TPV OpticalTouchScreen: EmulateWheelButton:
4, EmulateWheelInertia: 10, EmulateWheelTimeout: 200
[  5987.988] (**) Option "config_info"
"udev:/sys/devices/pci0000:00/0000:00:1d.7/usb1/1-2/1-2.1/1-2.1:1.0/input/input10/event7"
[  5987.988] (II) XINPUT: Adding extended input device "TPV
OpticalTouchScreen" (type: TOUCHSCREEN, id 10)
[  5987.988] (II) evdev: TPV OpticalTouchScreen: initialized for absolute axes.
[  5987.988] (**) TPV OpticalTouchScreen: (accel) keeping acceleration scheme 1
[  5987.988] (**) TPV OpticalTouchScreen: (accel) acceleration profile 0
[  5987.988] (**) TPV OpticalTouchScreen: (accel) acceleration factor: 2.000
[  5987.988] (**) TPV OpticalTouchScreen: (accel) acceleration threshold: 4

but a test of the touch capability doesn't yield anything useful as a
run of evtest doesn't show any activity after startup as I tap on the
display:

# evtest /dev/input/event7
Input driver version is 1.0.1
Input device ID: bus 0x3 vendor 0x25aa product 0x8883 version 0x110
Input device name: "TPV OpticalTouchScreen"
Supported events:
  Event type 0 (EV_SYN)
  Event type 1 (EV_KEY)
    Event code 330 (BTN_TOUCH)
  Event type 3 (EV_ABS)
    Event code 0 (ABS_X)
      Value      0
      Min        0
      Max     1919
    Event code 1 (ABS_Y)
      Value      0
      Min        0
      Max     1079
    Event code 47 (ABS_MT_SLOT)
      Value      0
      Min        0
      Max        9
    Event code 53 (ABS_MT_POSITION_X)
      Value      0
      Min        0
      Max     1919
    Event code 54 (ABS_MT_POSITION_Y)
      Value      0
      Min        0
      Max     1079
    Event code 57 (ABS_MT_TRACKING_ID)
      Value      0
      Min        0
      Max    65535
Testing ... (interrupt to exit)

I'm assuming the error in syslog ("usb_submit_urb(ctrl) failed: -1")
might be at least part of the issue, but I'm not sure how to
troubleshoot this further. Any hints or pointers would be greatly
appreciated.

Thanks!

Chris
