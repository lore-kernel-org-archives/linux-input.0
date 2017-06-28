From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCHv2,2/3] hwmon: da9052: fix checkpatch warnings
Date: Wed, 28 Jun 2017 09:44:00 -0700
Message-ID: <20170628164400.GA11461@roeck-us.net>
References: <20170627143859.21312-3-sebastian.reichel@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:42152 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751574AbdF1QoJ (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 28 Jun 2017 12:44:09 -0400
Content-Disposition: inline
In-Reply-To: <20170627143859.21312-3-sebastian.reichel@collabora.co.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: Sebastian Reichel <sre@kernel.org>, Support Opensource <support.opensource@diasemi.com>, Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jean Delvare <jdelvare@suse.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, devicetree@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Jun 27, 2017 at 04:38:58PM +0200, Sebastian Reichel wrote:
> Fix checkpatch warnings about S_IRUGO being less readable than
> providing the permissions octal as '0444'.
> 
checkpatch says:

"
WARNING: A patch subject line should describe the change not the tool that found it
#5: 
Subject: [PATCHv2,2/3] hwmon: da9052: fix checkpatch warnings
"

Guenter

> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
> ---
>  drivers/hwmon/da9052-hwmon.c | 36 ++++++++++++++++++------------------
>  1 file changed, 18 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/hwmon/da9052-hwmon.c b/drivers/hwmon/da9052-hwmon.c
> index c9832bfacfe5..708c91ac601f 100644
> --- a/drivers/hwmon/da9052-hwmon.c
> +++ b/drivers/hwmon/da9052-hwmon.c
> @@ -196,43 +196,43 @@ static ssize_t show_label(struct device *dev,
>  		       input_names[to_sensor_dev_attr(devattr)->index]);
>  }
>  
> -static SENSOR_DEVICE_ATTR(in0_input, S_IRUGO, da9052_read_vddout, NULL,
> +static SENSOR_DEVICE_ATTR(in0_input, 0444, da9052_read_vddout, NULL,
>  			  DA9052_ADC_VDDOUT);
> -static SENSOR_DEVICE_ATTR(in0_label, S_IRUGO, show_label, NULL,
> +static SENSOR_DEVICE_ATTR(in0_label, 0444, show_label, NULL,
>  			  DA9052_ADC_VDDOUT);
> -static SENSOR_DEVICE_ATTR(in3_input, S_IRUGO, da9052_read_vbat, NULL,
> +static SENSOR_DEVICE_ATTR(in3_input, 0444, da9052_read_vbat, NULL,
>  			  DA9052_ADC_VBAT);
> -static SENSOR_DEVICE_ATTR(in3_label, S_IRUGO, show_label, NULL,
> +static SENSOR_DEVICE_ATTR(in3_label, 0444, show_label, NULL,
>  			  DA9052_ADC_VBAT);
> -static SENSOR_DEVICE_ATTR(in4_input, S_IRUGO, da9052_read_misc_channel, NULL,
> +static SENSOR_DEVICE_ATTR(in4_input, 0444, da9052_read_misc_channel, NULL,
>  			  DA9052_ADC_IN4);
> -static SENSOR_DEVICE_ATTR(in4_label, S_IRUGO, show_label, NULL,
> +static SENSOR_DEVICE_ATTR(in4_label, 0444, show_label, NULL,
>  			  DA9052_ADC_IN4);
> -static SENSOR_DEVICE_ATTR(in5_input, S_IRUGO, da9052_read_misc_channel, NULL,
> +static SENSOR_DEVICE_ATTR(in5_input, 0444, da9052_read_misc_channel, NULL,
>  			  DA9052_ADC_IN5);
> -static SENSOR_DEVICE_ATTR(in5_label, S_IRUGO, show_label, NULL,
> +static SENSOR_DEVICE_ATTR(in5_label, 0444, show_label, NULL,
>  			  DA9052_ADC_IN5);
> -static SENSOR_DEVICE_ATTR(in6_input, S_IRUGO, da9052_read_misc_channel, NULL,
> +static SENSOR_DEVICE_ATTR(in6_input, 0444, da9052_read_misc_channel, NULL,
>  			  DA9052_ADC_IN6);
> -static SENSOR_DEVICE_ATTR(in6_label, S_IRUGO, show_label, NULL,
> +static SENSOR_DEVICE_ATTR(in6_label, 0444, show_label, NULL,
>  			  DA9052_ADC_IN6);
> -static SENSOR_DEVICE_ATTR(in9_input, S_IRUGO, da9052_read_vbbat, NULL,
> +static SENSOR_DEVICE_ATTR(in9_input, 0444, da9052_read_vbbat, NULL,
>  			  DA9052_ADC_VBBAT);
> -static SENSOR_DEVICE_ATTR(in9_label, S_IRUGO, show_label, NULL,
> +static SENSOR_DEVICE_ATTR(in9_label, 0444, show_label, NULL,
>  			  DA9052_ADC_VBBAT);
>  
> -static SENSOR_DEVICE_ATTR(curr1_input, S_IRUGO, da9052_read_ich, NULL,
> +static SENSOR_DEVICE_ATTR(curr1_input, 0444, da9052_read_ich, NULL,
>  			  DA9052_ADC_ICH);
> -static SENSOR_DEVICE_ATTR(curr1_label, S_IRUGO, show_label, NULL,
> +static SENSOR_DEVICE_ATTR(curr1_label, 0444, show_label, NULL,
>  			  DA9052_ADC_ICH);
>  
> -static SENSOR_DEVICE_ATTR(temp2_input, S_IRUGO, da9052_read_tbat, NULL,
> +static SENSOR_DEVICE_ATTR(temp2_input, 0444, da9052_read_tbat, NULL,
>  			  DA9052_ADC_TBAT);
> -static SENSOR_DEVICE_ATTR(temp2_label, S_IRUGO, show_label, NULL,
> +static SENSOR_DEVICE_ATTR(temp2_label, 0444, show_label, NULL,
>  			  DA9052_ADC_TBAT);
> -static SENSOR_DEVICE_ATTR(temp8_input, S_IRUGO, da9052_read_tjunc, NULL,
> +static SENSOR_DEVICE_ATTR(temp8_input, 0444, da9052_read_tjunc, NULL,
>  			  DA9052_ADC_TJUNC);
> -static SENSOR_DEVICE_ATTR(temp8_label, S_IRUGO, show_label, NULL,
> +static SENSOR_DEVICE_ATTR(temp8_label, 0444, show_label, NULL,
>  			  DA9052_ADC_TJUNC);
>  
>  static struct attribute *da9052_attrs[] = {
