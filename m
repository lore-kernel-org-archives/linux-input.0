From: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: USB hid blocks USB port in 2.6.28rc3
Date: Wed, 12 Nov 2008 15:31:41 +0100 (CET)
Message-ID: <alpine.LNX.1.10.0811121529240.32143@jikos.suse.cz>
References: <20081111003117.GA10904@basil.nowhere.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20081111003117.GA10904-3rXA9MLqAseW/qJFnhkgxti2O/JbrIOy@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andi Kleen <andi-Vw/NltI1exuRpAAqCnN02g@public.gmane.org>
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jiri Slaby <jslaby-AlSwsSmVLrQ@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Tue, 11 Nov 2008, Andi Kleen wrote:

> generic-usb 0003:047B:0011.0002: input: USB HID v1.00 Keyboard [Silitek Standard USB Keyboard ] on usb-0000:00:1d.0-2/input0
> usb 3-1: new low speed USB device using uhci_hcd and address 2
> /home/lsrc/linux-2.6.28-rc3/drivers/hid/usbhid/hid-core.c: couldn't find an input interrupt endpoint

Hmm, I am wondering about this error. This appears when the keyboard gets 
connected, before you do any of the device shuffling, right?

Could you please post /proc/bus/usb/devices before and after you do the 
connection changes?

-- 
Jiri Kosina
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
