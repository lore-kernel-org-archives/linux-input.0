From: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: full usbhid autosuspend
Date: Fri, 4 Apr 2008 16:38:18 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0804041637150.32130@jikos.suse.cz>
References: <200804011603.05998.oliver@neukum.org>
 <Pine.LNX.4.64.0804041437430.32130@jikos.suse.cz> <200804041628.14793.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <200804041628.14793.oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Fri, 4 Apr 2008, Oliver Neukum wrote:

> > there is some deadlock in IRQ path, could you please look at it? I have
> Sure.

Thanks.

> > triggered it on my test system trivially by just attaching one PS2 and one 
> > USB keyboard to the system, fiddling a bit with leds on PS2 keyboard and 
> > then tried to perform remote-wakeup on the suspended USB keyboard.
> That is you hit a key on the USB keyboard?

Yes. Just letting the USB keyboard go auto-suspend, then fiddling with 
LEDs on PS2 keyboard and then hitting key on USB keyboard triggers it for 
me quite reliably (not 100% though, so you may have to retry).

Thanks,

-- 
Jiri Kosina
SUSE Labs
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
