From: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] input/joystick: add driver fortius 1942
Date: Mon, 16 Mar 2009 19:25:31 -0700
Message-ID: <20090317022531.GA504@kroah.com>
References: <739e73230903161921u426f2c65gddbc089d25ba5d50@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <739e73230903161921u426f2c65gddbc089d25ba5d50-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peta Blaha <blahapeta-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Tue, Mar 17, 2009 at 03:21:18AM +0100, Peta Blaha wrote:
> Driver for Fortius 1942 device.
> 
> Signed-off-by: Petr Blaha <blahapeta-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
> 
> --- a/drivers/input/joystick/fortius_1942.c.orig 1970-01-01
> 01:00:00.000000000 +0100

Your patch is linewrapped :(

> +++ b/drivers/input/joystick/fortius_1942.c 2009-03-17 03:17:01.000000000 +0100
> @@ -0,0 +1,394 @@
> +/*
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.

Are you sure about "any later version"?
> + unsigned long difference = 0;
> + /*time measure*/
> + struct timeval time, time_before;
> + /*guessed fastest speed a man can possibly ride-incitating full
> + throttle*/
> + unsigned int fastest_wheel_rotate = 1000;
> + /*actual state of path reached in one cycle*/
> + unsigned int ride = 0, old_ride = 0;

These should all be static.

Have you run your code through scripts/checkpatch.pl?

> +struct usb_tfor {
> + char name[128];

Tabs are eaten by your email client :(

Care to try again?

thanks,

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
