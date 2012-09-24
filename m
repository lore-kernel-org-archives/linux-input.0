From: Rob Herring <robherring2@gmail.com>
Subject: Re: [PATCH] input: pwm-beeper: Add devicetree probing support
Date: Mon, 24 Sep 2012 07:55:38 -0500
Message-ID: <5060584A.80305@gmail.com>
References: <1348472258-31519-1-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oa0-f46.google.com ([209.85.219.46]:52112 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751997Ab2IXMzm (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 24 Sep 2012 08:55:42 -0400
Received: by oago6 with SMTP id o6so5330958oag.19
        for <linux-input@vger.kernel.org>; Mon, 24 Sep 2012 05:55:42 -0700 (PDT)
In-Reply-To: <1348472258-31519-1-git-send-email-s.hauer@pengutronix.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-input@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>, kernel@pengutronix.de

On 09/24/2012 02:37 AM, Sascha Hauer wrote:
> A very simple binding, the only property is the phandle to the PWM.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

Acked-by: Rob Herring <rob.herring@calxeda.com>

> ---
>  Documentation/devicetree/bindings/input/pwm-beeper.txt |    7 +++++++
>  drivers/input/misc/pwm-beeper.c                        |   11 ++++++++++-
>  2 files changed, 17 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/input/pwm-beeper.txt
> 
> diff --git a/Documentation/devicetree/bindings/input/pwm-beeper.txt b/Documentation/devicetree/bindings/input/pwm-beeper.txt
> new file mode 100644
> index 0000000..7388b82
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/pwm-beeper.txt
> @@ -0,0 +1,7 @@
> +* PWM beeper device tree bindings
> +
> +Registers a PWM device as beeper.
> +
> +Required properties:
> +- compatible: should be "pwm-beeper"
> +- pwms: phandle to the physical pwm device
> diff --git a/drivers/input/misc/pwm-beeper.c b/drivers/input/misc/pwm-beeper.c
> index fc84c8a..a6aa48c 100644
> --- a/drivers/input/misc/pwm-beeper.c
> +++ b/drivers/input/misc/pwm-beeper.c
> @@ -75,7 +75,10 @@ static int __devinit pwm_beeper_probe(struct platform_device *pdev)
>  	if (!beeper)
>  		return -ENOMEM;
>  
> -	beeper->pwm = pwm_request(pwm_id, "pwm beeper");
> +	if (pdev->dev.platform_data)
> +		beeper->pwm = pwm_request(pwm_id, "pwm beeper");
> +	else
> +		beeper->pwm = pwm_get(&pdev->dev, NULL);
>  
>  	if (IS_ERR(beeper->pwm)) {
>  		error = PTR_ERR(beeper->pwm);
> @@ -171,6 +174,11 @@ static SIMPLE_DEV_PM_OPS(pwm_beeper_pm_ops,
>  #define PWM_BEEPER_PM_OPS NULL
>  #endif
>  
> +static const struct of_device_id pwm_beeper_match[] = {
> +	{ .compatible = "pwm-beeper", },
> +	{ },
> +};
> +
>  static struct platform_driver pwm_beeper_driver = {
>  	.probe	= pwm_beeper_probe,
>  	.remove = __devexit_p(pwm_beeper_remove),
> @@ -178,6 +186,7 @@ static struct platform_driver pwm_beeper_driver = {
>  		.name	= "pwm-beeper",
>  		.owner	= THIS_MODULE,
>  		.pm	= PWM_BEEPER_PM_OPS,
> +		.of_match_table = pwm_beeper_match,
>  	},
>  };
>  module_platform_driver(pwm_beeper_driver);
> 

