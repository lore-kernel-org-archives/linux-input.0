From: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: [PATCH] USBHID: add NOGET quirk for devices from CH Products
Date: Thu, 7 May 2009 00:02:03 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.0905070001430.22532@wotan.suse.de>
References: <Pine.LNX.4.44L0.0905061543290.4430-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.44L0.0905061543290.4430-100000-IYeN2dnnYyZXsRXLowluHWD2FQJk+8+b@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: Sean Hildebrand <silverwraithii-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sid Boyce <sboyce-QgLWrMLu8clzjhtm8Ag3mw@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, stable-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Wed, 6 May 2009, Alan Stern wrote:

> This patch (as1240) adds the NOGET quirk for three devices from CH
> Products: the Pro pedals, the Combatstick joystick, and the Flight-Sim
> yoke.  Without these quirks, the devices haven't worked for many
> kernel releases.  Sometimes replugging them after boot-up would get
> them to work and sometimes they wouldn't work at all.
> 
> Signed-off-by: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
> Reported-by: Sean Hildebrand <silverwraithii-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Reported-by: Sid Boyce <sboyce-QgLWrMLu8clzjhtm8Ag3mw@public.gmane.org>
> Tested-by: Sean Hildebrand <silverwraithii-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Tested-by: Sid Boyce <sboyce-QgLWrMLu8clzjhtm8Ag3mw@public.gmane.org>

Applied, thanks!

-- 
Jiri Kosina
SUSE Labs
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
