From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH 1/2] hid: thingm: factor out duplicated code to
 thingm_init_led
Date: Mon, 18 Apr 2016 09:34:28 +0200
Message-ID: <20160418073428.GF21012@mail.corp.redhat.com>
References: <5713F643.80408@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53584 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751174AbcDRHed (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 18 Apr 2016 03:34:33 -0400
Content-Disposition: inline
In-Reply-To: <5713F643.80408@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org

On Apr 17 2016 or thereabouts, Heiner Kallweit wrote:
> Simplify thingm_init_rgb by factoring out duplicated code
> to thingm_init_led.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Both patches are:
Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Cheers,
Benjamin

> ---
>  drivers/hid/hid-thingm.c | 43 +++++++++++++++----------------------------
>  1 file changed, 15 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/hid/hid-thingm.c b/drivers/hid/hid-thingm.c
> index 847a497..a90463e 100644
> --- a/drivers/hid/hid-thingm.c
> +++ b/drivers/hid/hid-thingm.c
> @@ -157,48 +157,35 @@ static int thingm_led_set(struct led_classdev *ldev,
>  	return ret;
>  }
>  
> +static int thingm_init_led(struct thingm_led *led, const char *color_name,
> +			   struct thingm_rgb *rgb, int minor)
> +{
> +	snprintf(led->name, sizeof(led->name), "thingm%d:%s:led%d",
> +		 minor, color_name, rgb->num);
> +	led->ldev.name = led->name;
> +	led->ldev.max_brightness = 255;
> +	led->ldev.brightness_set_blocking = thingm_led_set;
> +	led->rgb = rgb;
> +	return devm_led_classdev_register(&rgb->tdev->hdev->dev, &led->ldev);
> +}
> +
>  static int thingm_init_rgb(struct thingm_rgb *rgb)
>  {
>  	const int minor = ((struct hidraw *) rgb->tdev->hdev->hidraw)->minor;
>  	int err;
>  
>  	/* Register the red diode */
> -	snprintf(rgb->red.name, sizeof(rgb->red.name),
> -			"thingm%d:red:led%d", minor, rgb->num);
> -	rgb->red.ldev.name = rgb->red.name;
> -	rgb->red.ldev.max_brightness = 255;
> -	rgb->red.ldev.brightness_set_blocking = thingm_led_set;
> -	rgb->red.rgb = rgb;
> -
> -	err = devm_led_classdev_register(&rgb->tdev->hdev->dev,
> -					 &rgb->red.ldev);
> +	err = thingm_init_led(&rgb->red, "red", rgb, minor);
>  	if (err)
>  		return err;
>  
>  	/* Register the green diode */
> -	snprintf(rgb->green.name, sizeof(rgb->green.name),
> -			"thingm%d:green:led%d", minor, rgb->num);
> -	rgb->green.ldev.name = rgb->green.name;
> -	rgb->green.ldev.max_brightness = 255;
> -	rgb->green.ldev.brightness_set_blocking = thingm_led_set;
> -	rgb->green.rgb = rgb;
> -
> -	err = devm_led_classdev_register(&rgb->tdev->hdev->dev,
> -					 &rgb->green.ldev);
> +	err = thingm_init_led(&rgb->green, "green", rgb, minor);
>  	if (err)
>  		return err;
>  
>  	/* Register the blue diode */
> -	snprintf(rgb->blue.name, sizeof(rgb->blue.name),
> -			"thingm%d:blue:led%d", minor, rgb->num);
> -	rgb->blue.ldev.name = rgb->blue.name;
> -	rgb->blue.ldev.max_brightness = 255;
> -	rgb->blue.ldev.brightness_set_blocking = thingm_led_set;
> -	rgb->blue.rgb = rgb;
> -
> -	err = devm_led_classdev_register(&rgb->tdev->hdev->dev,
> -					 &rgb->blue.ldev);
> -	return err;
> +	return thingm_init_led(&rgb->blue, "blue", rgb, minor);
>  }
>  
>  static int thingm_probe(struct hid_device *hdev, const struct hid_device_id *id)
> -- 
> 2.8.0
> 
> 
