From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] HID Sensors: Add USB pid 0x0A01
Date: Wed, 3 Oct 2012 14:55:43 -0700
Message-ID: <20121003215542.GA22413@core.coreip.homeip.net>
References: <37862.10.7.199.79.1349299910.squirrel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:43702 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752041Ab2JCVzr (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 3 Oct 2012 17:55:47 -0400
Received: by pbbrr4 with SMTP id rr4so10290902pbb.19
        for <linux-input@vger.kernel.org>; Wed, 03 Oct 2012 14:55:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <37862.10.7.199.79.1349299910.squirrel@linux.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Matt Gumbel <matthew.k.gumbel@linux.intel.com>
Cc: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>

Hi Matt,

This should go to Jiri Kosina (CCed).

Thanks.

On Wed, Oct 03, 2012 at 02:31:50PM -0700, Matt Gumbel wrote:
> For usb hid sensor hub in recent platform.
> 
> Signed-off-by: Matt Gumbel <matthew.k.gumbel@linux.intel.com>
> Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  drivers/hid/hid-core.c       |    1 +
>  drivers/hid/hid-ids.h        |    1 +
>  drivers/hid/hid-sensor-hub.c |    2 ++
>  3 files changed, 4 insertions(+)
> 
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index a9bb940..15cf199 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -1562,6 +1562,7 @@ static const struct hid_device_id
> hid_have_special_driver[] = {
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_INTEL_8086,
> USB_DEVICE_ID_SENSOR_HUB_09FA) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_INTEL_8087,
> USB_DEVICE_ID_SENSOR_HUB_1020) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_INTEL_8087,
> USB_DEVICE_ID_SENSOR_HUB_09FA) },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_INTEL_8087,
> USB_DEVICE_ID_SENSOR_HUB_0A01) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_KENSINGTON, USB_DEVICE_ID_KS_SLIMBLADE) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_KEYTOUCH, USB_DEVICE_ID_KEYTOUCH_IEC) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE, USB_DEVICE_ID_KYE_ERGO_525V) },
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index d08a4cf..48c1808 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -432,6 +432,7 @@
>  #define USB_VENDOR_ID_INTEL_8087	0x8087
>  #define USB_DEVICE_ID_SENSOR_HUB_1020	0x1020
>  #define USB_DEVICE_ID_SENSOR_HUB_09FA	0x09FA
> +#define USB_DEVICE_ID_SENSOR_HUB_0A01	0x0A01
> 
>  #define USB_VENDOR_ID_IRTOUCHSYSTEMS	0x6615
>  #define USB_DEVICE_ID_IRTOUCH_INFRARED_USB	0x0070
> diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.c
> index d9d73e9..b1c40e8 100644
> --- a/drivers/hid/hid-sensor-hub.c
> +++ b/drivers/hid/hid-sensor-hub.c
> @@ -638,6 +638,8 @@ static const struct hid_device_id sensor_hub_devices[]
> = {
>  			USB_DEVICE_ID_SENSOR_HUB_09FA) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_INTEL_8087,
>  			USB_DEVICE_ID_SENSOR_HUB_09FA) },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_INTEL_8087,
> +			USB_DEVICE_ID_SENSOR_HUB_0A01) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_STANTUM_STM,
>  			USB_DEVICE_ID_SENSOR_HUB_7014) },
>  	{ }
> -- 
> 1.7.9.5
> 

-- 
Dmitry
