From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 05/10] max77693: Move state container to common header
Date: Sat, 23 May 2015 17:11:52 +0200
Message-ID: <20150523151151.GA14029@earth>
References: <1430305114-23598-1-git-send-email-k.kozlowski.k@gmail.com>
 <1430305114-23598-6-git-send-email-k.kozlowski.k@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="VbJkn9YxBvnuCH5J"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1430305114-23598-6-git-send-email-k.kozlowski.k@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
Cc: Chanwoo Choi <cw00.choi@samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-input@vger.kernel.org


--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Apr 29, 2015 at 07:58:30PM +0900, Krzysztof Kozlowski wrote:
> This prepares for merging some of the drivers between max77693 and
> max77843 so the child MFD driver can be attached to any parent MFD main
> driver.
>=20
> Move the state container to common header file. Additionally add
> consistent 'i2c' prefixes to its members (of 'struct i2c_client' type).
>=20
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
> ---
>  drivers/extcon/extcon-max77693.c     |  3 ++-
>  drivers/input/misc/max77693-haptic.c |  1 +
>  drivers/mfd/max77693.c               | 31 +++++++++++++------------
>  drivers/power/max77693_charger.c     |  1 +
>  drivers/regulator/max77693.c         |  1 +
>  include/linux/mfd/max77693-common.h  | 44 ++++++++++++++++++++++++++++++=
++++++
>  include/linux/mfd/max77693-private.h | 25 --------------------
>  7 files changed, 65 insertions(+), 41 deletions(-)
>  create mode 100644 include/linux/mfd/max77693-common.h
>=20
> [...]
>
> diff --git a/drivers/power/max77693_charger.c b/drivers/power/max77693_ch=
arger.c
> index 754879eb59f6..eb68d0572799 100644
> --- a/drivers/power/max77693_charger.c
> +++ b/drivers/power/max77693_charger.c
> @@ -21,6 +21,7 @@
>  #include <linux/regmap.h>
>  #include <linux/mfd/max77693.h>
>  #include <linux/mfd/max77693-private.h>
> +#include <linux/mfd/max77693-common.h>
> =20
>  #define MAX77693_CHARGER_NAME				"max77693-charger"
>  static const char *max77693_charger_model		=3D "MAX77693";
> [...]

Acked-By: Sebastian Reichel <sre@kernel.org>

-- Sebastian

--VbJkn9YxBvnuCH5J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVYJi1AAoJENju1/PIO/qatLIP/0a8NA8dHoTE2pkJ/1YuNacL
PJKrp1VByHUNCkQ3QaBv2GpXE4e9azFUjVBYO91xGjvMUGmnhuz4JjHyEIIZvFhi
M/Pva0IdZQZ9aKZvN8yztuS3xKkj9GZ9LYxj68AnXV2sYHSrZOwXL2mt/lp+Sr5W
zDaLxHv9FZt7x7RoDdjnr1Vdz5oPCUsBZ/OqTEXIPfNQfWFavc3zGVT8brPBMvHB
TRNL7JmPzWEiYwF6lVvlOsFRWosAz+onPnEHz0E66kLSPoQ8HdAwnUgbZ0sjQK5b
fUBrTpKW0xqDPQX3itT51Twgl8VJuFjSaBpIqthuA2iqbRW9imBy2Mewkq1enfG0
6Wh9CbZwfLG8z6C2YIMv0/1vqVAGsr7CXGgNIUq40PdGgg5UjSmuYxrJCtbtIOLy
GGuRUb1obByo4zdVAcWUE39nXgJxose+JFlMWwnE9hbQetYyjHS70AX342OCQtR3
6KgQxbD2BipER/lizm+iarlsp7fbXdzyAtsXIYek9djK8HO/xpsWQoohOZgLbC7C
EMDYskd6Lmlz7nRJemIvaIlhLb2+80YHxrdlzdxp7AQdhzh1wJbLV00Hje11ccvA
hRTnv9fmLlWrdIV7DMcsrex+NhDRzu01AgzPYGHleqriWgsR0ev6keaArLBz4xBC
4gFEJR04uqifHsYB2Ysa
=PT7D
-----END PGP SIGNATURE-----

--VbJkn9YxBvnuCH5J--
