From: Jaya Kumar <jayakumar.lkml-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] hid Logitech G13 Driver 0.0.5
Date: Wed, 3 Mar 2010 07:23:37 +0800
Message-ID: <45a44e481003021523h4a05a9bfu9691f2c0f2f053c7@mail.gmail.com>
References: <201003021848.o22ImLSS004394@mustang.cs.nmsu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <201003021848.o22ImLSS004394-wBm1UmGkUFOpxMv/W9li2JVzexx5G7lz@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Rick L. Vinyard Jr." <rvinyard-qcTL/1vZYtiVc3sceRu5cw@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org, pavel-+ZI9xUNit7I@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, npavel-VxACSXvuqMTQT0dZR+AlfA@public.gmane.org, tomi.valkeinen-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, FlorianSchandinat-Mmb7MZpHnFY@public.gmane.org, krzysztof.h1-5tc4TXWwyLM@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jkosina-AlSwsSmVLrQ@public.gmane.org, bonbons-ud5FBsm0p/xEiooADzr8i9i2O/JbrIOy@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Wed, Mar 3, 2010 at 2:48 AM, Rick L. Vinyard Jr.
<rvinyard-qcTL/1vZYtiVc3sceRu5cw@public.gmane.org> wrote:
> [PATCH] hid Logitech G13 Driver 0.0.5

Hi Rick,

Thanks for posting this. It has improved a lot.

>
> This driver relies on two patches:
> =A01. Bruno Pr=E9mont's [PATCH 2/3] hid: add suspend/resume hooks for=
 hid drivers
> =A02. [PATCH] Add sysfs support for fbdefio delay

Please help me understand in what way does this patch have to have the
global userspace exposure of defio delay in sysfs support. If that
sysfs patch was not accepted, I don't see this patch affected
negatively.

> However, the driver does use the HID feature reports extensively to
> control the backlight, LEDs, et. al.

Ok.

> - Removed the update rate sysfs attribute as it is in the second patc=
h above.

Why? There is no consensus that exposing defio delay for _all_ fb
drivers is a good idea. I would rather you left that in here for now.

> +/*
> + * This is a default logo to be loaded upon driver initialization
> + * replacing the default Logitech G13 image loaded on device
> + * initialization. This is to provide the user a cue that the
> + * Linux driver is loaded and ready.
> + *
> + * This logo contains the text G13 in the center with two penguins
> + * on each side of the text. The penguins are a 33x40 rendition of
> + * the default framebuffer 80x80 monochrome image scaled down and
> + * cleaned up to retain something that looks a little better than
> + * a simple scaling.
> + *
> + * This logo is a simple xbm image created in GIMP and exported.
> + * To view the image copy the following two #defines plus the
> + * g13_lcd_bits to an ASCII text file and save with extension
> + * .xbm, then open with GIMP or any other graphical editor
> + * such as eog that recognizes the .xbm format.
> + */
=2E..
> +static unsigned char g13_lcd_bits[] =3D {
> + 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0=
x00,

I think you'll agree above is not an elegant solution.

> +
> +static DEVICE_ATTR(rgb, 0666, g13_rgb_show, g13_rgb_store);

Reading above code, it looks like this new userspace sysfs attribute
is for backlight control. Could that be better exposed using the
existing backlight class?

Thanks,
jaya
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
