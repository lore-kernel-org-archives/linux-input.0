From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: wacom: Report correct device resolution when using
 the wireless adapater
Date: Mon, 10 Aug 2015 10:45:22 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1508101045010.27871@pobox.suse.cz>
References: <1438814693-12051-1-git-send-email-killertofu@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:50473 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754545AbbHJIpX (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 10 Aug 2015 04:45:23 -0400
In-Reply-To: <1438814693-12051-1-git-send-email-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jason Gerecke <killertofu@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, Ping Cheng <pinglinux@gmail.com>, Aaron Skomra <skomra@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>

On Wed, 5 Aug 2015, Jason Gerecke wrote:

> The 'wacom_wireless_work' function does not recalculate the tablet's
> resolution, causing the value contained in the 'features' struct to
> always be reported to userspace. This value is valid only for the pen
> interface, meaning that the value will be incorrect for the touchpad (if
> present). This in particular causes problems for libinput which relies
> on the reported resolution being correct.
> 
> This patch adds the necessary calls to recalculate the resolution for
> each interface. This requires a little bit of code shuffling since both
> the 'wacom_set_default_phy' and 'wacom_calculate_res' are declared below
> their new first point of use in 'wacom_wireless_work'.
> 
> Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
> ---
> Jiri: Would it be possible to target this patch for 4.2?

Just want to understand the context here -- is this a regression? If yes, 
since what version/commit?

Thanks.

> 
>  drivers/hid/wacom_sys.c | 70 ++++++++++++++++++++++++++-----------------------
>  1 file changed, 37 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
> index 4c0ffca..7e064b0 100644
> --- a/drivers/hid/wacom_sys.c
> +++ b/drivers/hid/wacom_sys.c
> @@ -1282,6 +1282,39 @@ fail_register_pen_input:
>  	return error;
>  }
>  
> +/*
> + * Not all devices report physical dimensions from HID.
> + * Compute the default from hardcoded logical dimension
> + * and resolution before driver overwrites them.
> + */
> +static void wacom_set_default_phy(struct wacom_features *features)
> +{
> +	if (features->x_resolution) {
> +		features->x_phy = (features->x_max * 100) /
> +					features->x_resolution;
> +		features->y_phy = (features->y_max * 100) /
> +					features->y_resolution;
> +	}
> +}
> +
> +static void wacom_calculate_res(struct wacom_features *features)
> +{
> +	/* set unit to "100th of a mm" for devices not reported by HID */
> +	if (!features->unit) {
> +		features->unit = 0x11;
> +		features->unitExpo = -3;
> +	}
> +
> +	features->x_resolution = wacom_calc_hid_res(features->x_max,
> +						    features->x_phy,
> +						    features->unit,
> +						    features->unitExpo);
> +	features->y_resolution = wacom_calc_hid_res(features->y_max,
> +						    features->y_phy,
> +						    features->unit,
> +						    features->unitExpo);
> +}
> +
>  static void wacom_wireless_work(struct work_struct *work)
>  {
>  	struct wacom *wacom = container_of(work, struct wacom, work);
> @@ -1339,6 +1372,8 @@ static void wacom_wireless_work(struct work_struct *work)
>  		if (wacom_wac1->features.type != INTUOSHT &&
>  		    wacom_wac1->features.type != BAMBOO_PT)
>  			wacom_wac1->features.device_type |= WACOM_DEVICETYPE_PAD;
> +		wacom_set_default_phy(&wacom_wac1->features);
> +		wacom_calculate_res(&wacom_wac1->features);
>  		snprintf(wacom_wac1->pen_name, WACOM_NAME_MAX, "%s (WL) Pen",
>  			 wacom_wac1->features.name);
>  		snprintf(wacom_wac1->pad_name, WACOM_NAME_MAX, "%s (WL) Pad",
> @@ -1357,7 +1392,9 @@ static void wacom_wireless_work(struct work_struct *work)
>  			wacom_wac2->features =
>  				*((struct wacom_features *)id->driver_data);
>  			wacom_wac2->features.pktlen = WACOM_PKGLEN_BBTOUCH3;
> +			wacom_set_default_phy(&wacom_wac2->features);
>  			wacom_wac2->features.x_max = wacom_wac2->features.y_max = 4096;
> +			wacom_calculate_res(&wacom_wac2->features);
>  			snprintf(wacom_wac2->touch_name, WACOM_NAME_MAX,
>  				 "%s (WL) Finger",wacom_wac2->features.name);
>  			snprintf(wacom_wac2->pad_name, WACOM_NAME_MAX,
> @@ -1405,39 +1442,6 @@ void wacom_battery_work(struct work_struct *work)
>  	}
>  }
>  
> -/*
> - * Not all devices report physical dimensions from HID.
> - * Compute the default from hardcoded logical dimension
> - * and resolution before driver overwrites them.
> - */
> -static void wacom_set_default_phy(struct wacom_features *features)
> -{
> -	if (features->x_resolution) {
> -		features->x_phy = (features->x_max * 100) /
> -					features->x_resolution;
> -		features->y_phy = (features->y_max * 100) /
> -					features->y_resolution;
> -	}
> -}
> -
> -static void wacom_calculate_res(struct wacom_features *features)
> -{
> -	/* set unit to "100th of a mm" for devices not reported by HID */
> -	if (!features->unit) {
> -		features->unit = 0x11;
> -		features->unitExpo = -3;
> -	}
> -
> -	features->x_resolution = wacom_calc_hid_res(features->x_max,
> -						    features->x_phy,
> -						    features->unit,
> -						    features->unitExpo);
> -	features->y_resolution = wacom_calc_hid_res(features->y_max,
> -						    features->y_phy,
> -						    features->unit,
> -						    features->unitExpo);
> -}
> -
>  static size_t wacom_compute_pktlen(struct hid_device *hdev)
>  {
>  	struct hid_report_enum *report_enum;
> -- 
> 2.5.0
> 

-- 
Jiri Kosina
