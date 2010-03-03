From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: [PATCH] hid Logitech G13 Driver 0.0.5
Date: Wed, 3 Mar 2010 06:13:12 +0100
Message-ID: <20100303051311.GA4651@elf.ucw.cz>
References: <201003021848.o22ImLSS004394@mustang.cs.nmsu.edu>
 <45a44e481003021523h4a05a9bfu9691f2c0f2f053c7@mail.gmail.com>
 <24ab70ff629c48b6d10ce0cf6dc5d64b.squirrel@intranet.cs.nmsu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <24ab70ff629c48b6d10ce0cf6dc5d64b.squirrel-2xSMGd46i5akveL4JqN78fZ8FUJU4vz8@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Rick L. Vinyard, Jr." <rvinyard-qcTL/1vZYtiVc3sceRu5cw@public.gmane.org>
Cc: Jaya Kumar <jayakumar.lkml-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, npavel-VxACSXvuqMTQT0dZR+AlfA@public.gmane.org, tomi.valkeinen-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, florianschandinat-Mmb7MZpHnFY@public.gmane.org, krzysztof.h1-5tc4TXWwyLM@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jkosina-AlSwsSmVLrQ@public.gmane.org, bonbons-ud5FBsm0p/xEiooADzr8i9i2O/JbrIOy@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hi!

> >> +/*
> >> + * This is a default logo to be loaded upon driver initialization
> >> + * replacing the default Logitech G13 image loaded on device
> >> + * initialization. This is to provide the user a cue that the
> >> + * Linux driver is loaded and ready.
> >> + *
> >> + * This logo contains the text G13 in the center with two penguins
> >> + * on each side of the text. The penguins are a 33x40 rendition of
> >> + * the default framebuffer 80x80 monochrome image scaled down and
> >> + * cleaned up to retain something that looks a little better than
> >> + * a simple scaling.
> >> + *
> >> + * This logo is a simple xbm image created in GIMP and exported.
> >> + * To view the image copy the following two #defines plus the
> >> + * g13_lcd_bits to an ASCII text file and save with extension
> >> + * .xbm, then open with GIMP or any other graphical editor
> >> + * such as eog that recognizes the .xbm format.
> >> + */
> > ...
> >> +static unsigned char g13_lcd_bits[] = {
> >> + 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> >> 0x00,
> >
> > I think you'll agree above is not an elegant solution.
> 
> I could make it a config option.

You get about 10 complains already, but you are not willing to solve
it. No, config option does not help.

If you want to, make it separate patch so we can reject it separately.

> >> +static DEVICE_ATTR(rgb, 0666, g13_rgb_show, g13_rgb_store);
> >
> > Reading above code, it looks like this new userspace sysfs attribute
> > is for backlight control. Could that be better exposed using the
> > existing backlight class?
> >
> 
> I looked at the backlight class and it didn't seem to be a very good fit.
> 
> /* This structure defines all the properties of a backlight */
> struct backlight_properties {
> 	/* Current User requested brightness (0 - max_brightness) */
> 	int brightness;
> 	/* Maximal value for brightness (read-only) */
> 	int max_brightness;
> 	/* Current FB Power mode (0: full on, 1..3: power saving
> 	   modes; 4: full off), see FB_BLANK_XXX */
> 	int power;
> 	/* FB Blanking active? (values as for power) */
> 	/* Due to be removed, please use (state & BL_CORE_FBBLANK) */
> 	int fb_blank;
> 	/* Flags used to signal drivers of state changes */
> 	/* Upper 4 bits are reserved for driver internal use */
> 	unsigned int state;
> };
> 
> The g13's backlight doesn't support any of these properties. All you can
> set is an rgb value on the g13; no power modes, no brightness, etc. I
> could add a brightness attribute by scaling the rgb values, but I would
> prefer to do that from userspace rather than the driver since it's not
> supported in the device itself.
> 
> And, we'd still have to have the rgb attribute since the backlight class
> doesn't have color.

Or you could pretend you have 3 different backlights? ....which is
actually what you have...?
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
