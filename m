From: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
Subject: Re: INPUT_COMPAT_TEST
Date: Fri, 8 Jul 2011 19:44:56 -0300
Message-ID: <20110708224453.GA2705@nautilus.holoscopio.com>
References: <4E17504F.5070806@zytor.com>
 <20110708204630.GA28623@core.coreip.homeip.net>
 <4E178320.7050401@zytor.com>
 <20110708223709.GB28623@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3V7upXqbjpZ4EhLz"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from liberdade2.minaslivre.org ([74.50.53.203]:45570 "EHLO
	liberdade.minaslivre.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752057Ab1GHWpH (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 8 Jul 2011 18:45:07 -0400
Content-Disposition: inline
In-Reply-To: <20110708223709.GB28623@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Philip Langdale <philipl@overt.org>, linux-input@vger.kernel.org, "H.J. Lu" <hjl.tools@gmail.com>


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 08, 2011 at 03:37:09PM -0700, Dmitry Torokhov wrote:
> On Fri, Jul 08, 2011 at 03:22:24PM -0700, H. Peter Anvin wrote:
> > On 07/08/2011 01:46 PM, Dmitry Torokhov wrote:
> > >=20
> > > One such place is evdev read/write - unfortunately "struct input_even=
t"
> > > was not created 32/64 bit safe so we need to mangle it when running 32
> > > bit userspace with 64-bit kernels. See drivers/input/input-compat.c.
> > >=20
> >=20
> > So these are actually present on all the read/write path system calls.
> > That is truly awful.
> >=20
> > Do you happen to know if there is any kind of passing around of file
> > descriptors, or if this could perhaps be tied to file descriptor state.
>=20
> Not sure.
>=20
> >=20
> > > We also have similar issues with uinput API and uploading force-freed=
ack
> > > effects.
> >=20
> > Those are ioctl, though, if I read the code right, or did I miss
> > something obvious?
>=20
> Ah, yes, indeed.
>=20

uinput uses input_event_from_user in its write path. To inject events
into the kernel, one must write struct input_event into uinput. So, in
this case, it's not only ioctl that is affected.

Regards,
Cascardo.

> >=20
> > >> but it looks like input also
> > >> does things like change the format(?!) of sysfs entries, all of which
> > >> makes me very concerned.
> > >=20
> > > Another historical unfortunate decision. /proc/bus/input (and later
> > > added sysfs entries) export bitmaps in "compressed" form so that
> > > userspace can not figure out the size of the segment (32 or 64 bit) on
> > > its own so we have to convert to userspace size for longs.
> >=20
> > "Compressed form"?  Could you give a concrete example?  They look like
> > they are emitted in text form.
>=20
> We drop leading zeroes so if you get "1 0 0 1ffff" you do not know
> the bit position of the most significant '1' unless we keep segments of
> known size. Unfortunately we started with 32 bit segments on 32 bit
> kernels and 64 bit segments on 64 bit kernels so we coudl not simply say
> that we always split on 32 bit boundary when we discovered compat
> problem a few years later.
>=20
> >=20
> > Do you have a program that someone could run to see the differences
> > between compat and non-compat paths?
>=20
> Hmm, cat for /proc/bus/input/devices and sysfs nodes and evtest would
> either work or give garbage if compat code woudl not work.
>=20
> --=20
> Dmitry
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--3V7upXqbjpZ4EhLz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJOF4hkAAoJEEWxSg7udFZI8pcP/2U1arrxy6GczLBibAmOax0o
L2b4Emht8cEUufvpGu9cjU4P5B3LVeIQ+yQGVbEhaDLYitk7zmQyL6w+08gg79jT
unB/g35JZqYYBd3CTXxSkevK+X5d1XfoL3Nlbgin3hlHUU3U6a+BdxC5CoIovkV7
NxN/TKYc7hJzNh/16Hc5tcGZpJlYNu6pfypiZtKw1FMlq/81ITYqv5f/LW1hwqNm
lO38aVpdksVN9DLVONc8ObrxEefmqw+SArMOVJtisC0uGREcHCZc2dKjUtjkVgZP
FO2RHTWWHTFEMlYke5ukH8PDrHQ7/irF71Z7u2swvkUTPqgi482LpaexEyLwuSDu
0765x48CBO0B9cnACJs+a3pfqHCb0C1s/xGD31yB+WeLI/O/m9Qf2ht9XwYEtoWh
7qL3VIWgRuPbd8FkucaR1Eq955cQQAUQ4RT4z/TytckHnnvIaM7oDxvXegdmsa9u
PC2qM4bwN/U7caGZNlMxGxy51FCTFlD0pGuMKZ4lbr5mPgX4lNloSKehKWW/PFaN
UjhO8sBwrrCgz2eMaMA91lJd7Wf45xUg/7ORudEFQ2J3QxYDrFnt/Zi+QerUSw/0
FEJHbpRxqmStFyVjpZ/cDFEMBLjKiCZTfrlz98Y2lOpf+kMF9zSsHjWj4oD8VOil
V4tA6h08FNq9oW/WuFnk
=188r
-----END PGP SIGNATURE-----

--3V7upXqbjpZ4EhLz--
