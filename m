From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: USB hid blocks USB port in 2.6.28rc3
Date: Thu, 13 Nov 2008 10:54:34 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0811131040160.2380-100000@iolanthe.rowland.org>
References: <20081113143149.GW3810@one.firstfloor.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:50501 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752971AbYKMPyf (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 13 Nov 2008 10:54:35 -0500
In-Reply-To: <20081113143149.GW3810@one.firstfloor.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: Jiri Slaby <jirislaby@gmail.com>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-usb@vger.kernel.org

On Thu, 13 Nov 2008, Andi Kleen wrote:

> On Thu, Nov 13, 2008 at 01:30:55PM +0100, Jiri Slaby wrote:
> > Andi Kleen napsal(a):
> > > Which information do you need exactly out of /sys/bus/usb/devices? 
> > 
> > You misread the path, it's one file in /proc. (Make sure usbfs is mounted
> 
> There was nothing there, so I checked sysfs.
> 
> > there.)
> 
> With the power switch connected I have:
> 
> ...
> T:  Bus=03 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#=  2 Spd=1.5 MxCh= 0
> D:  Ver= 1.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
> P:  Vendor=04b4 ProdID=fd11 Rev= 1.01
> S:  Manufacturer=Gembird Electronics
> S:  Product=Gembird Silver Shield PM
> C:* #Ifs= 1 Cfg#= 1 Atr=80 MxPwr=150mA
> I:* If#= 0 Alt= 0 #EPs= 0 Cls=03(HID  ) Sub=00 Prot=00 Driver=usbhid
> 
> ...

It looks like this problem was caused by the introduction of the input 
bus.

When the USB device is detected, the hid_probe routine in usbhid is
called.  It registers the device on the input bus.  This causes the
hid_probe routine in drivers/hid/hid-core.c to be called, and it fails.

But that failure merely means there's no driver bound to the input
device.  It's still registered on the input bus, and the USB device is
still bound to usbhid.  Whereas before, the failure would occur in
usbhid's probe and would leave the USB device unbound.

This suggests that a lot of the work in usbhid_start should be 
performed earlier, before calling hid_add_device.  After all, why 
bother registering a USB device on the input bus if usbhid isn't going 
to be able to drive it?

Alan Stern

