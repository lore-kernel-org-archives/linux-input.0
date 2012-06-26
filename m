From: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
Subject: RE: [PATCH, 2/6] HID-Sensors: Sensor framework
Date: Tue, 26 Jun 2012 16:00:27 +0000
Message-ID: <4FA419E87744DF4DAECD5BCE1214B7A91933EBDE@ORSMSX104.amr.corp.intel.com>
References: <1340672054-16591-1-git-send-email-srinivas.pandruvada@intel.com>
 <1340672054-16591-3-git-send-email-srinivas.pandruvada@intel.com>
 <alpine.LNX.2.00.1206261356160.18612@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:33469 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757849Ab2FZQA3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 26 Jun 2012 12:00:29 -0400
In-Reply-To: <alpine.LNX.2.00.1206261356160.18612@pobox.suse.cz>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, "jic23.cam.ac.uk@suse.de" <jic23.cam.ac.uk@suse.de>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

OK. I can use debugfs. If you have some other comments, I can bundle all of them together in the next set.

Thanks,
Srinivas

-----Original Message-----
From: linux-iio-owner@vger.kernel.org [mailto:linux-iio-owner@vger.kernel.org] On Behalf Of Jiri Kosina
Sent: Tuesday, June 26, 2012 5:02 AM
To: Pandruvada, Srinivas
Cc: linux-iio@vger.kernel.org; jic23.cam.ac.uk@suse.de; linux-input@vger.kernel.org
Subject: Re: [PATCH, 2/6] HID-Sensors: Sensor framework

On Mon, 25 Jun 2012, srinivas pandruvada wrote:

> Adding processing for HID Sensor usage table as defined by HID 1.12, 
> Request #: HUTRR39, dated 05 May, 2011.
> This driver uses HID driver framework to register, send and receive 
> events.
> This uses MFD framework, so that actual processing for a specific 
> usage id can be done in a different driver. For example an 
> accelerometer driver can be a separate driver and use the interface 
> provided by this driver to register for events.
> 
> Signed-off-by: srinivas pandruvada <srinivas.pandruvada@intel.com>
> ---
>  drivers/hid/Kconfig            |   18 +
>  drivers/hid/Makefile           |    1 +
>  drivers/hid/hid-sensor-hub.c   |  883 ++++++++++++++++++++++++++++++++++++++++
>  include/linux/hid-sensor-hub.h |   99 +++++
>  include/linux/hid-sensor-ids.h |  116 ++++++
>  5 files changed, 1117 insertions(+), 0 deletions(-)  create mode 
> 100644 drivers/hid/hid-sensor-hub.c  create mode 100644 
> include/linux/hid-sensor-hub.h  create mode 100644 
> include/linux/hid-sensor-ids.h
> 
> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig index 
> ffddcba..0c86ab0 100644
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

Why not use debugfs (which is what the rest of the HID code and drivers do for debugging)?

Thanks,

--
Jiri Kosina
SUSE Labs
--
To unsubscribe from this list: send the line "unsubscribe linux-iio" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html
