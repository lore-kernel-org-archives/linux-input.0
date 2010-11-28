From: Jeremy Moles <jeremy@emperorlinux.com>
Subject: Re: Researching An Experimental Touchscreen Driver
Date: Sat, 27 Nov 2010 21:23:30 -0500
Message-ID: <1290911010.1932.9.camel@bathysphere>
References: <1290614820.3294.37.camel@bathysphere>
	 <20101127235133.GB29981@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from router.emperor-sw2.exsbs.net ([208.254.201.37]:40343 "EHLO
	sade.emperorlinux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750946Ab0K1CXR (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 27 Nov 2010 21:23:17 -0500
In-Reply-To: <20101127235133.GB29981@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

On Sat, 2010-11-27 at 15:51 -0800, Dmitry Torokhov wrote:
> On Wed, Nov 24, 2010 at 11:07:00AM -0500, Jeremy Moles wrote:
> > Hello everyone! I have a piece of hardware here using a vanilla 2.6.34
> > kernel (though I can easily change kernels if needed) that has attached
> > to it internally a USB touchscreen device. The relevant DMESG info is
> > below, and this is printed out whenever the module 'usbhid' is loaded.
> > 
> > --------------------------------------------------------------------
> > 
> > usbcore: registered new interface driver hiddev
> > input: Fujitsu Component USB Touch Panel
> > as /devices/pci0000:00/0000:00:1a.0/usb3/3-2/3-2:1.0/input/input9
> > generic-usb 0003:0430:0501.0002: input: USB HID v1.00 Mouse [Fujitsu
> > Component USB Touch Panel] on usb-0000:00:1a.0-2/input0
> > usbcore: registered new interface driver usbhid
> > usbhid: USB HID core driver
> > 
> > --------------------------------------------------------------------
> > 
> > For a long time now, we have been successfully configuring these
> > machines using the device node created when this driver is loaded, often
> > something like /dev/input/event5 (with a UDEV rule to make the name more
> > sensible). In X, we've been using the "evtouch" driver with this device
> > node, to great effect.
> > 
> > However, I am doing a bit of research and experimentation, and what I
> > would like to do is write some custom driver code to interface with this
> > device, instead of letting usbhid manage it. My question is, where is
> > the best place to start?
> 
> I guess you need to enumerate what deficiencies usbhid has and what
> issues you want to solve. That would clear a lot. I think that
> completely abandoning HID driver for device that is mostly HID compliant
> is not the best idea and you probably want to wire a HID sub-driver that
> works in tandem with usbhid.

I think you're absolutely right about a sub-driver of sorts.

Essentially it comes down to this: the touchscreen is being used in
hardware running Android, and the Android userspace code expects an
input event device to support the BTN_TOUCH ioctl. However, seeing as
usbhid binds to this device in a very generic way, it doesn't add the
BTN_TOUCH bits, and rightly so. In regular X, the evtouch driver does
not require this particular feature, so the device works fine.

HOWEVER, if I remove this check from the Android userspace library tslib
(the ioctl query for BTN_TOUCH), it does at least act as a pointer
inside Android's display manager, although there is no notion of
pressure--it's either 255 or 0 in tslib terms. I'm not entirely sure the
device even supports pressure, but that is why I'm researching this
project. :)

> > 
> > - Since usbhid already recognizes and binds to this device, what code
> > can I begin studying to see exactly how it's detecting this and
> > formatting input?
> 
> I guess drivers/hid/hid-input.c is the most interesting one.
> 
> > 
> > - Once usbhid attaches to this device, is the device in some kind of
> > lock? Is it possible to simply inject additional features or formatting
> > functions, possibly via quirks? (I don't quite understand how to do
> > anything with quirks other than blacklist a device).
> 
> Only one driver can manage a device so once HID claimed it your
> standalone driver will not be able to control it. However there is
> notion of HID bus drivers (you looked at hid-ntrig - it's one of them)
> that allow you to override and/or augment processing done by the default
> HID driver.

This is definitely what I'm interested in. I stripped its code down to
basically just the probe function. It recognizes my USB PCIID but fails
to call hid_parse() with the error -19. I've not been able to lock down
where the ll_driver->hid_parse() function is to see exactly what this
error might be.

> > 
> > - If I want to write a full driver for the device, what source file
> > would be best to start from? I've tried hacking usbtouchscreen.c and
> > hid-ntrig.c for the last few days to try and get them to bind to the
> > device, but neither attempt has seen any success. My hid-ntrig change
> > refuses to successfully call hid_parse(), and my usbtouchscreen change
> > continually returns some error code in the IRQ callback.
> 
> Did you add the VID/PID of your device to the blacklist in
> drivers/hid/hid-core.c?

Yes, and this does prevent usbhid from picking it up. I can also add a
quirk to modprobe.conf dynamically adding the HID_QUIRK_IGNORE quirk to
achieve the same effect. In fact, this is necessary for my "hacked"
hid-testdriver.c module to even TRY and call the probe function.

BTW, thanks a ton for you response. I hope I've given you more
information, and I'll keep hacking on this!

