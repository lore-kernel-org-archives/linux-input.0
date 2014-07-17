From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] drivers: Let several drivers depends on HAS_IOMEM for
 'devm_ioremap_resource'
Date: Thu, 17 Jul 2014 12:55:50 +0200
Message-ID: <20140717105549.GH17877@ulmo>
References: <201407130545.23004.marex@denx.de> <6823014.2plXDE9VA9@wuerfel>
 <20140717095657.GC17877@ulmo> <6350114.L77bTv76Ul@wuerfel>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1779726212945244665=="
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <6350114.L77bTv76Ul@wuerfel>
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


--===============1779726212945244665==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lrvsYIebpInmECXG"
Content-Disposition: inline


--lrvsYIebpInmECXG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 17, 2014 at 12:33:32PM +0200, Arnd Bergmann wrote:
> On Thursday 17 July 2014 11:56:58 Thierry Reding wrote:
> > On Thu, Jul 17, 2014 at 11:20:36AM +0200, Arnd Bergmann wrote:
> > [...]
> > >                       score should set HAS_IOMEM and doesn't
> > > even have public compilers
> >=20
> > This begs an interesting question. Should it be made a requirement to
> > have publicly available compilers for new architectures so that they can
> > at least be compile-tested? Preferably this would of course be in source
> > form so that there aren't any dependencies on the distribution.
>=20
> The question has come up a few times. I wouldn't mandate that the port
> has an upstream gcc (you've got to start mainlining one of them first
> after all), but having compilers available for download should probably be
> required. It's hard to ask for a particular quality of that gcc port
> though, or to expect it to stay available online.
>=20
> Where did you find the gcc port for score?

It's upstream, though marked obsolete and to be removed in the next
release... =3D)

Thierry

--lrvsYIebpInmECXG
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTx6u1AAoJEN0jrNd/PrOhEuwQALeTCrfkgfo5Tb0gskGOiJ2A
l5c9TdliuCOUNYpwW+4phztgN81QDg941PPecfB96ARNKGewq4tDbSt1QQ28/d1S
XC+bPi89pXVSzh+tt2VM9sWMXpkpfrY4Cv7F5HdlpsbAvXhU2q/Q89oJBDhOLLJ+
F7ledfllgqfF50oamHY4J+xJv4lDjKfve9U8MomM/r91IQ7rZAI2Zq//LwkFD3WF
6L8/FX1NbTOmGv85v19YDY3+PvDFbPpt4wG128p038hTIZ/k8RICic8N8smgh7r+
Ik/Bt3Ew4aXIgAtNXAyKzG9GIPuofKd6WkhaIB4vvrUoXan9kLqCY5CKrLuksG/p
Fj0B+4VGHoOevMwDVyqgn33pQPErm6rlTRdp0ddmI0SQph4GcKg0IBUIqD0XS0ma
WcUVlA6S3GLmXl7LrfCXl0xRvn/pa03v+Gzj7VcjmYNAxyDbtPrbzoSR8Lp0JC5j
t8Q03pOtQhXgI363OYll/S8j32qcreLtghi/xpi6MhAXSZJeonp0CxNi4Z/lWED+
aDr8rHEbve2orQ0ouyInSlV9mabI/03MdePZrHy/cJ94GPgpieHy1BLBc1N4JsEc
IPZWwWKj5LS3zG4wrutDweoN1Twh7nrQaPzlvJRSrtaGCEyKdHuHZMuhUjMXCcWH
ArZr57GeXOop6SEf41I5
=UHHF
-----END PGP SIGNATURE-----

--lrvsYIebpInmECXG--

--===============1779726212945244665==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel

--===============1779726212945244665==--
