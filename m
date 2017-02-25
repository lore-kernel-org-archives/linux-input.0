From: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2] hid: hid-sensor-prox: Add more data field for
 hysteresis parsing
Date: Sat, 25 Feb 2017 16:44:33 +0000
Message-ID: <433426f5-28c2-80eb-74d2-5c980774a1ca@kernel.org>
References: <1487755413-31421-1-git-send-email-hongyan.song@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1487755413-31421-1-git-send-email-hongyan.song-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Song Hongyan <hongyan.song-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: jikos-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, srinivas.pandruvada-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-input@vger.kernel.org

On 22/02/17 09:23, Song Hongyan wrote:
> Add HID_USAGE_SENSOR_HUMAN_PRESENCE support for Human Presence sensitivity
> parsing, in case some implementation uses it as sensitivity modifier.
> 
> Signed-off-by: Song Hongyan <hongyan.song-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Acked-by: Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Applied to the togreg branch of iio.git which will be initially pushed out as
testing for the autobuilders to play with it.
> ---
> change: adding Srinivas ack
No actual need to post a new version to add an Ack. I'll generally pick them
up directly from the thread whilst applying.

Thanks,

Jonathan
> 
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
