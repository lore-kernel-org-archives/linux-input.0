From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: [PATCH] Logitech G13 driver (fixed cc list --- ignore others)
Date: Mon, 4 Jan 2010 23:48:17 +0100
Message-ID: <20100104224817.GA21695@elf.ucw.cz>
References: <200912142122.nBELMW7d001243@mustang.cs.nmsu.edu>
 <20091216103423.GE1377@ucw.cz>
 <alpine.LNX.2.00.0912161504360.3755@pobox.suse.cz>
 <7f9100aac5f9b06ec78efff25c7a5a71.squirrel@intranet.cs.nmsu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <7f9100aac5f9b06ec78efff25c7a5a71.squirrel-2xSMGd46i5akveL4JqN78fZ8FUJU4vz8@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Rick L. Vinyard, Jr." <rvinyard-qcTL/1vZYtiVc3sceRu5cw@public.gmane.org>
Cc: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, krzysztof.h1-5tc4TXWwyLM@public.gmane.org, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hi!

> > Well, the device is still primarily HID device in its nature, so either
> > keeping the whole driver in drivers/hid, or separating it into two
> > drivers, one for the HID part and second for the framebuffer part should
> > be acceptable.
> 
> The framebuffer part uses the same interrupt endpoint for both HID and
> display. IIRC there were issues with two drivers using the same interrupt
> endpoint.

Ok, but I guess you should cc auxdisplay people in future.

> >> I'd prefer to go without another logo. Just make sure default penguin
> >> gets
> >> there or something.
> >
> > What logo is this, BTW? :)
> 
> It's similar to the default G13 load image, but with tux on the left and
> the GNU gnu on the right.
> 
> I tried to particularly clean up tux a bit since the default monochrome
> logo is 80x80 and the display is 160x43.
> 
> The only alternatives I could think of were to use the default logo and
> load it at 80x43 which cuts off Tux at the nipples, resample in the
> driver, or leave the logo off.

Or put something simple&stupid there like checkerboard?

Or just resample penguin -- skipping every second line should not be
particulary hard...
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
