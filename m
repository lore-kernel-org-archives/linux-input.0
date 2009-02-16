From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: dead USB devices after resume [mmotm 2009-02-10-16-35]
Date: Mon, 16 Feb 2009 14:58:23 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0902161448500.18928-100000@netrider.rowland.org>
References: <49996F43.2070801@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <49996F43.2070801-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jiri Slaby <jirislaby-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Kernel development list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, mm-commits-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Greg KH <gregkh-l3A5Bk7waGM@public.gmane.org>, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Mon, 16 Feb 2009, Jiri Slaby wrote:

> Alan Stern wrote:
> > So the problem must be lower down, such as in the usbhid driver.  The 
> > best way to track this is to use usbmon.
> 
> Well, there is some traffic after resume, but nothing when pressing keys...

Unforunately the most important part of the log was lost, probably
because the usbmon buffer filled up.  (It's the part between the
2320601617 and 2376096580 timestamps -- a 56-second gap.)  You can try
again after increasing the value of EVENT_MAX in
drivers/usb/mon/mon_text.c.

Alan Stern


--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
