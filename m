From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: [rft]power management for usbtouch
Date: Mon, 30 Jun 2008 12:16:13 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0806301210430.2708-100000@iolanthe.rowland.org>
References: <20080630115953.ZZRA012@mailhub.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20080630115953.ZZRA012-NG0XCrj25/nJrYCpivWRnl5pS2h4L8biXqFh9Ls21Oc@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>, Ville Syrj?l? <syrjala-ORSVBvAovxo@public.gmane.org>, daniel.ritz-OI3hZJvNYWs@public.gmane.org, Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Mon, 30 Jun 2008, Dmitry Torokhov wrote:

> > My feeling is that we will leave manual suspension in the kernel.  The
> > code passed to the USB driver's suspend method will be changed so that
> > the method can tell whether it is being called for a system sleep vs.
> > an autosuspend vs. a manual suspend.
> > 
> 
> Ok, I see... So what does a device do when it is suspended and a
> request comes in? Does it automatically resume and service the request
> (and potentially goes back to sleep)? Does it queue the request for
> later? Ignore it? Is it a system-wide policy or up to the device
> [class]?

What sort of request do you mean?  If a device is suspended, it _can't_ 
receive any data (requests or otherwise) over the USB bus.

If a device receives data over some other channel (like a mouse getting
a button click) while it is suspended, its behavior depends on the
settings at the time it was suspended.  If remote wakeup was disabled
then the device does essentially nothing (maybe it remembers the data
for later, maybe not).  If remote wakeup was enabled then the device
should send a wakeup request to the host.

Remote wakeup is controlled by a setting in sysfs: 
/sys/bus/usb/device/.../power/wakeup.  It is enabled by default for all 
USB devices that support it.

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
