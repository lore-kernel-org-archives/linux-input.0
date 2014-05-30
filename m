From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/1] Input: max8997_haptic - Check return value of
 regulator_enable
Date: Fri, 30 May 2014 13:05:26 -0700
Message-ID: <20140530200526.GB27692@core.coreip.homeip.net>
References: <1401446173-21981-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f53.google.com ([209.85.160.53]:34415 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030261AbaE3UFa (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 30 May 2014 16:05:30 -0400
Received: by mail-pb0-f53.google.com with SMTP id md12so2058569pbc.26
        for <linux-input@vger.kernel.org>; Fri, 30 May 2014 13:05:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1401446173-21981-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: linux-input@vger.kernel.org, Donggeun Kim <dg77.kim@samsung.com>

Hi Sachin,

On Fri, May 30, 2014 at 04:06:13PM +0530, Sachin Kamat wrote:
> Fixes the following warning:
> drivers/input/misc/max8997_haptic.c:185:19: warning: ignoring return =
value of =E2=80=98regulator_enable=E2=80=99, declared with attribute wa=
rn_unused_result [-Wunused-result]
>=20
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Cc: Donggeun Kim <dg77.kim@samsung.com>
> ---
>  drivers/input/misc/max8997_haptic.c |    6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/input/misc/max8997_haptic.c b/drivers/input/misc=
/max8997_haptic.c
> index 1fea5484941f..4f4c34e135f5 100644
> --- a/drivers/input/misc/max8997_haptic.c
> +++ b/drivers/input/misc/max8997_haptic.c
> @@ -182,7 +182,11 @@ static void max8997_haptic_enable(struct max8997=
_haptic *chip)
> =20
>  	if (!chip->enabled) {
>  		chip->enabled =3D true;
> -		regulator_enable(chip->regulator);
> +		error =3D regulator_enable(chip->regulator);
> +		if (error) {
> +			dev_err(chip->dev, "Failed to enable regulator");
> +			goto out;

We should not be leaving with chip->enabled =3D=3D true in this case.

> +		}
>  		max8997_haptic_configure(chip);
>  		if (chip->mode =3D=3D MAX8997_EXTERNAL_MODE)
>  			pwm_enable(chip->pwm);

What about checking this one as well?

Thanks.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
