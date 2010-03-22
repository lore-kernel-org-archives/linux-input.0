From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
Subject: Re: [PATCH v2 3/6] hid: add backlight support to PicoLCD device
Date: Mon, 22 Mar 2010 12:01:16 +0100
Message-ID: <20100322120116.12979762@neptune.home>
References: <20100320170014.440959a8@neptune.home>
	<20100320170619.4ae99546@neptune.home>
	<alpine.LNX.2.00.1003220957390.18642@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LNX.2.00.1003220957390.18642@pobox.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, linux-usb@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, "Rick L. Vinyard Jr." <rvinyard@cs.nmsu.edu>, Nicu Pavel <npavel@ituner.com>, Oliver Neukum <oliver@neukum.org>, Jaya Kumar <jayakumar.lkml@gmail.com>, Richard Purdie <rpurdie@rpsys.net>
List-Id: linux-input@vger.kernel.org

On Mon, 22 March 2010 Jiri Kosina <jkosina@suse.cz> wrote:
> On Sat, 20 Mar 2010, Bruno Pr=C3=A9mont wrote:
>=20
> > Add backlight support to PicoLCD device.
> >=20
> > Backlight support depends on backlight class and is only being
> > compiled if backlight class has been selected.
> >=20
> > Signed-off-by: Bruno Pr=C3=A9mont <bonbons@linux-vserver.org>
> > ---
> >  drivers/hid/Kconfig       |    2 +-
> >  drivers/hid/hid-picolcd.c |  134 +++++++++++++++++++++++++++++++++=
+++++++++++-
> >  2 files changed, 134 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> > index a474bcd..5ec3cb7 100644
> > --- a/drivers/hid/Kconfig
> > +++ b/drivers/hid/Kconfig
> > @@ -243,8 +243,8 @@ config HID_PICOLCD
> >  	  - Keypad
> >  	  - Switching between Firmware and Flash mode
> >  	  - Framebuffer for monochrome 256x64 display
> > +	  - Backlight control    (needs CONFIG_BACKLIGHT_CLASS_DEVICE)
>=20
> Wouldn't it be better to have Kconfig rules actually resolve the=20
> dependency?
>=20
> I don't see any issue with HID_PICOLCD directly selecting=20
> BACKLIGHT_CLASS_DEVICE. Or you can do a separate sub-option for that,=
 if=20
> you really want to avoid the direct dependency of the whole driver.

I could select both BACKLIGHT_CLASS_DEVICE and LCD_CLASS_DEVICE (as
well as their common parent -- same applies to FB) though for the
LEDS_CLASS I would definitely rather go the path of a sub-option, by
default the GPO pins operated with the LEDs are not connected to
anything.

Thanks for the review,
Bruno
