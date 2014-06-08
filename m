From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2 1/1] Input: max8997_haptic - Check return values
Date: Sat, 7 Jun 2014 23:12:09 -0700
Message-ID: <20140608061209.GC6982@core.coreip.homeip.net>
References: <1401704643-27846-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f181.google.com ([209.85.213.181]:53663 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752859AbaFHGMM (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 8 Jun 2014 02:12:12 -0400
Received: by mail-ig0-f181.google.com with SMTP id h3so2405162igd.8
        for <linux-input@vger.kernel.org>; Sat, 07 Jun 2014 23:12:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1401704643-27846-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: linux-input@vger.kernel.org, Donggeun Kim <dg77.kim@samsung.com>

On Mon, Jun 02, 2014 at 03:54:03PM +0530, Sachin Kamat wrote:
> Check the return value of regulator_enable and pwm_enable to
> avoid errors.
> Fixes the following warning:
> drivers/input/misc/max8997_haptic.c:185:19: warning: ignoring return =
value of =E2=80=98regulator_enable=E2=80=99, declared with attribute wa=
rn_unused_result [-Wunused-result]
>=20
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Cc: Donggeun Kim <dg77.kim@samsung.com>
> ---
> Changes since v1:
> * checked the return value of pwm_enable as suggested by Dmitry.
> * Make chip->enabled =3D true only if enablement is
> successful.
> ---
>  drivers/input/misc/max8997_haptic.c |   17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/input/misc/max8997_haptic.c b/drivers/input/misc=
/max8997_haptic.c
> index 1fea5484941f..11f4d84625b3 100644
> --- a/drivers/input/misc/max8997_haptic.c
> +++ b/drivers/input/misc/max8997_haptic.c
> @@ -181,11 +181,20 @@ static void max8997_haptic_enable(struct max899=
7_haptic *chip)
>  	}
> =20
>  	if (!chip->enabled) {
> -		chip->enabled =3D true;
> -		regulator_enable(chip->regulator);
> +		error =3D regulator_enable(chip->regulator);
> +		if (error) {
> +			dev_err(chip->dev, "Failed to enable regulator\n");
> +			goto out;
> +		}
>  		max8997_haptic_configure(chip);
> -		if (chip->mode =3D=3D MAX8997_EXTERNAL_MODE)
> -			pwm_enable(chip->pwm);
> +		if (chip->mode =3D=3D MAX8997_EXTERNAL_MODE) {
> +			error =3D pwm_enable(chip->pwm);
> +			if (error) {
> +				dev_err(chip->dev, "Failed to enable PWM\n");

I think we should also disable regulator here, I'll add it.

> +				goto out;
> +			}
> +		}
> +		chip->enabled =3D true;
>  	}
> =20
>  out:
> --=20
> 1.7.9.5
>=20

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
