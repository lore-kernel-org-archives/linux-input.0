From: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] iio: hid-sensor-attributes: Fix gravity sensor scale
 value not right issue
Date: Sat, 25 Mar 2017 16:24:47 +0000
Message-ID: <a34ce134-4aa1-9ca9-ca73-d924fa7e9036@kernel.org>
References: <1490001174-897-1-git-send-email-hongyan.song@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1490001174-897-1-git-send-email-hongyan.song-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Song Hongyan <hongyan.song-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: jikos-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, srinivas.pandruvada-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-input@vger.kernel.org

On 20/03/17 09:12, Song Hongyan wrote:
> Scale value include two parts: unit conversion and exponent conversion.
> Add gravity unit convert table to fix gravity sensor scale value not
> right issue.
> 
> Signed-off-by: Song Hongyan <hongyan.song-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Acked-by: Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
I guess this only effects the recently added gravity driver, but
would have been good to have a fixes tag.

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/common/hid-sensors/hid-sensor-attributes.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> index cc2ce2a..2884783 100644
> --- a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> +++ b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> @@ -38,6 +38,12 @@
>  	{HID_USAGE_SENSOR_ACCEL_3D,
>  		HID_USAGE_SENSOR_UNITS_G, 9, 806650000},
>  
> +	{HID_USAGE_SENSOR_GRAVITY_VECTOR, 0, 9, 806650000},
> +	{HID_USAGE_SENSOR_GRAVITY_VECTOR,
> +		HID_USAGE_SENSOR_UNITS_METERS_PER_SEC_SQRD, 1, 0},
> +	{HID_USAGE_SENSOR_GRAVITY_VECTOR,
> +		HID_USAGE_SENSOR_UNITS_G, 9, 806650000},
> +
>  	{HID_USAGE_SENSOR_GYRO_3D, 0, 0, 17453293},
>  	{HID_USAGE_SENSOR_GYRO_3D,
>  		HID_USAGE_SENSOR_UNITS_RADIANS_PER_SECOND, 1, 0},
> 
