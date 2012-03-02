From: linux@johnea.net
Subject: usbtouchscreen unreliable
Date: Fri, 02 Mar 2012 09:52:30 -0800
Message-ID: <4F5108DE.6060005@johnea.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from johnea.net ([70.167.123.7]:11880 "EHLO mail.johnea.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753475Ab2CBSCd (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 2 Mar 2012 13:02:33 -0500
Received: from [192.168.100.166] (traveler.johnea.net [192.168.100.166])
	(using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.johnea.net (Postfix) with ESMTPSA id DCE7773F187D
	for <linux-input@vger.kernel.org>; Fri,  2 Mar 2012 09:53:42 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org


Hello,

I'm using the usbtouchscreen driver with an e2i touchscreen on linux 3.2.6 and X.Org X Server 1.10.4.

The touch screen works well initially, but after a day or so of operation, stops responding.

dmesg and Xorg.log both note successful initalization of the device, but no dmesg, Xorg.log, or other log messages are logged at the time of failure. The device just stops responding. Other input devices (a standard optical usb mouse) continue to operate correctly.

I have tried to exit X, rmmod and then insmod the usbtouchscreen driver, then restart X, but this does not correct the issue.

If I exit Xorg, unplug the integrated USB display/touchscreen and then plug it back in, and restart X, this will get the touchscreen to work again. (display is using fbdev driver with displaylink usb panel, output to display does not fail)

Can anyone suggest how to debug this issue? 

I'm not sure if it's a kernel usbtouchscreen issue, an Xorg issue, or some issue with configuration of the system. 

The touchscreen has been failing in this way since at least the 3.1 kernel.

Below are logs of the devices initialization.

Any guidance debugging this issue is greatly appreciated.

Thank You...

johnea

>From dmesg:
[    7.679382] input: e2i Technology, Inc. USB Touchpanel as /devices/platform/usbhs-omap.0/ehci-omap.0/usb1/1-2/1-2.4/1-2.4.
3/1-2.4.3:1.0/input/input5
[    7.684600] usbcore: registered new interface driver usbtouchscreen


>From Xorg.log:
[    26.418] (II) config/udev: Adding input device e2i Technology, Inc. USB Touchpanel (/dev/input/event5)
[    26.418] (**) e2i Technology, Inc. USB Touchpanel: Applying InputClass "evdev touchscreen catchall"
[    26.418] (II) Using input driver 'evdev' for 'e2i Technology, Inc. USB Touchpanel'
[    26.419] (II) Loading /usr/lib/xorg/modules/input/evdev_drv.so
[    26.419] (**) e2i Technology, Inc. USB Touchpanel: always reports core events
[    26.419] (**) e2i Technology, Inc. USB Touchpanel: Device: "/dev/input/event5"
[    26.419] (--) e2i Technology, Inc. USB Touchpanel: Found absolute axes
[    26.419] (--) e2i Technology, Inc. USB Touchpanel: Found x and y absolute axes
[    26.419] (--) e2i Technology, Inc. USB Touchpanel: Found absolute touchscreen
[    26.419] (**) Option "InvertY" "True"
[    26.420] (**) Option "SwapAxes" "True"
[    26.420] (II) e2i Technology, Inc. USB Touchpanel: Configuring as touchscreen
[    26.420] (**) e2i Technology, Inc. USB Touchpanel: YAxisMapping: buttons 4 and 5
[    26.420] (**) e2i Technology, Inc. USB Touchpanel: EmulateWheelButton: 4, EmulateWheelInertia: 10, EmulateWheelTimeout: 200
[    26.420] (**) Option "config_info" "udev:/sys/devices/platform/usbhs-omap.0/ehci-omap.0/usb1/1-2/1-2.4/1-2.4.3/1-2.4.3:1.0/input/input5/event5"
[    26.420] (II) XINPUT: Adding extended input device "e2i Technology, Inc. USB Touchpanel" (type: TOUCHSCREEN)
[    26.420] (II) e2i Technology, Inc. USB Touchpanel: initialized for absolute axes.
[    26.421] (**) e2i Technology, Inc. USB Touchpanel: (accel) keeping acceleration scheme 1
[    26.421] (**) e2i Technology, Inc. USB Touchpanel: (accel) acceleration profile 0
[    26.421] (**) e2i Technology, Inc. USB Touchpanel: (accel) acceleration factor: 2.000
[    26.421] (**) e2i Technology, Inc. USB Touchpanel: (accel) acceleration threshold: 4
[    26.423] (II) config/udev: Adding input device e2i Technology, Inc. USB Touchpanel (/dev/input/mouse1)
