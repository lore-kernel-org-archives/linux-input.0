From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v4 3/4] mfd: max77693: add haptic of_compatible in
 mfd_cell
Date: Tue, 16 Sep 2014 15:41:48 -0700
Message-ID: <20140916224148.GS25162@lee--X1>
References: <1410440062-19963-1-git-send-email-jaewon02.kim@samsung.com>
 <1410440062-19963-4-git-send-email-jaewon02.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f174.google.com ([209.85.192.174]:54079 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752938AbaIPWmJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 16 Sep 2014 18:42:09 -0400
Received: by mail-pd0-f174.google.com with SMTP id v10so714334pde.33
        for <linux-input@vger.kernel.org>; Tue, 16 Sep 2014 15:42:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1410440062-19963-4-git-send-email-jaewon02.kim@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jaewon Kim <jaewon02.kim@samsung.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>, Chanwoo Choi <cw00.choi@samsung.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Thu, 11 Sep 2014, Jaewon Kim wrote:

> This patch add haptic of_compatible in order to use the haptic
> device driver using Devicetree.
>=20
> Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>
> Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
> ---
>  drivers/mfd/max77693.c |    5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Acked-by: Lee Jones <lee.jones@linaro.org>

> diff --git a/drivers/mfd/max77693.c b/drivers/mfd/max77693.c
> index fbfed56..5b516fe 100644
> --- a/drivers/mfd/max77693.c
> +++ b/drivers/mfd/max77693.c
> @@ -46,7 +46,10 @@ static const struct mfd_cell max77693_devs[] =3D {
>  	{ .name =3D "max77693-charger", },
>  	{ .name =3D "max77693-flash", },
>  	{ .name =3D "max77693-muic", },
> -	{ .name =3D "max77693-haptic", },
> +	{
> +		.name =3D "max77693-haptic",
> +		.of_compatible =3D "maxim,max77693-haptic",
> +	},
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
