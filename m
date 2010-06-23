From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] hid Logitech G13 Driver 0.0.5
Date: Wed, 23 Jun 2010 12:30:01 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1006231229230.13809@pobox.suse.cz>
References: <alpine.LNX.2.00.1006211442350.13809@pobox.suse.cz> <d1cda632f4cdb650a68119903473fbb4.squirrel@intranet.cs.nmsu.edu> <20100623122344.372e5f75@neptune.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100623122344.372e5f75@neptune.home>
Sender: linux-kernel-owner@vger.kernel.org
To: =?ISO-8859-15?Q?Bruno_Pr=E9mont?= <bonbons@linux-vserver.org>
Cc: "Rick L. Vinyard, Jr." <rvinyard@cs.nmsu.edu>, Marek Vasut <marek.vasut@gmail.com>, Pavel Machek <pavel@ucw.cz>, Jaya Kumar <jayakumar.lkml@gmail.com>, linux-kernel@vger.kernel.org, felipe.balbi@nokia.com, linux-usb@vger.kernel.org, oliver@neukum.org, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, npavel@ituner.com, tomi.valkeinen@nokia.com, tony@atomide.com, florianschandinat@gmx.de, krzysztof.h1@wp.pl, akpm@linux-foundation.org, linux-fbdev@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, 23 Jun 2010, Bruno Pr=E9mont wrote:

> Please check how your driver behaves if the framebuffer is still in u=
se
> (open and/or mmapped) by some userspace process when you unplug the
> keyboard.
>=20
> Probably you will get hit be the same complaints from kernel I was se=
eing
> with PicoLCD driver (see my patch http://lkml.org/lkml/2010/5/30/15 t=
hat
> is expected to fix it on PicoLCD side, the refcounting part of the pa=
tch)

BTW I'd like to have this fixed, but I haven't seen any Acks from=20
framebuffer people, which I'd really like to have before taking it thro=
ugh=20
my tree.

Thanks,

--=20
Jiri Kosina
SUSE Labs, Novell Inc.
