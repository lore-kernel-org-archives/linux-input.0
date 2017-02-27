From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2] Input: pwm-beeper: support customized freq for
 SND_BELL
Date: Mon, 27 Feb 2017 13:10:57 -0600
Message-ID: <20170227191057.uvrefh6mypnwkmkx@rob-hp-laptop>
References: <1487579863-7256-1-git-send-email-hs@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ot0-f194.google.com ([74.125.82.194]:35880 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751378AbdB1BF3 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 27 Feb 2017 20:05:29 -0500
Content-Disposition: inline
In-Reply-To: <1487579863-7256-1-git-send-email-hs@denx.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Heiko Schocher <hs@denx.de>
Cc: linux-input@vger.kernel.org, Guan Ben <ben.guan@cn.bosch.com>, Mark Jonas <mark.jonas@de.bosch.com>, devicetree@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, linux-kernel@vger.kernel.org, Boris Brezillon <boris.brezillon@free-electrons.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Manfred Schlaegl <manfred.schlaegl@gmx.at>, Mark Rutland <mark.rutland@arm.com>

On Mon, Feb 20, 2017 at 09:37:43AM +0100, Heiko Schocher wrote:
> From: Guan Ben <ben.guan@cn.bosch.com>
> 
> extend the pwm-beeper driver to support customized frequency
> for SND_BELL from device tree.
> 
> Signed-off-by: Guan Ben <ben.guan@cn.bosch.com>
> Signed-off-by: Mark Jonas <mark.jonas@de.bosch.com>
> [hs@denx.de: adapted to 4.10-rc7]
> Signed-off-by: Heiko Schocher <hs@denx.de>
> 
> ---
> 
> Changes in v2:
> - add comment from Rob Herring:
>   rename property name "bell-frequency" to "beeper-hz"
> - add comment from Dmitry Torokhov:
>   use device_property_read_u32() instead of of_property_read_u32()
> - rebased against c470abd4fde40ea6a0846a2beab642a578c0b8cd
>   Linux 4.10
> 
>  .../devicetree/bindings/input/pwm-beeper.txt       |  3 ++

Acked-by: Rob Herring <robh@kernel.org>

A few comments on the driver though.

>  drivers/input/misc/pwm-beeper.c                    | 36 ++++++++++++++++------
>  2 files changed, 30 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/input/pwm-beeper.txt b/Documentation/devicetree/bindings/input/pwm-beeper.txt
> index be332ae..4e4e128 100644
> --- a/Documentation/devicetree/bindings/input/pwm-beeper.txt
> +++ b/Documentation/devicetree/bindings/input/pwm-beeper.txt
> @@ -5,3 +5,6 @@ Registers a PWM device as beeper.
>  Required properties:
>  - compatible: should be "pwm-beeper"
>  - pwms: phandle to the physical PWM device
> +
> +optional properties:
> +- beeper-hz:  bell frequency in Hz
> diff --git a/drivers/input/misc/pwm-beeper.c b/drivers/input/misc/pwm-beeper.c
> index 5f9655d..5ea6fda 100644
> --- a/drivers/input/misc/pwm-beeper.c
> +++ b/drivers/input/misc/pwm-beeper.c
> @@ -27,6 +27,7 @@ struct pwm_beeper {
>  	struct pwm_device *pwm;
>  	struct work_struct work;
>  	unsigned long period;
> +	unsigned int bell_frequency;
>  };
>  
>  #define HZ_TO_NANOSECONDS(x) (1000000000UL/(x))
> @@ -58,20 +59,17 @@ static int pwm_beeper_event(struct input_dev *input,
>  	if (type != EV_SND || value < 0)
>  		return -EINVAL;
>  
> -	switch (code) {
> -	case SND_BELL:
> -		value = value ? 1000 : 0;
> -		break;
> -	case SND_TONE:
> -		break;
> -	default:
> +	if (code != SND_BELL && code != SND_TONE)
>  		return -EINVAL;
> -	}
>  
>  	if (value == 0)
>  		beeper->period = 0;
> -	else
> +	else {
> +		if (code == SND_BELL)
> +			value = beeper->bell_frequency;
> +
>  		beeper->period = HZ_TO_NANOSECONDS(value);
> +	}
>  
>  	schedule_work(&beeper->work);
>  
> @@ -93,6 +91,25 @@ static void pwm_beeper_close(struct input_dev *input)
>  	pwm_beeper_stop(beeper);
>  }
>  
> +static void pwm_beeper_init_bell_frequency(struct device *dev,
> +					   struct pwm_beeper *beeper)
> +{
> +	struct device_node *node;
> +	unsigned int bell_frequency = 1000;
> +	int err;
> +
> +	if (IS_ENABLED(CONFIG_OF)) {

You don't really need this. There should be an empty version of the 
function.

> +		node = dev->of_node;

You don't need this line.

> +		err = device_property_read_u32(dev, "beeper-hz",
> +					       &bell_frequency);
> +		if (err < 0)
> +			dev_dbg(dev, "Failed to read beeper-hz, using default: %u Hz\n",
> +				bell_frequency);
> +	}
> +
> +	beeper->bell_frequency = bell_frequency;
> +}
> +
>  static int pwm_beeper_probe(struct platform_device *pdev)
>  {
>  	unsigned long pwm_id = (unsigned long)dev_get_platdata(&pdev->dev);
> @@ -122,6 +139,7 @@ static int pwm_beeper_probe(struct platform_device *pdev)
>  	pwm_apply_args(beeper->pwm);
>  
>  	INIT_WORK(&beeper->work, pwm_beeper_work);
> +	pwm_beeper_init_bell_frequency(&pdev->dev, beeper);
>  
>  	beeper->input = input_allocate_device();
>  	if (!beeper->input) {
> -- 
> 2.7.4
> 
