From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: [PATCH mmotm] hid-picolcd: depends on LCD_CLASS_DEVICE
Date: Wed, 7 Apr 2010 13:12:04 -0700
Message-ID: <20100407131204.10759584.randy.dunlap@oracle.com>
References: <201004052336.o35NaeSE015814@imap1.linux-foundation.org>
	<20100405220414.9d90da83.randy.dunlap@oracle.com>
	<alpine.LNX.2.00.1004061038510.8345@pobox.suse.cz>
	<20100406105635.5384a087@pluto.restena.lu>
	<20100406082614.79aaf1c5.randy.dunlap@oracle.com>
	<20100406183535.7de3c628@neptune.home>
	<20100406095633.49ec957a.randy.dunlap@oracle.com>
	<20100407204404.5233ba6b@neptune.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from acsinet12.oracle.com ([141.146.126.234]:32654 "EHLO
	acsinet12.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751038Ab0DGUNL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 7 Apr 2010 16:13:11 -0400
In-Reply-To: <20100407204404.5233ba6b@neptune.home>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bruno =?ISO-8859-1?Q?Pr=E9mont?= <bonbons@linux-vserver.org>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, rvinyard@cs.nmsu.edu

On Wed, 7 Apr 2010 20:44:04 +0200 Bruno Pr=E9mont wrote:

> On Tue, 06 April 2010 Randy Dunlap <randy.dunlap@oracle.com> wrote:
> > >=20
> > > One of my attempts did end up with a circular loop with regard to=
 FB
> > > (some of the FB drivers did select INPUT)? =20
> >=20
> >   (not that I can find)
> >=20
> > CONFIG_VT does select INPUT
> > and CONFIG_DRM_I915 does
> > 	select INPUT if ACPI
>=20
> A newer attempt still produces the same result:
>=20
> drivers/input/Kconfig:9:error: found recursive dependency: INPUT ->
>        HID_SUPPORT -> HID_PICOLCD_FB -> FB -> FB_STI -> VT -> INPUT
>=20
> (it's only FB which causes the loop, LEDS, LCD and BACKLIGHT are fine=
)

  (yes, so I see)

> This is with following patch on top of the improved deps patch I sent
> a few minutes ago deeper in this thread.
>=20
> Is there a way around this?
>=20

Well, lesson #1 is that select is evil^W^W should only be used to enabl=
e
library-like code, or as Documentation/kbuild/kconfig-language.txt says=
:

  Note:
	select should be used with care. select will force
	a symbol to a value without visiting the dependencies.
	By abusing select you are able to select a symbol FOO even
	if FOO depends on BAR that is not set.
	In general use select only for non-visible symbols
	(no prompts anywhere) and for symbols with no dependencies.
	That will limit the usefulness but on the other hand avoid
	the illegal configurations all over.
	kconfig should one day warn about such things.



(more below)

>=20
> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> index 782a34e..711c091 100644
> --- a/drivers/hid/Kconfig
> +++ b/drivers/hid/Kconfig
> @@ -285,7 +285,7 @@ config HID_PICOLCD_FB
>  	bool "Framebuffer support"
>  	default !EMBEDDED
>  	depends on HID_PICOLCD
> -	depends on HID_PICOLCD=3DFB || FB=3Dy
> +	select FB

If you'll go back to the unpatched (by this patch) version here,
it seems to work OK.

>  	select FB_DEFERRED_IO
>  	select FB_SYS_FILLRECT
>  	select FB_SYS_COPYAREA
> @@ -299,7 +299,8 @@ config HID_PICOLCD_BACKLIGHT
>  	bool "Backlight control"
>  	default !EMBEDDED
>  	depends on HID_PICOLCD
> -	depends on HID_PICOLCD=3DBACKLIGHT_CLASS_DEVICE || BACKLIGHT_CLASS_=
DEVICE=3Dy
> +	select BACKLIGHT_LCD_SUPPORT
> +	select BACKLIGHT_CLASS_DEVICE
>  	---help---
>  	  Provide access to PicoLCD's backlight control via backlight
>  	  class.
> @@ -308,7 +309,8 @@ config HID_PICOLCD_LCD
>  	bool "Contrast control"
>  	default !EMBEDDED
>  	depends on HID_PICOLCD
> -	depends on HID_PICOLCD=3DLCD_CLASS_DEVICE || LCD_CLASS_DEVICE=3Dy
> +	select BACKLIGHT_LCD_SUPPORT
> +	select LCD_CLASS_DEVICE
>  	---help---
>  	  Provide access to PicoLCD's LCD contrast via lcd class.
> =20
> @@ -316,7 +318,8 @@ config HID_PICOLCD_LEDS
>  	bool "GPO via leds class"
>  	default !EMBEDDED
>  	depends on HID_PICOLCD
> -	depends on HID_PICOLCD=3DLEDS_CLASS || LEDS_CLASS=3Dy
> +	select NEW_LEDS
> +	select LEDS_CLASS
>  	---help---
>  	  Provide access to PicoLCD's GPO pins via leds class.


---
~Randy
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
