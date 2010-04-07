From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: [PATCH mmotm] hid-picolcd: depends on LCD_CLASS_DEVICE
Date: Wed, 7 Apr 2010 09:20:10 -0700
Message-ID: <20100407092010.4cd60ece.randy.dunlap@oracle.com>
References: <201004052336.o35NaeSE015814@imap1.linux-foundation.org>
	<20100405220414.9d90da83.randy.dunlap@oracle.com>
	<alpine.LNX.2.00.1004061038510.8345@pobox.suse.cz>
	<20100406105635.5384a087@pluto.restena.lu>
	<20100406082614.79aaf1c5.randy.dunlap@oracle.com>
	<20100406183535.7de3c628@neptune.home>
	<20100406095633.49ec957a.randy.dunlap@oracle.com>
	<20100406230434.1336c317@neptune.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100406230434.1336c317@neptune.home>
Sender: linux-kernel-owner@vger.kernel.org
To: Bruno =?ISO-8859-1?Q?Pr=E9mont?= <bonbons@linux-vserver.org>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, rvinyard@cs.nmsu.edu
List-Id: linux-input@vger.kernel.org

On Tue, 6 Apr 2010 23:04:34 +0200 Bruno Pr=E9mont wrote:

> On Tue, 06 April 2010 Randy Dunlap <randy.dunlap@oracle.com> wrote:
> > > It triggers the issue by having PicoLCD built-in while one of the
> > > optional dependencies as a module.
> >=20
> > Yes, basically what the patch description said.
>=20
> Oops, sorry I didn't completely read the patch description.
>=20
> > > Any idea of how this can be solved with kbuild in order to keep t=
he
> > > dependencies optional?
> > >=20
> > > Something that would satisfy the following pseudocode:
> > >   if CONFIG_HID_PICOLCD =3D=3D y
> > >     assert(CONFIG_LCD_CLASS_DEVICE !=3D m)
> > >=20
> >=20
> > If you don't want the kconfig machinery to do that (it appears that=
 you don't),
> > then I guess that you'll need to expand the source code to handle
> > CONFIG_LCD_CLASS_DEVICE=3Dy and CONFIG_LCD_CLASS_DEVICE=3Dm differe=
ntly.
> > Or only handle them differently if HID_PICOLCD=3Dy.  :(
>=20
> Below a patch (against 2.6.34-rc3 + Jiri's picolcd branch) which
> should fix above issue keeping the deps optional.
>=20
> With it it's not yet possible to select the deps from HID menu.
>=20
> I did a few oldconfig and compile-tests with PICOLCD=3Dy/m and same f=
or
> the deps (not switched FB for those tests).
>=20
> Bruno
>=20
>=20
>=20
>=20
>=20
> HID_PICOLCD should depend on LCD_CLASS_DEVICE, otherwise the
> build fails when HID_PICOLCD=3Dy and LCD_CLASS_DEVICE=3Dm:
>=20
> hid-picolcd.c:(.text+0x84523f): undefined reference to `lcd_device_un=
register'
> hid-picolcd.c:(.text+0x8478ab): undefined reference to `lcd_device_re=
gister'
> hid-picolcd.c:(.text+0x84c15f): undefined reference to `lcd_device_un=
register'
>=20
> Reported-by: Randy Dunlap <randy.dunlap@oracle.com>
> Signed-off-by: Bruno Pr=E9mont <bonbons@linux-vserver.org>
>=20
> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> index a2ecd83..39df4f5 100644
> --- a/drivers/hid/Kconfig
> +++ b/drivers/hid/Kconfig
> @@ -285,6 +285,35 @@ config HID_PICOLCD
>  	  Features that are not (yet) supported:
>  	  - IR
> =20

All of these user-visible kconfig options need help text also...

> +config HID_PICOLCD_FB
> +	bool "Framebuffer support"
> +	default !EMBEDDED
> +	depends on HID_PICOLCD
> +	depends on HID_PICOLCD=3DFB || FB=3Dy
> +	select FB_DEFERRED_IO
> +	select FB_SYS_FILLRECT
> +	select FB_SYS_COPYAREA
> +	select FB_SYS_IMAGEBLIT
> +	select FB_SYS_FOPS
> +
> +config HID_PICOLCD_BACKLIGHT
> +	bool "Backlight control"
> +	default !EMBEDDED
> +	depends on HID_PICOLCD
> +	depends on HID_PICOLCD=3DBACKLIGHT_CLASS_DEVICE || BACKLIGHT_CLASS_=
DEVICE=3Dy
> +
> +config HID_PICOLCD_LCD
> +	bool "Contrast control"
> +	default !EMBEDDED
> +	depends on HID_PICOLCD
> +	depends on HID_PICOLCD=3DLCD_CLASS_DEVICE || LCD_CLASS_DEVICE=3Dy
> +
> +config HID_PICOLCD_LEDS
> +	bool "GPO via leds class"
> +	default !EMBEDDED
> +	depends on HID_PICOLCD
> +	depends on HID_PICOLCD=3DLEDS_CLASS || LEDS_CLASS=3Dy
> +
>  config HID_QUANTA
>  	tristate "Quanta Optical Touch"
>  	depends on USB_HID


---
~Randy
