From: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Subject: Re: [PATCHv6,3/4] hwmon: da9052: replace S_IRUGO with 0444
Date: Sat, 22 Jul 2017 07:53:17 -0700
Message-ID: <20170722145317.GA12511@roeck-us.net>
References: <20170718092024.22552-4-sebastian.reichel@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170718092024.22552-4-sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Cc: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Support Opensource <support.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Jean Delvare <jdelvare-IBi9RG/b67k@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-hwmon-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hi Sebastian,

On Tue, Jul 18, 2017 at 11:20:23AM +0200, Sebastian Reichel wrote:
> Fix checkpatch warnings about S_IRUGO being less readable than
> providing the permissions octal as '0444'.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>

Again:

Acked-by: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>

If you don't make changes, please don't drop already provided Reviewed-by:
or Acked-by: tags. You are making it unnecessarily hard on us, forcing us
to re-review your patches.

Sure, it only takes a few minutes to track down the previous version of your
patches, compare it to this version, and send another Ack. But it is a few
minutes of _my_ time.

Thanks,
Guenter

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
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
