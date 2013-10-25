From: Grant Likely <grant.likely@linaro.org>
Subject: Re: [PATCHv6 1/3] Input: twl4030-pwrbutton - add device tree support
Date: Fri, 25 Oct 2013 20:09:04 +0100
Message-ID: <20131025190904.3EE93C403B8@trevor.secretlab.ca>
References: <1382626126-12565-1-git-send-email-sre@debian.org> <1382626126-12565-2-git-send-email-sre@debian.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wg0-f46.google.com ([74.125.82.46]:46617 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752042Ab3JYWvH (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 25 Oct 2013 18:51:07 -0400
Received: by mail-wg0-f46.google.com with SMTP id m15so4453999wgh.25
        for <linux-input@vger.kernel.org>; Fri, 25 Oct 2013 15:51:05 -0700 (PDT)
In-Reply-To: <1382626126-12565-2-git-send-email-sre@debian.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sebastian Reichel <sre@ring0.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Rob Herring <rob.herring@calxeda.com>, Sebastian Reichel <sre@debian.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Sachin Kamat <sachin.kamat@linaro.org>, Florian Vaussard <florian.vaussard@epfl.ch>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org

On Thu, 24 Oct 2013 16:48:44 +0200, Sebastian Reichel <sre@debian.org> wrote:
> Add device tree support for twl4030 power button driver.

The above commit text is insufficient. There are changes in the patch
that aren't described here and have nothing to do with device tree
bindings.

> 
> Signed-off-by: Sebastian Reichel <sre@debian.org>
> ---
>  .../devicetree/bindings/input/twl4030-pwrbutton.txt | 21 +++++++++++++++++++++
>  drivers/input/misc/twl4030-pwrbutton.c              | 16 ++++++++++++----
>  2 files changed, 33 insertions(+), 4 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/input/twl4030-pwrbutton.txt
> 
> diff --git a/Documentation/devicetree/bindings/input/twl4030-pwrbutton.txt b/Documentation/devicetree/bindings/input/twl4030-pwrbutton.txt
> new file mode 100644
> index 0000000..4375646
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/twl4030-pwrbutton.txt
> @@ -0,0 +1,21 @@
> +Texas Instruments TWL family (twl4030) pwrbutton module

Can all of the TWL or TWL4030 funciton bindings be collected into a
single file please? It is a single device after all. All of it should be
in bindings/mfd/twl-family.txt

> +
> +This module is part of the TWL4030. For more details about the whole
> +chip see Documentation/devicetree/bindings/mfd/twl-familly.txt.
> +
> +This module provides a simple power button event via an Interrupt.
> +
> +Required properties:
> +- compatible: should be one of the following
> +   - "ti,twl4030-pwrbutton": For controllers compatible with twl4030
> +- interrupt: should be one of the following

Spelling: s/interrupt/interrupts/

> +   - <8>: For controllers compatible with twl4030
> +
> +Example:
> +
> +&twl {
> +	twl_pwrbutton: pwrbutton {
> +		compatible = "ti,twl4030-pwrbutton";
> +		interrupts = <8>;
> +	};
> +};
> diff --git a/drivers/input/misc/twl4030-pwrbutton.c b/drivers/input/misc/twl4030-pwrbutton.c
> index b9a05fd..a3a0fe3 100644
> --- a/drivers/input/misc/twl4030-pwrbutton.c
> +++ b/drivers/input/misc/twl4030-pwrbutton.c
> @@ -52,7 +52,7 @@ static irqreturn_t powerbutton_irq(int irq, void *_pwr)
>  	return IRQ_HANDLED;
>  }
>  
> -static int __init twl4030_pwrbutton_probe(struct platform_device *pdev)
> +static int twl4030_pwrbutton_probe(struct platform_device *pdev)
>  {
>  	struct input_dev *pwr;
>  	int irq = platform_get_irq(pdev, 0);
> @@ -106,16 +106,24 @@ static int __exit twl4030_pwrbutton_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +#if IS_ENABLED(CONFIG_OF)
> +static const struct of_device_id twl4030_pwrbutton_dt_match_table[] = {
> +       { .compatible = "ti,twl4030-pwrbutton" },
> +       {},
> +};
> +MODULE_DEVICE_TABLE(of, twl4030_pwrbutton_dt_match_table);
> +#endif
> +
>  static struct platform_driver twl4030_pwrbutton_driver = {
> +	.probe		= twl4030_pwrbutton_probe,
>  	.remove		= __exit_p(twl4030_pwrbutton_remove),

Remove the __exit_p() wrapper. __exit is for module exit functions, not
remove hooks (I know, that's not actually this patch, but the code is
definitely wrong here).

>  	.driver		= {
>  		.name	= "twl4030_pwrbutton",
>  		.owner	= THIS_MODULE,
> +		.of_match_table = of_match_ptr(twl4030_pwrbutton_dt_match_table),
>  	},
>  };
> -
> -module_platform_driver_probe(twl4030_pwrbutton_driver,
> -			twl4030_pwrbutton_probe);
> +module_platform_driver(twl4030_pwrbutton_driver);
>  
>  MODULE_ALIAS("platform:twl4030_pwrbutton");
>  MODULE_DESCRIPTION("Triton2 Power Button");
> -- 
> 1.8.4.rc3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

