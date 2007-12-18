From: Harald Welte <laforge-4Bgg8jF3iZdg9hUCZPvPmw@public.gmane.org>
Subject: [PATCH 0/12] neo1973: FIC/OpenMoko Neo1973
	GTA01 machine support
Date: Tue, 18 Dec 2007 12:06:16 +0100
Message-ID: <20071218110616.GG29882@prithivi.gnumonks.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0860010752=="
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org
Cc: linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org, arnaud.patard-dQbF7i+pzddAfugRpC6u6w@public.gmane.org
List-Id: linux-input@vger.kernel.org


--===============0860010752==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UHN/qo2QbUvPLonB"
Content-Disposition: inline


--UHN/qo2QbUvPLonB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

This is a patchset to add core machine support for the FIC/OpenMoko
Neo1973 GTA01 GSM smartphone[1] to the Linux Kernel.  They all apply to
Linus' linux-2.6 git tree as of today.

The Neo1973 GTA01 is hardware that has been distributed to developers
for about one year, and is on public sale since July 2007.

There is a second reviison called GTA02 which is also already circulated
among developers since September 2007.  It is expected to be publicly
available soon.

There is some code that is shared by GTA01 and GTA02, and 'neo1973' is
used consistently whenever referring to shared code (platform devices,
file names as well as CONFIG_ #defines).  Whenever GTA01 is used, this
particular piece of code is specifically to the first hardware
generation.

I have some more patches piled up, including GTA02 support.  But I'd
much rather see this patchset merged first.

All your comments and feedback are welcome.  Please keep me in Cc
whenever responding.

[1] http://www.openmoko.org/

Happy hacking,
--=20
- Harald Welte <laforge-4Bgg8jF3iZdg9hUCZPvPmw@public.gmane.org>          	        http://openmoko.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
Software for the world's first truly open Free Software mobile phone

--UHN/qo2QbUvPLonB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHZ6moXaXGVTD0i/8RApiIAKCM9+gEmYg2yQs4nMQoPG1F6tLx3gCfRbXV
spHtP0kIz0vJpwtitMdmfMs=
=oD/y
-----END PGP SIGNATURE-----

--UHN/qo2QbUvPLonB--


--===============0860010752==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
SF.Net email is sponsored by:
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services
for just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
--===============0860010752==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
spi-devel-general mailing list
spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/spi-devel-general

--===============0860010752==--
