From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: Debuging embedded touchpad driver
Date: Mon, 8 Aug 2016 14:57:33 +0200
Message-ID: <20160808125733.GC17850@mail.corp.redhat.com>
References: <CAKvQZ_1ALPVT_-RqBw8u2Z2vHDimLjDT5nqVRVwPMzm7hLoQiQ@mail.gmail.com>
 <20160803075404.GB38160@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45840 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752348AbcHHM5i (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 8 Aug 2016 08:57:38 -0400
Content-Disposition: inline
In-Reply-To: <20160803075404.GB38160@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Willy Lambert <lambert.willy@gmail.com>, linux-input@vger.kernel.org

On Aug 03 2016 or thereabouts, Dmitry Torokhov wrote:
> On Sun, Jul 31, 2016 at 09:48:32PM +0200, Willy Lambert wrote:
> > Hi guys,
> > 
> > I am trying to debug an eGalax touchpad in my embedded system. What's
> > strange is that the "evtest" method doesn't react when I'm touching
> > (see below). I'm not sure the touchpas is alive, so I can't tell if
> > it's HW or SW.
> > 
> > Could anyone with experience on this kind of debug help me with a test
> > procedure ? I don't know what to look to identify my problem.
> > 
> > root@(ubiquity)():~# evtest /dev/input/event4
> > Input driver version is 1.0.1
> > Input device ID: bus 0x3 vendor 0xeef product 0x1 version 0x210
> > Input device name: "eGalax Inc. USB TouchController"
> > Supported events:
> >   Event type 0 (Sync)
> >   Event type 1 (Key)
> >     Event code 330 (Touch)
> >   Event type 3 (Absolute)
> >     Event code 0 (X)
> >       Value      0
> >       Min        0
> >       Max     4095
> >     Event code 1 (Y)
> >       Value      0
> >       Min        0
> >       Max     4095
> >     Event code 47 (?)
> >       Value      0
> >       Min        0
> >       Max        7
> >     Event code 53 (?)
> >       Value      0
> >       Min        0
> >       Max     4095
> >     Event code 54 (?)
> >       Value      0
> >       Min        0
> >       Max     4095
> >     Event code 57 (?)
> >       Value      0
> >       Min        0
> >       Max    65535
> > Testing ... (interrupt to exit)
> > 
> > 
> > More details on my setup below :
> > 
> > 
> > 
> > The kernel should have recognized the device :
> > [    1.635292] hub 3-0:1.0: port 2, status 0101, change 0001, 12 Mb/s
> > [    1.641396] usbtouchscreen 2-2:1.0: usb_probe_interface
> > [    1.641408] usbtouchscreen 2-2:1.0: usb_probe_interface - got id
> > [    1.641799] usbcore: registered new interface driver usbtouchscreen
> > [    1.645880] usbhid 2-2:1.0: usb_probe_interface
> > [    1.645891] usbhid 2-2:1.0: usb_probe_interface - got id
> > [    1.650539] usbcore: registered new interface driver usbhid
> > [    1.650545] usbhid: USB HID core driver
> > [    1.659604] input: eGalax Inc. USB TouchController Pen as
> > /devices/pci0000:00/0000:00:1d.0/usb2/2-2/2-2:1.0/input/input3
> > [    1.660740] input: eGalax Inc. USB TouchController as
> > /devices/pci0000:00/0000:00:1d.0/usb2/2-2/2-2:1.0/input/input4
> > [    1.661541] usbhid 2-2:1.0: looking for a minor, starting at 96
> > [    1.662614] hid-multitouch 0003:0EEF:0001.0001:
> > input,hiddev0,hidraw0: USB HID v2.10 Pointer [eGalax Inc. USB
> > TouchController] on usb-0000:00:1d.0-2/input0
> > 
> > 
> > The "usbtouchpad" driver is loaded :
> 
> As shown by the dmesg fragment above the touchscreen is not driven by
> usbtouchscreen but rather hid-multitouch driver. Benjamin might have an
> idea...

The eGalax 0001 is known to be a problem. Some devices are multitouch
and are handled properly by hid-multitouch, and some are not and should
be driven by something else. The issue is that there is no clear pattern
whether we should use one driver or the other.

Try adding the VID/PID in hid_ignore_list[] in drivers/hid/hid-core.c, and
see if usbtouchscreen works better for you.

Cheers,
Benjamin

> 
> > 
> > root@(ubiquity)():~# lsmod
> > Module                  Size  Used by
> > sja1000_isa             2821  0
> > sja1000                 5206  1 sja1000_isa
> > can_dev                 6395  1 sja1000
> > ard_usb                 6911  0
> > hid_multitouch          8637  0
> > usbhid                 32470  0
> > usbtouchscreen         11076  0
> > i915                  511371  1
> > drm_kms_helper         23402  1 i915
> > drm                   185361  2 i915,drm_kms_helper
> > cfbcopyarea             2714  1 i915
> > i2c_algo_bit            4336  1 i915
> > video                   9818  1 i915
> > cfbimgblt               1947  1 i915
> > cfbfillrect             3142  1 i915
> > 
> > 
> > The device is listed (it's still a mystery why the touchpad appears 2
> > times as a pen and as a device) :
> > 
> > 
> > 
> > ---------------------------------------------------------------------------------------
> > root@(ubiquity)():~# cat /proc/bus/input/devices
> > I: Bus=0019 Vendor=0000 Product=0001 Version=0000
> > N: Name="Power Button"
> > P: Phys=PNP0C0C/button/input0
> > S: Sysfs=/devices/LNXSYSTM:00/device:00/PNP0C0C:00/input/input0
> > U: Uniq=
> > H: Handlers=kbd event0
> > B: PROP=0
> > B: EV=3
> > B: KEY=100000 0 0 0
> > 
> > I: Bus=0019 Vendor=0000 Product=0001 Version=0000
> > N: Name="Power Button"
> > P: Phys=LNXPWRBN/button/input0
> > S: Sysfs=/devices/LNXSYSTM:00/LNXPWRBN:00/input/input1
> > U: Uniq=
> > H: Handlers=kbd event1
> > B: PROP=0
> > B: EV=3
> > B: KEY=100000 0 0 0
> > 
> > I: Bus=0010 Vendor=001f Product=0001 Version=0100
> > N: Name="PC Speaker"
> > P: Phys=isa0061/input0
> > S: Sysfs=/devices/platform/pcspkr/input/input2
> > U: Uniq=
> > H: Handlers=kbd event2
> > B: PROP=0
> > B: EV=40001
> > B: SND=6
> > 
> > I: Bus=0003 Vendor=0eef Product=0001 Version=0210
> > N: Name="eGalax Inc. USB TouchController Pen"
> > P: Phys=usb-0000:00:1d.0-2/input0
> > S: Sysfs=/devices/pci0000:00/0000:00:1d.0/usb2/2-2/2-2:1.0/input/input3
> > U: Uniq=
> > H: Handlers=mouse0 event3
> > B: PROP=0
> > B: EV=1b
> > B: KEY=c01 0 0 0 0 0 0 0 0 0 0
> > B: ABS=3
> > B: MSC=10
> > 
> > I: Bus=0003 Vendor=0eef Product=0001 Version=0210
> > N: Name="eGalax Inc. USB TouchController"
> > P: Phys=usb-0000:00:1d.0-2/input0
> > S: Sysfs=/devices/pci0000:00/0000:00:1d.0/usb2/2-2/2-2:1.0/input/input4
> > U: Uniq=
> > H: Handlers=mouse1 event4
> > B: PROP=2
> > B: EV=b
> > B: KEY=400 0 0 0 0 0 0 0 0 0 0
> > B: ABS=2608000 3
> 
> Thanks.
> 
> -- 
> Dmitry
