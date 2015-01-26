From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2 1/2] DT: i2c: Deprecate adi,adxl34x compatible string
Date: Mon, 26 Jan 2015 13:09:47 +0100
Message-ID: <20150126120947.GC1052@katana>
References: <1421333655-31029-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1421333655-31029-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <20150115170209.GA6342@katana>
 <CAMuHMdW7ETcFGSPiE9BWA2dAE93477fzoyF-+_EaiPSDT9WMWA@mail.gmail.com>
 <20150115174333.GC6342@katana>
 <CAMuHMdUwHde0EvbCD574L2tW6qqxLCtZwAb+0M-4QCjB9V6fmQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ctP54qlpMx3WjD+/"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:55888 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751623AbbAZMJw (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 26 Jan 2015 07:09:52 -0500
Content-Disposition: inline
In-Reply-To: <CAMuHMdUwHde0EvbCD574L2tW6qqxLCtZwAb+0M-4QCjB9V6fmQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Linux I2C <linux-i2c@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>


--ctP54qlpMx3WjD+/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> >> If you drop adi,adxl346, checkpatch will start complaining if it encou=
nters
> >> it in a .dts.
> >
> > Boah, this is annoying. That means we need an 346 entry even if it is
> > not different from 345 (which is fine by me).
>=20
> To be clear: you need the entry in the documentation. It can be omitted
> from the driver if it's not (yet) used for matching.

Well, I don't really like that behaviour, but I don't like
i2c/trivial-devices.txt as well, so I'll just apply the patch and live
with it :)


--ctP54qlpMx3WjD+/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUxi6LAAoJEBQN5MwUoCm2HrsP/2sYjISludcqelKR5gHEHa8X
VAFcGFiIsVlu9TQWjDFWMzZnBrmBXGDH46ZT1wijmpGBzN/6UmANqhHQRLJnPthO
30yc7m1DGJxlfEoY/WRHAvbioH8OhFQ3yt+oKd1JZJlhb9Tpf6Alzsr6w/pxz9IO
bSw1ttHqAEDZdjsVyYY/2xiwS4mjbnIcLBwbewzAAb9i0dE7WnK2iqlnZn2jQuUN
RscejLZiF3jxO+vwvWxVuSZaNSvdeT7uI2tVuEm21I7JLF0GzrMJqnmJ82Y6U758
2Vjt1JIP8irbxbMMsICwdjymWVCRPnknuYVJa9Y0FqHrI9WDx2Q4s/8u515bBTVH
Aoj2cwTuqFmt0AML7e3YLmGKYvYAo4ASgjGUWnmZ8Ezxc2wVp6QHQorbrOVBB+7w
6zrmup2Qj2OMcZyv2DTWvJboBVL9Q6T9RQMSec9CogT4GYq+qOY2V2exiWYBeCPH
tLbURZvtf3qIYdjJ7+b2yLwNi+rYPu7rCN80AsszJH0O01FpRnmPkg92jI5PM8Rb
JyIDU5G2rYC7yFW7+N+US8GpM8a2CI1Vl0YuHzRg5650jf/ngX2p2/uGVRSDg5ea
UUKRROE5xI1FekLSufLHpgJXXJjw6k/GZt4/1xROuWXPNMupUxM3eZgdmLJLoKCh
jQKvt0PnMawLwiKAVcot
=q7Qu
-----END PGP SIGNATURE-----

--ctP54qlpMx3WjD+/--
