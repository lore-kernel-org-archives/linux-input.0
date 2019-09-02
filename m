From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 2/2] touchscreen: goodix: define GPIO mapping for GPD
 P2 Max
Date: Mon, 2 Sep 2019 13:04:15 +0300
Message-ID: <20190902100415.GX2680@smile.fi.intel.com>
References: <20190831030916.13172-1-peter@typeblog.net>
 <20190831030916.13172-2-peter@typeblog.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190831030916.13172-2-peter@typeblog.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Cai <peter@typeblog.net>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Bastien Nocera <hadess@hadess.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Sat, Aug 31, 2019 at 11:09:15AM +0800, Peter Cai wrote:
> The firmware of GPD P2 Max could not handle panel resets although code
> is present in DSDT. The kernel needs to take on this job instead, but
> the DSDT does not provide _DSD, rendering kernel helpless when trying to
> find the respective GPIO pins.
> 
> Fortunately, this time GPD has proper DMI vendor / product strings that
> we could match against. We simply apply an acpi_gpio_mapping table when
> GPD P2 Max is matched.
> 
> Additionally, the DSDT definition of the irq pin specifies a wrong
> polarity. The new quirk introduced in the previous patch
> (ACPI_GPIO_QUIRK_OVERRIDE_POLARITY) is applied to correct this.

FWIW,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

though one comment below.

> 
> Signed-off-by: Peter Cai <peter@typeblog.net>
> ---
> 
> v2: removed '#ifdef CONFIG_ACPI' as per suggestion. The #ifdef guards
> for CONFIG_DMI is kept for consistency with the other dmi_system_id
> definition in the same file.
> ---
>  drivers/input/touchscreen/goodix.c | 31 ++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
> index 5178ea8b5f30..df476f7dcd95 100644
> --- a/drivers/input/touchscreen/goodix.c
> +++ b/drivers/input/touchscreen/goodix.c
> @@ -144,6 +144,31 @@ static const struct dmi_system_id rotated_screen[] = {
>  	{}
>  };
>  
> +static const struct acpi_gpio_params irq_gpios_default = { 0, 0, false };
> +static const struct acpi_gpio_params reset_gpios_default = { 1, 0, false };
> +static const struct acpi_gpio_mapping gpio_mapping_force_irq_active_high[] = {
> +	{ "irq-gpios", &irq_gpios_default, 1, ACPI_GPIO_QUIRK_OVERRIDE_POLARITY },
> +	{ "reset-gpios", &reset_gpios_default, 1 },
> +	{}
> +};
> +
> +/*
> + * Devices that need acpi_gpio_mapping to function correctly
> + */
> +static const struct dmi_system_id need_gpio_mapping[] = {
> +#if defined(CONFIG_DMI) && defined(CONFIG_X86)
> +	{
> +		.ident = "GPD P2 Max",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "GPD"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "P2 MAX")
> +		},
> +		.driver_data = &gpio_mapping_force_irq_active_high
> +	},
> +#endif
> +	{}
> +};
> +
>  /**
>   * goodix_i2c_read - read data from a register of the i2c slave device.
>   *
> @@ -795,6 +820,12 @@ static int goodix_ts_probe(struct i2c_client *client,
>  {
>  	struct goodix_ts_data *ts;
>  	int error;

> +	struct dmi_system_id *dmi_match;

I guess it should be const as kbuild bot complained on v1.

And perhaps you want to keep reverse xmas tree order in definition block:

	const struct dmi_system_id *dmi_match;
	struct goodix_ts_data *ts;
	int error;

> +
> +	dmi_match = dmi_first_match(need_gpio_mapping);
> +	if (dmi_match)
> +		devm_acpi_dev_add_driver_gpios(&client->dev,
> +					       dmi_match->driver_data);
>  
>  	dev_dbg(&client->dev, "I2C Address: 0x%02x\n", client->addr);
>  
> -- 
> 2.23.0
> 

-- 
With Best Regards,
Andy Shevchenko
