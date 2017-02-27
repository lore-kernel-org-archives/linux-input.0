From: David Lechner <david-nq/r/kbU++upp/zk7JDF2g@public.gmane.org>
Subject: Re: [v2] Input: pwm-beeper: support customized freq for SND_BELL
Date: Mon, 27 Feb 2017 12:11:06 -0600
Message-ID: <06af466d-ac78-ea38-77d2-3bf32a6e157c@lechnology.com>
References: <1487579863-7256-1-git-send-email-hs@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1487579863-7256-1-git-send-email-hs-ynQEQJNshbs@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Heiko Schocher <hs-ynQEQJNshbs@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Guan Ben <ben.guan-dUNdQdTMQaZWk0Htik3J/w@public.gmane.org>, Mark Jonas <mark.jonas-V5te9oGctAVWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Manfred Schlaegl <manfred.schlaegl-RbZlAiThDcE@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On 02/20/2017 02:37 AM, Heiko Schocher wrote:
> From: Guan Ben <ben.guan-dUNdQdTMQaZWk0Htik3J/w@public.gmane.org>
>
> extend the pwm-beeper driver to support customized frequency
> for SND_BELL from device tree.
>
> Signed-off-by: Guan Ben <ben.guan-dUNdQdTMQaZWk0Htik3J/w@public.gmane.org>
> Signed-off-by: Mark Jonas <mark.jonas-V5te9oGctAVWk0Htik3J/w@public.gmane.org>
> [hs-ynQEQJNshbs@public.gmane.org: adapted to 4.10-rc7]
> Signed-off-by: Heiko Schocher <hs-ynQEQJNshbs@public.gmane.org>
> ---
>
> Changes in v2:
> - add comment from Rob Herring:
>   rename property name "bell-frequency" to "beeper-hz"

Is there a separate patch for the devicetree bindings documentation?

> - add comment from Dmitry Torokhov:
>   use device_property_read_u32() instead of of_property_read_u32()
> - rebased against c470abd4fde40ea6a0846a2beab642a578c0b8cd
>   Linux 4.10
>
>  .../devicetree/bindings/input/pwm-beeper.txt       |  3 ++
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

This would be much simpler if you just changed the single line above:

		value = value ? beeper->bell_frequency : 0;

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

I don't think the check for CONFIG_OF is needed when using 
device_property_read_u32().

> +		node = dev->of_node;

node variable is never used

> +		err = device_property_read_u32(dev, "beeper-hz",
> +					       &bell_frequency);

Does the device_property_read_u32() function guarantee that 
bell_frequency is not modified when err < 0 ?

> +		if (err < 0)
> +			dev_dbg(dev, "Failed to read beeper-hz, using default: %u Hz\n",

"Failed" sounds like an error, but this is a perfectly normal thing to 
happen. Maybe better to say "'beeper-hz' not specified, using default: 
%u Hz\n".

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

This function is so simple, it could just be done inline here.

>
>  	beeper->input = input_allocate_device();
>  	if (!beeper->input) {
>

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
