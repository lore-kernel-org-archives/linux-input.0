From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 1/2] Input: mcs_touchkey: add device tree support
Date: Wed, 21 May 2014 14:48:19 +0100
Message-ID: <20140521134819.GG17827@leverpostej>
References: <537C3EF5.90000@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:58387 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751202AbaEUNs0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 21 May 2014 09:48:26 -0400
Content-Disposition: inline
In-Reply-To: <537C3EF5.90000@samsung.com>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Beomho Seo <beomho.seo@samsung.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, Joonyoung Shim <jy0922.shim@samsung.com>, Myungjoo Ham <myungjoo.ham@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>

On Wed, May 21, 2014 at 06:51:49AM +0100, Beomho Seo wrote:
> Add device tree support for mcs touchkey driver.
> Tested on exynos 4412 board.
> 
> Signed-off-by: Beomho Seo <beomho.seo@samsung.com>
> Cc: Joonyoung Shim <jy0922.shim@samsung.com>
> ---
>  drivers/input/keyboard/mcs_touchkey.c |   73 +++++++++++++++++++++++++++++++--
>  1 file changed, 69 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/input/keyboard/mcs_touchkey.c b/drivers/input/keyboard/mcs_touchkey.c
> index 1da8e0b..9bff47b 100644
> --- a/drivers/input/keyboard/mcs_touchkey.c
> +++ b/drivers/input/keyboard/mcs_touchkey.c
> @@ -19,6 +19,7 @@
>  #include <linux/irq.h>
>  #include <linux/slab.h>
>  #include <linux/pm.h>
> +#include <linux/of_gpio.h>
> 
>  /* MCS5000 Touchkey */
>  #define MCS5000_TOUCHKEY_STATUS		0x04
> @@ -96,6 +97,60 @@ static irqreturn_t mcs_touchkey_interrupt(int irq, void *dev_id)
>  	return IRQ_HANDLED;
>  }
> 
> +#ifdef CONFIG_OF
> +static struct mcs_platform_data *mcs_touchkey_parse_dt(struct device *dev)
> +{
> +	struct mcs_platform_data *pdata;
> +	struct device_node *np = dev->of_node;
> +	unsigned int keymap[2];
> +	unsigned int len;
> +	int i = 0;
> +	const __be32 *prop;

Hmm. Almost every use of __be32 *prop values is indicative of something
that can be done with existing accessors. I suspect that may be true
here...

> +
> +	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
> +	if (!pdata) {
> +		dev_err(dev, "Failed to allocate platform data\n");
> +		return ERR_PTR(-ENOMEM);
> +	}
> +
> +	prop = of_get_property(np, "linux,code", &len);
> +	if (!prop) {
> +		dev_err(dev, "Failed to get code\n");
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	if (len % sizeof(u32)) {
> +		dev_err(dev, "Malformed keycode property\n");
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	pdata->keymap_size = len / sizeof(u32);

Use of_property_count_u32_elems. It does all of this and returns a
negative error code if anything is wrong.

> +
> +	if (of_property_read_u32(np, "key_maxval", &pdata->key_maxval)) {
> +		dev_err(dev, "Failed to get key max value data\n");
> +		return ERR_PTR(-EINVAL);
> +	}

What is this? This sounds like an implementation detail. Why is it in
the DT?

Why doesn't it follow dt conventions ('-' rather than '_')?

> +
> +	if (pdata->keymap_size > pdata->key_maxval) {
> +		dev_err(dev, "Key map size overflow\n");
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	for (i = 0; i < pdata->keymap_size; i++) {
> +		u32 code = be32_to_cpup(prop + i);

Use the DT accessors (e.g. of_property_read_u32_index). There is
absolutely no reason to touch the raw DTB data here.

> +		keymap[i] = MCS_KEY_MAP(i, code);
> +	}
> +	pdata->keymap = keymap;
> +	return pdata;
> +}
> +#else
> +static inline struct mcs_platform_data *mcs_touchkey_parse_dt
> +						(struct device *dev)
> +{
> +	return NULL;
> +}
> +#endif
> +
>  static int mcs_touchkey_probe(struct i2c_client *client,
>  		const struct i2c_device_id *id)
>  {
> @@ -107,10 +162,14 @@ static int mcs_touchkey_probe(struct i2c_client *client,
>  	int error;
>  	int i;
> 
> -	pdata = dev_get_platdata(&client->dev);
> -	if (!pdata) {
> -		dev_err(&client->dev, "no platform data defined\n");
> -		return -EINVAL;
> +	if (&client->dev.of_node)
> +		pdata = mcs_touchkey_parse_dt(&client->dev);
> +	else
> +		pdata = dev_get_platdata(&client->dev);
> +
> +	if (IS_ERR(pdata)) {
> +		dev_err(&client->dev, "Failed to get platform data\n");
> +		return PTR_ERR(pdata);
>  	}
> 
>  	data = kzalloc(sizeof(struct mcs_touchkey_data) +
> @@ -262,11 +321,17 @@ static const struct i2c_device_id mcs_touchkey_id[] = {
>  };
>  MODULE_DEVICE_TABLE(i2c, mcs_touchkey_id);
> 
> +static struct of_device_id mcs_touchkey_dt_match[] = {
> +	{ .compatible = "mcs5000_touchkey", },
> +	{ .compatible = "mcs5080_touchkey", },

NAK. These do not follow the "$VENDOR,$DEVICE" pattern.

Mark.

> +};
> +
>  static struct i2c_driver mcs_touchkey_driver = {
>  	.driver = {
>  		.name	= "mcs_touchkey",
>  		.owner	= THIS_MODULE,
>  		.pm	= &mcs_touchkey_pm_ops,
> +		.of_match_table = of_match_ptr(mcs_touchkey_dt_match),
>  	},
>  	.probe		= mcs_touchkey_probe,
>  	.remove		= mcs_touchkey_remove,
> -- 
> 1.7.9.5
> 
