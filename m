From: Markus Pargmann <m@mpgm.de>
Subject: Re: [PATCH 3/3] input: mc13783: Add DT probe support
Date: Mon, 8 Jul 2013 09:13:55 +0200
Message-ID: <20130708071355.GO16871@s25.your-server.de>
References: <1373086680-31444-1-git-send-email-shc_work@mail.ru>
 <1373086680-31444-3-git-send-email-shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from allfex.org ([78.46.73.241]:48001 "EHLO s25.allfex.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751392Ab3GHHYa (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 8 Jul 2013 03:24:30 -0400
Content-Disposition: inline
In-Reply-To: <1373086680-31444-3-git-send-email-shc_work@mail.ru>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alexander Shiyan <shc_work@mail.ru>
Cc: linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, Sascha Hauer <kernel@pengutronix.de>, Grant Likely <grant.likely@linaro.org>, Rob Herring <rob.herring@calxeda.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Shawn Guo <shawn.guo@linaro.org>

Hi,

On Sat, Jul 06, 2013 at 08:58:00AM +0400, Alexander Shiyan wrote:
> Patch adds DT support for MC13783/MC13892 PMICs.
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> ---
>  Documentation/devicetree/bindings/mfd/mc13xxx.txt | 12 +++++
>  drivers/input/misc/mc13783-pwrbutton.c            | 59 ++++++++++++++++++-----
>  2 files changed, 58 insertions(+), 13 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/mc13xxx.txt b/Documentation/devicetree/bindings/mfd/mc13xxx.txt
> index abd9e3c..967bed6 100644
> --- a/Documentation/devicetree/bindings/mfd/mc13xxx.txt
> +++ b/Documentation/devicetree/bindings/mfd/mc13xxx.txt
> @@ -10,6 +10,11 @@ Optional properties:
>  - fsl,mc13xxx-uses-touch : Indicate the touchscreen controller is being used
>  
>  Sub-nodes:
> +- buttons : Contain power button nodes. Each button should be declared as
> +  "btn<num>" and contain code in "linux,code" property. Optional properties:

gpio_keys also defines button node bindings. Why don't you use the same
name format (button@<num>)?

> +    active-high : Change active button level from 0 to 1.
> +    enable-reset: Performs hadware reset through PMIC.
> +    debounce    : Debounce value which will be taken from PMIC datasheet.
>  - regulators : Contain the regulator nodes. The regulators are bound using
>    their names as listed below with their registers and bits for enabling.
>  
> @@ -89,6 +94,13 @@ ecspi@70010000 { /* ECSPI1 */
>  		interrupt-parent = <&gpio0>;
>  		interrupts = <8>;
>  
> +		buttons {
> +			btn1 {
> +				linux,code = <0x1f>;
> +				debounce = <1>;
> +			};
> +		};
> +
>  		regulators {
>  			sw1_reg: mc13892__sw1 {
>  				regulator-min-microvolt = <600000>;
> diff --git a/drivers/input/misc/mc13783-pwrbutton.c b/drivers/input/misc/mc13783-pwrbutton.c
> index 855d576..05bb570 100644
> --- a/drivers/input/misc/mc13783-pwrbutton.c
> +++ b/drivers/input/misc/mc13783-pwrbutton.c
> @@ -24,6 +24,7 @@
>  #include <linux/kernel.h>
>  #include <linux/errno.h>
>  #include <linux/input.h>
> +#include <linux/of.h>
>  #include <linux/platform_device.h>
>  #include <linux/mfd/mc13783.h>
>  #include <linux/mfd/mc13892.h>
> @@ -121,21 +122,28 @@ static int __init mc13xxx_pwrbutton_probe(struct platform_device *pdev)
>  	struct mc13xxx *mc13xxx = dev_get_drvdata(pdev->dev.parent);
>  	struct mc13xxx_pwrb_devtype *devtype =
>  		(struct mc13xxx_pwrb_devtype *)pdev->id_entry->driver_data;
> +	struct device_node *parent, *child;
>  	struct mc13xxx_pwrb *priv;
>  	int i, reg = 0, ret = -EINVAL;
>  
> -	if (!pdata) {
> +	of_node_get(pdev->dev.parent->of_node);
> +	parent = of_find_node_by_name(pdev->dev.parent->of_node, "buttons");
> +	if (!pdata && !parent) {
>  		dev_err(&pdev->dev, "Missing platform data\n");
>  		return -ENODEV;
>  	}
>  
>  	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> -	if (!priv)
> -		return -ENOMEM;
> +	if (!priv) {
> +		ret = -ENOMEM;
> +		goto out_node_put;
> +	}
>  
>  	priv->input = devm_input_allocate_device(&pdev->dev);
> -	if (!priv->input)
> -		return -ENOMEM;
> +	if (!priv->input) {
> +		ret = -ENOMEM;
> +		goto out_node_put;
> +	}
>  
>  	priv->mc13xxx = mc13xxx;
>  	priv->devtype = devtype;
> @@ -143,15 +151,36 @@ static int __init mc13xxx_pwrbutton_probe(struct platform_device *pdev)
>  
>  	for (i = 0; i < MAX13XXX_NUM_BUTTONS; i++) {
>  		u16 code, invert, reset, debounce;
> +		const __be32 *prop;
> +		char childname[5];
>  
> -		if (!(pdata->buttons[i].flags & MC13XXX_BUTTON_ENABLE))
> -			continue;
> -		code = pdata->buttons[i].keycode;
> -		invert = !!(pdata->buttons[i].flags &
> -			    MC13XXX_BUTTON_POL_INVERT);
> -		reset = !!(pdata->buttons[i].flags &
> -			   MC13XXX_BUTTON_RESET_EN);
> -		debounce = pdata->buttons[i].flags;
> +		if (parent) {
> +			sprintf(childname, "btn%i", i + 1);
> +			child = of_get_child_by_name(parent, childname);
> +			if (!child)
> +				continue;
> +			prop = of_get_property(child, "linux,code", NULL);
> +			if (prop)
> +				code = be32_to_cpu(*prop) & 0xffff;
> +			else {
> +				dev_err(&pdev->dev,
> +					"Button %i: Missing key code\n", i + 1);
> +				continue;
> +			}
> +			invert = !!of_get_property(child, "active-high", NULL);
> +			reset = !!of_get_property(child, "enable-reset", NULL);

You can use of_property_read_bool here.

Regards,

Markus

> +			prop = of_get_property(child, "debounce", NULL);
> +			debounce = prop ? be32_to_cpu(*prop) : 0;
> +		} else {
> +			if (!(pdata->buttons[i].flags & MC13XXX_BUTTON_ENABLE))
> +				continue;
> +			code = pdata->buttons[i].keycode;
> +			invert = !!(pdata->buttons[i].flags &
> +				    MC13XXX_BUTTON_POL_INVERT);
> +			reset = !!(pdata->buttons[i].flags &
> +				   MC13XXX_BUTTON_RESET_EN);
> +			debounce = pdata->buttons[i].flags;
> +		}
>  
>  		priv->btn_code[i] = code;
>  		if (code != KEY_RESERVED)
> @@ -186,6 +215,10 @@ static int __init mc13xxx_pwrbutton_probe(struct platform_device *pdev)
>  	if (ret)
>  		dev_err(&pdev->dev, "Can't register input device: %i\n", ret);
>  
> +out_node_put:
> +	if (parent)
> +		of_node_put(parent);
> +
>  	return ret;
>  }
>  
> -- 
> 1.8.1.5
> 
> 
