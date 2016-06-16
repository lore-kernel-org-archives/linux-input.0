From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v8 3/4] i2c: i801: add support of Host Notify
Date: Thu, 16 Jun 2016 08:09:42 +0200
Message-ID: <20160616060942.GA1403@tetsubishi>
References: <1465484030-28838-1-git-send-email-benjamin.tissoires@redhat.com>
 <1465484030-28838-4-git-send-email-benjamin.tissoires@redhat.com>
 <20160615081247.GQ24234@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UugvWAfsgieZRqgk"
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160615081247.GQ24234@mail.corp.redhat.com>
Sender: linux-doc-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Corey Minyard <minyard@acm.org>, Jean Delvare <jdelvare@suse.de>, Guenter Roeck <linux@roeck-us.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Duggan <aduggan@synaptics.com>, Christopher Heiny <cheiny@synaptics.com>, linux-i2c@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> > - removed the .resume hook as upstream changed suspend/resume hooks and=
 there
> >   is no need in the end to re-enable host notify on resume (tested on L=
enovo
> >   t440 and t450).
>=20
> Actually, this hook seemed to be required on the Lenovo T440 (Haswell)
> but not on the T450 (Broadwell) laptop I have now here.
>=20
> Wolfram, I can resend the whole series or a follow-up patch to re-enable
> after resume Host Notify. How do you prefer I deal with that?

That depends a little how we want to handle patch 4. I am going to apply
patches 1+2 today to my tree. Then you can just resend patch 3 which I
hope will get some review soon, but I will pick it up for 4.8 later
nonetheless. If it is not causing too much dependency hassle, I'd prefer
that patch 4 goes via Dmitry's input tree.


--UugvWAfsgieZRqgk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXYkKmAAoJEBQN5MwUoCm280AP/jekLLlp41Ksk+uUjMDhyRcW
lG9Bdl3PkCsro1rWG41B3JTX4WekhfBRw1rM8becxR5qvpFouaB15aUHnebGVpeM
2xwTwG0xGoQYDDeDLysvnxJVY9efv2LnDXJOtUFvcDfpg8CGCMnUsSkz2yUPBm6x
uDeHYCRBP7qomYlVvly6Q1eIBA+uD9WBIda+fiQcneihduOPP2SRAmWR64C7NfeP
EghzdFpQJ9RTbELIoxp1YDI7IjR7KKD1lVcEVGmeSiaI/4GEUOO/3H4QEfx3w5mw
T86bmA+4rRBk0XjmuxatHOZLWeyX8ctD5uv5t0IDxwI+kZ3XKI7jVN9i3Rnix5Dc
zi52nEiQEl8F2EJKTJyLgUYla54uYJil5n6Hp3hDkmdBtwt/DexpVR0AmpatQwYI
XFjiIqwhtq+AdboZ18WSw64ytJhCEAQ0r7zaXX5UvgLquRh6VYe5yNFLgHfh4mOd
ysfvGopiNraqQlwjlt+JCiLCnUHXuzV2cX9jF/KmI8T+3JUewCBNGRKrQ+/7PwpD
IbjyoaVHx7RMjq6tCovvAKgjMz5mSOoocWy1Wo/VB7DvgJ4/aWdI4KBweYbjtHcw
OS/Dk3xlngycrrldOi5ckNgUIssPgG/C/+vaRxyuHGWvMGQrX74clWhTNdUY5NAT
NWS30DXPdQxrs1P8btES
=4NfN
-----END PGP SIGNATURE-----

--UugvWAfsgieZRqgk--
