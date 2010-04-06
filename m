From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
Subject: Re: [PATCH mmotm] hid-picolcd: depends on LCD_CLASS_DEVICE
Date: Tue, 6 Apr 2010 18:35:35 +0200
Message-ID: <20100406183535.7de3c628@neptune.home>
References: <201004052336.o35NaeSE015814@imap1.linux-foundation.org>
	<20100405220414.9d90da83.randy.dunlap@oracle.com>
	<alpine.LNX.2.00.1004061038510.8345@pobox.suse.cz>
	<20100406105635.5384a087@pluto.restena.lu>
	<20100406082614.79aaf1c5.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from legolas.restena.lu ([158.64.1.34]:56416 "EHLO
	legolas.restena.lu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751669Ab0DFQfm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 6 Apr 2010 12:35:42 -0400
In-Reply-To: <20100406082614.79aaf1c5.randy.dunlap@oracle.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, rvinyard@cs.nmsu.edu

On Tue, 06 April 2010 Randy Dunlap <randy.dunlap@oracle.com> wrote:
> On Tue, 6 Apr 2010 10:56:35 +0200 Bruno Pr=C3=A9mont wrote:
>=20
> > On Tue, 6 Apr 2010 10:40:06 +0200 Jiri Kosina <jkosina@suse.cz> wro=
te:
> > >=20
> > > [ adding Bruno to CC ]
> > >=20
> > > On Mon, 5 Apr 2010, Randy Dunlap wrote:
> > >=20
> > > > From: Randy Dunlap <randy.dunlap@oracle.com>
> > > >=20
> > > > HID_PICOLCD should depend on LCD_CLASS_DEVICE, otherwise the
> > > > build fails when HID_PICOLCD=3Dy and LCD_CLASS_DEVICE=3Dm:
> > > >=20
> > > > hid-picolcd.c:(.text+0x84523f): undefined reference to `lcd_dev=
ice_unregister'
> > > > hid-picolcd.c:(.text+0x8478ab): undefined reference to `lcd_dev=
ice_register'
> > > > hid-picolcd.c:(.text+0x84c15f): undefined reference to `lcd_dev=
ice_unregister'
> >=20
> > That is weird, the
> >=20
> > #if defined(CONFIG_LCD_CLASS_DEVICE) || defined(CONFIG_LCD_CLASS_DE=
VICE_MODULE)
> >   feature support code
> > #else
> >   empty stubs
> > #endif
> >=20
> > blocks should have prevented LCD_CLASS support from being built if =
it
> > was not enabled in configuration.
> >=20
> > Do you have the .config matching your build?
>=20
> Yes, it's attached.

Thanks, here is the extract (only the pertinent items):
CONFIG_BACKLIGHT_LCD_SUPPORT=3Dy
CONFIG_LCD_CLASS_DEVICE=3Dm
CONFIG_BACKLIGHT_CLASS_DEVICE=3Dy
CONFIG_HID_PICOLCD=3Dy

It triggers the issue by having PicoLCD built-in while one of the
optional dependencies as a module.

Any idea of how this can be solved with kbuild in order to keep the
dependencies optional?

Something that would satisfy the following pseudocode:
  if CONFIG_HID_PICOLCD =3D=3D y
    assert(CONFIG_LCD_CLASS_DEVICE !=3D m)


One of my attempts did end up with a circular loop with regard to FB
(some of the FB drivers did select INPUT)?

I had something like:

config HID_PICOLCD
  tristate ...

config HID_PICOLCD_FB
  bool ...
  depends on HID_PICOLCD
  select FB
  select FB_...

=2E..

Then in the code I checked for CONFIG_HID_PICOLCD_FB instead of
(CONFIG_FB or CONFIG_FB_MODULE).

Thanks,
Bruno
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
