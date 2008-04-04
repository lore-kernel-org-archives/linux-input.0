From: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Subject: Re: full usbhid autosuspend
Date: Fri, 4 Apr 2008 16:28:14 +0200
Message-ID: <200804041628.14793.oliver@neukum.org>
References: <200804011603.05998.oliver@neukum.org> <Pine.LNX.4.64.0804041437430.32130@jikos.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.64.0804041437430.32130-YCXOAqNspd+N3ZZ/Hiejyg@public.gmane.org>
Content-Disposition: inline
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Am Freitag, 4. April 2008 16:24:30 schrieb Jiri Kosina:
> On Tue, 1 Apr 2008, Oliver Neukum wrote:
> 
> > this is a full implementation of autosuspend for USB HID devices. 
> > Contrary to the current implementation it tries to safe power even for 
> > open devices, like keyboards and mice. Please test.
> 
> Hi Oliver,
> 
> there is some deadlock in IRQ path, could you please look at it? I have

Sure.

> triggered it on my test system trivially by just attaching one PS2 and one 
> USB keyboard to the system, fiddling a bit with leds on PS2 keyboard and 
> then tried to perform remote-wakeup on the suspended USB keyboard.

That is you hit a key on the USB keyboard?

	Regards
		Oliver
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
