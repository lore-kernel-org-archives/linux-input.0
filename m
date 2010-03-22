From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH v2 2/6] hid: add framebuffer support to PicoLCD device
Date: Mon, 22 Mar 2010 09:56:38 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1003220955000.18642@pobox.suse.cz>
References: <20100320170014.440959a8@neptune.home> <20100320170415.6ee219c8@neptune.home> <45a44e481003210024l2c66938fp9436d34f6473f811@mail.gmail.com> <20100321171128.324a606f@neptune.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100321171128.324a606f@neptune.home>
Sender: linux-kernel-owner@vger.kernel.org
To: =?ISO-8859-15?Q?Bruno_Pr=E9mont?= <bonbons@linux-vserver.org>
Cc: Jaya Kumar <jayakumar.lkml@gmail.com>, linux-input@vger.kernel.org, linux-usb@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, "Rick L. Vinyard Jr." <rvinyard@cs.nmsu.edu>, Nicu Pavel <npavel@ituner.com>, Oliver Neukum <oliver@neukum.org>
List-Id: linux-input@vger.kernel.org

On Sun, 21 Mar 2010, Bruno Pr=C3=A9mont wrote:

> > > ---
> > > =C2=A0drivers/hid/Kconfig =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A07 +=
-
> > > =C2=A0drivers/hid/hid-picolcd.c | =C2=A0454 +++++++++++++++++++++=
++++++++++++++++++++++++
> > > =C2=A02 files changed, 460 insertions(+), 1 deletions(-)
> >=20
> > It is customary for framebuffer drivers to live in drivers/video. T=
his
> > is the first one I've reviewed that is outside of it. Is there a go=
od
> > reason for this one to be outside of it? If so, could you put it in
> > the comments.
>=20
> I've kept all the pieces of PicoLCD driver together under hid,
> as it's a HID based device. Framebuffer is just one of its features a=
nd
> keeping pieces together makes it easier to handle.

I think it makes sense for a HID driver for this device to contain the=20
framebuffer bits as well ... from user perspective, this seems to be HI=
D=20
device, with "extra" framebuffer display on it.

If framebuffer folks Ack the fb-related code, I am fine keeping it unde=
r=20
drivers/hid.

Thanks,

--=20
Jiri Kosina
SUSE Labs, Novell Inc.
