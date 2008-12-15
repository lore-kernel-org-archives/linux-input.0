From: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: [patch]cleanup of hiddev
Date: Mon, 15 Dec 2008 17:01:07 +0100 (CET)
Message-ID: <alpine.LNX.1.10.0812151659340.21089@jikos.suse.cz>
References: <200812091319.59054.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <200812091319.59054.oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Cc: Jiri Slaby <jslaby-AlSwsSmVLrQ@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Tue, 9 Dec 2008, Oliver Neukum wrote:

> commit f05614115c77fae393b3a262780f8f13ff485173
> Author: Oliver Neukum <oneukum-l3A5Bk7waGM@public.gmane.org>
> Date:   Tue Dec 9 13:09:56 2008 +0100
> 
>     cleanup of hiddev
>     
>     - thread safety
>     - fix race between ioctl and disconnect
>     - race in open
>     - error checking
>     - O_NONBLOCK handled

Hi Oliver,

I have finally gone through the patch, and I think it is OK. I'd prefer 
taking the individual cleanups as individual patches though, if you have 
it split in your tree.

Or at least more descriptive changelog, explaining the bugs fixed in 
deeper detail, would be nice to have.

Thanks!

-- 
Jiri Kosina
SUSE Labs
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
