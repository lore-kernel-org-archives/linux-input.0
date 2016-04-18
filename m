From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/5] input: twl6040-vibra: fix DT node memory management
Date: Mon, 18 Apr 2016 14:22:00 -0700
Message-ID: <20160418212200.GC1006@dtor-ws>
References: <cover.1461009340.git.hns@goldelico.com>
 <fa39d5e67bd71ba0cde980313747f5b4d2f9be94.1461009340.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:35622 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750968AbcDRVWE (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 18 Apr 2016 17:22:04 -0400
Content-Disposition: inline
In-Reply-To: <fa39d5e67bd71ba0cde980313747f5b4d2f9be94.1461009340.git.hns@goldelico.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@pyra-handheld.com, letux-kernel@openphoenux.org

On Mon, Apr 18, 2016 at 09:55:37PM +0200, H. Nikolaus Schaller wrote:
> commit e7ec014a47e4 ("Input: twl6040-vibra - update for device tree support")
> 
> made the separate vibra DT node to a subnode of the twl6040.
> 
> It now calls of_find_node_by_name() to locate the "vibra" subnode.
> This function has a side effect to call of_node_put on() for the twl6040
> parent node passed in as a parameter. This causes trouble later on.
> 
> Solution: we must call of_node_get() before of_find_node_by_name()

God, what messed up API. Any chance we can make it a bit more sane and
not drop the reference inside it instead?

> 
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> ---
>  drivers/input/misc/twl6040-vibra.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/input/misc/twl6040-vibra.c b/drivers/input/misc/twl6040-vibra.c
> index ea63fad..7221a00 100644
> --- a/drivers/input/misc/twl6040-vibra.c
> +++ b/drivers/input/misc/twl6040-vibra.c
> @@ -262,6 +262,7 @@ static int twl6040_vibra_probe(struct platform_device *pdev)
>  	int vddvibr_uV = 0;
>  	int error;
>  
> +	of_node_get(twl6040_core_dev->of_node);
>  	twl6040_core_node = of_find_node_by_name(twl6040_core_dev->of_node,
>  						 "vibra");
>  	if (!twl6040_core_node) {
> -- 
> 2.7.3
> 

-- 
Dmitry
