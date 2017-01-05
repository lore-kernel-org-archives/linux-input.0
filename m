From: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 1/2] iio: Add channel for Gravity
Date: Thu, 5 Jan 2017 13:06:00 +0000
Message-ID: <953045fc-bf55-ee44-e5b9-bb4b23b70ba8@kernel.org>
References: <1483611844-7078-1-git-send-email-hongyan.song@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1483611844-7078-1-git-send-email-hongyan.song-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Song Hongyan <hongyan.song-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: jikos-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, srinivas.pandruvada-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-input@vger.kernel.org

On 05/01/17 10:24, Song Hongyan wrote:
> Add new channel types support for gravity sensor.
> 
> Gravity sensor provides an application-level or physical collection that
> identifies a device that measures exclusively the force of Earth's
> gravity along any number of axes.
> 
> More information can be found in:
> http://www.usb.org/developers/hidpage/HUTRR59_-_Usages_for_Wearables.pdf
> 
> Signed-off-by: Song Hongyan <hongyan.song-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Applied to the togreg branch of iio.git. Will push out as testing sometime soon when
I have a decent net connection.

Thanks,

Jonathan
> ---
> changes: patch rebase
> 
>  Documentation/ABI/testing/sysfs-bus-iio | 10 ++++++++++
>  drivers/iio/industrialio-core.c         |  1 +
>  include/uapi/linux/iio/types.h          |  1 +
>  tools/iio/iio_event_monitor.c           |  2 ++
>  4 files changed, 14 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index b8f220f..ed5bc2b 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -170,6 +170,16 @@ Description:
>  		Has all of the equivalent parameters as per voltageY. Units
>  		after application of scale and offset are m/s^2.
>  
> +What:		/sys/bus/iio/devices/iio:deviceX/in_gravity_x_raw
> +What:		/sys/bus/iio/devices/iio:deviceX/in_gravity_y_raw
> +What:		/sys/bus/iio/devices/iio:deviceX/in_gravity_z_raw
> +KernelVersion:	4.11
> +Contact:	linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> +Description:
> +		Gravity in direction x, y or z (may be arbitrarily assigned
> +		but should match other such assignments on device).
> +		Units after application of scale and offset are m/s^2.
> +
>  What:		/sys/bus/iio/devices/iio:deviceX/in_anglvel_x_raw
>  What:		/sys/bus/iio/devices/iio:deviceX/in_anglvel_y_raw
>  What:		/sys/bus/iio/devices/iio:deviceX/in_anglvel_z_raw
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index aaca428..c601698 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -83,6 +83,7 @@ struct bus_type iio_bus_type = {
>  	[IIO_ELECTRICALCONDUCTIVITY] = "electricalconductivity",
>  	[IIO_COUNT] = "count",
>  	[IIO_INDEX] = "index",
> +	[IIO_GRAVITY]  = "gravity",
>  };
>  
>  static const char * const iio_modifier_names[] = {
> diff --git a/include/uapi/linux/iio/types.h b/include/uapi/linux/iio/types.h
> index e54d14a..ffafd6c 100644
> --- a/include/uapi/linux/iio/types.h
> +++ b/include/uapi/linux/iio/types.h
> @@ -42,6 +42,7 @@ enum iio_chan_type {
>  	IIO_ELECTRICALCONDUCTIVITY,
>  	IIO_COUNT,
>  	IIO_INDEX,
> +	IIO_GRAVITY,
j>  };
>  
>  enum iio_modifier {
> diff --git a/tools/iio/iio_event_monitor.c b/tools/iio/iio_event_monitor.c
> index d9b7e0f..b61245e 100644
> --- a/tools/iio/iio_event_monitor.c
> +++ b/tools/iio/iio_event_monitor.c
> @@ -57,6 +57,7 @@
>  	[IIO_RESISTANCE] = "resistance",
>  	[IIO_PH] = "ph",
>  	[IIO_UVINDEX] = "uvindex",
> +	[IIO_GRAVITY] = "gravity",
>  };
>  
>  static const char * const iio_ev_type_text[] = {
> @@ -149,6 +150,7 @@ static bool event_is_known(struct iio_event_data *event)
>  	case IIO_RESISTANCE:
>  	case IIO_PH:
>  	case IIO_UVINDEX:
> +	case IIO_GRAVITY:
>  		break;
>  	default:
>  		return false;
> 
