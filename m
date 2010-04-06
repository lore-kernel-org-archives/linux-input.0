From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: [PATCH mmotm] hid-picolcd: depends on LCD_CLASS_DEVICE
Date: Tue, 6 Apr 2010 09:56:33 -0700
Message-ID: <20100406095633.49ec957a.randy.dunlap@oracle.com>
References: <201004052336.o35NaeSE015814@imap1.linux-foundation.org>
	<20100405220414.9d90da83.randy.dunlap@oracle.com>
	<alpine.LNX.2.00.1004061038510.8345@pobox.suse.cz>
	<20100406105635.5384a087@pluto.restena.lu>
	<20100406082614.79aaf1c5.randy.dunlap@oracle.com>
	<20100406183535.7de3c628@neptune.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rcsinet12.oracle.com ([148.87.113.124]:51547 "EHLO
	rcsinet12.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757076Ab0DFQ5J convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 6 Apr 2010 12:57:09 -0400
In-Reply-To: <20100406183535.7de3c628@neptune.home>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bruno =?ISO-8859-1?Q?Pr=E9mont?= <bonbons@linux-vserver.org>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, rvinyard@cs.nmsu.edu

On Tue, 6 Apr 2010 18:35:35 +0200 Bruno Pr=E9mont wrote:

> On Tue, 06 April 2010 Randy Dunlap <randy.dunlap@oracle.com> wrote:
> > On Tue, 6 Apr 2010 10:56:35 +0200 Bruno Pr=E9mont wrote:
> >=20
> > > On Tue, 6 Apr 2010 10:40:06 +0200 Jiri Kosina <jkosina@suse.cz> w=
rote:
> > > >=20
> > > > [ adding Bruno to CC ]
> > > >=20
> > > > On Mon, 5 Apr 2010, Randy Dunlap wrote:
> > > >=20
> > > > > From: Randy Dunlap <randy.dunlap@oracle.com>
> > > > >=20
> > > > > HID_PICOLCD should depend on LCD_CLASS_DEVICE, otherwise the
> > > > > build fails when HID_PICOLCD=3Dy and LCD_CLASS_DEVICE=3Dm:
> > > > >=20
> > > > > hid-picolcd.c:(.text+0x84523f): undefined reference to `lcd_d=
evice_unregister'
> > > > > hid-picolcd.c:(.text+0x8478ab): undefined reference to `lcd_d=
evice_register'
> > > > > hid-picolcd.c:(.text+0x84c15f): undefined reference to `lcd_d=
evice_unregister'
> > >=20
> > > That is weird, the
> > >=20
> > > #if defined(CONFIG_LCD_CLASS_DEVICE) || defined(CONFIG_LCD_CLASS_=
DEVICE_MODULE)
> > >   feature support code
> > > #else
> > >   empty stubs
> > > #endif
> > >=20
> > > blocks should have prevented LCD_CLASS support from being built i=
f it
> > > was not enabled in configuration.
> > >=20
> > > Do you have the .config matching your build?
> >=20
> > Yes, it's attached.
>=20
> Thanks, here is the extract (only the pertinent items):
> CONFIG_BACKLIGHT_LCD_SUPPORT=3Dy
> CONFIG_LCD_CLASS_DEVICE=3Dm
> CONFIG_BACKLIGHT_CLASS_DEVICE=3Dy
> CONFIG_HID_PICOLCD=3Dy
>=20
> It triggers the issue by having PicoLCD built-in while one of the
> optional dependencies as a module.

Yes, basically what the patch description said.

> Any idea of how this can be solved with kbuild in order to keep the
> dependencies optional?
>=20
> Something that would satisfy the following pseudocode:
>   if CONFIG_HID_PICOLCD =3D=3D y
>     assert(CONFIG_LCD_CLASS_DEVICE !=3D m)
>=20

If you don't want the kconfig machinery to do that (it appears that you=
 don't),
then I guess that you'll need to expand the source code to handle
CONFIG_LCD_CLASS_DEVICE=3Dy and CONFIG_LCD_CLASS_DEVICE=3Dm differently=
=2E
Or only handle them differently if HID_PICOLCD=3Dy.  :(


>=20
> One of my attempts did end up with a circular loop with regard to FB
> (some of the FB drivers did select INPUT)?

  (not that I can find)

CONFIG_VT does select INPUT
and CONFIG_DRM_I915 does
	select INPUT if ACPI


> I had something like:
>=20
> config HID_PICOLCD
>   tristate ...
>=20
> config HID_PICOLCD_FB
>   bool ...
>   depends on HID_PICOLCD
>   select FB
>   select FB_...
>=20
> ...
>=20
> Then in the code I checked for CONFIG_HID_PICOLCD_FB instead of
> (CONFIG_FB or CONFIG_FB_MODULE).



---
~Randy
(re)read Documentation/ManagementStyle
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
