From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 1/3] Input: twl4030-vibra: fix sibling-node lookup
Date: Mon, 13 Nov 2017 09:17:09 +0200
Message-ID: <2f1d38a1-2646-1c9a-ccb7-62f8a62ca110@ti.com>
References: <20171111154339.16875-1-johan@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from lelnx194.ext.ti.com ([198.47.27.80]:27150 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751568AbdKMHQo (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 13 Nov 2017 02:16:44 -0500
In-Reply-To: <20171111154339.16875-1-johan@kernel.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Johan Hovold <johan@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, stable <stable@vger.kernel.org>, Marek Belisko <marek@goldelico.com>



On 2017-11-11 17:43, Johan Hovold wrote:
> A helper purported to look up a child node based on its name was using
> the wrong of-helper and ended up prematurely freeing the parent of-node
> while searching the whole device tree depth-first starting at the parent
> node.
> 
> Fixes: 64b9e4d803b1 ("input: twl4030-vibra: Support for DT booted kernel")
> Fixes: e661d0a04462 ("Input: twl4030-vibra - fix ERROR: Bad of_node_put() warning")
> Cc: stable <stable@vger.kernel.org>     # 3.7
> Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Cc: Marek Belisko <marek@goldelico.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>

Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

> ---
>  drivers/input/misc/twl4030-vibra.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/input/misc/twl4030-vibra.c b/drivers/input/misc/twl4030-vibra.c
> index 6c51d404874b..c37aea9ac272 100644
> --- a/drivers/input/misc/twl4030-vibra.c
> +++ b/drivers/input/misc/twl4030-vibra.c
> @@ -178,12 +178,14 @@ static SIMPLE_DEV_PM_OPS(twl4030_vibra_pm_ops,
>  			 twl4030_vibra_suspend, twl4030_vibra_resume);
>  
>  static bool twl4030_vibra_check_coexist(struct twl4030_vibra_data *pdata,
> -			      struct device_node *node)
> +			      struct device_node *parent)
>  {
> +	struct device_node *node;
> +
>  	if (pdata && pdata->coexist)
>  		return true;
>  
> -	node = of_find_node_by_name(node, "codec");
> +	node = of_get_child_by_name(parent, "codec");
>  	if (node) {
>  		of_node_put(node);
>  		return true;
> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
