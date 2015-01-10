From: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/9] iio: hid-sensor-accel-3d: Adjust parameter for attribute
 read
Date: Sat, 10 Jan 2015 22:42:30 +0000
Message-ID: <54B1AAD6.6070303@kernel.org>
References: <1420656483-7093-1-git-send-email-srinivas.pandruvada@linux.intel.com> <1420656483-7093-3-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1420656483-7093-3-git-send-email-srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, jkosina-AlSwsSmVLrQ@public.gmane.org, a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org
Cc: linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, holler-SXC+2es9fhnfWeYVQQPykw@public.gmane.org, rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-input@vger.kernel.org

On 07/01/15 18:47, Srinivas Pandruvada wrote:
> The new API added a flag for sync/async mode. Added sync mode flag.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Again, please don't break the build between patches like this.

If you want to do things in steps, you'll have to carry to versions of
the function during the conversion and drop the unwanted one at the end.

> ---
>  drivers/iio/accel/hid-sensor-accel-3d.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/accel/hid-sensor-accel-3d.c b/drivers/iio/accel/hid-sensor-accel-3d.c
> index d5d9531..0085c2f 100644
> --- a/drivers/iio/accel/hid-sensor-accel-3d.c
> +++ b/drivers/iio/accel/hid-sensor-accel-3d.c
> @@ -130,7 +130,8 @@ static int accel_3d_read_raw(struct iio_dev *indio_dev,
>  			*val = sensor_hub_input_attr_get_raw_value(
>  					accel_state->common_attributes.hsdev,
>  					HID_USAGE_SENSOR_ACCEL_3D, address,
> -					report_id);
> +					report_id,
> +					SENSOR_HUB_SYNC);
>  		else {
>  			*val = 0;
>  			hid_sensor_power_state(&accel_state->common_attributes,
> 
