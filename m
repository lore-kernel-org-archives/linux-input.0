From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/4 v2] input : wacom - retrieve maximum number of touch
 points
Date: Sat, 28 Jan 2012 23:04:48 -0800
Message-ID: <20120129070448.GF23595@core.coreip.homeip.net>
References: <1325717032-6378-1-git-send-email-pinglinux@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:56519 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751133Ab2A2HEy (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 29 Jan 2012 02:04:54 -0500
Received: by pbaa10 with SMTP id a10so2866278pba.19
        for <linux-input@vger.kernel.org>; Sat, 28 Jan 2012 23:04:54 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1325717032-6378-1-git-send-email-pinglinux@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: linux-input@vger.kernel.org, Ping Cheng <pingc@wacom.com>

On Wed, Jan 04, 2012 at 02:43:52PM -0800, Ping Cheng wrote:
> From the HID usage table when it is supported.
> 
> Tested-by: Chris Bagwell <chris@cnpbagwell.com>
> Reviewed-by: Chris Bagwell <chris@cnpbagwell.com>
> Signed-off-by: Ping Cheng <pingc@wacom.com>
> ---
> 
> v2: updated with Chris' comments.
> 
>  drivers/input/tablet/wacom_sys.c |   31 ++++++++++++++++++++++++++++++-
>  drivers/input/tablet/wacom_wac.c |   10 ++++------
>  drivers/input/tablet/wacom_wac.h |    1 +
>  3 files changed, 35 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/input/tablet/wacom_sys.c b/drivers/input/tablet/wacom_sys.c
> index c9588ee..f7fe091 100644
> --- a/drivers/input/tablet/wacom_sys.c
> +++ b/drivers/input/tablet/wacom_sys.c
> @@ -28,6 +28,7 @@
>  #define HID_USAGE_Y_TILT		0x3e
>  #define HID_USAGE_FINGER		0x22
>  #define HID_USAGE_STYLUS		0x20
> +#define HID_USAGE_CONTACTMAX		0x55
>  #define HID_COLLECTION			0xa1
>  #define HID_COLLECTION_LOGICAL		0x02
>  #define HID_COLLECTION_END		0xc0
> @@ -191,11 +192,30 @@ static int wacom_parse_logical_collection(unsigned char *report,
>  		features->x_max = features->y_max =
>  			get_unaligned_le16(&report[10]);
>  
> +		features->touch_max = 16;
>  		length = 11;
>  	}
>  	return length;
>  }
>  
> +static void wacom_retrieve_report_data(struct usb_interface *intf,
> +				       struct wacom_features *features)
> +{
> +	int result = 0;
> +	unsigned char *rep_data;
> +
> +	rep_data = kmalloc(2, GFP_KERNEL);
> +	if (!rep_data)
> +		return;
> +
> +	rep_data[0] = 12;
> +	result = wacom_get_report(intf, WAC_HID_FEATURE_REPORT,
> +		 rep_data[0], rep_data, 2, WAC_MSG_RETRIES);
> +
> +	if ((result >= 0) && (rep_data[1] > 2))
> +		features->touch_max = rep_data[1];
> +}
> +
>  /*
>   * Interface Descriptor of wacom devices can be incomplete and
>   * inconsistent so wacom_features table is used to store stylus
> @@ -286,16 +306,19 @@ static int wacom_parse_hid(struct usb_interface *intf,
>  						if (features->type == TABLETPC2FG) {
>  							/* need to reset back */
>  							features->pktlen = WACOM_PKGLEN_TPC2FG;
> +							features->touch_max = 2;

Why do we set it dynamically for devices where number of contacts is
constant? Or, even if it is not constant, we could seed it in the
features that we set in driver_info and only adjust when we encounter
HID_USAGE_CONTACTMAX?

Thanks.

-- 
Dmitry
