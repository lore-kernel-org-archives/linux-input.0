From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/4] Input: wm97xx: Drop out of range inputs
Date: Sat, 9 Mar 2013 01:15:49 +0800
Message-ID: <20130308171538.GA26088@opensource.wolfsonmicro.com>
References: <1362759309-18782-1-git-send-email-mpa@pengutronix.de>
 <1362759309-18782-2-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="a8Wt8u1KmwUX3Y2C"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:48717 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932535Ab3CHRP7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 8 Mar 2013 12:15:59 -0500
Content-Disposition: inline
In-Reply-To: <1362759309-18782-2-git-send-email-mpa@pengutronix.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Markus Pargmann <mpa@pengutronix.de>
Cc: Liam Girdwood <lrg@slimlogic.co.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, patches@opensource.wolfsonmicro.com, linux-input@vger.kernel.org, kernel@pengutronix.de, stable@vger.kernel.org


--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 08, 2013 at 05:15:06PM +0100, Markus Pargmann wrote:

> +		if (
> +				abs_x[0] > (data.x & 0xfff)
> +				|| abs_x[1] < (data.x & 0xfff)
> +				|| abs_y[0] > (data.y & 0xfff)
> +				|| abs_y[1] < (data.y & 0xfff)) {
> +			dev_dbg(wm->dev, "Measurement out of range, dropping it\n");
> +			rc = RC_AGAIN;
> +			goto out;

The change is good but not a fan of the coding style here.  Otherwise

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

--a8Wt8u1KmwUX3Y2C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJROhybAAoJELSic+t+oim9IZgP/0CE96Dfrm+eAf4EGfFP4QHW
a0du/zpptBtfowckMiao4MnOzWuj2zHSDW953jtB3SFD0U4xVDMLd22+h5xECSTP
xnP9CNzXe4YTMj6hTBGjctJj9/mSp9bWzB3WsFuibl/93SFDhdEZc0+xYiL2AY/q
9f4bARxcK/lU1AHSoQ7pf9Zf/exxoHuveNiQuKFvMU1iBVx1f4f/9WupBbwXMEUn
z0h3naahbxN9/dIZhIM62gGnl/xLyH/8S6MbvxQtHnoUDj116yh22+UNoW8ZvqMS
7ENzgx2TVpohKbXIMZmGYEgg8i8sUPM+q7BjDcG9b7/mQ3DhkTERlQV4IkyORdM2
2qbCTTlExjM67ossq8UwlKjtpKydD3ka1HB40AmWhJd0pyouHCvdexgPVAbUsdV+
nHp8QhepwLr8dYVBYY7Aue2TuDDDJ0ABpXrEp6sMcIs9q4cYHVOa3Km3an4ZKQ9o
yDxwE5qTcIfcTEGjQWbGtPdc6CK+KX/nbyczjq/vu1UTuriuIDpndbcPuPhUM6cS
aUMC0kHDc75J0u4PJXS0zAzKMd2CoagXK5VKVwRPEYHu7M38zgp8gRpMxVeQ1kPp
C82WHfMleMRdY1DRSd2gr9TTRFpO6Lq4jcgOF5UB48lhRNCUQBGBIfq/z7VT6C8c
Vj/rUed7+I+JFqetD6PJ
=66vL
-----END PGP SIGNATURE-----

--a8Wt8u1KmwUX3Y2C--
