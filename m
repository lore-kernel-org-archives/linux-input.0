From: Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [PATCH] hid Logitech G13 Driver 0.0.5
Date: Sat, 19 Jun 2010 17:57:21 +0200
Message-ID: <201006191757.22035.marek.vasut@gmail.com>
References: <201003021848.o22ImLSS004394@mustang.cs.nmsu.edu> <24ab70ff629c48b6d10ce0cf6dc5d64b.squirrel@intranet.cs.nmsu.edu> <20100303051311.GA4651@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100303051311.GA4651@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: "Rick L. Vinyard, Jr." <rvinyard@cs.nmsu.edu>, Jaya Kumar <jayakumar.lkml@gmail.com>, linux-kernel@vger.kernel.org, felipe.balbi@nokia.com, linux-usb@vger.kernel.org, oliver@neukum.org, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, npavel@ituner.com, tomi.valkeinen@nokia.com, tony@atomide.com, florianschandinat@gmx.de, krzysztof.h1@wp.pl, akpm@linux-foundation.org, linux-fbdev@vger.kernel.org, jkosina@suse.cz, bonbons@linux-vserver.org
List-Id: linux-input@vger.kernel.org

Dne St 3. b=C5=99ezna 2010 06:13:12 Pavel Machek napsal(a):
> Hi!
>=20
> > >> +/*
> > >> + * This is a default logo to be loaded upon driver initializati=
on
> > >> + * replacing the default Logitech G13 image loaded on device
> > >> + * initialization. This is to provide the user a cue that the
> > >> + * Linux driver is loaded and ready.
> > >> + *
> > >> + * This logo contains the text G13 in the center with two pengu=
ins
> > >> + * on each side of the text. The penguins are a 33x40 rendition=
 of
> > >> + * the default framebuffer 80x80 monochrome image scaled down a=
nd
> > >> + * cleaned up to retain something that looks a little better th=
an
> > >> + * a simple scaling.
> > >> + *
> > >> + * This logo is a simple xbm image created in GIMP and exported=
=2E
> > >> + * To view the image copy the following two #defines plus the
> > >> + * g13_lcd_bits to an ASCII text file and save with extension
> > >> + * .xbm, then open with GIMP or any other graphical editor
> > >> + * such as eog that recognizes the .xbm format.
> > >> + */
> > >=20
> > > ...
> > >=20
> > >> +static unsigned char g13_lcd_bits[] =3D {
> > >> + 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x=
00,
> > >> 0x00,
> > >=20
> > > I think you'll agree above is not an elegant solution.
> >=20
> > I could make it a config option.
>=20
> You get about 10 complains already, but you are not willing to solve
> it. No, config option does not help.
>=20
> If you want to, make it separate patch so we can reject it separately=
=2E
>=20
> > >> +static DEVICE_ATTR(rgb, 0666, g13_rgb_show, g13_rgb_store);
> > >=20
> > > Reading above code, it looks like this new userspace sysfs attrib=
ute
> > > is for backlight control. Could that be better exposed using the
> > > existing backlight class?
> >=20
> > I looked at the backlight class and it didn't seem to be a very goo=
d fit.
> >=20
> > /* This structure defines all the properties of a backlight */
> > struct backlight_properties {
> >=20
> > 	/* Current User requested brightness (0 - max_brightness) */
> > 	int brightness;
> > 	/* Maximal value for brightness (read-only) */
> > 	int max_brightness;
> > 	/* Current FB Power mode (0: full on, 1..3: power saving
> > =09
> > 	   modes; 4: full off), see FB_BLANK_XXX */
> > =09
> > 	int power;
> > 	/* FB Blanking active? (values as for power) */
> > 	/* Due to be removed, please use (state & BL_CORE_FBBLANK) */
> > 	int fb_blank;
> > 	/* Flags used to signal drivers of state changes */
> > 	/* Upper 4 bits are reserved for driver internal use */
> > 	unsigned int state;
> >=20
> > };
> >=20
> > The g13's backlight doesn't support any of these properties. All yo=
u can
> > set is an rgb value on the g13; no power modes, no brightness, etc.=
 I
> > could add a brightness attribute by scaling the rgb values, but I w=
ould
> > prefer to do that from userspace rather than the driver since it's =
not
> > supported in the device itself.
> >=20
> > And, we'd still have to have the rgb attribute since the backlight =
class
> > doesn't have color.
>=20
> Or you could pretend you have 3 different backlights? ....which is
> actually what you have...?
> 									Pavel

Any updates on this?

btw. it'd be good if we could use the g13fb on G15 ... would that be po=
ssible?
Cheers!
