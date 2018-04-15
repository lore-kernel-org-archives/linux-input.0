From: Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v3 03/11] iio: Add channel for Position Relative
Date: Sun, 15 Apr 2018 20:29:42 +0100
Message-ID: <20180415202942.5c7d50a8@archlinux>
References: <1523350677-27106-1-git-send-email-eugen.hristev@microchip.com>
        <1523350677-27106-4-git-send-email-eugen.hristev@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1523350677-27106-4-git-send-email-eugen.hristev@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eugen Hristev <eugen.hristev@microchip.com>
Cc: ludovic.desroches@microchip.com, alexandre.belloni@bootlin.com, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, linux-input@vger.kernel.org, nicolas.ferre@microchip.com, dmitry.torokhov@gmail.com, robh@kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, 10 Apr 2018 11:57:49 +0300
Eugen Hristev <eugen.hristev@microchip.com> wrote:

> Add new channel type for relative position on a pad.
> 
> These type of analog sensor offers the position of a pen
> on a touchpad, and is represented as a voltage, which can be
> converted to a position on X and Y axis on the pad.
> The channel will hand the relative position on the pad in both directions.
> 
> The channel can then be consumed by a touchscreen driver or
> read as-is for a raw indication of the touchpen on a touchpad.
> 
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
> ---
> Changes in v2:
>  - modified channel name to relative position as suggested.
>  - modified kernel version to 4.18 (presumable)
> 
>  Documentation/ABI/testing/sysfs-bus-iio | 12 ++++++++++++
>  drivers/iio/industrialio-core.c         |  1 +
>  include/uapi/linux/iio/types.h          |  1 +
>  tools/iio/iio_event_monitor.c           |  2 ++
>  4 files changed, 16 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index 6a5f34b..42a9287 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -190,6 +190,18 @@ Description:
>  		but should match other such assignments on device).
>  		Units after application of scale and offset are m/s^2.
>  
> +What:		/sys/bus/iio/devices/iio:deviceX/in_positionrelative_x_raw
> +What:		/sys/bus/iio/devices/iio:deviceX/in_positionrelative_y_raw
> +KernelVersion:	4.18
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Relative position in direction x or y on a pad (may be
> +		arbitrarily assigned but should match other such assignments on
> +		device).
> +		Units after application of scale and offset are milli percents
> +		from the pad's size in both directions. Should be calibrated by
> +		the consumer.
I know the milli percent comes form the humidity equivalent, but I wonder
if we are right to follow that.  10^-5 is a pretty random base unit (though
I got argued into it being a standard choice for humidity sensors IIRC...

What do people think?  We could go with 1 for full range or just percent perhaps?

I'm not that fussed about staying consistent with humidity - we are unlikely
to end up with sensors doing both anytime soon so there shouldn't be
any confusion...

Jonathan
> +
>  What:		/sys/bus/iio/devices/iio:deviceX/in_anglvel_x_raw
>  What:		/sys/bus/iio/devices/iio:deviceX/in_anglvel_y_raw
>  What:		/sys/bus/iio/devices/iio:deviceX/in_anglvel_z_raw
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 19bdf3d..14bf3d24 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -85,6 +85,7 @@ static const char * const iio_chan_type_name_spec[] = {
>  	[IIO_COUNT] = "count",
>  	[IIO_INDEX] = "index",
>  	[IIO_GRAVITY]  = "gravity",
> +	[IIO_POSITIONRELATIVE]  = "positionrelative",
>  };
>  
>  static const char * const iio_modifier_names[] = {
> diff --git a/include/uapi/linux/iio/types.h b/include/uapi/linux/iio/types.h
> index 4213cdf..033c7d2 100644
> --- a/include/uapi/linux/iio/types.h
> +++ b/include/uapi/linux/iio/types.h
> @@ -44,6 +44,7 @@ enum iio_chan_type {
>  	IIO_COUNT,
>  	IIO_INDEX,
>  	IIO_GRAVITY,
> +	IIO_POSITIONRELATIVE,
>  };
>  
>  enum iio_modifier {
> diff --git a/tools/iio/iio_event_monitor.c b/tools/iio/iio_event_monitor.c
> index b61245e..148f69d 100644
> --- a/tools/iio/iio_event_monitor.c
> +++ b/tools/iio/iio_event_monitor.c
> @@ -58,6 +58,7 @@ static const char * const iio_chan_type_name_spec[] = {
>  	[IIO_PH] = "ph",
>  	[IIO_UVINDEX] = "uvindex",
>  	[IIO_GRAVITY] = "gravity",
> +	[IIO_POSITIONRELATIVE] = "positionrelative",
>  };
>  
>  static const char * const iio_ev_type_text[] = {
> @@ -151,6 +152,7 @@ static bool event_is_known(struct iio_event_data *event)
>  	case IIO_PH:
>  	case IIO_UVINDEX:
>  	case IIO_GRAVITY:
> +	case IIO_POSITIONRELATIVE:
>  		break;
>  	default:
>  		return false;
