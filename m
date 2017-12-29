From: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 02/14] iio: Add channel for Position
Date: Fri, 29 Dec 2017 16:09:58 +0000
Message-ID: <20171229160958.2531299b@archlinux>
References: <1513955241-10985-1-git-send-email-eugen.hristev@microchip.com>
        <1513955241-10985-3-git-send-email-eugen.hristev@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1513955241-10985-3-git-send-email-eugen.hristev-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Eugen Hristev <eugen.hristev-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
Cc: nicolas.ferre-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org, ludovic.desroches-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org, alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Fri, 22 Dec 2017 17:07:09 +0200
Eugen Hristev <eugen.hristev-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org> wrote:

> Add new channel type for position on a pad.
> 
> These type of analog sensor represents the position of a pen
> on a touchpad, and is represented as a voltage, which can be
> converted to a position on X and Y axis on the pad.
> 
> The channel can then be consumed by a touchscreen driver or
> read as-is for a raw indication of the touchpen on a touchpad.
> 
> Signed-off-by: Eugen Hristev <eugen.hristev-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
> ---
>  Documentation/ABI/testing/sysfs-bus-iio | 11 +++++++++++
>  drivers/iio/industrialio-core.c         |  1 +
>  include/uapi/linux/iio/types.h          |  1 +
>  tools/iio/iio_event_monitor.c           |  2 ++
>  4 files changed, 15 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index a478740..d2b9e2f 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -190,6 +190,17 @@ Description:
>  		but should match other such assignments on device).
>  		Units after application of scale and offset are m/s^2.
>  
> +What:		/sys/bus/iio/devices/iio:deviceX/in_position_x_raw
> +What:		/sys/bus/iio/devices/iio:deviceX/in_position_y_raw
> +KernelVersion:	4.16
> +Contact:	linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> +Description:
> +		Position in direction x or y on a pad (may be arbitrarily
> +		assigned but should match other such assignments on device).
> +		Units after application of scale and offset are millipercents
> +		from the pad's size in both directions. Should be calibrated by
> +		the consumer.

Hmm. The units are an issues as to be consistent with the existing ABI position
should be in meters.  Perhaps the trick is to do similar to we have done for
relative humidity and call this in_positionrelative_x_raw etc.

That leaves position open for absolute position devices (who knows what)
in the future.

> +
>  What:		/sys/bus/iio/devices/iio:deviceX/in_anglvel_x_raw
>  What:		/sys/bus/iio/devices/iio:deviceX/in_anglvel_y_raw
>  What:		/sys/bus/iio/devices/iio:deviceX/in_anglvel_z_raw
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 2e8e36f..a4fa49b 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -85,6 +85,7 @@ static const char * const iio_chan_type_name_spec[] = {
>  	[IIO_COUNT] = "count",
>  	[IIO_INDEX] = "index",
>  	[IIO_GRAVITY]  = "gravity",
> +	[IIO_POSITION]  = "position",
>  };
>  
>  static const char * const iio_modifier_names[] = {
> diff --git a/include/uapi/linux/iio/types.h b/include/uapi/linux/iio/types.h
> index 4213cdf..35e17da 100644
> --- a/include/uapi/linux/iio/types.h
> +++ b/include/uapi/linux/iio/types.h
> @@ -44,6 +44,7 @@ enum iio_chan_type {
>  	IIO_COUNT,
>  	IIO_INDEX,
>  	IIO_GRAVITY,
> +	IIO_POSITION,
>  };
>  
>  enum iio_modifier {
> diff --git a/tools/iio/iio_event_monitor.c b/tools/iio/iio_event_monitor.c
> index b61245e..0c2b317 100644
> --- a/tools/iio/iio_event_monitor.c
> +++ b/tools/iio/iio_event_monitor.c
> @@ -58,6 +58,7 @@ static const char * const iio_chan_type_name_spec[] = {
>  	[IIO_PH] = "ph",
>  	[IIO_UVINDEX] = "uvindex",
>  	[IIO_GRAVITY] = "gravity",
> +	[IIO_POSITION] = "position",
>  };
>  
>  static const char * const iio_ev_type_text[] = {
> @@ -151,6 +152,7 @@ static bool event_is_known(struct iio_event_data *event)
>  	case IIO_PH:
>  	case IIO_UVINDEX:
>  	case IIO_GRAVITY:
> +	case IIO_POSITION:
>  		break;
>  	default:
>  		return false;
