From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/3] Input: twl4030-vibra: fix sibling-node lookup
Date: Sat, 11 Nov 2017 09:50:59 -0800
Message-ID: <20171111175059.lwfhw2wdhlj5yxhc@dtor-ws>
References: <20171111154339.16875-1-johan@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171111154339.16875-1-johan@kernel.org>
Sender: stable-owner@vger.kernel.org
To: Johan Hovold <johan@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, stable <stable@vger.kernel.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Marek Belisko <marek@goldelico.com>
List-Id: linux-input@vger.kernel.org

On Sat, Nov 11, 2017 at 04:43:37PM +0100, Johan Hovold wrote:
> A helper purported to look up a child node based on its name was using
> the wrong of-helper and ended up prematurely freeing the parent of-node
> while searching the whole device tree depth-first starting at the parent
> node.

Ugh, this all is pretty ugly business. Can we teach MFD to allow
specifying firmware node to be attached to the platform devices it
creates in mfd_add_device() so that the leaf drivers simply call
device_property_read_XXX() on their own device and not be bothered with
weird OF refcount issues or what node they need to locate and parse?

Thanks!

> 
> Fixes: 64b9e4d803b1 ("input: twl4030-vibra: Support for DT booted kernel")
> Fixes: e661d0a04462 ("Input: twl4030-vibra - fix ERROR: Bad of_node_put() warning")
> Cc: stable <stable@vger.kernel.org>     # 3.7
> Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Cc: Marek Belisko <marek@goldelico.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>
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
> -- 
> 2.15.0
> 

-- 
Dmitry
