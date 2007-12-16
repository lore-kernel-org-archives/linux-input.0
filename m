From: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: [argyllcms] Re: [PATCH] usb/hid: Blacklist the Gretag-Macbeth
 Huey display	colorimeter
Date: Sun, 16 Dec 2007 17:59:28 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0712161756480.12449@jikos.suse.cz>
References: <1197585460.28927.2.camel@rousalka.dyndns.org>
 <20071214053853.GD7765@kroah.com>  <1197626696.5281.5.camel@rousalka.dyndns.org>
  <47626D00.202@argyllcms.com> <1197634579.2766.8.camel@rousalka.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1197634579.2766.8.camel-mHT02fcw9gwi5CQI31g/s0B+6BGkLq7r@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nicolas Mailhot <nicolas.mailhot-QFKgK+z4sOrR7s880joybQ@public.gmane.org>
Cc: argyllcms-uGLqWuYN4qMgsBAKwltoeQ@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Frederic Crozat <fcrozat-4qZELD6FgxhWk0Htik3J/w@public.gmane.org>, Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Fri, 14 Dec 2007, Nicolas Mailhot wrote:

> > Actually (to put it frankly), I'm amazed that this exceptions list is 
> > compiled into the driver. I would have thought that such a list should 
> > at least be in a configuration file that an installed application can 
> > add or delete, if not something more sophisticated.
> Something more sophisticated will happen someday, this is what we have
> now.

There is also possibility (for quite a few releases already) to change the 
quirk list in runtime. See the 'quirk' parameter to the usbhid module.

> > What will happen if the HID driver is fixed to allow arbitrary 
> > messages, and I want to switch back to using it rather than libusb ?

What exactly is the problem here? I didn't seem to catch the beginning of 
the thread (or it happened off the list I am subscribed to).

I will apply the patch to my tree, thanks.

-- 
Jiri Kosina
SUSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
