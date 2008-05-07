From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: [patch]full autosuspend for USB HID
Date: Wed, 7 May 2008 11:46:38 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0805071145130.3701-100000@iolanthe.rowland.org>
References: <200805071450.39499.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <200805071450.39499.oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Cc: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Wed, 7 May 2008, Oliver Neukum wrote:

> Hi,
> 
> this patch introduces full autosuspend support for USB HID devices that
> support remote wakeup. It is quite large a patch because keyboards are
> hard to handle. That's because keyboards are also output devices.
> The current support for autosuspend in usbhid is based on the pm counters
> and works on an open/close base. This patch uses the last busy timer based
> approach.
> 
> It does the following changes:
> 
> - mark the device busy when input data arrives
> - extend the suspend() method to fail autosuspend if
> a - a key is being pressed as keyboards usually fail to wakeup on key release
> b - an LED is on as that makes suspension detectable to the user (optional)
> c - output is being performed
> - defer output to a suspended device (in interrupt)
> - handle deferred output in resume()
> - trigger wakeup if deferred output is queued
> - rework of locking for open/close to make sure suspend/resume have reliable state
> - unify locking for the output code path
> - handle resets correctly
> - synchronize power management and error handling
> - request remote wakeup
> 
> The basic strategy for input is to keep the device marked busy. The bulk of the
> patch is for output, the work around for the release stuff and synchronization.

One big problem we always faced with autosuspend for keyboards is that
most of them were not able to autoresume quickly enough to avoid losing
keystrokes.  Isn't that still a problem?

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
