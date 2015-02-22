From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH] Add a quirk for the Dell XPS 13 (2015) when in PS/2 mode.
Date: Sun, 22 Feb 2015 17:55:05 +0100
Message-ID: <201502221755.05587@pali>
References: <1424310180-2512-1-git-send-email-mario_limonciello@dell.com> <201502202141.16017@pali> <54E7A567.5030501@dell.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2380155.kuSWhSUare";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wg0-f41.google.com ([74.125.82.41]:57327 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751965AbbBVQzJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 22 Feb 2015 11:55:09 -0500
In-Reply-To: <54E7A567.5030501@dell.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mario Limonciello <mario_limonciello@dell.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, LKML <linux-kernel@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Rob <robr.bensson@gmail.com>

--nextPart2380155.kuSWhSUare
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Friday 20 February 2015 22:21:43 Mario Limonciello wrote:
> On 02/20/2015 02:41 PM, Pali Roh=C3=A1r wrote:
> > On Friday 20 February 2015 20:56:23 Mario Limonciello wrote:
> > I have BIOS version A05 on my E6440 machine. That version
> > does not have problems with "repeating keys" and my
> > workaround for ALPS touchpad (which is in mainline tree and
> > -stable trees now) works fine. If I do not see other
> > problems, I will not update BIOS (just because current
> > version working -- with workarounds).
> >=20
> > But CCing Rob. He told me as first about existence of new
> > BIOS version for E6440 and he is already testing new
> > version of BIOS, so can share details.
> >=20
> > Mario, can you share some details about that new BIOS
> > update? If it is not secret, how was problem with
> > "repeating keys" fixed? Why linux had more problems as
> > Windows? Cannot we implement some "workaround" in linux
> > kernel to prevent that (or similar) problems in future?
>=20
> It's a bit ironic really.  The problem was introduced because
> a timer was added to the EC last year to fix a key repeating
> problem found on Windows.  In doing so the EC was blocking
> "BREAK" from being sent to the OS.  Windows OS didn't mind
> this, but Linux did. The fix doesn't block BREAK anymore.
>=20

Thank you for information!

Mario, do you know if it is possible to "switch" keyboard into=20
mode under which Fn key will send scancode (like Ctrl or Alt)=20
when presses, so it could be possible to use any Fn+key=20
combination for keyboard shortcuts? Because now Fn+F* send one=20
scancode (e.g. suspend key) and other combination of Fn+something=20
does not work...

Dmitry, should not Linux follow this Windows input behaviour? For=20
year we have seen people complaining about non working keyboard=20
on Dell laptops under Linux (when user Windows it worked)...

Now that BIOS/EC problem is fixed for some dell laptops (probably=20
new versions of BIOSes for other modules will be released too),=20
but it is really bad to see *new* laptop (with broken BIOS) that=20
does not work under Linux (and work under Windows)...

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart2380155.kuSWhSUare
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlTqCekACgkQi/DJPQPkQ1K1ywCfT6xDkrpSNJBf1rxT1qkc7Q5x
E1MAnRb+vXnxTYVVKBpURCfJHZsh3fSM
=MyVb
-----END PGP SIGNATURE-----

--nextPart2380155.kuSWhSUare--
