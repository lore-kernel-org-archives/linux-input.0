From: "xerces8" <xerces8-i80Im65WZOA@public.gmane.org>
Subject: Re: USB mouse protocol,
Date: Wed, 30 Apr 2008 16:07:06 +0200
Message-ID: <WorldClient-F200804301607.AA07060136@butn.net>
References: <WorldClient-F200804301128.AA28590066@butn.net> <20080430111816.GA9876@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20080430111816.GA9876-AlSwsSmVLrQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Vojtech Pavlik <vojtech-AlSwsSmVLrQ@public.gmane.org>
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Vojtech Pavlik wrote:

> On Wed, Apr 30, 2008 at 11:28:59AM +0200, xerces8 wrote:
> > Hi!
> > 
> > I'm curious about some details in the protocol used by USB mice.
> > A cursory look at the "Device Class Definition for HID 1.11" documents
> > tells me (note this is the first USB technical document I ever read)
> > that a mouse can tell the host the format (the protocol) used to report
> > data (movement, button state etc.).
> > 
> > Also a quick look into linuxv2.6.25/drivers/hid/usbhid/usbmouse.c suggests
> > that 8 bits are used for position.
> > 
> > So my questions are:
> >  - is the position data always 8 bits wide ?
> 
> No. The driver you need to look at is usbhid.ko, not usbmouse - that
> only works for the static "HID Boot Protocol", and is only useful in
> embedded devices.

Pretty hard to read there... Can I activate some debug output, to see what
my mouse is sending ?

> >  - when are reports sent ? Are they polled by host ? Or sent by the device
> > on its own ?
> 
> That depends on how you look at it. The host controller polls the device
> at a specified rate - typically 100Hz, but the device decides whether it
> will or won't send a report when polled.

100Hz is the linux default ? Is there an USB standard value ?

Regards,
David


--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
