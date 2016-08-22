From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] input: touchscreen: silead: Add regulator support
Date: Mon, 22 Aug 2016 14:11:47 -0700
Message-ID: <20160822211147.GC12277@dtor-ws>
References: <1471376124-31169-1-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1471376124-31169-1-git-send-email-hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Hi Hans,

On Tue, Aug 16, 2016 at 09:35:24PM +0200, Hans de Goede wrote:
> On some tablets the touchscreen controller is powered by seperate
> regulators, add support for this.
> 
> Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> ---
>  .../bindings/input/touchscreen/silead_gsl1680.txt  |  2 +
>  drivers/input/touchscreen/silead.c                 | 51 ++++++++++++++++++++--
>  2 files changed, 49 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/silead_gsl1680.txt b/Documentation/devicetree/bindings/input/touchscreen/silead_gsl1680.txt
> index 37a9370..65eb4c7 100644
> --- a/Documentation/devicetree/bindings/input/touchscreen/silead_gsl1680.txt
> +++ b/Documentation/devicetree/bindings/input/touchscreen/silead_gsl1680.txt
> @@ -22,6 +22,8 @@ Optional properties:
>  - touchscreen-inverted-y  : See touchscreen.txt
>  - touchscreen-swapped-x-y : See touchscreen.txt
>  - silead,max-fingers	  : maximum number of fingers the touchscreen can detect
> +- vddio-supply		  : regulator phandle for controller VDDIO
> +- avdd-supply		  : regulator phandle for controller AVDD
>  
>  Example:
>  
> diff --git a/drivers/input/touchscreen/silead.c b/drivers/input/touchscreen/silead.c
> index 7379fe1..04992c5 100644
> --- a/drivers/input/touchscreen/silead.c
> +++ b/drivers/input/touchscreen/silead.c
> @@ -29,6 +29,7 @@
>  #include <linux/input/touchscreen.h>
>  #include <linux/pm.h>
>  #include <linux/irq.h>
> +#include <linux/regulator/consumer.h>
>  
>  #include <asm/unaligned.h>
>  
> @@ -72,6 +73,8 @@ enum silead_ts_power {
>  struct silead_ts_data {
>  	struct i2c_client *client;
>  	struct gpio_desc *gpio_power;
> +	struct regulator *vddio;
> +	struct regulator *avdd;
>  	struct input_dev *input;
>  	char fw_name[64];
>  	struct touchscreen_properties prop;
> @@ -463,21 +466,52 @@ static int silead_ts_probe(struct i2c_client *client,
>  	if (client->irq <= 0)
>  		return -ENODEV;
>  
> +	data->vddio = devm_regulator_get_optional(dev, "vddio");

No need for devm_regulator_get_optional(), devm_regulator_get() will
give you dummy regulator that you can enable/disable.
regulator_get_optional() is only need if you have truly optional
functionality in controller and you need to adjust behavior depending on
presence of a regulator.

> +	if (IS_ERR(data->vddio)) {
> +		if (PTR_ERR(data->vddio) == -EPROBE_DEFER)
> +			return -EPROBE_DEFER;
> +		data->vddio = NULL;
> +	}
> +
> +	data->avdd = devm_regulator_get_optional(dev, "avdd");
> +	if (IS_ERR(data->avdd)) {
> +		if (PTR_ERR(data->avdd) == -EPROBE_DEFER)
> +			return -EPROBE_DEFER;
> +		data->avdd = NULL;
> +	}
> +
> +	/*
> +	 * Enable regulators at probe and disable them at remove, we need
> +	 * to keep the chip powered otherwise it forgets its firmware.
> +	 */
> +	if (data->vddio) {
> +		error = regulator_enable(data->vddio);
> +		if (error)
> +			return error;
> +	}
> +
> +	if (data->avdd) {
> +		error = regulator_enable(data->avdd);
> +		if (error)
> +			goto disable_vddio;
> +	}

Hmm, so you are enabling regulators and leave them on. That is not
great. I'd rather we powered the device up during probe(), but then shut
it off and waited for ->open() to be called. And power it down in
->close(). You also need to handle it in suspend and resume.

Thanks.

-- 
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
