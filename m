From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH 05/13] input: convert sun4i-ts to use
 devm_thermal_zone_of_sensor_register
Date: Mon, 14 Mar 2016 14:07:22 -0700
Message-ID: <20160314210721.GB4740@localhost.localdomain>
References: <1457559336-17652-1-git-send-email-edubezval@gmail.com>
 <1457559336-17652-6-git-send-email-edubezval@gmail.com>
 <20160309214514.GA18066@dtor-ws>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tjCHc7DPkfUGtrlw"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:33845 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932815AbcCNVH0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 14 Mar 2016 17:07:26 -0400
Content-Disposition: inline
In-Reply-To: <20160309214514.GA18066@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Rui Zhang <rui.zhang@intel.com>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, lm-sensors@lm-sensors.org, Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>, Hans de Goede <hdegoede@redhat.com>, Lukasz Majewski <l.majewski@samsung.com>, Heiko Stuebner <heiko@sntech.de>, Sascha Hauer <s.hauer@pengutronix.de>, Jens Thiele <karme@karme.de>, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org


--tjCHc7DPkfUGtrlw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 09, 2016 at 01:45:14PM -0800, Dmitry Torokhov wrote:
> On Wed, Mar 09, 2016 at 01:35:27PM -0800, Eduardo Valentin wrote:
> > This changes the driver to use the devm_ version
> > of thermal_zone_of_sensor_register and cleans
> > up the  local points and unregister calls.
> >=20
> > Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
> > Cc: Chen-Yu Tsai <wens@csie.org>
> > Cc: Hans de Goede <hdegoede@redhat.com>
> > Cc: Zhang Rui <rui.zhang@intel.com>
> > Cc: Lukasz Majewski <l.majewski@samsung.com>
> > Cc: Heiko Stuebner <heiko@sntech.de>
> > Cc: Sascha Hauer <s.hauer@pengutronix.de>
> > Cc: Jens Thiele <karme@karme.de>
> > Cc: linux-input@vger.kernel.org
> > Cc: linux-arm-kernel@lists.infradead.org
> > Cc: linux-kernel@vger.kernel.org
> > Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
>=20
> Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>=20
> I guess it will make sense to merge through your tree unless you want to
> hold off until after I merge winth mainline (around -rc3) assuming that
> it even makes into 4.6.

No rush from my side. I would rather get the right review cycles.

The devm_ APIs were sent to 4.6-rc1 (well, right now in Rui's tree, but
I assume he is sending them).

Thanks for your review.

--tjCHc7DPkfUGtrlw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBAgAGBQJW5ygFAAoJEMLUO4d9pOJW1fkH/RTl+WR8y+rYZn8P7sMComvB
NVumLi7MTMyke2BdcRbuwkJBdQmpIEFAl4RsYwq0R1M2jfMrKjClgjfLTUyv+Stj
3dgZ2tIuqRACUm0eTasF2yprIM7NfsPuQd8kQdZEemKLZxJJCTUMyasYKKbYDJXA
7xeoZD5mqPwwRUcL5aitm/jRkWFdnX4lnhzjSTjYyq3+7UxQFsTUmZG/u5sayoim
xJk2Fm5RZTGZdbjelEbH8JxGHmcXYYff8fxar99V/Aw2V+rhdTW/r04a8rXNTFn5
w3XvIRcjBnApNqSd0dqqK1joMfGv/6xTeidjOGRBSECFBm3DB1+S0lkkiNGlFwQ=
=+wPS
-----END PGP SIGNATURE-----

--tjCHc7DPkfUGtrlw--
