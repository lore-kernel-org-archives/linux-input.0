From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Researching An Experimental Touchscreen Driver
Date: Sat, 27 Nov 2010 15:51:33 -0800
Message-ID: <20101127235133.GB29981@core.coreip.homeip.net>
References: <1290614820.3294.37.camel@bathysphere>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:61086 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753891Ab0K0Xvj (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 27 Nov 2010 18:51:39 -0500
Received: by gxk22 with SMTP id 22so1459991gxk.19
        for <linux-input@vger.kernel.org>; Sat, 27 Nov 2010 15:51:39 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1290614820.3294.37.camel@bathysphere>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jeremy Moles <jeremy@emperorlinux.com>
Cc: linux-input@vger.kernel.org

On Wed, Nov 24, 2010 at 11:07:00AM -0500, Jeremy Moles wrote:
> Hello everyone! I have a piece of hardware here using a vanilla 2.6.34
> kernel (though I can easily change kernels if needed) that has attached
> to it internally a USB touchscreen device. The relevant DMESG info is
> below, and this is printed out whenever the module 'usbhid' is loaded.
> 
> --------------------------------------------------------------------
> 
> usbcore: registered new interface driver hiddev
> input: Fujitsu Component USB Touch Panel
> as /devices/pci0000:00/0000:00:1a.0/usb3/3-2/3-2:1.0/input/input9
> generic-usb 0003:0430:0501.0002: input: USB HID v1.00 Mouse [Fujitsu
> Component USB Touch Panel] on usb-0000:00:1a.0-2/input0
> usbcore: registered new interface driver usbhid
> usbhid: USB HID core driver
> 
> --------------------------------------------------------------------
> 
> For a long time now, we have been successfully configuring these
> machines using the device node created when this driver is loaded, often
> something like /dev/input/event5 (with a UDEV rule to make the name more
> sensible). In X, we've been using the "evtouch" driver with this device
> node, to great effect.
> 
> However, I am doing a bit of research and experimentation, and what I
> would like to do is write some custom driver code to interface with this
> device, instead of letting usbhid manage it. My question is, where is
> the best place to start?

I guess you need to enumerate what deficiencies usbhid has and what
issues you want to solve. That would clear a lot. I think that
completely abandoning HID driver for device that is mostly HID compliant
is not the best idea and you probably want to wire a HID sub-driver that
works in tandem with usbhid.

> 
> - Since usbhid already recognizes and binds to this device, what code
> can I begin studying to see exactly how it's detecting this and
> formatting input?

I guess drivers/hid/hid-input.c is the most interesting one.

> 
> - Once usbhid attaches to this device, is the device in some kind of
> lock? Is it possible to simply inject additional features or formatting
> functions, possibly via quirks? (I don't quite understand how to do
> anything with quirks other than blacklist a device).

Only one driver can manage a device so once HID claimed it your
standalone driver will not be able to control it. However there is
notion of HID bus drivers (you looked at hid-ntrig - it's one of them)
that allow you to override and/or augment processing done by the default
HID driver.

> 
> - If I want to write a full driver for the device, what source file
> would be best to start from? I've tried hacking usbtouchscreen.c and
> hid-ntrig.c for the last few days to try and get them to bind to the
> device, but neither attempt has seen any success. My hid-ntrig change
> refuses to successfully call hid_parse(), and my usbtouchscreen change
> continually returns some error code in the IRQ callback.

Did you add the VID/PID of your device to the blacklist in
drivers/hid/hid-core.c?

-- 
Dmitry
