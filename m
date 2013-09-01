From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 2/3] driver: input: twl4030-vibra: fix missing of_node_put
Date: Sun, 1 Sep 2013 20:01:31 +0300
Message-ID: <522372EB.1060701@ti.com>
References: <522190ED.6020909@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:54299 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755822Ab3IARB3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 1 Sep 2013 13:01:29 -0400
In-Reply-To: <522190ED.6020909@huawei.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Libo Chen <clbchenlibo.chen@huawei.com>
Cc: dmitry.torokhov@gmail.com, Bill Pemberton <wfp5p@virginia.edu>, broonie@opensource.wolfsonmicro.com, linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

On 08/31/2013 09:45 AM, Libo Chen wrote:
>=20
> decrease node device_node refcount after task completion
>=20
> Signed-off-by: Libo Chen <libo.chen@huawei.com>

Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

> ---
>  drivers/input/misc/twl4030-vibra.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
>=20
> diff --git a/drivers/input/misc/twl4030-vibra.c b/drivers/input/misc/=
twl4030-vibra.c
> index 68a5f33..b8d1526 100644
> --- a/drivers/input/misc/twl4030-vibra.c
> +++ b/drivers/input/misc/twl4030-vibra.c
> @@ -185,8 +185,10 @@ static bool twl4030_vibra_check_coexist(struct t=
wl4030_vibra_data *pdata,
>  	if (pdata && pdata->coexist)
>  		return true;
>=20
> -	if (of_find_node_by_name(node, "codec"))
> +	if (of_find_node_by_name(node, "codec")) {
> +		of_node_put(node);
>  		return true;
> +	}
>=20
>  	return false;
>  }
>=20


--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
