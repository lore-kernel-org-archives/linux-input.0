From: Nicolas Mailhot <nicolas.mailhot@laposte.net>
Subject: Re: Tablet with evdev driver
Date: Sun, 16 Mar 2008 17:41:12 +0100
Message-ID: <1205685672.3154.11.camel@rousalka.dyndns.org>
References: <alpine.LNX.1.00.0803161706250.15404@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0126808884=="
Return-path: <xorg-bounces@lists.freedesktop.org>
In-Reply-To: <alpine.LNX.1.00.0803161706250.15404@localhost>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/listinfo/xorg>,
	<mailto:xorg-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/xorg>
List-Post: <mailto:xorg@lists.freedesktop.org>
List-Help: <mailto:xorg-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/xorg>,
	<mailto:xorg-request@lists.freedesktop.org?subject=subscribe>
Mime-version: 1.0
Sender: xorg-bounces@lists.freedesktop.org
Errors-To: xorg-bounces@lists.freedesktop.org
To: Andrej Gelenberg <andrej.gelenberg@googlemail.com>
Cc: linux-input <linux-input@vger.kernel.org>, xorg@lists.freedesktop.org
List-Id: linux-input@vger.kernel.org


--===============0126808884==
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-OWQXDmtFSiPfqu1LtuD6"


--=-OWQXDmtFSiPfqu1LtuD6
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Le dimanche 16 mars 2008 =C3=A0 17:16 +0100, Andrej Gelenberg a =C3=A9crit =
:

> i have one G-Pen 340 Pen Tablet. It report as evdev. I wrote small test=20
> program and i known now, than X-Axis have code 0x2 and Y-Axis have code=20
> 0x3. My question is, how can i remap XYZ-Axis?

The evdev driver relays the kernel view of an input device. If a device
needs to be quirked (change axis order, etc) it's better to do it at the
kernel level (this is how mouse wheels are handled for example)

--=20
Nicolas Mailhot

--=-OWQXDmtFSiPfqu1LtuD6
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Ceci est une partie de message
	=?ISO-8859-1?Q?num=E9riquement?= =?ISO-8859-1?Q?_sign=E9e?=

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (GNU/Linux)

iEYEABECAAYFAkfdTagACgkQI2bVKDsp8g3ZTACgixSvGpTWNohr2ejyx19cN0On
3OEAn2K8DJ/e0Ud2l2TDmSUCGpMxirBp
=qetv
-----END PGP SIGNATURE-----

--=-OWQXDmtFSiPfqu1LtuD6--


--===============0126808884==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
xorg mailing list
xorg@lists.freedesktop.org
http://lists.freedesktop.org/mailman/listinfo/xorg
--===============0126808884==--
