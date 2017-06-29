From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCHv3 4/4] hwmon: da9052: add support for TSI channel
Date: Thu, 29 Jun 2017 11:45:21 -0700
Message-ID: <20170629184521.GA38388@dtor-ws>
References: <20170629124346.22325-1-sebastian.reichel@collabora.co.uk>
 <20170629124346.22325-5-sebastian.reichel@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-hwmon-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170629124346.22325-5-sebastian.reichel@collabora.co.uk>
Sender: linux-hwmon-owner@vger.kernel.org
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: Sebastian Reichel <sre@kernel.org>, Support Opensource <support.opensource@diasemi.com>, Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, devicetree@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Sebastian,

On Thu, Jun 29, 2017 at 02:43:46PM +0200, Sebastian Reichel wrote:
> @@ -238,6 +239,14 @@ static int da9052_ts_probe(struct platform_device *pdev)
>  	if (!da9052)
>  		return -EINVAL;
>  
> +	/*
> +	 * Check if touchscreen pins are used are analogue input instead
> +	 * of having a touchscreen connected to them. The analogue input
> +	 * functionality will be provided by hwmon driver (if enabled).
> +	 */
> +	if (device_property_read_bool(pdev->dev.parent, "dlg,tsi-as-adc"))
> +		return -ENODEV;
> +

I believe this is not the right way of doing this. da9052-core should
simply forgo creating da9052-tsi platform device when this property is
present.

Thanks.

-- 
Dmitry
