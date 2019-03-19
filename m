From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 2/6] input: da9063_onkey: remove platform_data support
Date: Tue, 19 Mar 2019 13:49:18 +0100
Message-ID: <20190319124917.sidcf742iml2jzam@verge.net.au>
References: <20190318154759.21978-1-wsa+renesas@sang-engineering.com>
 <20190318154759.21978-3-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190318154759.21978-3-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>, Support Opensource <support.opensource@diasemi.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, Mar 18, 2019 at 04:47:54PM +0100, Wolfram Sang wrote:
> There are no in-kernel users anymore, so remove this outdated interface.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

> ---
>  drivers/input/misc/da9063_onkey.c | 11 ++---------
>  1 file changed, 2 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/input/misc/da9063_onkey.c b/drivers/input/misc/da9063_onkey.c
> index 3e9c353d82ef..e3a273c74123 100644
> --- a/drivers/input/misc/da9063_onkey.c
> +++ b/drivers/input/misc/da9063_onkey.c
> @@ -22,7 +22,6 @@
>  #include <linux/regmap.h>
>  #include <linux/of.h>
>  #include <linux/mfd/da9063/core.h>
> -#include <linux/mfd/da9063/pdata.h>
>  #include <linux/mfd/da9063/registers.h>
>  #include <linux/mfd/da9062/core.h>
>  #include <linux/mfd/da9062/registers.h>
> @@ -201,8 +200,6 @@ static void da9063_cancel_poll(void *data)
>  
>  static int da9063_onkey_probe(struct platform_device *pdev)
>  {
> -	struct da9063 *da9063 = dev_get_drvdata(pdev->dev.parent);
> -	struct da9063_pdata *pdata = dev_get_platdata(da9063->dev);
>  	struct da9063_onkey *onkey;
>  	const struct of_device_id *match;
>  	int irq;
> @@ -229,12 +226,8 @@ static int da9063_onkey_probe(struct platform_device *pdev)
>  		return -ENXIO;
>  	}
>  
> -	if (pdata)
> -		onkey->key_power = pdata->key_power;
> -	else
> -		onkey->key_power =
> -			!of_property_read_bool(pdev->dev.of_node,
> -					       "dlg,disable-key-power");
> +	onkey->key_power = !of_property_read_bool(pdev->dev.of_node,
> +						  "dlg,disable-key-power");
>  
>  	onkey->input = devm_input_allocate_device(&pdev->dev);
>  	if (!onkey->input) {
> -- 
> 2.11.0
> 
