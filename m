From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v3 3/4] mfd: max77693: add haptic of_compatible in
 mfd_cell
Date: Tue, 9 Sep 2014 09:15:35 +0100
Message-ID: <20140909081535.GI30307@lee--X1>
References: <1409917702-17009-1-git-send-email-jaewon02.kim@samsung.com>
 <1409917702-17009-4-git-send-email-jaewon02.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f179.google.com ([209.85.223.179]:51456 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751040AbaIIIPl (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 9 Sep 2014 04:15:41 -0400
Received: by mail-ie0-f179.google.com with SMTP id rl12so3618475iec.38
        for <linux-input@vger.kernel.org>; Tue, 09 Sep 2014 01:15:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1409917702-17009-4-git-send-email-jaewon02.kim@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jaewon Kim <jaewon02.kim@samsung.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>

On Fri, 05 Sep 2014, Jaewon Kim wrote:

> This patch add haptic of_compatible in order to use the haptic
> device driver using Devicetree.
>=20
> Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>
> Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
> ---
>  drivers/mfd/max77693.c |    5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/mfd/max77693.c b/drivers/mfd/max77693.c
> index fbfed56..03fd431 100644
> --- a/drivers/mfd/max77693.c
> +++ b/drivers/mfd/max77693.c
> @@ -46,7 +46,10 @@ static const struct mfd_cell max77693_devs[] =3D {
>  	{ .name =3D "max77693-charger", },
>  	{ .name =3D "max77693-flash", },
>  	{ .name =3D "max77693-muic", },
> -	{ .name =3D "max77693-haptic", },
> +	{
> +	  .name =3D "max77693-haptic",
> +	  .of_compatible =3D "maxim,max77693-haptic",
> +	},

Proper tabbing please.

>  };
> =20
>  static const struct regmap_config max77693_regmap_config =3D {

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
