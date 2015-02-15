From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: Dell ALPS patches for Dell Latitude 7250 & 7450
Date: Sun, 15 Feb 2015 17:38:36 +0100
Message-ID: <201502151738.36559@pali>
References: <201502101419.53861@pali> <54DB0712.4050306@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2102820.zSLYykXaaU";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wg0-f49.google.com ([74.125.82.49]:63263 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754493AbbBOQij (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 15 Feb 2015 11:38:39 -0500
In-Reply-To: <54DB0712.4050306@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Vadim Klishko <vadim@cirque.com>

--nextPart2102820.zSLYykXaaU
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wednesday 11 February 2015 08:38:58 Hans de Goede wrote:
> Thanks for this and the other related mail. I also have an
> alps.c directly from alps themselves which adds support for
> v8 and v9 protocols. The problem is that like with v7 the
> code is not really in a state where we want to take it as is,
> e.g. it does clickpad softbutton emulation in the kernel
> instead of leaving it to userspace.
>=20
> I spend a considerable amount of time cleaning up the alps
> code itself and then adding a cleaner version of the v7 code,
> we should do the same for the v8 and v9 code probably but
> that requires someone with hardware access so that we can
> actually test the end result.
>=20
> Regards,
>=20
> Hans

Ok. Hans, can you look at least on second one patch?
http://www.spinics.net/lists/linux-input/msg36554.html

This is a bit shorter patch and maybe easier to review and decide=20
if is needed or not...

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart2102820.zSLYykXaaU
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlTgy4wACgkQi/DJPQPkQ1LtGQCcCm0jy4gvPWcPLJc5JgOOvxcG
S4YAn0aPSY8hjI26awOA1jkadVxJVsvf
=WhEA
-----END PGP SIGNATURE-----

--nextPart2102820.zSLYykXaaU--
