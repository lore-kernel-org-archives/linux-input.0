From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2 7/7] Input: pwm-beeper - switch to using "atomic" PWM
 API
Date: Fri, 20 Jan 2017 11:23:55 +0100
Message-ID: <20170120102355.GG3824@ulmo.ba.sec>
References: <20170119224057.9995-1-dmitry.torokhov@gmail.com>
 <20170119224057.9995-7-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="L+ofChggJdETEG3Y"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34661 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751714AbdATKaM (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 20 Jan 2017 05:30:12 -0500
Content-Disposition: inline
In-Reply-To: <20170119224057.9995-7-dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, David Lechner <david@lechnology.com>, Frieder Schrempf <frieder.schrempf@exceet.de>


--L+ofChggJdETEG3Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 19, 2017 at 02:40:57PM -0800, Dmitry Torokhov wrote:
> The "atomic" API allows us to configure PWM period and duty cycle and
> enable it in one call.
>=20
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/input/misc/pwm-beeper.c | 25 ++++++++++++++++---------
>  1 file changed, 16 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/input/misc/pwm-beeper.c b/drivers/input/misc/pwm-bee=
per.c
> index 7b213e0ab06c..3408dc666afa 100644
> --- a/drivers/input/misc/pwm-beeper.c
> +++ b/drivers/input/misc/pwm-beeper.c
> @@ -37,13 +37,16 @@ struct pwm_beeper {
> =20
>  static int pwm_beeper_on(struct pwm_beeper *beeper, unsigned long period)
>  {
> +	struct pwm_state state;
>  	int error;
> =20
> -	error =3D pwm_config(beeper->pwm, period / 2, period);
> -	if (error)
> -		return error;
> +	pwm_get_state(beeper->pwm, &state);
> =20
> -	error =3D pwm_enable(beeper->pwm);
> +	state.enabled =3D true;
> +	state.period =3D period;
> +	pwm_set_relative_duty_cycle(&state, 50, 100);
> +
> +	error =3D pwm_apply_state(beeper->pwm, &state);
>  	if (error)
>  		return error;
> =20

I was going to say that you need to update pwm_beeper_off() to use the
atomic API as well, but I think I might keep pwm_disable() around for
cases such as this.

Reviewed-by: Thierry Reding <thierry.reding@gmail.com>

--L+ofChggJdETEG3Y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAliB5TsACgkQ3SOs138+
s6G5+A//UWIxd1rAywj8gaVBspPX00vReDLSEUguDiJLDnz+OMFMsIBwlJERZQsB
MglAQu4v4OZlF3ZYBESJaxRKY5uzDGJSQAA2nOwGfSQdNXXEGt1pNvMKJylQPj9B
4pu2LOLUFIuzNMNCLeN7Du17Z4oSJQAEA38rgij5xYQA+sZvJ9Qqqvv5T6gzzP5F
hKYfLpMe5TS1QgM7mlJdFXZN5mtpFFGxHcyh8XN2Q74w9pXKpT2xWCDHiiVa8nWA
seorKy+cndijcrjXrx8BOOu9+fP+JIRo98zYgsM+Pid8fuyhpe/iAvdiBldZ9uMS
NVpODpkomE2bc9maMh7AVLy37ElfRU29t3Tb/ykt6c2ov9SXLC+hsJcegrDDtYUY
FTbi8stRlCLUqY8i5MIxtOV/Ldzdwj9kuORrSLXfCXXDE6kqiaoQde/RxKgtXy3R
5BX3U5XwN6Sby2GNb9/uaQT1aqKpyyIffiFzfHl4R/UXzectIuamxH0xWbJdCrsy
XTrLZDJfBqWTMu+Th2w+S2nbiiY/BOXxh6ODj0dXa998piUuFJ6ZXUcqSpsqmYB7
JVNPSCO1tsNDIvPdek7ydEsOSePLvWe8GdKeIV8llvoeVOxlcqVFLqn9/9jsCoZp
4mNKn825yYGVjmgfqJ8SPOXc++9fkMVKM3PRmBNpMH1q610J8Zs=
=w7Yx
-----END PGP SIGNATURE-----

--L+ofChggJdETEG3Y--
