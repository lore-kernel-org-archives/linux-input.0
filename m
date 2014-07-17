From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] drivers: Let several drivers depends on HAS_IOMEM for
 'devm_ioremap_resource'
Date: Thu, 17 Jul 2014 11:56:58 +0200
Message-ID: <20140717095657.GC17877@ulmo>
References: <201407130545.23004.marex@denx.de> <53C53CE1.4090803@gmail.com>
 <53C7269E.4010702@gmail.com> <6823014.2plXDE9VA9@wuerfel>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8809055754789219782=="
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <6823014.2plXDE9VA9@wuerfel>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: driverdev-devel-bounces@linuxdriverproject.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-iio@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, teg@jklm.no, Lennox Wu <lennox.wu@gmail.com>, linux-watchdog@vger.kernel.org, Marek Vasut <marex@denx.de>, Liqin Chen <liqin.linux@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>, Richard Weinberger <richard@nod.at>, Geert Uytterhoeven <geert@linux-m68k.org>, msalter@redhat.com, Guenter Roeck <linux@roeck-us.net>, linux-pwm@vger.kernel.org, devel@driverdev.osuosl.org, Chen Gang <gang.chen.5i5j@gmail.com>, linux-input@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, dmitry.torokhov@gmail.com, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, knaack.h@gmx.de, Martin Schwidefsky <schwidefsky@de.ibm.com>, Mischa.Jonker@synopsys.com, jic23@kernel.org
List-Id: linux-input@vger.kernel.org


--===============8809055754789219782==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="R+My9LyyhiUvIEro"
Content-Disposition: inline


--R+My9LyyhiUvIEro
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 17, 2014 at 11:20:36AM +0200, Arnd Bergmann wrote:
[...]
>                       score should set HAS_IOMEM and doesn't
> even have public compilers

This begs an interesting question. Should it be made a requirement to
have publicly available compilers for new architectures so that they can
at least be compile-tested? Preferably this would of course be in source
form so that there aren't any dependencies on the distribution.

Thierry

--R+My9LyyhiUvIEro
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTx53pAAoJEN0jrNd/PrOhf/8P/2X54LIgpjrxnJPx8B4sv3TP
o9A12YuzrVI/fL3USm6qF9uSgq/J2d5w34PzDP9zcj5AkCPHY9nJXHbkKnUBE9jj
dxRP4mOrdfZG+Pvmc5gvD48KqwonrvEay0qYqDQLWdBtl7sRP/DA3KObVLCdRD8f
SGCjaJSxdcPjKjrEICUlEQ+xZk2rhILWdLHt9BhDxuzapdFxIgxy5RZQpQdJDm1Z
FKR20aKreT+2drvj8rJKIqN5qJN/9o832J6vH6iWc+a4DxthIMNyM1iAolBZ/DwL
E2z0CAVTuEVtsOjTZ/MfhAMW5O/SyQeEnG+V5yi3cp3Z2P9OO3kNvbXDwleTPRZ+
wEtiIy0vSQALP/Gkbwqwk2pAkMsefc9Du7JPlSF8kXNsxB2QOSbuxcQasz35VeMR
CgDRx1DOO+sDInHq0SneO3B0mhQRCvRXX1mKghVxkWRr/GLFjaPqBW7NjrZy88Wr
qNX/TyGadB0n+in1o4K7IxrNOunlFmnqzhujhmZo6UKzjZljlf1qlcmEVnnOeMkB
qa6F7AYwz4ifJt/VUtRSsa0NJkPnNZCwAwdgSR+xn6dFdOUC5plqKx5pCT1rC7Cp
cCalBOg8Dp7saiFGij5RWCsiMT6g4HzFCCnaupylrWrAds2C0bf8q/3GyEQ41mco
CEVT3bsEWUOF1QYRyoi0
=U/Tt
-----END PGP SIGNATURE-----

--R+My9LyyhiUvIEro--

--===============8809055754789219782==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel

--===============8809055754789219782==--
