From: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/3] IIO: call sensor hub open close function
Date: Tue, 01 Oct 2013 09:42:31 +0100
Message-ID: <524A8AF7.8030304@kernel.org>
References: <1379524399-16995-1-git-send-email-srinivas.pandruvada@linux.intel.com> <1379524399-16995-2-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1379524399-16995-2-git-send-email-srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: jkosina-AlSwsSmVLrQ@public.gmane.org, holler-SXC+2es9fhnfWeYVQQPykw@public.gmane.org
List-Id: linux-input@vger.kernel.org

On 09/18/13 18:13, Srinivas Pandruvada wrote:
> Call hid_sensor_hub_device_open when user space opens device and call
> hid_sensor_hub_device_close when device is closed. This helps in
> saving power.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Applied to the togreg branch of iio.git

Thanks,
> ---
>  drivers/iio/common/hid-sensors/hid-sensor-trigger.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> index 87419c4..b6e77e0 100644
> --- a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> +++ b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> @@ -34,6 +34,12 @@ static int hid_sensor_data_rdy_trigger_set_state(struct iio_trigger *trig,
>  	struct hid_sensor_common *st = iio_trigger_get_drvdata(trig);
>  	int state_val;
>  
> +	if (state) {
> +		if (sensor_hub_device_open(st->hsdev))
> +			return -EIO;
> +	} else
> +		sensor_hub_device_close(st->hsdev);
> +
>  	state_val = state ? 1 : 0;
>  	if (IS_ENABLED(CONFIG_HID_SENSOR_ENUM_BASE_QUIRKS))
>  		++state_val;
> 
