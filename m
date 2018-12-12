From: Benson Leung <bleung@google.com>
Subject: Re: [PATCH v2] MAINTAINERS: add maintainers for ChromeOS EC
 sub-drivers
Date: Wed, 12 Dec 2018 10:21:26 -0800
Message-ID: <20181212182126.GA32052@google.com>
References: <20181211190953.13626-1-enric.balletbo@collabora.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tThc/1wpZn/ma/RB"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181211190953.13626-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: linux-kernel@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>, linux-pwm@vger.kernel.org, linux-iio@vger.kernel.org, Alexandre Belloni <alexandre.belloni@bootlin.com>, linux-i2c@vger.kernel.org, groeck@chromium.org, kernel@collabora.com, linux-rtc@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>, Benson Leung <bleung@chromium.org>, Sebastian Reichel <sre@kernel.org>, linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jonathan Cameron <jic23@kernel.org>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, devicetree@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, linux-pm@vger.kernel.org, MyungJoo Ham <myungjoo.ham@samsung.com>, Lee Jones <lee.jones@linaro.org>, Hartmut Knaack <knaack.h@gmx.de>, Rob
List-Id: linux-input@vger.kernel.org


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 11, 2018 at 08:09:52PM +0100, Enric Balletbo i Serra wrote:
> There are multiple ChromeOS EC sub-drivers spread in different
> subsystems, as all of them are related to the Chrome stuff add
> Benson and myself as a maintainers for all these sub-drivers.
>=20
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Signed-off-by: Benson Leung <bleung@chromium.org>

Thanks for sending this, Enric.

> ---
>=20
> Changes in v2:
> - Fix typo in Benson email address.
>=20
>  MAINTAINERS | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a24129b0b043..bbe7180e2851 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3625,6 +3625,30 @@ S:	Maintained
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/bleung/chrome-platf=
orm.git
>  F:	drivers/platform/chrome/
> =20
> +CHROMEOS EC SUBDRIVERS
> +M:	Benson Leung <bleung@chromium.org>
> +M:	Enric Balletbo i Serra <enric.balletbo@collabora.com>
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/extcon/extcon-usbc-cros-ec.txt
> +F:	Documentation/devicetree/bindings/input/cros-ec-keyb.txt
> +F:	Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.txt
> +F:	Documentation/devicetree/bindings/i2c/i2c-cros-ec-tunnel.txt
> +F:	Documentation/devicetree/bindings/mfd/cros-ec.txt
> +F:	Documentation/ABI/testing/sysfs-bus-iio-cros-ec
> +F:	drivers/extcon/extcon-usbc-cros-ec.c
> +F:	drivers/i2c/busses/i2c-cros-ec-tunnel.c
> +F:	drivers/iio/accel/cros_ec*
> +F:	drivers/iio/common/cros_ec_sensors/
> +F:	drivers/iio/light/cros_ec*
> +F:	drivers/iio/pressure/cros_ec*
> +F:	drivers/input/keyboard/cros_ec*
> +F:	drivers/mfd/cros_ec*
> +F:	drivers/power/supply/cros_usbpd-charger.c
> +F:	drivers/pwm/pwm-cros-ec.c
> +F:	drivers/rtc/rtc-cros-ec.c
> +F:	include/linux/iio/common/cros_ec_sensors_core.h
> +F:	include/linux/mfd/cros_ec*
> +
>  CIRRUS LOGIC AUDIO CODEC DRIVERS
>  M:	Brian Austin <brian.austin@cirrus.com>
>  M:	Paul Handrigan <Paul.Handrigan@cirrus.com>
> --=20
> 2.19.2
>=20

--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--tThc/1wpZn/ma/RB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6gYDF28Li+nEiKLaHwn1ewov5lgFAlwRUaYACgkQHwn1ewov
5ljVzA/+LrEt1Rm2OOw/34K53k7jK/9/Y8LDf9Wp9RZ/BeOeZScECxRYkfKN9XL6
LUzgBp+z/BgBOy4BYOjAeH5rknXpVieJkH/3I8AIi33oEpeWC0KxkyyNJIWjj7D1
fq5Cz+DI9GKF4a/onTVsMYRoYftRLYTm+L/z3hJzLAYkqcwShs9ak15M/qDeFlZ8
KF/Im4yeInCBHg6giScg72tMV7zh40pBOTopcMbzXAHch56OzXE4i0PueJJFhhCb
BHesObxRHQEe+2TiijJRE1aoXKqKCwLwhz2uqo7qhnX+OItMUI2FQLkO0H8GrvZh
+9ZrENqy1rpLjYRWF92nHfv1FSXRhYHbidXHh045nSMdOElQqSQXDYa1JX9MNAZ5
IU1LXMkNRwOz717JgSe2SszlkOw9fQK2mHhxkbqhwzvxh50TX2QHIfcSDW3wiSQT
BW4sxqv8+DWKsOO2yPnq2wsG/AmaKDBSCUTif1U7e12G33etvychk1eN+4Dv8Fni
fGu416RC9xcUe8vqXi8fDfFEpgqu5NyIiVnZQ/MTnoyFjV7u1nut38FQQmfRbOUM
NMKLgGirJrY+ar4P/uyZvuakHpXEb0rZ7QGlWDcdtuoqMLlvSM8m35y9XTzhsVC3
B0NfMIoxmuw7FQiGK7tI8eCdF8/+aCPxmpcM49SQWF9SUu+tmPk=
=WY6c
-----END PGP SIGNATURE-----

--tThc/1wpZn/ma/RB--
