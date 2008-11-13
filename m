From: Andi Kleen <andi-Vw/NltI1exuRpAAqCnN02g@public.gmane.org>
Subject: Re: USB hid blocks USB port in 2.6.28rc3
Date: Thu, 13 Nov 2008 12:32:24 +0100
Message-ID: <20081113113223.GT3810@one.firstfloor.org>
References: <20081111003117.GA10904@basil.nowhere.org> <alpine.LNX.1.10.0811121529240.32143@jikos.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <alpine.LNX.1.10.0811121529240.32143-YCXOAqNspd+N3ZZ/Hiejyg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
Cc: Andi Kleen <andi-Vw/NltI1exuRpAAqCnN02g@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jiri Slaby <jslaby-AlSwsSmVLrQ@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Wed, Nov 12, 2008 at 03:31:41PM +0100, Jiri Kosina wrote:
> On Tue, 11 Nov 2008, Andi Kleen wrote:
> 
> > generic-usb 0003:047B:0011.0002: input: USB HID v1.00 Keyboard [Silitek Standard USB Keyboard ] on usb-0000:00:1d.0-2/input0
> > usb 3-1: new low speed USB device using uhci_hcd and address 2
> > /home/lsrc/linux-2.6.28-rc3/drivers/hid/usbhid/hid-core.c: couldn't find an input interrupt endpoint
> 
> Hmm, I am wondering about this error. This appears when the keyboard gets 
> connected, before you do any of the device shuffling, right?

Yes. The log was over a longer run time and connected and disconnected
several things at different times.
> 
> Could you please post /proc/bus/usb/devices before and after you do the 
> connection changes?

I did some retesting and right now it looks like the power switch
never works with 2.6.28rc4 (not sure how I got to the conclusion
earlier that it was only after reconnect)

I now always get when I run sispm:

usb 3-2: usbfs: interface 0 claimed by usbhid while 'sispm' sets config #1

On 2.6.27 it works.

Which information do you need exactly out of /sys/bus/usb/devices? 

A simple find on 2.6.28rc4 is:

/sys/bus/usb/devices/
/sys/bus/usb/devices/usb1
/sys/bus/usb/devices/1-0:1.0
/sys/bus/usb/devices/usb2
/sys/bus/usb/devices/2-0:1.0
/sys/bus/usb/devices/usb3
/sys/bus/usb/devices/3-0:1.0
/sys/bus/usb/devices/usb4
/sys/bus/usb/devices/4-0:1.0
/sys/bus/usb/devices/usb5
/sys/bus/usb/devices/5-0:1.0
/sys/bus/usb/devices/1-3
/sys/bus/usb/devices/1-3:1.0
/sys/bus/usb/devices/3-2
/sys/bus/usb/devices/3-2:1.0
/sys/bus/usb/devices/1-3.1
/sys/bus/usb/devices/1-3.1:1.0
/sys/bus/usb/devices/1-3.2
/sys/bus/usb/devices/1-3.2:1.0
/sys/bus/usb/devices/1-3.3
/sys/bus/usb/devices/1-3.3:1.0
/sys/bus/usb/devices/1-3.3:1.1
/sys/bus/usb/devices/1-3.4
/sys/bus/usb/devices/1-3.4:1.0
/sys/bus/usb/devices/1-5
/sys/bus/usb/devices/1-5:1.0
/sys/bus/usb/devices/1-5:1.1
/sys/bus/usb/devices/1-5:1.2
/sys/bus/usb/devices/1-5:1.3

with gembird switch connected.

-Andi
-- 
ak-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
