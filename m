From: Tomasz Figa <tomasz.figa@gmail.com>
Subject: Re: [PATCH v3 RESEND 3/3] input: mc13783: Add DT probe support
Date: Sat, 17 Aug 2013 13:52:30 +0200
Message-ID: <3233260.60GMVrPt0m@flatron>
References: <1376718340-16885-1-git-send-email-shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bk0-f44.google.com ([209.85.214.44]:37710 "EHLO
	mail-bk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753076Ab3HQLwg (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 17 Aug 2013 07:52:36 -0400
In-Reply-To: <1376718340-16885-1-git-send-email-shc_work@mail.ru>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alexander Shiyan <shc_work@mail.ru>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sascha Hauer <kernel@pengutronix.de>, devicetree@vger.kernel.org, Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ian.campbell@citrix.com>, Grant Likely <grant.likely@linaro.org>

Hi Alexander,

Please see my comments inline.

On Saturday 17 of August 2013 09:45:40 Alexander Shiyan wrote:
> Patch adds DT support for MC13783/MC13892 PMICs.
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> ---
>  Documentation/devicetree/bindings/mfd/mc13xxx.txt | 13 +++++
>  drivers/input/misc/mc13783-pwrbutton.c            | 61
> +++++++++++++++++------ 2 files changed, 60 insertions(+), 14
> deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/mc13xxx.txt
> b/Documentation/devicetree/bindings/mfd/mc13xxx.txt index
> abd9e3c..cf8b61c 100644
> --- a/Documentation/devicetree/bindings/mfd/mc13xxx.txt
> +++ b/Documentation/devicetree/bindings/mfd/mc13xxx.txt
> @@ -10,6 +10,12 @@ Optional properties:
>  - fsl,mc13xxx-uses-touch : Indicate the touchscreen controller is being
> used
> 
>  Sub-nodes:
> +- buttons : Contain power button nodes. Each button should be declared
> as +  "button@<num>" and contain code in "linux,code" property.

You should not really be enforcing such strict node naming. If you have 
the "buttons" node, which aggregates all the buttons, all you need is just 
parsing all the child nodes of it, regardless of their names.

As a side note, the @unit-address suffix is used only when you have the 
reg property present in the node and must be equal to the address value 
set in this property.

If you need the button index (which is true, looking at the code), you 
should use the reg property instead, with appropriate #address-cells 
(probably 1 for your use case) and #size-cells (0, as size doesn't make 
sense in your use case) in "buttons" node.

> +  Optional properties:

The properties below should be rather prefixed with "fsl," string to 
indicate that they are specific to this particular device.

> +    active-high : Change active button level from 0 to 1.

It is a boolean property, isn't it? If yes, this should be noted. Also the 
"from 0 to 1" statement is a bit unfortunate.

What about:

	active-high : A boolean property present if the button is active 
high. Otherwise the button is assumed to be active low.

> +    enable-reset: Performs hadware reset through PMIC.

Could you elaborate on meaning of this property a bit more, please?

> +    debounce    : Debounce value which will be taken from PMIC
> datasheet. - regulators : Contain the regulator nodes. The regulators
> are bound using their names as listed below with their registers and
> bits for enabling.
> 
> @@ -89,6 +95,13 @@ ecspi@70010000 { /* ECSPI1 */
>  		interrupt-parent = <&gpio0>;
>  		interrupts = <8>;
> 
> +		buttons {
> +			button@1 {
> +				linux,code = <0x1f>;
> +				debounce = <1>;
> +			};
> +		};
> +

So basically this example after addressing my comments would look like:

	buttons {
		#address-cells = <1>;
		#size-cells = <0>;

		irrelevant-name@1 {
			reg = <1>;
			linux,code = <0x1f>;
			fsl,debounce = <1>;
		};
	};

>  		regulators {
>  			sw1_reg: mc13892__sw1 {
>  				regulator-min-microvolt = <600000>;
> diff --git a/drivers/input/misc/mc13783-pwrbutton.c
> b/drivers/input/misc/mc13783-pwrbutton.c index 2e21f19..3f9cfd1 100644
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
> @@ -77,21 +78,28 @@ static int __init mc13xxx_pwrbutton_probe(struct
> platform_device *pdev) struct mc13xxx *mc13xxx =
> dev_get_drvdata(pdev->dev.parent); struct mc13xxx_pwrb_devtype *devtype
> =
>  		(struct mc13xxx_pwrb_devtype *)pdev->id_entry-
>driver_data;
> +	struct device_node *parent, *child;
>  	struct mc13xxx_pwrb *priv;
>  	int i, reg = 0, ret = -EINVAL;
> 
> -	if (!pdata) {
> +	of_node_get(pdev->dev.parent->of_node);
> +	parent = of_find_node_by_name(pdev->dev.parent->of_node, 
"buttons");

The of_find_node_by_name() function does not search for node with given 
name inside the node you specify, but rather starting from this node and 
going over all the rest of device tree.

of_get_child_by_name() seems to be what you need here.

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
> @@ -99,15 +107,36 @@ static int __init mc13xxx_pwrbutton_probe(struct
> platform_device *pdev)
> 
>  	for (i = 0; i < MAX13XXX_NUM_BUTTONS; i++) {
>  		u16 code, invert, reset, debounce;
> -
> -		if (!(pdata->buttons[i].flags & MC13XXX_BUTTON_ENABLE))
> -			continue;
> -		code = pdata->buttons[i].keycode;
> -		invert = !!(pdata->buttons[i].flags &
> -			    MC13XXX_BUTTON_POL_INVERT);
> -		reset = !!(pdata->buttons[i].flags &
> -			   MC13XXX_BUTTON_RESET_EN);
> -		debounce = pdata->buttons[i].flags;
> +		const __be32 *prop;
> +		char childname[5];
> +
> +		if (parent) {
> +			sprintf(childname, "button@%i", i + 1);

Hmm, this can lead to stack corruption. The line above will print 9 
(including terminating zero) characters to the childname array, which can 
hold only 5 of them.

> +			child = of_get_child_by_name(parent, childname);
> +			if (!child)
> +				continue;
> +			prop = of_get_property(child, "linux,code", NULL);
> +			if (prop)
> +				code = be32_to_cpu(*prop) & 0xffff;

What about using of_property_read_u32() here? See include/linux/of.h for a 
whole lot of useful DT parsing functions and their descriptions in 
drivers/of/base.c (kernel-doc comments).

> +			else {
> +				dev_err(&pdev->dev,
> +					"Button %i: Missing key code\n", i 
+ 1);
> +				continue;
> +			}
> +			invert = of_property_read_bool(child, "active-
high");
> +			reset = of_property_read_bool(child, "enable-
reset");
> +			prop = of_get_property(child, "debounce", NULL);
> +			debounce = prop ? be32_to_cpu(*prop) : 0;

Again, of_property_read_u32() would simplify the code. As a side note, 
there is also a be32_to_cpup() helper, which dereferences a __be32 pointer 
for you and returns a value in CPU endianess.

> +		} else {
> +			if (!(pdata->buttons[i].flags & 
MC13XXX_BUTTON_ENABLE))
> +				continue;
> +			code = pdata->buttons[i].keycode;
> +			invert = !!(pdata->buttons[i].flags &
> +				    MC13XXX_BUTTON_POL_INVERT);
> +			reset = !!(pdata->buttons[i].flags &
> +				   MC13XXX_BUTTON_RESET_EN);
> +			debounce = pdata->buttons[i].flags;
> +		}

Anyway, based on my comments wrt the bindings, I would rather separate the 
DT parsing code from this loop and, in DT case, parse the buttons in a 
for_each_child_of_node() loop, reading the reg property and using it as an 
index to the buttons array (after checking if the index isn't out of 
bounds, of course).

Best regards,
Tomasz

