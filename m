From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] HID: i2c-hid: Use device properties (instead of device
 tree)
Date: Sun, 01 Oct 2017 19:18:50 +0300
Message-ID: <1506874730.16112.194.camel@linux.intel.com>
References: <20170929224441.98176-1-rajatja@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:39145 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751093AbdJAQSz (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Sun, 1 Oct 2017 12:18:55 -0400
In-Reply-To: <20170929224441.98176-1-rajatja@google.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Rajat Jain <rajatja@google.com>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, David Arcari <darcari@redhat.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, HungNien Chen <hn.chen@weidahitech.com>, Hans de Goede <hdegoede@redhat.com>, Brian Norris <briannorris@chromium.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, dtor@google.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, rajatxjain@gmail.com

On Fri, 2017-09-29 at 15:44 -0700, Rajat Jain wrote:
> Use the device properties (that can be provided by ACPI systems
> as well as non ACPI systems) instead of device tree properties
> (that are not provided ACPI systems). This required some minor
> code restructuring.
> 

> I don't think its a big deal, but just FYI, this changes the order in
> which we
> look for HID register address from
> (device tree -> platform_data -> ACPI) to
> (platform data -> device tree -> ACPI)

I do.

We would like to discourage use of legacy platform data in favour
of Device Tree / ACPI. 

> +static int i2c_hid_fwnode_probe(struct i2c_client *client,
>  		struct i2c_hid_platform_data *pdata)
>  {
>  	struct device *dev = &client->dev;
>  	u32 val;
>  	int ret;
>  
> -	ret = of_property_read_u32(dev->of_node, "hid-descr-addr",
> &val);
> -	if (ret) {
> -		dev_err(&client->dev, "HID register address not
> provided\n");
> -		return -ENODEV;
> -	}
> -	if (val >> 16) {
> -		dev_err(&client->dev, "Bad HID register address:
> 0x%08x\n",
> -			val);
> -		return -EINVAL;
> +	ret = device_property_read_u32(dev, "hid-descr-addr", &val);
> +	if (ret || val >> 16) {
> +		/* Couldn't read using fwnode, try ACPI next */
> +		if (!i2c_hid_acpi_pdata(client, pdata)) {
> +			dev_err(dev, "Bad/Not provided HID register
> address\n");
> +			return -ENODEV;
> +		}

Why not just replace of_ calls by device_ ones?

>  	}
>  	pdata->hid_descriptor_address = val;
>  
> -	ret = of_property_read_u32(dev->of_node, "post-power-on-
> delay-ms",
> -				   &val);
> +	ret = device_property_read_u32(dev, "post-power-on-delay-ms", 
> &val);
>  	if (!ret)
>  		pdata->post_power_delay_ms = val;
>  
>  	return 0;
>  }
> 

Looking how ACPI support is established in the driver, I would rather
NAK this change. Is there any _actual_ hardware on the wild with such
properties?

HID protocol for ACPI is described in [1] where nothing is about _DSD.

[1]: https://docs.microsoft.com/en-us/windows-hardware/drivers/hid/plug-
and-play-support-and-power-management

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
