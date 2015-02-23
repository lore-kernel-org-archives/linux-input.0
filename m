From: Markus Pargmann <mpa@pengutronix.de>
Subject: Re: [PATCH] input: edt-ft5x06, Add i2c device ids
Date: Mon, 23 Feb 2015 23:06:00 +0100
Message-ID: <20150223220600.GB16926@pengutronix.de>
References: <1424447785-14337-1-git-send-email-mpa@pengutronix.de>
 <20150220183250.GA20060@dtor-glaptop>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="R3G7APHDIzY6R/pk"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:36734 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751601AbbBWWGD (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 23 Feb 2015 17:06:03 -0500
Content-Disposition: inline
In-Reply-To: <20150220183250.GA20060@dtor-glaptop>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Lothar =?utf-8?Q?Wa=C3=9Fmann?= <LW@KARO-electronics.de>, linux-input@vger.kernel.org, kernel@pengutronix.de


--R3G7APHDIzY6R/pk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Dmitry,

On Fri, Feb 20, 2015 at 10:32:50AM -0800, Dmitry Torokhov wrote:
> Hi Markus,
>=20
> On Fri, Feb 20, 2015 at 04:56:25PM +0100, Markus Pargmann wrote:
> > These ids are necessary to use edt-ft5x06 as a kernel module. Otherwise
> > it is not loaded automatically in userspace because the ids do not matc=
h.
> >=20
>=20
> We already have all module aliases needed, please fix i2c to generate mod=
alias
> for devices described in OF properly.

Yes, that's probably the better way to fix it. I will have a look into this.

Thanks,

Markus

--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--R3G7APHDIzY6R/pk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU66RIAAoJEEpcgKtcEGQQxuMQAIaPwlGcXq7EX32Er4uGJOLO
g41E/9EF+p+kgE89b7fbWg8o/2cu+iTXUXCJaG+YDOI5yzN6rCmoJpVbWKZV/cer
psQ5MJudOA0qVHExubQeRb+w8oZMySemvpmDlnsM7xfTRln4IZnNHtVtNW2i5bL4
yGh5i5/UukI8TawURe0VbIFz+a0mJjYt7KFUYrF/IBNbDW/sUzQL9nELX6cEy13w
W3qfm8ADl5qcnZsdNw/kuXPmRp1+Qtirn6DmayEcal5VPNWqTa+KYcqhlJkuWbZY
7AG7ig5tHs4uDFGoq8HO3sunRV+9U3yuS5H21nPl1DXKgLqxSHl5Qq1KWfHtQDbX
dY1jLlLs6bbMUniXaR5rXNTyqf+ZP77DCTPpjQ5t3LQ5G5UtZRuMa1xj6BYA7NCt
oFf5yn+RbmYg6senom9Ug71c4bMLcVc3i2yq93TloRVqN4PZ/uzWcxqmDa1hG+U4
5E55vGgklvPmuOWTfUwDk+f/2/VAffvP46KQ7bqjqSXQE3uUBg00ft3emAKwqzvf
XzK2K8ANTZmg8Kpf/bq10H3us23/10j0+ILa0sGtjNmD5NWU680sMz05TwBh2htI
JpWXc/cfZJeoTK0ubOtx1katCzkRGQkV+kUpDQQLFnSYKqxX54LMPwRzEISk7nkM
Eg6/kptXUn7p7n/cY5oi
=meKJ
-----END PGP SIGNATURE-----

--R3G7APHDIzY6R/pk--
