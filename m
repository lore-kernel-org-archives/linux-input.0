From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 3/3] driver: input: twl6040-vibra: fix missing of_node_put
Date: Sun, 1 Sep 2013 19:59:58 +0300
Message-ID: <5223728E.8000905@ti.com>
References: <522190F1.3010103@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:54139 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757569Ab3IARAE (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 1 Sep 2013 13:00:04 -0400
In-Reply-To: <522190F1.3010103@huawei.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Libo Chen <clbchenlibo.chen@huawei.com>
Cc: dmitry.torokhov@gmail.com, Bill Pemberton <wfp5p@virginia.edu>, broonie@opensource.wolfsonmicro.com, javier@dowhile0.org, linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Li Zefan <lizefan@huawei.com>, "zhangwei(Jovi)" <jovi.zhangwei@huawei.com>

On 08/31/2013 09:45 AM, Libo Chen wrote:
>=20
> decrease twl6040_core_node device_node refcount after task completion
>=20
> There are two ways to implement the function of_node_put through
> the marco CONFIG_OF_DYNAMIC, so it is save to call directly.
>=20
> Signed-off-by: Libo Chen <libo.chen@huawei.com>

Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

> ---
>  drivers/input/misc/twl6040-vibra.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
>=20
> diff --git a/drivers/input/misc/twl6040-vibra.c b/drivers/input/misc/=
twl6040-vibra.c
> index 0c2dfc8..f16193a 100644
> --- a/drivers/input/misc/twl6040-vibra.c
> +++ b/drivers/input/misc/twl6040-vibra.c
> @@ -271,12 +271,14 @@ static int twl6040_vibra_probe(struct platform_=
device *pdev)
>  #endif
>=20
>  	if (!pdata && !twl6040_core_node) {
> +		of_node_put(twl6040_core_node);
>  		dev_err(&pdev->dev, "platform_data not available\n");
>  		return -EINVAL;
>  	}
>=20
>  	info =3D devm_kzalloc(&pdev->dev, sizeof(*info), GFP_KERNEL);
>  	if (!info) {
> +		of_node_put(twl6040_core_node);
>  		dev_err(&pdev->dev, "couldn't allocate memory\n");
>  		return -ENOMEM;
>  	}
> @@ -304,6 +306,7 @@ static int twl6040_vibra_probe(struct platform_de=
vice *pdev)
>  				     &vddvibl_uV);
>  		of_property_read_u32(twl6040_core_node, "ti,vddvibr-uV",
>  				     &vddvibr_uV);
> +		of_node_put(twl6040_core_node);
>  	}
>=20
>  	if ((!info->vibldrv_res && !info->viblmotor_res) ||
>=20


--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
