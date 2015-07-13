From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v1] HID: cp2112: fix byte order in SMBUS operations
Date: Mon, 13 Jul 2015 16:41:09 +0200
Message-ID: <20150713144109.GA8115@katana>
References: <1436504671-2485-1-git-send-email-ellen@cumulusnetworks.com>
 <alpine.LNX.2.00.1507131322180.7522@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dDRMvlgZJXvWKvBx"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:46007 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751137AbbGMOlY (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 13 Jul 2015 10:41:24 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1507131322180.7522@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.com>
Cc: Ellen Wang <ellen@cumulusnetworks.com>, borneo.antonio@gmail.com, dbarksdale@uplogix.com, linux-input@vger.kernel.org, linux-i2c@vger.kernel.org


--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 13, 2015 at 01:23:52PM +0200, Jiri Kosina wrote:
> On Thu, 9 Jul 2015, Ellen Wang wrote:
>=20
> > Change all occurrences of be16 to le16 in cp2112_xfer(),
> > because SMBUS words are little endian, not big endian.
> >=20
> > Signed-off-by: Ellen Wang <ellen@cumulusnetworks.com>
>=20
> Alright, this means that I2C_SMBUS_WORD_DATA and I2C_SMBUS_PROC_CALL have=
=20
> been terminally broken since the very beginning and noone noticed.
>=20
> Does this mean that those commands are in practice mostly unused anyway?=
=20
> This is important for 4.2 vs 4.3 consideration.

PROC_CALL is really rare. WORD_DATA depends on the setup, it is used.


--dDRMvlgZJXvWKvBx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVo84FAAoJEBQN5MwUoCm2EwQP/1ouMmzpYtbXsZsxvAdmtbMK
MrgK2srwRXk9I9ZeT3wf4ambVr6lCwuntV9M5KDxWL97IwLfEW9EeX1lCzhkJ2Nq
E9+g16CyoT+DZoTpW4UrE5p3m/ugxsc1CKxbkQPlDiPLB+F0pDQsSOCk1ofQItQb
uFh9PmwBm9+2C6B7D/ab1d4ucJ+ntWMagX/UachYJgC9iaadHNW1zp1JrMqTgnhg
zIWEGzE8pWkfy+5qhGRcGAsSEKZqLVKsz7LNdcg8LmIIo6rOmmHMmJA6PFmyEOCx
M0eel9eWt8k2iH/QjnRYDNCKiiHhFgJ7SLbkZeEP56ERrx/G5Yn/bcW9rakgaiob
0vw9KU0rgytwzECdItHhg8rp0lTwDxRkVbWz7YkFtSPTfBW8hScPDfFl8ZZUJnZ8
P2GcYJiws6CmeoazNogKA1hl5Za/p2+0NrfG76LzLzyaASyvUYppBsEmzsECcjOD
9lLKEKF09hRkmt5I5QyP3kW3PhtN0JQrEZTidLG4xYTZA766tm/zJHTk6wd+oYY6
8x0CB9IvGzLm3ICxhDtgKAavBIZo32f98UAUDp6lYQbwk5MeGmKRKeUbuKpgXqJ/
i6tXPMXbEeCpxGyTcQxv4RSxzh4rPeVU0ydABj4PTmYCadZsclQb+7Xf+nmgDiWT
8P9jOZAhhtoD8/9a91WA
=uLqW
-----END PGP SIGNATURE-----

--dDRMvlgZJXvWKvBx--
