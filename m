From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v3] MAINTAINERS: add maintainers for ChromeOS EC
 sub-drivers
Date: Fri, 14 Dec 2018 14:17:52 +0100
Message-ID: <20181214131752.3qfdbxk6z3hkp7cp@earth.universe>
References: <20181214114858.21231-1-enric.balletbo@collabora.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lgqwv4ykv6pafxpf"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181214114858.21231-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: linux-kernel@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>, linux-pwm@vger.kernel.org, linux-iio@vger.kernel.org, Alexandre Belloni <alexandre.belloni@bootlin.com>, linux-i2c@vger.kernel.org, groeck@chromium.org, kernel@collabora.com, linux-rtc@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>, Benson Leung <bleung@chromium.org>, linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jonathan Cameron <jic23@kernel.org>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, devicetree@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, linux-pm@vger.kernel.org, MyungJoo Ham <myungjoo.ham@samsung.com>, Lee Jones <lee.jones@linaro.org>, Hartmut Knaack <knaack.h@gmx.de>, Rob Herring <robh+dt@kernel.org>, Lars-Peter
List-Id: linux-input@vger.kernel.org


--lgqwv4ykv6pafxpf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Dec 14, 2018 at 12:48:58PM +0100, Enric Balletbo i Serra wrote:
> There are multiple ChromeOS EC sub-drivers spread in different
> subsystems, as all of them are related to the Chrome stuff add
> Benson and myself as a maintainers for all these sub-drivers.
>=20
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Signed-off-by: Benson Leung <bleung@chromium.org>
> Acked-by: Wolfram Sang <wsa@the-dreams.de>
> Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com> for iio parts.
> Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Acked-by: Lee Jones <lee.jones@linaro.org>
> ---

Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

>=20
> Changes in v3:
> - Add collected acks
> - Use a cros[-_]ec pattern instead of list all the files.
> - Add Guenter as a reviewer.
>=20
> Changes in v2:
> - Fix typo in Benson email address.
>=20
>  MAINTAINERS | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e7260191301b..437e036435d5 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3629,6 +3629,14 @@ S:	Maintained
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/bleung/chrome-platf=
orm.git
>  F:	drivers/platform/chrome/
> =20
> +CHROMEOS EC SUBDRIVERS
> +M:	Benson Leung <bleung@chromium.org>
> +M:	Enric Balletbo i Serra <enric.balletbo@collabora.com>
> +R:	Guenter Roeck <groeck@chromium.org>
> +S:	Maintained
> +N:	cros[-_]ec
> +F:	drivers/power/supply/cros_usbpd-charger.c
> +
>  CIRRUS LOGIC AUDIO CODEC DRIVERS
>  M:	Brian Austin <brian.austin@cirrus.com>
>  M:	Paul Handrigan <Paul.Handrigan@cirrus.com>
> --=20
> 2.19.2
>=20
>=20
> --=20
> To unsubscribe, send mail to kernel-unsubscribe@lists.collabora.co.uk.

--lgqwv4ykv6pafxpf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlwTrX0ACgkQ2O7X88g7
+pp/yxAAgDkNnwL/12ET+OUIaYGlUvknCfQAjrIMeEQkOj/cNanVPk5rHbr+xsSt
ssO7WNBlyl45qUtUsQtGew2iSCIrn5LwWUb9rxiGpdEpLwx0nna1ZRIcN+lY/VOp
OtcoXftkfJq/b5b8Dc553TqbpHCRSTjJQmnbDaWwSLQwOGjezAa6Bu3BllnaRKEl
3XYwTmIy2Xfic/ONL7dHJT0+RSBbjrkVqNLg+4/Dtg9Nq5wfsik/XwGeDjc8ilYC
urGFnqAQF61nU53KCbekcAYhtGxBdMqGqZxnd63pFCgqzQwWpRHDtCkFj4aEVaJJ
kM1c8nVshjs/1+/6Ptlbej/2iTWK5dc5exkHFjin9UDhdXT0ypx8HnBQpVb5qOzA
kW5t+BJA+yQG4TEKOrCbJRkYF5Zxg2XIjkJf2nl0jo+TAmQRrG+RS8nh3/3S/x0F
ahjSjdNFIRoqsTwS82tNJ+r/Y8RkVaPNcFG7v4zBuZ0xmXYWaqhFnVyHmbeOv9ot
jFQNT0MhLYA56t76YWfJheElTKwi1BkJwPsduXfYsl144zsWTJkQzKTG+r/R0BSG
UZ6M2axDAosv4XFG3Zc43yRkrxaBMVIo2q3P703B2cdAQIxkSdCpPAQZU1q1DZcF
AuoH4VcsHpCcomhjpoa2RWLKNMokC5vMiCuLLdgDJhXafuZdbLk=
=7DkH
-----END PGP SIGNATURE-----

--lgqwv4ykv6pafxpf--
