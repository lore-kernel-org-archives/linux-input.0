From: Dylan Alex Simon <dylan-kernel@dylex.net>
Subject: Re: hid-thingm: kernel panic on remove
Date: Tue, 2 Sep 2014 16:12:19 -0400
Message-ID: <20140902201218.GA2001@datura.dylex.net>
References: <20140902174659.GA1811@datura.dylex.net>
 <54062150.2010800@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from datura.dylex.net ([66.114.66.16]:54388 "EHLO datura.dylex.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752455AbaIBUMV (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 2 Sep 2014 16:12:21 -0400
Content-Disposition: inline
In-Reply-To: <54062150.2010800@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>

>From Benjamin Tissoires <benjamin.tissoires@gmail.com>, Tue, Sep 02, 2014 at 03:58:08PM -0400:
> Hi,
> 
> On 09/02/2014 01:46 PM, Dylan Alex Simon wrote:
> > Whenever either disconnecting the USB device or simply rmmod'ing the module
> > (even when not in use), I get a kernel panic.  I haven't managed to capture a
> > backtrace, but at least the first two lines were saved after an rmmod.
> > 
> > Let me know if you'd like me to try to capture more info, but this problem
> > seems very reproducible (at least with a mk2 device; I never had the problem on
> > older kernels with a mk1).  I do direct write()s to the hidraw device, but
> > don't otherwise use the driver while it's loaded.
> > 
> > Also at https://bugzilla.kernel.org/show_bug.cgi?id=83751
> 
> Do you happen to see a "unsupported firmware " error when plugging your device?
> 
> If so, then the following patch should help with the panic (but you will an other one to be able to use again your device).

No, no unsupported firmware messages.  The device and driver work fine
otherwise.  It registers (and unregisters) all the devices.  Hotplug events:

18:53:17 kernel: thingm 0003:27B8:01ED.0004: hidraw3: USB HID v1.01 Device [ThingM blink(1) mk2] on usb-0000:00:12.2-3.1.4/input0
18:53:17 hotplug: 694 add module path:/module/hid_thingm
18:53:17 hotplug: 695 add hidraw path:/devices/pci0000:00/0000:00:12.2/usb1/1-3/1-3.1/1-3.1.4/1-3.1.4:1.0/0003:27B8:01ED.0004/hidraw/hidraw3
18:53:17 hotplug: 696 add leds path:/devices/pci0000:00/0000:00:12.2/usb1/1-3/1-3.1/1-3.1.4/1-3.1.4:1.0/0003:27B8:01ED.0004/leds/thingm3:red:led1
18:53:17 hotplug: 698 add leds path:/devices/pci0000:00/0000:00:12.2/usb1/1-3/1-3.1/1-3.1.4/1-3.1.4:1.0/0003:27B8:01ED.0004/leds/thingm3:blue:led1
18:53:17 hotplug: 697 add leds path:/devices/pci0000:00/0000:00:12.2/usb1/1-3/1-3.1/1-3.1.4/1-3.1.4:1.0/0003:27B8:01ED.0004/leds/thingm3:green:led1
18:53:17 hotplug: 699 add leds path:/devices/pci0000:00/0000:00:12.2/usb1/1-3/1-3.1/1-3.1.4/1-3.1.4:1.0/0003:27B8:01ED.0004/leds/thingm3:red:led2
18:53:17 hotplug: 700 add leds path:/devices/pci0000:00/0000:00:12.2/usb1/1-3/1-3.1/1-3.1.4/1-3.1.4:1.0/0003:27B8:01ED.0004/leds/thingm3:green:led2
18:53:17 hotplug: 701 add leds path:/devices/pci0000:00/0000:00:12.2/usb1/1-3/1-3.1/1-3.1.4/1-3.1.4:1.0/0003:27B8:01ED.0004/leds/thingm3:blue:led2
18:53:17 hotplug: 702 add drivers path:/bus/hid/drivers/thingm
<snip, rmmod:>
08:38:42 hotplug: 710 remove leds path:/devices/pci0000:00/0000:00:12.2/usb1/1-3/1-3.1/1-3.1.4/1-3.1.4:1.0/0003:27B8:01ED.0004/leds/thingm3:red:led1
08:38:42 hotplug: 712 remove leds path:/devices/pci0000:00/0000:00:12.2/usb1/1-3/1-3.1/1-3.1.4/1-3.1.4:1.0/0003:27B8:01ED.0004/leds/thingm3:blue:led1
08:38:42 hotplug: 711 remove leds path:/devices/pci0000:00/0000:00:12.2/usb1/1-3/1-3.1/1-3.1.4/1-3.1.4:1.0/0003:27B8:01ED.0004/leds/thingm3:green:led1
08:38:42 hotplug: 714 remove leds path:/devices/pci0000:00/0000:00:12.2/usb1/1-3/1-3.1/1-3.1.4/1-3.1.4:1.0/0003:27B8:01ED.0004/leds/thingm3:green:led2
08:38:42 hotplug: 713 remove leds path:/devices/pci0000:00/0000:00:12.2/usb1/1-3/1-3.1/1-3.1.4/1-3.1.4:1.0/0003:27B8:01ED.0004/leds/thingm3:red:led2
08:38:42 hotplug: 715 remove leds path:/devices/pci0000:00/0000:00:12.2/usb1/1-3/1-3.1/1-3.1.4/1-3.1.4:1.0/0003:27B8:01ED.0004/leds/thingm3:blue:led2
08:38:42 hotplug: 716 remove hidraw path:/devices/pci0000:00/0000:00:12.2/usb1/1-3/1-3.1/1-3.1.4/1-3.1.4:1.0/0003:27B8:01ED.0004/hidraw/hidraw3
08:38:42 kernel: BUG: unable to handle kernel paging request at fffffffb8a80aaf8
08:38:42 kernel: IP: [<ffffffff8106e30c>] osq_lock+0x3c/0x110
