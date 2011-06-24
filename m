From: Wolfram Sang <w.sang@pengutronix.de>
Subject: wm97xx_read_aux_adc() for battery & pen down?
Date: Fri, 24 Jun 2011 15:00:49 +0200
Message-ID: <20110624130049.GA9374@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mYCpIKhGyMATD0i+"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:42677 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751094Ab1FXNAv (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 24 Jun 2011 09:00:51 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>


--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

I have one question I got while hacking on this cheap tablet thingie I don't
have schematics or documentation for. It uses a WM9715 for (at least) touch=
 and
battery-status, but I need the following dirty hack for 3.0-rc4 in
wm97xx_read_aux_adc():

=2E..
-       if (!(*sample & WM97XX_PEN_DOWN)) {
+       /* HACK! Disable check for battery channel on Jaytech PID7901 */
+       if ((adcsel !=3D 0x6000) && !(*sample & WM97XX_PEN_DOWN)) {
                wm->pen_probably_down =3D 0;
                return RC_PENUP;
        }

        return RC_VALID;
}

So, it uses WM97XX_AUX_ID3 as the battery channel which never sets PEN_DOWN=
=2E As
a result, I always see timeouts when reading the current voltage (without t=
he
patch). My question is: How to avoid this hack? Did I forget to configure
something somewhere? I read through the wm9715-docs and the driver source, =
yet
I think I missed something (or the current implementation cannot work?).

Thanks,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--mYCpIKhGyMATD0i+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk4EioEACgkQD27XaX1/VRtWrgCZAWo2YqPQ/WIJYKUcVCniTduY
y68AoILd4+R2dKnVpTd5VI5Hy/l0U5ed
=/TGf
-----END PGP SIGNATURE-----

--mYCpIKhGyMATD0i+--
