From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/4] Input - arizona-haptics: Add driver haptics module
 on Arizona CODECs
Date: Tue, 27 Nov 2012 20:00:02 +0000
Message-ID: <20121127200001.GJ4468@opensource.wolfsonmicro.com>
References: <1354020025-23881-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <1354020025-23881-2-git-send-email-broonie@opensource.wolfsonmicro.com>
 <20121127195644.GA29727@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Qo8f1a4rgWw9S/zY"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:57153 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754474Ab2K0UAI (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 27 Nov 2012 15:00:08 -0500
Content-Disposition: inline
In-Reply-To: <20121127195644.GA29727@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>, Liam Girdwood <lrg@ti.com>, alsa-devel@alsa-project.org, linux-input@vger.kernel.org, patches@opensource.wolfsonmicro.com


--Qo8f1a4rgWw9S/zY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 27, 2012 at 11:56:44AM -0800, Dmitry Torokhov wrote:

> How do you want to merge it? My tree or some other?

I'm not terribly fussed but I guess as it's a new driver for the input
tree merging via ASoC will minimise the potential for conflicts?  But
we're near the merge window and I'm not sure that's likely anyway so if
you want to apply it to your tree.

--Qo8f1a4rgWw9S/zY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQtRutAAoJELSic+t+oim9BI4P/3X+5fUZZnI5h/Qht9pifS5L
8ybFaGKP95UUa+4G59tNws0umWp7xUPgd5EgMoY5zdgzvgRLaole9+RCShAsU+0d
2m9oAYTyoU8gpv3eRiCaKyYNNeE5oTBAlZwD0aPNW94zZSBpE3ncq9uT1di8T5jT
rPnbyDv8HGOY+trN4kx+F9O1xqvD5xdv69pZiEWCDyy4o/Gp2v2YLkPC+sDRDMTN
85N4mH/ttKa+r09GrxmeihsqlAZvkd0bZ7qaG1MMgvXuseWlhDFL2/qqnjZebAMM
zq+YlbiGoy/rBOdgNviZf1l3hFccc3VuvB5Fb9NkBQHmKRvaHXllLmEntyKqnXjB
0yqH7Z+5G1wIqU3ZZG+ZJD9KTJueRbB2RJt8TS+zagDB2+05N7YN/0Q7TDXu0yQH
zCQL/XTZe4DEto5f6sre+np8VKZ9WPMV9swV3m7/DDCIlLd6zh0pBTzBGzg7kg9Y
4av9Is578tY/vltSx/F4tMXvQigtYlG/i/KTG1pUzu3Mj0xtlWF2X82GohgB1pku
D4FFMaKL+nMGXwNmX6NGNKF8n6hat7TLkuBz5eCFkmPt1kp3wwDGbOSsBkSqzFon
zh8sDlZEKmljdXC9uOsvWsYPZS15Kqd1bMpL/ANOZRoFAR4RwszSf1AkfmuHPGz4
QhCz2Q+yJ8V8GldMI8aR
=Ez89
-----END PGP SIGNATURE-----

--Qo8f1a4rgWw9S/zY--
