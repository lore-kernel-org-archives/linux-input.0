From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 2/3] Input: twl6040-vibra: fix child-node lookup
Date: Mon, 13 Nov 2017 16:10:52 +0200
Message-ID: <e2d4212c-cb75-d98a-caa1-b1d7b2f165f2@ti.com>
References: <20171111154339.16875-1-johan@kernel.org>
 <20171111154339.16875-2-johan@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from lelnx194.ext.ti.com ([198.47.27.80]:9236 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751337AbdKMOKY (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 13 Nov 2017 09:10:24 -0500
In-Reply-To: <20171111154339.16875-2-johan@kernel.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Johan Hovold <johan@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, stable <stable@vger.kernel.org>, "H . Nikolaus Schaller" <hns@goldelico.com>



On 2017-11-11 17:43, Johan Hovold wrote:
> Fix child-node lookup during probe, which ended up searching the whole
> device tree depth-first starting at parent rather than just matching on
> its children.
> 
> Later sanity checks on node properties (which would likely be missing)
> should prevent this from causing much trouble however, especially as the
> original premature free of the parent node has already been fixed
> separately (but that "fix" was apparently never backported to stable).
> 
> Fixes: e7ec014a47e4 ("Input: twl6040-vibra - update for device tree support")
> Fixes: c52c545ead97 ("Input: twl6040-vibra - fix DT node memory management")
> Cc: stable <stable@vger.kernel.org>     # 3.6

Note that of_get_child_by_name() is not present in 3.6, this was the
reason the original implementation was using of_find_node_by_name()

> Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Cc: H. Nikolaus Schaller <hns@goldelico.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>  drivers/input/misc/twl6040-vibra.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/input/misc/twl6040-vibra.c b/drivers/input/misc/twl6040-vibra.c
> index 5690eb7ff954..15e0d352c4cc 100644
> --- a/drivers/input/misc/twl6040-vibra.c
> +++ b/drivers/input/misc/twl6040-vibra.c
> @@ -248,8 +248,7 @@ static int twl6040_vibra_probe(struct platform_device *pdev)
>  	int vddvibr_uV = 0;
>  	int error;
>  
> -	of_node_get(twl6040_core_dev->of_node);
> -	twl6040_core_node = of_find_node_by_name(twl6040_core_dev->of_node,
> +	twl6040_core_node = of_get_child_by_name(twl6040_core_dev->of_node,
>  						 "vibra");
>  	if (!twl6040_core_node) {
>  		dev_err(&pdev->dev, "parent of node is missing?\n");
> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
