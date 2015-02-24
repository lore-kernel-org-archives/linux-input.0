From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH] Add a quirk for the Dell XPS 13 (2015) when in PS/2 mode.
Date: Tue, 24 Feb 2015 01:01:45 +0100
Message-ID: <201502240101.45446@pali>
References: <1424310180-2512-1-git-send-email-mario_limonciello@dell.com> <201502221755.05587@pali> <54EBB868.2040405@dell.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3784640.IZiqhOh6kV";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:47784 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751845AbbBXABt (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 23 Feb 2015 19:01:49 -0500
In-Reply-To: <54EBB868.2040405@dell.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mario Limonciello <mario_limonciello@dell.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, LKML <linux-kernel@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Rob <robr.bensson@gmail.com>

--nextPart3784640.IZiqhOh6kV
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tuesday 24 February 2015 00:31:52 Mario Limonciello wrote:
> On 02/22/2015 10:55 AM, Pali Roh=C3=A1r wrote:
> > Thank you for information!
>=20
> Sure, no problem.
>=20
> > Mario, do you know if it is possible to "switch" keyboard
> > into mode under which Fn key will send scancode (like Ctrl
> > or Alt) when presses, so it could be possible to use any
> > Fn+key combination for keyboard shortcuts? Because now
> > Fn+F* send one scancode (e.g. suspend key) and other
> > combination of Fn+something does not work...
>=20
> Sorry, this is not possible with today's BIOS and EC as I am
> aware. I'll inquire about this for the future though.
>=20

=46or older dell models (some old inspirions and maybe also=20
latitude) it was possible to use undocumented DELLDIAG interface=20
(which enter into SMM mode and call some functions) to enable=20
that "RAW" mode.

Now when you are discussing with us, do you have some information=20
or can you comment (if it is not secret) that DELLDIAG SMM=20
interface?

In linux kernel we have for it driver (provides info about=20
temperature, fan speed, power management, hotkeys, ...), but it=20
use undocumented interface (and sometimes it has problems):

https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/driver=
s/char/i8k.c

> > Dmitry, should not Linux follow this Windows input
> > behaviour? For year we have seen people complaining about
> > non working keyboard on Dell laptops under Linux (when user
> > Windows it worked)...
>=20
> This is a bit surprising to me.  Completely non-working?  Or
> similar problem to what's getting fixed in the BIOS update we
> discussed above?
>=20

Nothing new. It is that problem with repeating keys which is=20
fixed by last version of BIOS.

I saw one E6440 model with preinstalled Ubuntu 12.04.2 and=20
distributed with A08 BIOS (which had that problem). And this was=20
very very annoying! You could imagine it, you buy new Latitude=20
(business class pro notebook), you started it and on preinstalled=20
OS, keyboard is not usable. Updating to A10 fixed it.

> > Now that BIOS/EC problem is fixed for some dell laptops
> > (probably new versions of BIOSes for other modules will be
> > released too), but it is really bad to see *new* laptop
> > (with broken BIOS) that does not work under Linux (and work
> > under Windows)...
>=20
> Yes, if you're aware of any models that are not fixed by the
> BIOS update this month, I would be interested to know.  A
> majority of our hardware does undergo testing with Linux
> during development, so usually these types of things are
> caught.  Once we declare a BIOS stable it's a much lengthier
> process to issue future fixes however.

In this forum thread people reported that "repeating keys"=20
problem for more models: http://en.community.dell.com/support-forums/laptop=
/f/3518/t/19593360?pi239031352=3D19

And it looks like (from what I'm reading) last version A10 of=20
E6440 BIOS broke USB3.0 support.

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart3784640.IZiqhOh6kV
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlTrv2kACgkQi/DJPQPkQ1JANgCfa94+1kK8j2NslP8NkYqcxeyl
+zMAoKaelKB+E0FgovcCBcw0HN6kHxSp
=GZ80
-----END PGP SIGNATURE-----

--nextPart3784640.IZiqhOh6kV--
