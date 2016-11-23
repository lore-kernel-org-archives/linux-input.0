From: Jiri Kosina <jikos-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V4] hid: hid-sensor-hub: clear memory to avoid random
 data
Date: Wed, 23 Nov 2016 17:56:25 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1611231756151.29400@cbobk.fhfr.pm>
References: <1479172270-3684-1-git-send-email-hongyan.song@intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1479172270-3684-1-git-send-email-hongyan.song-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Song Hongyan <hongyan.song-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, srinivas.pandruvada-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Tue, 15 Nov 2016, Song Hongyan wrote:

> When user tried to read some fields like hysteresis from IIO sysfs on some
> systems, it fails. The reason is that this field is a byte field and caller
> of sensor_hub_get_feature() passes a buffer of 4 bytes. Here the function
> sensor_hub_get_feature() copies the single byte from the report to the
> caller buffer and returns "1" as the number of bytes copied. So caller
> can use the return value.
> 
> But this is done by multiple callers, so if we just change the
> sensor_hub_get_feature so that caller buffer is initialized with 0s
> then we don't to change all functions.
> 
> Signed-off-by: Song Hongyan <hongyan.song-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> ---
> 	changes: update comments
> 
>  drivers/hid/hid-sensor-hub.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.c
> index 658a607..b74d954 100644
> --- a/drivers/hid/hid-sensor-hub.c
> +++ b/drivers/hid/hid-sensor-hub.c
> @@ -252,6 +252,7 @@ int sensor_hub_get_feature(struct hid_sensor_hub_device *hsdev, u32 report_id,
>  	int report_size;
>  	int ret = 0;
>  
> +	memset(buffer, 0, buffer_size);
>  	mutex_lock(&data->mutex);
>  	report = sensor_hub_report(report_id, hsdev->hdev, HID_FEATURE_REPORT);
>  	if (!report || (field_index >= report->maxfield) ||

Applied to hid.git#for-4.9/upstream-fixes

Thanks,

-- 
Jiri Kosina
SUSE Labs
