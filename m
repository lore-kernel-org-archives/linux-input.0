From: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] hid: hid-sensor-prox: Add more data field for hysteresis
 parsing
Date: Sun, 19 Feb 2017 11:50:21 +0000
Message-ID: <a27a7238-c825-b2d9-733e-0c7a7919a3d6@kernel.org>
References: <1486979692-44878-1-git-send-email-hongyan.song@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1486979692-44878-1-git-send-email-hongyan.song-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Song Hongyan <hongyan.song-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: jikos-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, srinivas.pandruvada-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-input@vger.kernel.org

On 13/02/17 09:54, Song Hongyan wrote:
> Add HID_USAGE_SENSOR_HUMAN_PRESENCE support for Human Presence sensitivity
> parsing, in case some implementation uses it as sensitivity modifier.
> 
> Signed-off-by: Song Hongyan <hongyan.song-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Do we want to perhaps indicate to userspace in some way that this is what is being
reported? (not that I have any idea how a proximity sensor could potentially tell
a human from a passing cat for example ;)

Otherwise, I'm fine with this but would like an Ack from Srinivas.
> ---
>  drivers/iio/light/hid-sensor-prox.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/iio/light/hid-sensor-prox.c b/drivers/iio/light/hid-sensor-prox.c
> index 45ca056..73fced8 100644
> --- a/drivers/iio/light/hid-sensor-prox.c
> +++ b/drivers/iio/light/hid-sensor-prox.c
> @@ -240,6 +240,13 @@ static int prox_parse_report(struct platform_device *pdev,
>  			st->common_attributes.sensitivity.index,
>  			st->common_attributes.sensitivity.report_id);
>  	}
> +	if (st->common_attributes.sensitivity.index < 0)
> +		sensor_hub_input_get_attribute_info(hsdev,
> +			HID_FEATURE_REPORT, usage_id,
> +			HID_USAGE_SENSOR_DATA_MOD_CHANGE_SENSITIVITY_ABS |
> +			HID_USAGE_SENSOR_HUMAN_PRESENCE,
> +			&st->common_attributes.sensitivity);
> +
>  	return ret;
>  }
>  
> 
