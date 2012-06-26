From: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: [PATCH, 2/6] HID-Sensors: Sensor framework
Date: Tue, 26 Jun 2012 14:02:08 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1206261356160.18612@pobox.suse.cz>
References: <1340672054-16591-1-git-send-email-srinivas.pandruvada@intel.com> <1340672054-16591-3-git-send-email-srinivas.pandruvada@intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1340672054-16591-3-git-send-email-srinivas.pandruvada-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: srinivas pandruvada <srinivas.pandruvada-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jic23.cam.ac.uk-l3A5Bk7waGM@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Mon, 25 Jun 2012, srinivas pandruvada wrote:

> Adding processing for HID Sensor usage table as defined by
> HID 1.12, Request #: HUTRR39, dated 05 May, 2011.
> This driver uses HID driver framework to register, send and
> receive events.
> This uses MFD framework, so that actual processing for a
> specific usage id can be done in a different driver. For
> example an accelerometer driver can be a separate driver and
> use the interface provided by this driver to register for
> events.
> 
> Signed-off-by: srinivas pandruvada <srinivas.pandruvada-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/hid/Kconfig            |   18 +
>  drivers/hid/Makefile           |    1 +
>  drivers/hid/hid-sensor-hub.c   |  883 ++++++++++++++++++++++++++++++++++++++++
>  include/linux/hid-sensor-hub.h |   99 +++++
>  include/linux/hid-sensor-ids.h |  116 ++++++
>  5 files changed, 1117 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/hid/hid-sensor-hub.c
>  create mode 100644 include/linux/hid-sensor-hub.h
>  create mode 100644 include/linux/hid-sensor-ids.h
> 
> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> index ffddcba..0c86ab0 100644
> --- a/drivers/hid/Kconfig
> +++ b/drivers/hid/Kconfig
> @@ -644,6 +644,24 @@ config HID_ZYDACRON
>  	---help---
>  	Support for Zydacron remote control.
>  
> +config HID_SENSOR_HUB
> +	tristate "HID Sensors framework support"
> +	depends on USB_HID
> +	select MFD_CORE
> +	default n
> +	-- help---
> +	  Support for HID Sensor framework. This will provide MFD framework for
> +	  adding different sensors, using HID sensor usage table. This defines
> +	  a set of interface functions to register callbacks for events so
> +	  that the events are transferred to user space using either input
> +	  or IIO ineterfaces.
> +
> +config HID_SENSOR_HUB_DEBUG
> +	tristate "HID Sensor debug support"
> +	default n
> +	-- help---
> +	  Debug support for Hid sensors. Enable this flag to debug only.
> +

Why not use debugfs (which is what the rest of the HID code and drivers do 
for debugging)?

Thanks,

-- 
Jiri Kosina
SUSE Labs
