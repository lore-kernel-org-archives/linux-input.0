From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 1/2 v2] i2c: cros-ec-tunnel: Add of match table
Date: Tue, 30 Sep 2014 08:07:09 +0200
Message-ID: <20140930060709.GB1325@katana>
References: <1411114093-3505-1-git-send-email-sjoerd.simons@collabora.co.uk>
 <1411114093-3505-2-git-send-email-sjoerd.simons@collabora.co.uk>
 <20140929205922.GB2758@katana>
 <5429E982.4050509@collabora.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Yylu36WmvOXNoKYn"
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5429E982.4050509@collabora.co.uk>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Cc: Sjoerd Simons <sjoerd.simons@collabora.co.uk>, Lee Jones <lee.jones@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Doug Anderson <dianders@chromium.org>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-i2c@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org


--Yylu36WmvOXNoKYn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Doug posted a patch [0] to fix the issue you are reporting but it was not
> picked. I tested that the patch applies on top of linux-next + the latest
> cros_ec cleanups (that includes a patch for this i2c driver and was taken
> by Lee. So I think is safe for you take Doug's patch through your tree
> since it seems to not cause any conflict with the mfd tree.

OK, thanks for the heads up. I picked it.


--Yylu36WmvOXNoKYn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUKkiNAAoJEBQN5MwUoCm2G9AP/ROUbQsRtiVEoyBLI3eLfGm7
UbYf56CiqdtHG/pbINtV2Kg+apnre77fDKOXwJs2RDzl+qEWNmCv0tYJD2/kdmUf
yOlD+Eb1SU/vBy7lGcgXzrCzfUnJdOPKXcMwIa1yxOyqq3PexxSUduAaPtYxkm7S
0upJiBJy5Yo3AH3IMG75xHORNgNONIEOep61gbSOl4SDV1IzBr5nBZMoBJguB84u
P9sLJBR0OEiYZzDkbPkTFirtdH7DbJO0/piY0M1X6NIgdoE4L1nxYiEBxgsfVoGB
K3+0XnfsPLli7nsZUg29raWm3x2rJF5Sz36nLiZieAQG58OrsLDI5jTPnnE+mcQ6
onBv+FGYWUNEd7vyzPHlU+wD8LVypce2jJl3p33yOwr+TZ4KGMmEKm3WQZvg1t8E
rBAkb+LEQezNRWlbc2q1wO9Lhpo1vg1fxkTUyHKty3jWyLZUXAVLbUhC0Dvln3Mv
2r+rmbXK3TCIftp611GRz/kh9aOW02cNxzUng3F19/ugnbv982/BHZEVHkYwTYv5
volGEi4EPXRNX/e4EZcDwV0ziFicWXIKDkoc9C8j69u0AyPtQY7Dgcm3MkVutLeO
6dzE1CyEEJWb6d2pnTU7nZszqu7cOLQD8R5JAFHnDvF31+iHwrLEd8cRhYUDBUMc
Sqf0GMelve1ncCxXwg+3
=dIiz
-----END PGP SIGNATURE-----

--Yylu36WmvOXNoKYn--
