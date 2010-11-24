From: Jeremy Moles <jeremy@emperorlinux.com>
Subject: Researching An Experimental Touchscreen Driver
Date: Wed, 24 Nov 2010 11:07:00 -0500
Message-ID: <1290614820.3294.37.camel@bathysphere>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from router.emperor-sw2.exsbs.net ([208.254.201.37]:59265 "EHLO
	sade.emperorlinux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754937Ab0KXQ0p (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 24 Nov 2010 11:26:45 -0500
Received: from [192.168.1.179] (dhcp179.emperorlinux.com [192.168.1.179])
	by sade.emperorlinux.com (Postfix) with ESMTP id 38D577E9C73
	for <linux-input@vger.kernel.org>; Wed, 24 Nov 2010 11:01:07 -0500 (EST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hello everyone! I have a piece of hardware here using a vanilla 2.6.34
kernel (though I can easily change kernels if needed) that has attached
to it internally a USB touchscreen device. The relevant DMESG info is
below, and this is printed out whenever the module 'usbhid' is loaded.

--------------------------------------------------------------------

usbcore: registered new interface driver hiddev
input: Fujitsu Component USB Touch Panel
as /devices/pci0000:00/0000:00:1a.0/usb3/3-2/3-2:1.0/input/input9
generic-usb 0003:0430:0501.0002: input: USB HID v1.00 Mouse [Fujitsu
Component USB Touch Panel] on usb-0000:00:1a.0-2/input0
usbcore: registered new interface driver usbhid
usbhid: USB HID core driver

--------------------------------------------------------------------

For a long time now, we have been successfully configuring these
machines using the device node created when this driver is loaded, often
something like /dev/input/event5 (with a UDEV rule to make the name more
sensible). In X, we've been using the "evtouch" driver with this device
node, to great effect.

However, I am doing a bit of research and experimentation, and what I
would like to do is write some custom driver code to interface with this
device, instead of letting usbhid manage it. My question is, where is
the best place to start?

- Since usbhid already recognizes and binds to this device, what code
can I begin studying to see exactly how it's detecting this and
formatting input?

- Once usbhid attaches to this device, is the device in some kind of
lock? Is it possible to simply inject additional features or formatting
functions, possibly via quirks? (I don't quite understand how to do
anything with quirks other than blacklist a device).

- If I want to write a full driver for the device, what source file
would be best to start from? I've tried hacking usbtouchscreen.c and
hid-ntrig.c for the last few days to try and get them to bind to the
device, but neither attempt has seen any success. My hid-ntrig change
refuses to successfully call hid_parse(), and my usbtouchscreen change
continually returns some error code in the IRQ callback.

