From: "'Sebastian Reichel'" <sre@debian.org>
Subject: Re: [PATCH] Input: twl4030 - convert to using managed resources
Date: Mon, 6 Jan 2014 23:14:06 +0100
Message-ID: <20140106221405.GA22325@earth.universe>
References: <20140104090147.GA16680@core.coreip.homeip.net>
 <007901cf0a86$a0639550$e12abff0$%han@samsung.com>
 <20140106023358.GA11575@earth.universe>
 <009301cf0a8a$1963cfd0$4c2b6f70$%han@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="W/nzBZO5zC0uMSeA"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ring0.de ([91.143.88.219]:52040 "EHLO smtp.ring0.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755383AbaAFWOM (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 6 Jan 2014 17:14:12 -0500
Content-Disposition: inline
In-Reply-To: <009301cf0a8a$1963cfd0$4c2b6f70$%han@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jingoo Han <jg1.han@samsung.com>
Cc: 'Dmitry Torokhov' <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, 'Fugang Duan' <B38611@freescale.com>, 'Peter Ujfalusi' <peter.ujfalusi@ti.com>, ".linux-kernel"@vger.kernel.org


--W/nzBZO5zC0uMSeA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 06, 2014 at 11:50:46AM +0900, Jingoo Han wrote:
> If you repeat at least twice insmod & rmmod 'twl4030_keypad.ko',
> it will be good. If there are some bugs, it will make the error
> messages or kernel panic.

I tried load & unloading the twl4030_keypad module multiple times.
I didn't get any error messages or kernel panics. Everything seems
to behave correctly.

-- Sebastian

--W/nzBZO5zC0uMSeA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBCAAGBQJSyyqtAAoJENju1/PIO/qa/YMP/25yFI45HXZ19Z3mOWybmHHu
dSewc4uxrL7i40UI0E2JDC/v85L3En7PjLyw6se50LtrWswMGhqQvlrans2Nm0PL
YWIWnNxoUxBgQDRmO4Du6W0r6l4FRRNRouObdBiuDEZBivRiER9CdxFE9gqL2nZj
e8mrJa3NmpeSck15qb2u5t4/FHikkUzRCnzosc6IVOco8X8gi8Rg93l2X8KlMDOj
SAKzujnndao7ckvvMNIfRoDLi6HXdK9ARzPTykR01AaXzmjPMEcyzPCeTeh9jjN4
EHH9GWoP41XbAvnnV/vLAewQcAYt3suwJtC29k+yTotOuO7oozm+5PKAoUHsMdKe
DpC9tKYMt/y1CNFx2kxgzKcEENcvbQ/hUBidByJ5P4Jg1jAQUGFu+gECrCETLGtw
5Bhp5sTPAGMHNTFFstjbN9gNwvCBg+ZhaiTumjvhw3tSRfmTagLuUXIeeEutz47H
f3UcZnaYQA7LrMPaXl444m50rstmkTxBHfBaGjNXsPd67Zql9l5FAI2/8JY7gFwA
hyqwdunvT/B5A6MaZvapCzEKPYgW4kA8vFcLr2k7P5XQ9RfFXJCtWhvDuh8zIgpB
70AQTrnOYYOAOINBF/S3TaQWnGGuWtE0l8Cu3uP+87Yx8ZAnxkxMTGQ2+hEeiojk
BELPS4Qj+5MUQv2xQOEE
=pFGX
-----END PGP SIGNATURE-----

--W/nzBZO5zC0uMSeA--
