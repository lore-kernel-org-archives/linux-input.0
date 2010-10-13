From: Antonio Ospite <ospite@studenti.unina.it>
Subject: Re: [RFC, PATCH 0/2] Enable setting leds via hidraw on Sixaxis
Date: Thu, 14 Oct 2010 00:27:22 +0200
Message-ID: <20101014002722.9884ff26.ospite@studenti.unina.it>
References: <4CA9DD89.2010106@signal11.us>
	<1287003458-3791-1-git-send-email-ospite@studenti.unina.it>
	<4CB62F69.1070809@signal11.us>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Thu__14_Oct_2010_00_27_22_+0200_F3seOTz0mqZrQ0+S"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp206.alice.it ([82.57.200.102]:59770 "EHLO smtp206.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751301Ab0JMW1n (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 13 Oct 2010 18:27:43 -0400
In-Reply-To: <4CB62F69.1070809@signal11.us>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Ott <alan@signal11.us>
Cc: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Jim Paris <jim@jtan.com>, Ranulf Doswell <ralf@ranulf.net>, Mikko =?ISO-8859-1?Q?Vi?= =?ISO-8859-1?Q?rkkil=E4?= <mvirkkil@cc.hut.fi>, falktx@gmail.com

--Signature=_Thu__14_Oct_2010_00_27_22_+0200_F3seOTz0mqZrQ0+S
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 13 Oct 2010 18:15:05 -0400
Alan Ott <alan@signal11.us> wrote:

> On 10/13/2010 04:57 PM, Antonio Ospite wrote:
> > Hi,
> >
> > this series adds a new quirk to force output reports to be sent over the
> > control endpoint rather than the interrupt ep, this is needed on our
> > "beloved" Sixaxis controller in order to set leds via hidraw, sending
> > the output report on the interrupt endpoint does not have any effect
> > whatsoever.
> >
> > This is just an RFC for now, the quirk name can be improved, and I have
> > to make clear in the code and in the commit messages if this is for
> > hidraw only, but you can get the idea already.
> >
> > Thanks,
> >     Antonio
> >
> >
> > Antonio Ospite (2):
> >    HID: usbhid, new quirk to force out reports on the control ep
> >    HID: hid-sony, use HID_QUIRK_FORCE_OUT_CONTROL_EP for Sixaxis
> >
> >   include/linux/hid.h           |    1 +
> >   drivers/hid/hid-sony.c        |    4 +++-
> >   drivers/hid/usbhid/hid-core.c |    3 ++-
> >   3 files changed, 6 insertions(+), 2 deletions(-)
> >
> >
> >   =20
>=20
> Hi Antonio,
>=20
> If it were me, I'd just call usb_control_msg() from inside your driver=20
> (hid-sony) instead of calling usbhid_output_report(). What's wrong with=20
> doing that?
>

Alan, yeah, _overriding_ the usbhid_output_report() method with another
function which performs usb_control_msg() unconditionally could work; I
am giving that a try.

Thanks,
   Antonio

--=20
Antonio Ospite
http://ao2.it

PGP public key ID: 0x4553B001

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?

--Signature=_Thu__14_Oct_2010_00_27_22_+0200_F3seOTz0mqZrQ0+S
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAky2MkoACgkQ5xr2akVTsAEOjwCeMrUJL1NeJbpvNqoKXBcnVaf4
CSAAoI+wKvrRjgJs+8bFF3i9K70z25Xq
=dOfK
-----END PGP SIGNATURE-----

--Signature=_Thu__14_Oct_2010_00_27_22_+0200_F3seOTz0mqZrQ0+S--
