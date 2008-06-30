From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [rft]power management for usbtouch
Date: Mon, 30 Jun 2008 11:29:54 -0400
Message-ID: <20080630112709.ZZRA012@mailhub.coreip.homeip.net>
References: <Pine.LNX.4.44L0.0806281230510.23173-100000@netrider.rowland.org> <200806290047.56736.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200806290047.56736.oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Cc: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Ville Syrj?l? <syrjala-ORSVBvAovxo@public.gmane.org>, daniel.ritz-OI3hZJvNYWs@public.gmane.org, Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Sun, Jun 29, 2008 at 12:47:55AM +0200, Oliver Neukum wrote:
> Am Samstag 28 Juni 2008 18:33:30 schrieb Alan Stern:
> > On Sat, 28 Jun 2008, Oliver Neukum wrote:
> > 
> > > In hindsight adding that interface at all was an error. I was in favor
> > > of it and that was a mistake. Maybe it should be removed.
> > > Complicating good drivers for its sake I therefore consider an error.
> > > Possibly we should consider a forcible suspension a form of disconnection.
> > 
> > Are you suggesting that the "off" value in /sys/.../power/level 
> > shouldn't be allowed?  I don't see it that way -- there's no other 
> > mechanism for userspace to force a USB device into the low-power state.
> 
> Unfortunately.
> 
> > Forcing a disconnection during suspend might be a good idea.  But if 
> > you do, is there any reason to consider manual suspension different 
> > from system sleep?
> 
> During system sleep user space is asleep and cannot make demands
> on drivers. If you force a device to sleep, the driver cannot work. Therefore
> it should not be bound to such a device. It's cleaner to disconnect.

I'd agree with this. Otherwise we need somehow to be able to resync
the state of the device (like have LEDs and repeat rate reset,
re-upload force-feedback effects, etc, etc) once device is resumed.
So... what is the consensus? Do we need to worry about manual
device-level suspension or it will be reworked/removed?

-- 
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
