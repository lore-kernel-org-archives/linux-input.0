From: Bastien Nocera <hadess@hadess.net>
Subject: Re: RFC: Wacom Bluetooth HID driver, first pass
Date: Mon, 16 Mar 2009 23:58:54 +0000
Message-ID: <1237247934.32264.10670.camel@cookie.hadess.net>
References: <1236988799.32264.6310.camel@cookie.hadess.net>
	 <1237200912.32264.9867.camel@cookie.hadess.net>
	 <93531296-64B0-4D4B-A4A9-26F3D67DF579@holtmann.org>
	 <1237213799.32264.10090.camel@cookie.hadess.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:34336 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754451AbZCQASg (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 16 Mar 2009 20:18:36 -0400
In-Reply-To: <1237213799.32264.10090.camel@cookie.hadess.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-input <linux-input@vger.kernel.org>, BlueZ development <linux-bluetooth@vger.kernel.org>, mjg <mjg@redhat.com>, Peter Hutterer <peter.hutterer@redhat.com>, zap@homelink.ru

On Mon, 2009-03-16 at 14:29 +0000, Bastien Nocera wrote:
> On Mon, 2009-03-16 at 15:00 +0100, Marcel Holtmann wrote:
<snip>
> > > A couple of notes:
> > > - the wheel action is reversed, it's a simple fix, done locally
> > > - hidp and the Bluetooth sub-system says it can't probe the device  
> > > with
> > > error "-14" when hid-wacom.ko isn't already loaded

Bluetooth: HIDP (Human Interface Emulation) ver 1.2 
wacom 0005:056A:0081.0001: parse failed
wacom: probe of 0005:056A:0081.0001 failed with error -14 
wacom driver registered

> > what was the reason for not forcing HID to load the generic driver?
> 
> What generic driver? If you're talking about the default Wacom driver,
> it isn't an HID driver, and requires a USB device.
> 
> >  I  
> > lost track on how HID is suppose to handle these. You could also  
> > introduce a phony export like we do with L2CAP to ensure it is loaded  
> > even if userspace isn't ready to handle this dependency.
> 
> Well, the problem is that the driver _does_ load, but I'm not certain
> about the sequence of events between the Bluetooth sub-system, the
> user-space enabling (see the linked patch to bluetoothd), and the HID
> sub-system.

Turning the device off and on again works though. No idea what's
happening.

> > > - I'm getting oopses in hci_conn_del() when the device goes away  
> > > (eg. I
> > > turn it off).
> > 
> > Try to run a net-next-2.6 or bluetooth-next-2.6 kernel. Kyle should  
> > have merged these patches into the latest rawhide kernel.
> 
> I was hoping this would be fixed in the latest linus-2.6 tree, guess
> not.

No more crashes. Great stuff.

I sent a fixed up patch to the list earlier.

Cheers


