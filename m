From: Jan Losinski <losinski@wh2.tu-dresden.de>
Subject: [PATCH 0/1] Input: ati_remote - extend keytable for medion remotes
Date: Mon, 18 Apr 2011 12:41:08 +0200
Message-ID: <20110418104108.GA4876@atlantis.wh2.tu-dresden.de.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="h31gzZEtNLTqOjlF"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: losinski@wh2.tu-dresden.de
List-Id: linux-input@vger.kernel.org


--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

the following patch will extend the ati_remote input driver to support
multiple key translation tables. I have a device produced by medion that
is supported by this driver. Unfortunately the single hardcoded key
translation table does not enable all the keys and maps some of them to
completely wrong key events.

So I changed the driver to choose another table if the product-id is the
one this device has. For any other device the old "default" table will
be used. I also provide a full table with meaningful key events for my
device.

I hope you can merge this patch to the mainline version. Please let me
know if this patch causes any issues.

Thanks,
Jan Losinski

--h31gzZEtNLTqOjlF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk2sFUQACgkQ1Hv7AMjH+2E4LQCfd2k0EqzQlYD3FB2PUoJY4n9r
AbEAn1zT1uiY2GtFQkTZen8DXVU5Mt2Z
=TjHz
-----END PGP SIGNATURE-----

--h31gzZEtNLTqOjlF--
