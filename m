From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/4] Input: wm9712: Fix wrong pen up readings
Date: Sat, 9 Mar 2013 01:23:15 +0800
Message-ID: <20130308172313.GD26088@opensource.wolfsonmicro.com>
References: <1362759309-18782-1-git-send-email-mpa@pengutronix.de>
 <1362759309-18782-4-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Hf61M2y+wYpnELGG"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:45067 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933174Ab3CHRXX (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 8 Mar 2013 12:23:23 -0500
Content-Disposition: inline
In-Reply-To: <1362759309-18782-4-git-send-email-mpa@pengutronix.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Markus Pargmann <mpa@pengutronix.de>
Cc: Liam Girdwood <lrg@slimlogic.co.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, patches@opensource.wolfsonmicro.com, linux-input@vger.kernel.org, kernel@pengutronix.de, Teresa =?iso-8859-1?Q?G=E1mez?= <t.gamez@phytec.de>, Christian Hemp <c.hemp@phytec.de>, stable@vger.kernel.org


--Hf61M2y+wYpnELGG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 08, 2013 at 05:15:08PM +0100, Markus Pargmann wrote:
> Often a reading can be wrong. This patch assures that this is really a
> pen up event and not a false reading.

Hrm, it feels like we should wait for the device to tell us another
reading is ready but on the other hand I can see the sort of issue that
might mean this is needed and if it improves performance in your
testing:

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

--Hf61M2y+wYpnELGG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJROh57AAoJELSic+t+oim9LsUP+QETNy5K5Uxsdj8rYImc5d/Q
0hT7BUyt1VN1NdKedfc/gWcMzPZ0Iw8y/QsGYK0gwSvRnfBZferg4zFi17pccgiI
ftOL9rDp5+Or+Whu8wL+C3qDiEo6OtNbVhusOZye0y1wmdCpfYisHo9h0kx++FVN
vLL3K+jJXhcFyAFlgRWVg1rVa9fHK+cCKPBrEzgv9Nirm/NNf/4o619qbEPLTOZi
PvuvlSdxDwWa2sBRShd2rz+ZGkyAtcKcLrLdyiRjwk9MzEtvpu3BRr+ymmTaAjSp
nA7PLfWbUCciG72jUJhNDVhUiJFtuatOXw90LDUdr3QkwFSKEReZlka4eZTnrH4X
HDolbhcZPPV+/9EgQdEkN4UNPe9AbVOxcaR/Jl8dmIhdtCoc3PbzF+L1gf4sO4Ad
y9B/09es2JoFnGkeGXEVozDp+1W9lYc9+JmD7fTxUFZLA2XhKCec6nXAuHDxhDSV
6YMCS/XLFPSQslq91VSKbIeo+W+0IZByEHLch5YzfglWLIdb7FLN0KW+6MkIm7Bm
dU1FdLwQRcsNUN87ipaZiBDrfsKFtxQ40gHohzo14X4/r9RJ1QIOg+H9ojBV+TSf
U7hk+RArAPVpZ39ssEk/lhIQfoEuGmJ0UTV27DbEkD3Myv/qBbwyNCPrBcxQOF3B
J8FDrmYMnFgiVdE9hYEe
=mJ25
-----END PGP SIGNATURE-----

--Hf61M2y+wYpnELGG--
