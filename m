From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2 2/7] Input: pwm-beeper - switch to using managed
 resources
Date: Fri, 20 Jan 2017 11:10:54 +0100
Message-ID: <20170120101054.GB3824@ulmo.ba.sec>
References: <20170119224057.9995-1-dmitry.torokhov@gmail.com>
 <20170119224057.9995-2-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hQiwHBbRI9kgIhsi"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170119224057.9995-2-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, David Lechner <david@lechnology.com>, Frieder Schrempf <frieder.schrempf@exceet.de>
List-Id: linux-input@vger.kernel.org


--hQiwHBbRI9kgIhsi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 19, 2017 at 02:40:52PM -0800, Dmitry Torokhov wrote:
> Use of managed resources (devm) simplifies error handling and tear down
> of the driver.
>=20
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/input/misc/pwm-beeper.c | 44 ++++++++++-------------------------=
------
>  1 file changed, 10 insertions(+), 34 deletions(-)
>=20
> diff --git a/drivers/input/misc/pwm-beeper.c b/drivers/input/misc/pwm-bee=
per.c
> index cb87e475bd23..14c52054f5b7 100644
> --- a/drivers/input/misc/pwm-beeper.c
> +++ b/drivers/input/misc/pwm-beeper.c
> @@ -95,18 +95,19 @@ static void pwm_beeper_close(struct input_dev *input)
> =20
>  static int pwm_beeper_probe(struct platform_device *pdev)
>  {
> +	struct device *dev =3D &pdev->dev;
>  	struct pwm_beeper *beeper;
>  	int error;
> =20
> -	beeper =3D kzalloc(sizeof(*beeper), GFP_KERNEL);
> +	beeper =3D devm_kzalloc(dev, sizeof(*beeper), GFP_KERNEL);
>  	if (!beeper)
>  		return -ENOMEM;
> =20
> -	beeper->pwm =3D pwm_get(&pdev->dev, NULL);
> +	beeper->pwm =3D devm_pwm_get(dev, NULL);
>  	if (IS_ERR(beeper->pwm)) {
>  		error =3D PTR_ERR(beeper->pwm);
> -		dev_err(&pdev->dev, "Failed to request pwm device: %d\n", error);
> -		goto err_free;
> +		dev_err(dev, "Failed to request pwm device: %d\n", error);

While at it, could you do a "pwm" -> "PWM" in the above. It's an
abbreviation.

Otherwise this looks like great cleanup:

Reviewed-by: Thierry Reding <thierry.reding@gmail.com>

--hQiwHBbRI9kgIhsi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAliB4i4ACgkQ3SOs138+
s6Hu4A//ceQLa3d2oeIxtWOn+w5RcKghmaYQgVM0bzBdTuUO3X6J59654ar4ySng
VReArPIDQMin8M5nWuQcvu7tVNrtZF3mcOt5JABB6cYN93vtncDK6UEWkmhw22k1
zcm5NAie9xFcs2RtlkFjSkVgIH2PXVDiRhNWCWpoOMVWODWHgpJf5oN7uHdfKyUP
Pl+qZoDI95yCk/DYz7Xeu+FA8lz90dq0NvXHUv92HmcFgquIz199YUGkn0u3Pslr
fvYIH4XlppOw2Bdqwu6Y17xc90cmgaNtLQQOm6fmeE2JFv+8IFRAN91KkPei6NWu
yrdsCDTdyPVbh4EyjhwqvRlGWIvpNx+uQiUJ3PJXlMRHNuoZVNuyP1/RMaqM3puI
lXZDNafDKUej7nXt7W7d+me+fwcJG2zr5JEBMSyhmgIRiH1SZjaQ3/EX/bIAALWO
IVVF2N6eTNxH1ToxA5YAaM3QGEY1AjsrknZdCBDspkS+as8VjaZK1Z3xr3RsIFHw
R07uQzsq6P5QEYqc3T4YoRZM9yPy6j85oTFxS+Y2r8phYMyZX3kZiKx4F84L6mno
t9DLAzZmAxHsXonxHMrQ2sZMxs9w6EMPJaBF383ME7xBVCz88HuxQTtKu3XJ+YTr
tC9U3y9F34MqnSg1LRGxyraS8i8pXAhPEZg1ehAt384osegSYa0=
=Gb2Q
-----END PGP SIGNATURE-----

--hQiwHBbRI9kgIhsi--
