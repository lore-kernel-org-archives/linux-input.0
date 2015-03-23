From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 2/2] mfd: stmpe: move platform data into mfd driver
Date: Mon, 23 Mar 2015 16:11:10 +0000
Message-ID: <20150323161110.GR24804@x1>
References: <1427124553-27551-1-git-send-email-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wg0-f50.google.com ([74.125.82.50]:33942 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752288AbbCWQLQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 23 Mar 2015 12:11:16 -0400
Received: by wgs2 with SMTP id 2so42998945wgs.1
        for <linux-input@vger.kernel.org>; Mon, 23 Mar 2015 09:11:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1427124553-27551-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Samuel Ortiz <sameo@linux.intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Mon, 23 Mar 2015, Linus Walleij wrote:

> The STMPE platform data is only populated from the device tree
> in all existing users, so push the struct and make the OF case
> the norm.
>=20
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/mfd/stmpe.c       | 41 ++++++++++++++++++++++++++++++-------=
----
>  include/linux/mfd/stmpe.h | 23 +----------------------
>  2 files changed, 31 insertions(+), 33 deletions(-)
>=20
> diff --git a/drivers/mfd/stmpe.c b/drivers/mfd/stmpe.c
> index 2d7fae94c861..cb5f19749442 100644
> --- a/drivers/mfd/stmpe.c
> +++ b/drivers/mfd/stmpe.c

[...]

>  /* Called from client specific probe routines */
>  int stmpe_probe(struct stmpe_client_info *ci, enum stmpe_partnum par=
tnum)
>  {
> -	struct stmpe_platform_data *pdata =3D dev_get_platdata(ci->dev);
> +	struct stmpe_platform_data *pdata;
>  	struct device_node *np =3D ci->dev->of_node;
>  	struct stmpe *stmpe;
>  	int ret;
> =20
> -	if (!pdata) {
> -		if (!np)
> -			return -EINVAL;
> +	if (!np)
> +		return -EINVAL;

Nit: I believe this is now impossible.

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
