From: "xerces8" <xerces8-i80Im65WZOA@public.gmane.org>
Subject: USB mouse protocol,
Date: Wed, 30 Apr 2008 11:28:59 +0200
Message-ID: <WorldClient-F200804301128.AA28590066@butn.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: vojtech-AlSwsSmVLrQ@public.gmane.org
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hi!

I'm curious about some details in the protocol used by USB mice.
A cursory look at the "Device Class Definition for HID 1.11" documents
tells me (note this is the first USB technical document I ever read)
that a mouse can tell the host the format (the protocol) used to report
data (movement, button state etc.).

Also a quick look into linuxv2.6.25/drivers/hid/usbhid/usbmouse.c suggests
that 8 bits are used for position.

So my questions are:
 - is the position data always 8 bits wide ?
 - when are reports sent ? Are they polled by host ? Or sent by the device
on its own ?

Thanks for any answers,
David Balazic
 


--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
