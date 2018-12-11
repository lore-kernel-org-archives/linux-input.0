From: Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: Re: [PATCH v2] MAINTAINERS: add maintainers for ChromeOS EC
 sub-drivers
Date: Wed, 12 Dec 2018 00:09:07 +0100
Message-ID: <20181211230907.2gfxkllqooovwsw2@earth.universe>
References: <20181211190953.13626-1-enric.balletbo@collabora.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pjsrogytlfephcai"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181211190953.13626-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: linux-kernel@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>, linux-pwm@vger.kernel.org, linux-iio@vger.kernel.org, Alexandre Belloni <alexandre.belloni@bootlin.com>, linux-i2c@vger.kernel.org, groeck@chromium.org, kernel@collabora.com, linux-rtc@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>, Benson Leung <bleung@chromium.org>, linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jonathan Cameron <jic23@kernel.org>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, devicetree@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, linux-pm@vger.kernel.org, MyungJoo Ham <myungjoo.ham@samsung.com>, Lee Jones <lee.jones@linaro.org>, Hartmut Knaack <knaack.h@gmx.de>, Rob Herring <robh+dt@kernel.org>, Lars-Peter
List-Id: linux-input@vger.kernel.org


--pjsrogytlfephcai
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Dec 11, 2018 at 08:09:52PM +0100, Enric Balletbo i Serra wrote:
> There are multiple ChromeOS EC sub-drivers spread in different
> subsystems, as all of them are related to the Chrome stuff add
> Benson and myself as a maintainers for all these sub-drivers.
>=20
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
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

Maybe just use the following (+ extra F entry for cros_usbpd, which
does not have the ec part)?

N:	cros[-_]ec

-- Sebastian

>  CIRRUS LOGIC AUDIO CODEC DRIVERS
>  M:	Brian Austin <brian.austin@cirrus.com>
>  M:	Paul Handrigan <Paul.Handrigan@cirrus.com>

--pjsrogytlfephcai
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlwQQ5AACgkQ2O7X88g7
+pqX+w//aYjXk2l425T0xSM4PppxkSaFMcAwEQxbrDUrtC5QsF8p/AOcRux2Aekn
PN1Aw41fHu0slow5ECfwxImMvZiKKGR5HT495TQIpJfS9AD4NCjVcVx7Yc46Cdzl
o5UHBuzIZurXK16EMAoZnhtc2JsoxMccIuVhtn/HaLZ2NrjkhMh8aSfuG/8/zzGC
fDKQESeaz+Lgaat3F3vJVCnTEengARF9b2yqWix6D3sfh1y+chNJBaCjpvpzQU8C
Q+gyzX7mSBpFab4V7QMhm3hV/bW+3gEW5NkyK/1xB1/DK2EC8UwYaROw6ZmElXJ9
AtTbGiDSSTecbzTwn0Gy9SuiwlSa82rSHBWYujyeL5VGB5WJc0rvHCmHimmWvKyB
fLcN/FyV2uEdIMBnwMDbnHmszx0VOt9NGleHGJt1GM1Vk0rZU6Wyenm0uHysl4Pp
+SqTB1CkmdtD0siup+pcmU/mzWSa0bxRWoOAqGNuouT2qY1Qfz1yZIxi1Ebbs6fx
ug+q4+q/bi2FeHVwGmjxfHhQXulFEccCJM36FJ+15R2QZmCUilIinqixz61oy0FV
3nUADRywH0DM+af+8sCNHGUEQqtRUMxkPDGk6lH+NOUaa0wNLWm92zDFFoCMhhbH
p1vOYPw+CdjaLyrDiauaASd1h0i5tAowztxfHN9MuZxuGxRsCmo=
=Z0j4
-----END PGP SIGNATURE-----

--pjsrogytlfephcai--
