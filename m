From: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: Re: [PATCH 1/2] iio: Add support for linear accel
Date: Tue, 3 Jan 2017 08:22:59 +0100 (CET)
Message-ID: <alpine.DEB.2.02.1701030821450.18919@pmeerw.net>
References: <1483456430-6980-1-git-send-email-hongyan.song@intel.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="324295856-438752256-1483428179=:18919"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([84.19.176.92]:42093 "EHLO pmeerw.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751408AbdACHXC (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 3 Jan 2017 02:23:02 -0500
In-Reply-To: <1483456430-6980-1-git-send-email-hongyan.song@intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Song Hongyan <hongyan.song@intel.com>
Cc: linux-input@vger.kernel.org, linux-iio@vger.kernel.org, jikos@kernel.org, jic23@kernel.org, srinivas.pandruvada@intel.com

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--324295856-438752256-1483428179=:18919
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT


> Add new channel types support for linear accel sensor.
> 
> Linear acceleration differs from a standard accelerometor,
> its value depends on standard accel sensor and gravity sensor.
> Conceptually, this three sensors have following relationship:
> linear acceleration = acceleration - acceleration due to gravity
> 
> At rest, standard accelerometer displays 1g due to earth’s
> gravitational pull while a liner accelerometer will show 0g.

comment below
 
> More information can be found in:
> http://www.usb.org/developers/hidpage/HUTRR59_-_Usages_for_Wearables.pdf
> 
> Signed-off-by: Song Hongyan <hongyan.song@intel.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-iio | 10 ++++++++++
>  drivers/iio/industrialio-core.c         |  1 +
>  include/uapi/linux/iio/types.h          |  1 +
>  tools/iio/iio_event_monitor.c           |  2 ++
>  4 files changed, 14 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index 60b7406..8091f3d 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -170,6 +170,16 @@ Description:
>  		Has all of the equivalent parameters as per voltageY. Units
>  		after application of scale and offset are m/s^2.
>  
> +What:		/sys/bus/iio/devices/iio:deviceX/in_linear_accel_x_raw
> +What:		/sys/bus/iio/devices/iio:deviceX/in_linear_accel_y_raw
> +What:		/sys/bus/iio/devices/iio:deviceX/in_linear_accel_z_raw

I think this would be in_linearaccel_x_raw, etc.?

> +KernelVersion:	4.11
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Linear Acceleration in direction x, y or z (may be arbitrarily assigned
> +		but should match other such assignments on device).
> +		Has all of the equivalent parameters as per voltageY. Units
> +		after application of scale and offset are m/s^2.
>  
>  What:		/sys/bus/iio/devices/iio:deviceX/in_gravity_x_raw
>  What:		/sys/bus/iio/devices/iio:deviceX/in_gravity_y_raw
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 72fc96a..da78c26 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -82,6 +82,7 @@ struct bus_type iio_bus_type = {
>  	[IIO_UVINDEX] = "uvindex",
>  	[IIO_ELECTRICALCONDUCTIVITY] = "electricalconductivity",
>  	[IIO_GRAVITY]  = "gravity",
> +	[IIO_LINEAR_ACCEL] = "linearaccel",
>  };
>  
>  static const char * const iio_modifier_names[] = {
> diff --git a/include/uapi/linux/iio/types.h b/include/uapi/linux/iio/types.h
> index d3f7ba7..d6df101 100644
> --- a/include/uapi/linux/iio/types.h
> +++ b/include/uapi/linux/iio/types.h
> @@ -41,6 +41,7 @@ enum iio_chan_type {
>  	IIO_UVINDEX,
>  	IIO_ELECTRICALCONDUCTIVITY,
>  	IIO_GRAVITY,
> +	IIO_LINEAR_ACCEL,
>  };
>  
>  enum iio_modifier {
> diff --git a/tools/iio/iio_event_monitor.c b/tools/iio/iio_event_monitor.c
> index b61245e..116644a 100644
> --- a/tools/iio/iio_event_monitor.c
> +++ b/tools/iio/iio_event_monitor.c
> @@ -58,6 +58,7 @@
>  	[IIO_PH] = "ph",
>  	[IIO_UVINDEX] = "uvindex",
>  	[IIO_GRAVITY] = "gravity",
> +	[IIO_LINEAR_ACCEL] = "linearaccel",
>  };
>  
>  static const char * const iio_ev_type_text[] = {
> @@ -151,6 +152,7 @@ static bool event_is_known(struct iio_event_data *event)
>  	case IIO_PH:
>  	case IIO_UVINDEX:
>  	case IIO_GRAVITY:
> +	case IIO_LINEAR_ACCEL:
>  		break;
>  	default:
>  		return false;
> 

-- 

Peter Meerwald-Stadler
+43-664-2444418 (mobile)
--324295856-438752256-1483428179=:18919--
