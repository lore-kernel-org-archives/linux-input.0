From: "'Sebastian Reichel'" <sre@debian.org>
Subject: Re: [PATCH] Input: twl4030 - convert to using managed resources
Date: Mon, 6 Jan 2014 03:33:58 +0100
Message-ID: <20140106023358.GA11575@earth.universe>
References: <20140104090147.GA16680@core.coreip.homeip.net>
 <007901cf0a86$a0639550$e12abff0$%han@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2oS5YaxWCcQjTEyO"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ring0.de ([91.143.88.219]:47515 "EHLO smtp.ring0.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751460AbaAFCeA (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 5 Jan 2014 21:34:00 -0500
Content-Disposition: inline
In-Reply-To: <007901cf0a86$a0639550$e12abff0$%han@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jingoo Han <jg1.han@samsung.com>
Cc: 'Dmitry Torokhov' <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, 'Fugang Duan' <B38611@freescale.com>, 'Peter Ujfalusi' <peter.ujfalusi@ti.com>, ".linux-kernel"@vger.kernel.org


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 06, 2014 at 11:25:54AM +0900, Jingoo Han wrote:
> IMHO, input_unregister_device() seems to be necessary,
> because input_register_device() is still used.
> If I am wrong, please let me know kindly.
>=20
> Sebastian Reichel,
> Would you repeat insmod & rmmod 'twl4030_keypad.ko'?

mh. I only tested with twl4030-keypad compiled into the kernel.
I will try building the driver as module and reloading it on
the device when I find some time.

-- Sebastian

--2oS5YaxWCcQjTEyO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBCAAGBQJSyhYVAAoJENju1/PIO/qaoS4P/j94eAkXs2Kn+jwRvUZC88ad
Vy7rIOUc8752eXRz7n8jB6xytut9kx+0zYEgmNCCUsdqRSV9obVFOmVBQ9AIKxm/
LAzKGAahUTazIwYsXFX5cFzK1Gd2tJqvuNbtouHJzC8rsFR0XnxzbFP3vz7k1Pb8
wAvEsQA3/mVOgOacmpdnZmVtndU13BgCoqvEmwQJQ4gPvaS/wJzpvk0e7VyXqYfN
/DYQBennV1wYTeqniEveP6ZznhCndZrQ8JBQOMspFxhdYv4F0nvNRNKM67CUeJeo
779OWJ1VcISkgjp1rTvM8eMawSR1gpJ0moNb2B5qDBP9dtOHNdehwp49+BX1rM3b
k0wnTV59wr/ug1UMoO47TOTRuxmsxNpVlvLgMC9TZh6eTOMQYmtptEFjFWbLvvjY
5jwur0SvDuMYFuU7hWJok4x/0izRytmNWA/Wc5tninBymbKiaY3OtnxrcC07IAqR
5tz/TCJ0kI7cj6WNH/dYh1RgI41waurwgFcFq533GzL5QzH6vLDO+PCpgyWoZAO5
0KPmTD4Osx7i0Tcayyati2g2nhN4JO3PhQrAlMmkONjFhExrFwc1kKJRSt0cYG88
udY4br8I852bph+jVAxldji6Yush7sa6fHao/EgHt6r+BwAz8UrABGyke5LXOFYk
VRiKH3Khs7ZEf3OlyQmx
=LmVr
-----END PGP SIGNATURE-----

--2oS5YaxWCcQjTEyO--
