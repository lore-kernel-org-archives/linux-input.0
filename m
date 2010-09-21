From: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: [BUG, Regression, bisected] USB mouse causes bug on 1st insert,
 ignored on 2nd insert, lsusb stuck at usbdev_open
Date: Tue, 21 Sep 2010 18:55:36 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1009211852010.26813@pobox.suse.cz>
References: <alpine.LNX.2.00.1009211156520.26813@pobox.suse.cz> <Pine.LNX.4.44L0.1009211013460.1644-100000@iolanthe.rowland.org> <20100921165048.GB8756@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100921165048.GB8756-l3A5Bk7waGM@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg KH <gregkh-l3A5Bk7waGM@public.gmane.org>
Cc: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Phil Turmel <philip-xiX+HWoRdKcdnm+yROfE0A@public.gmane.org>, Mat <jackdachef-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Guillaume Chazarain <guichaz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>, Alan Ott <alan-yzvJWuRpmD1zbRFIqnYvSA@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andreas Bombe <aeb-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>, Alex Riesen <raa.lkml-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Gabriel C <nix.or.die-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Tue, 21 Sep 2010, Greg KH wrote:

> > > I have just found out that it's actually CONFIG_USB_DYNAMIC_MINORS which 
> > > makes the difference. When unset, the problem doesn't trigger, and 
> > > usb_find_interface() always returns the proper interface. When 
> > > CONFIG_USB_DYNAMIC_MINORS is being used, the oops happen.
> > > 
> > > I'll look into that.
> > 
> > Apparently the problem is that intf->minors doesn't get initialized 
> > properly.  This patch should fix it.  Everybody, please try it out.
> 
> Wow, what happened to suddenly cause this?  Nothing has changed here in
> a long time.
> 
> wierd.

It doesn't hit you if you are calling usb_register_dev() for all the 
instances you have, as the first device will have minor '0', the second 
one '1', etc.

But if you are calling usb_find_interface() for devices that have never 
been registered through usb_register_dev(), then you have a problem, as 
usb_find_interface() will match those unregistered devices (as minor == 0 
in such cases).

This is probably quite rare scenario, and hiddev (which might be the only 
in-kernel driver doing this?) has moved to usb_find_interface() only 
recently.

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
