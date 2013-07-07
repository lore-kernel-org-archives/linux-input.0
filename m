From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: My logitech wireless keyboard and mouse stop working after 3.10
 kernel
Date: Sun, 7 Jul 2013 11:55:58 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1307071153210.26857@pobox.suse.cz>
References: <CAPf1XsNNqBajqi=SZ=_gcB9dQ1RSAvMnGn981gnN7JqqdThjhQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:48438 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751295Ab3GGJ4E (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 7 Jul 2013 05:56:04 -0400
In-Reply-To: <CAPf1XsNNqBajqi=SZ=_gcB9dQ1RSAvMnGn981gnN7JqqdThjhQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: wujun zhou <zwj.echo@gmail.com>
Cc: linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Andrew de los Reyes <adlr@chromium.org>, Nestor Lopez Casado <nlopezcasad@logitech.com>

On Sat, 6 Jul 2013, wujun zhou wrote:

> Dear maintainers,
> 
> After I switch to the 3.10 kernel, my logitech wireless keyboard and mouse
> stop working.
> 
> The keyboard and mouse are connected to the desktop though logitech
> unifying receiver. This little problem almost makes my desktop totally
> unusable. Could someone check and fix the problem? Thanks
> 
> Keywords: hid, input, logitech unifying receiver
> Version: Linux version 3.10.0 (gcc version 4.7.3 (Gentoo 4.7.3 p1.0,
> pie-0.5.5) ) #6 SMP Sat Jul 6 21:29:14 PDT 2013

[ adding some CCs ]

Hi,

you are not the first one reporting problems getting worse with later 
kernels with the unifying receiver.

Does the keyboard/mouse get properly discovered if you unplug and replug 
the receiver? Linus reported that sometimes this is the case for him as 
well.

Quoting my response to him two days ago:

===
we have had such reports before, but commit a9dd22b730 (and subsequent 
revert of workaround fone by 59626408) was supposed to fix exactly that.

Any idea when this started happening to you?

What if you revert back to the 59626408 workaround (i.e. revert 
a9dd22b730 and 8af6c0883)?

I have a couple of unifying receivers myself, but was never able to see 
this problem ... so it's either rather timing sensitive, or 
device-specific.
===

> 
> In case the model matters:
> My mouse: logitech M705
> Keyboard: logitech K270
> The logitech unifying receiver came with one of them. (Sorry, I can't
> remember exactly which one it belong to)
> 
> The driver stop working after this commit
> 4f5a81042909fed6977881f22c024aa3582cfcca. The previous version
> 83a44ac8bf4a8e6cbbf0c00ff281a482778f708a works. And I think it is caused by
> the changes to drivers/hid/hid-logitech-dj.c
> 
> I get the following dmesg and /proc/bus/input/devices using 3.10 kernel
> [    5.523741] logitech-djreceiver 0003:046D:C52B.0005: hiddev0,hidraw2:
> USB HID v1.11 Device [Logitech USB Receiver] on usb-0000:00:14.0-9.2/input2
> 
> $ cat /proc/bus/input/devices
> ...
> I: Bus=0019 Vendor=0000 Product=0006 Version=0000
> N: Name="Video Bus"
> P: Phys=LNXVIDEO/video/input0
> S: Sysfs=/devices/LNXSYSTM:00/device:00/PNP0A08:00/LNXVIDEO:00/input/input2
> U: Uniq=
> H: Handlers=kbd event2
> B: PROP=0
> B: EV=3
> B: KEY=3e000b00000000 0 0 0
> 
> The kernel find the receiver but not the connected keyboard and mouse.
> 
> 
> The dmesg and /proc/bus/input/devices when everything works:
> commit 83a44ac8bf4a8e6cbbf0c00ff281a482778f708a
> 
> [    7.479464] logitech-djreceiver 0003:046D:C52B.0003: hiddev0,hidraw0:
> USB HID v1.11 Device [Logitech USB Receiver] on usb-0000:00:14.0-9.2/input2
> [   33.072330] input: Logitech Unifying Device. Wireless PID:101b as
> /devices/pci0000:00/0000:00:14.0/usb3/3-9/3-9.2/3-9.2:1.2/0003:046D:C52B.0003/input/input3
> [   33.072550] logitech-djdevice 0003:046D:C52B.0004: input,hidraw1: USB
> HID v1.11 Mouse [Logitech Unifying Device. Wireless PID:101b] on
> usb-0000:00:14.0-9.2:1
> [   33.074266] input: Logitech Unifying Device. Wireless PID:4003 as
> /devices/pci0000:00/0000:00:14.0/usb3/3-9/3-9.2/3-9.2:1.2/0003:046D:C52B.0003/input/input4
> [   33.074380] logitech-djdevice 0003:046D:C52B.0005: input,hidraw2: USB
> HID v1.11 Keyboard [Logitech Unifying Device. Wireless PID:4003] on
> usb-0000:00:14.0-9.2:2
> 
> 
> $ cat /proc/bus/input/devices
> I: Bus=0019 Vendor=0000 Product=0001 Version=0000
> N: Name="Power Button"
> P: Phys=PNP0C0C/button/input0
> S: Sysfs=/devices/LNXSYSTM:00/device:00/PNP0C0C:00/input/input0
> U: Uniq=
> H: Handlers=kbd event0
> B: PROP=0
> B: EV=3
> B: KEY=10000000000000 0
> 
> I: Bus=0019 Vendor=0000 Product=0001 Version=0000
> N: Name="Power Button"
> P: Phys=LNXPWRBN/button/input0
> S: Sysfs=/devices/LNXSYSTM:00/LNXPWRBN:00/input/input1
> U: Uniq=
> H: Handlers=kbd event1
> B: PROP=0
> B: EV=3
> B: KEY=10000000000000 0
> 
> I: Bus=0019 Vendor=0000 Product=0006 Version=0000
> N: Name="Video Bus"
> P: Phys=LNXVIDEO/video/input0
> S: Sysfs=/devices/LNXSYSTM:00/device:00/PNP0A08:00/LNXVIDEO:00/input/input2
> U: Uniq=
> H: Handlers=kbd event2
> B: PROP=0
> B: EV=3
> B: KEY=3e000b00000000 0 0 0
> 
> I: Bus=0003 Vendor=046d Product=c52b Version=0111
> N: Name="Logitech Unifying Device. Wireless PID:101b"
> P: Phys=usb-0000:00:14.0-9.2:1
> S:
> Sysfs=/devices/pci0000:00/0000:00:14.0/usb3/3-9/3-9.2/3-9.2:1.2/0003:046D:C52B.0003/input/input3
> U: Uniq=
> H: Handlers=mouse0 event3
> B: PROP=0
> B: EV=17
> B: KEY=ffff0000 0 0 0 0
> B: REL=143
> B: MSC=10
> 
> I: Bus=0003 Vendor=046d Product=c52b Version=0111
> N: Name="Logitech Unifying Device. Wireless PID:4003"
> P: Phys=usb-0000:00:14.0-9.2:2
> S:
> Sysfs=/devices/pci0000:00/0000:00:14.0/usb3/3-9/3-9.2/3-9.2:1.2/0003:046D:C52B.0003/input/input4
> U: Uniq=
> H: Handlers=sysrq kbd event4
> B: PROP=0
> B: EV=12001f
> B: KEY=4837fff072ff32d bf54444600000000 1 30f908b17c007 ffff7bfad941dfff
> febeffdfffefffff fffffffffffffffe
> B: REL=40
> B: ABS=100000000
> B: MSC=10
> B: LED=1f
> 
> Please let me know if you need more debug info. Thanks.
> 
> Best,
> Wujun Zhou
> 

-- 
Jiri Kosina
SUSE Labs
