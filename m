From: Steve Twiss <stwiss.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
Subject: RE: [RESEND PATCH V5 7/8] thermal: da9062/61: Thermal junction
 temperature monitoring driver
Date: Mon, 27 Mar 2017 10:09:35 +0000
Message-ID: <6ED8E3B22081A4459DAC7699F3695FB7018CD69BD3@SW-EX-MBX02.diasemi.com>
References: <cover.1486026227.git.stwiss.opensource@diasemi.com>
 <6a1a651530fdaedd3e380aa33749ca5fce1a80a8.1486026227.git.stwiss.opensource@diasemi.com>
 <20170219014007.GA20845@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170219014007.GA20845-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: LINUX-KERNEL <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LINUX-PM <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, DEVICETREE <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, LINUX-INPUT <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LINUX-WATCHDOG <linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lukasz Luba <lukasz.luba-5wv7dgnIgG8@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Support Opensource <Support.Opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>, Wim Van Sebroeck <wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On 19 February 2017 01:40, Eduardo Valentin wrote:

Hi Eduardo,

My apologies in taking so long to reply.
There were *no* problems with implementing your requests. See below.
I will have sent these changes as PATCH V6.

https://lkml.org/lkml/2017/3/27/253

Regards,
Steve

> To: Steve Twiss
> Subject: Re: [RESEND PATCH V5 7/8] thermal: da9062/61: Thermal junction
> temperature monitoring driver

[...]

> I see no reason why this driver cannot have the COMPILE_TEST flag.
> Tested myself here so:
> 
> +	depends on MFD_DA9062 || COMPILE_TEST

Added.

> please cleanup the minor issues checkpatch complains:
> /scripts/checkpatch.pl --strict <your patch>

I have fixed all of those for latest checkpatch.pl script, this time using "--strict".

[...]

> > +static void da9062_thermal_poll_on(struct work_struct *work)
> > +{
> > +	struct da9062_thermal *thermal = container_of(work,
> > +						struct da9062_thermal,
> > +						work.work);
> > +	unsigned int val;
> > +	int ret;
> > +
> > +	/* clear E_TEMP */
> > +	ret = regmap_write(thermal->hw->regmap,
> > +				DA9062AA_EVENT_B,
> > +				DA9062AA_E_TEMP_MASK);
> > +	if (ret < 0) {
> > +		dev_err(thermal->dev,
> > +			"Cannot clear the TJUNC temperature status\n");
> > +		goto err_enable_irq;
> > +	}
> > +
> > +	/* Now read E_TEMP again: it is acting like a status bit.
> > +	 * If over-temperature, then this status will be true.
> > +	 * If not over-temperature, this status will be false.
> > +	 */
> > +	ret = regmap_read(thermal->hw->regmap,
> > +			  DA9062AA_EVENT_B,
> > +			  &val);
> > +	if (ret < 0) {
> > +		dev_err(thermal->dev,
> > +			"Cannot check the TJUNC temperature status\n");
> > +		goto err_enable_irq;
> > +	} else {
> > +		if (val & DA9062AA_E_TEMP_MASK) {
> > +			mutex_lock(&thermal->lock);
> > +			thermal->temperature = DA9062_MILLI_CELSIUS(125);
> > +			mutex_unlock(&thermal->lock);
> > +			thermal_zone_device_update(thermal->zone,
> > +				THERMAL_EVENT_UNSPECIFIED);
> > +
> > +			schedule_delayed_work(&thermal->work,
> > +				msecs_to_jiffies(thermal->zone->passive_delay));
> > +			return;
> > +		} else {
> > +			mutex_lock(&thermal->lock);
> > +			thermal->temperature = DA9062_MILLI_CELSIUS(0);
> > +			mutex_unlock(&thermal->lock);
> > +			thermal_zone_device_update(thermal->zone,
> > +				THERMAL_EVENT_UNSPECIFIED);
> > +		}
> > +	}
> 
> The above code is a little confusing, can it be maybe, better read like
> this?
> 
> diff --git a/drivers/thermal/da9062-thermal.c b/drivers/thermal/da9062-
> thermal.c
> index 52a095d..6ac8574 100644
> --- a/drivers/thermal/da9062-thermal.c
> +++ b/drivers/thermal/da9062-thermal.c
> @@ -95,26 +95,26 @@ static void da9062_thermal_poll_on(struct work_struct
> *work)
>  		dev_err(thermal->dev,
>  			"Cannot check the TJUNC temperature status\n");
>  		goto err_enable_irq;
> -	} else {
> -		if (val & DA9062AA_E_TEMP_MASK) {
> -			mutex_lock(&thermal->lock);
> -			thermal->temperature = DA9062_MILLI_CELSIUS(125);
> -			mutex_unlock(&thermal->lock);
> -			thermal_zone_device_update(thermal->zone,
> -				THERMAL_EVENT_UNSPECIFIED);
> -
> -			schedule_delayed_work(&thermal->work,
> +	}
> +
> +	if (val & DA9062AA_E_TEMP_MASK) {
> +		mutex_lock(&thermal->lock);
> +		thermal->temperature = DA9062_MILLI_CELSIUS(125);
> +		mutex_unlock(&thermal->lock);
> +		thermal_zone_device_update(thermal->zone,
> +				THERMAL_EVENT_UNSPECIFIED);
> +
> +		schedule_delayed_work(&thermal->work,
>  				msecs_to_jiffies(thermal->zone->passive_delay));
> -			return;
> -		} else {
> -			mutex_lock(&thermal->lock);
> -			thermal->temperature = DA9062_MILLI_CELSIUS(0);
> -			mutex_unlock(&thermal->lock);
> -			thermal_zone_device_update(thermal->zone,
> -			THERMAL_EVENT_UNSPECIFIED);
> -		}
> +		return;
>  	}
> 
> +	mutex_lock(&thermal->lock);
> +	thermal->temperature = DA9062_MILLI_CELSIUS(0);
> +	mutex_unlock(&thermal->lock);
> +	thermal_zone_device_update(thermal->zone,
> +			THERMAL_EVENT_UNSPECIFIED);
> +
>  err_enable_irq:
>  	enable_irq(thermal->irq);
>  }

That makes more sense getting rid of those else clauses.
Applied that, thanks.

Regards,
Steve
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
