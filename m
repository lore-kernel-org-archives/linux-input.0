From: Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH] HID: i2c-hid: Use device properties (instead of device
 tree)
Date: Fri, 29 Sep 2017 17:08:43 -0700
Message-ID: <20170930000841.GA42188@google.com>
References: <20170929224441.98176-1-rajatja@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170929224441.98176-1-rajatja@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rajat Jain <rajatja@google.com>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, David Arcari <darcari@redhat.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, HungNien Chen <hn.chen@weidahitech.com>, Hans de Goede <hdegoede@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, dtor@google.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, rajatxjain@gmail.com
List-Id: linux-input@vger.kernel.org

Hi Rajat,

On Fri, Sep 29, 2017 at 03:44:41PM -0700, Rajat Jain wrote:
> Use the device properties (that can be provided by ACPI systems
> as well as non ACPI systems) instead of device tree properties
> (that are not provided ACPI systems). This required some minor
> code restructuring.
> 
> Signed-off-by: Rajat Jain <rajatja@google.com>
> ---
> I don't think its a big deal, but just FYI, this changes the order in which we
> look for HID register address from
> (device tree -> platform_data -> ACPI) to
> (platform data -> device tree -> ACPI)
> 
>  drivers/hid/i2c-hid/i2c-hid.c | 44 ++++++++++++++-----------------------------
>  1 file changed, 14 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
> index 77396145d2d0..718afceb2395 100644
> --- a/drivers/hid/i2c-hid/i2c-hid.c
> +++ b/drivers/hid/i2c-hid/i2c-hid.c
> @@ -908,45 +908,36 @@ static inline int i2c_hid_acpi_pdata(struct i2c_client *client,
>  static inline void i2c_hid_acpi_fix_up_power(struct device *dev) {}
>  #endif
>  
> -#ifdef CONFIG_OF
> -static int i2c_hid_of_probe(struct i2c_client *client,
> +static int i2c_hid_fwnode_probe(struct i2c_client *client,
>  		struct i2c_hid_platform_data *pdata)
>  {
>  	struct device *dev = &client->dev;
>  	u32 val;
>  	int ret;
>  
> -	ret = of_property_read_u32(dev->of_node, "hid-descr-addr", &val);
> -	if (ret) {
> -		dev_err(&client->dev, "HID register address not provided\n");
> -		return -ENODEV;
> -	}
> -	if (val >> 16) {
> -		dev_err(&client->dev, "Bad HID register address: 0x%08x\n",
> -			val);
> -		return -EINVAL;
> +	ret = device_property_read_u32(dev, "hid-descr-addr", &val);
> +	if (ret || val >> 16) {

We used to reject a bad addr with -EINVAL. Now we retry with ACPI. Is
that reasonable? I'd think you should just reject a bad value.

> +		/* Couldn't read using fwnode, try ACPI next */
> +		if (!i2c_hid_acpi_pdata(client, pdata)) {

I think the '!' negation is wrong. Returning 0 is success.

> +			dev_err(dev, "Bad/Not provided HID register address\n");
> +			return -ENODEV;

This should propagate the error code from i2c_hid_acpi_pdata().

> +		}
>  	}
>  	pdata->hid_descriptor_address = val;

This will break ACPI (with no device property) now; i2c_hid_acpi_pdata()
can parse one value, but then you'll clobber it here with some junk
('val' is potentially uninitialized in the ACPI case).

>  
> -	ret = of_property_read_u32(dev->of_node, "post-power-on-delay-ms",
> -				   &val);
> +	ret = device_property_read_u32(dev, "post-power-on-delay-ms", &val);
>  	if (!ret)
>  		pdata->post_power_delay_ms = val;
>  
>  	return 0;
>  }
>  
> +#ifdef CONFIG_OF
>  static const struct of_device_id i2c_hid_of_match[] = {
>  	{ .compatible = "hid-over-i2c" },
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, i2c_hid_of_match);
> -#else
> -static inline int i2c_hid_of_probe(struct i2c_client *client,
> -		struct i2c_hid_platform_data *pdata)
> -{
> -	return -ENODEV;
> -}
>  #endif
>  
>  static int i2c_hid_probe(struct i2c_client *client,
> @@ -977,19 +968,12 @@ static int i2c_hid_probe(struct i2c_client *client,
>  	if (!ihid)
>  		return -ENOMEM;
>  
> -	if (client->dev.of_node) {
> -		ret = i2c_hid_of_probe(client, &ihid->pdata);
> +	if (platform_data) {
> +		ihid->pdata = *platform_data;
> +	} else if (dev_fwnode(&client->dev)) {
> +		ret = i2c_hid_fwnode_probe(client, &ihid->pdata);
>  		if (ret)
>  			goto err;
> -	} else if (!platform_data) {
> -		ret = i2c_hid_acpi_pdata(client, &ihid->pdata);
> -		if (ret) {
> -			dev_err(&client->dev,
> -				"HID register address not provided\n");
> -			goto err;
> -		}
> -	} else {
> -		ihid->pdata = *platform_data;
>  	}

Where's the 'else' case now? Presumably there's some case where you have
neither platform_data nor dev_fwnode() (I actually don't know much
about non-device tree fwnodes -- do all ACPI systems have them now?)

Anyway, I'd think you should have at least an error in the 'else' case
now.

Brian

>  
>  	ihid->pdata.supply = devm_regulator_get(&client->dev, "vdd");
> -- 
> 2.14.2.822.g60be5d43e6-goog
> 
