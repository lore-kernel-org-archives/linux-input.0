From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2 1/2] DT: i2c: Deprecate adi,adxl34x compatible string
Date: Mon, 2 Mar 2015 07:40:49 +0100
Message-ID: <20150302064049.GA1401@katana>
References: <1421333655-31029-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <CAMuHMdUwHde0EvbCD574L2tW6qqxLCtZwAb+0M-4QCjB9V6fmQ@mail.gmail.com>
 <20150126120947.GC1052@katana>
 <2747724.u7aGnnSiv7@avalon>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+HP7ph2BbKc20aGI"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:58434 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750992AbbCBGkn (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 2 Mar 2015 01:40:43 -0500
Content-Disposition: inline
In-Reply-To: <2747724.u7aGnnSiv7@avalon>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Linux I2C <linux-i2c@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>


--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 26, 2015 at 04:27:49PM +0200, Laurent Pinchart wrote:
> Hi Wolfram,
>=20
> On Monday 26 January 2015 13:09:47 Wolfram Sang wrote:
> > > >> If you drop adi,adxl346, checkpatch will start complaining if it
> > > >> encounters
> > > >> it in a .dts.
> > > >=20
> > > > Boah, this is annoying. That means we need an 346 entry even if it =
is
> > > > not different from 345 (which is fine by me).
> > >=20
> > > To be clear: you need the entry in the documentation. It can be omitt=
ed
> > > from the driver if it's not (yet) used for matching.
> >=20
> > Well, I don't really like that behaviour, but I don't like
> > i2c/trivial-devices.txt as well, so I'll just apply the patch and live
> > with it :)
>=20
> What happened to this patch ?

My idea was that Dmitry takes them both because they are related:

http://article.gmane.org/gmane.linux.drivers.i2c/21763


--+HP7ph2BbKc20aGI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU9AXxAAoJEBQN5MwUoCm2hvMP+wUMKZQV5Twtomz75LmOPOKx
VMecTuwZXb4P5acZWfFz3J03KvEkWSgJfQrcNCl/MYbTsDEmYf1CGDeEoFuqXwWL
qfP4hjweQFXwf5JwRGFYW5SMWhUfr4LZIwJrcEughZEY1mwbmyXvGT2AWEVkNosk
s619JpBE4g85iNyTPELjK0rjhCdYhVmlwRIAaYVyb04tI51UTkJw8s3gDXrFf1oq
+QP07FLc5CWFFxUI8XUg8coI2FuxzsWSONGM554ls4NHXEdm0AKFE2Y2w2fAPktu
sTmlXB2LAyYJsuChCfGqGJ+EBoiFJouGGxKktaxtg4gLWFwal735+cK/Wtcm06wf
Rhe5TB0/inm5hQIjsqXoPL2/1ZSajDYrb4gRjDxVU2sFJwjjXaZoZV6X2p5cK7d6
lk1EyVUMaegqGPwxGKMZvXWKYZPCB5t3MlTCq9eZD8BtPhvjk3RSGdP4VCxMHCww
J7XKkePBLnYW6gr6KBaAvLXiSd7wK7jUKM7OIAlml6zZNkOgUpD7huv3X9g1G8Cp
XTvmk13SS5SlAeCbWoeDSsS0e6BtzlblBEuaLM3Hphwz9+DQfSvLIbck0+iWHnmO
wAfMGR2VszUYNkWZhsTzTD7F8kIXb2Ye+gJGmBx8IZBGceIZMsxNtTRHfZeMiknS
rDtI8LTBg78TItP7lIdM
=qP1+
-----END PGP SIGNATURE-----

--+HP7ph2BbKc20aGI--
