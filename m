From: Maurus Cuelenaere <mcuelenaere@gmail.com>
Subject: Re: [PATCH 1/2] input : wacom - retrieve maximum number of touch
 points
Date: Wed, 01 Feb 2012 12:53:34 +0100
Message-ID: <4F2927BE.4010905@gmail.com>
References: <1328069031-16873-1-git-send-email-chris@cnpbagwell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:41411 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753983Ab2BALxh (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 1 Feb 2012 06:53:37 -0500
Received: by bkcjm19 with SMTP id jm19so934948bkc.19
        for <linux-input@vger.kernel.org>; Wed, 01 Feb 2012 03:53:36 -0800 (PST)
In-Reply-To: <1328069031-16873-1-git-send-email-chris@cnpbagwell.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: chris@cnpbagwell.com
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, Ping Cheng <pinglinux@gmail.com>, Ping Cheng <pingc@wacom.com>

Op 01-02-12 05:03, chris@cnpbagwell.com schreef:
> From: Ping Cheng<pinglinux@gmail.com>
>
>  From the HID usage table when it is supported.
>
> Tested-by: Chris Bagwell<chris@cnpbagwell.com>
> Signed-off-by: Chris Bagwell<chris@cnpbagwell.com>
> Signed-off-by: Ping Cheng<pingc@wacom.com>
> ---
>
> These two patches were originally in a set of 4 from Ping.
> 2 of those 4 have already been committed to next branch.
>
> The change between this version and Ping's last version is
> making use of features to set the new touch_max value.
> The 2nd patch is unmodified.
>
>   drivers/input/tablet/wacom_sys.c |   26 +++++++++++++++++-
>   drivers/input/tablet/wacom_wac.c |   55 +++++++++++++++++++++++--------------
>   drivers/input/tablet/wacom_wac.h |    1 +
>   3 files changed, 60 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/input/tablet/wacom_sys.c b/drivers/input/tablet/wacom_sys.c
> index c9588ee..5004a75 100644
> --- a/drivers/input/tablet/wacom_sys.c
> +++ b/drivers/input/tablet/wacom_sys.c
> @@ -28,6 +28,7 @@
>   #define HID_USAGE_Y_TILT		0x3e
>   #define HID_USAGE_FINGER		0x22
>   #define HID_USAGE_STYLUS		0x20
> +#define HID_USAGE_CONTACTMAX		0x55
>   #define HID_COLLECTION			0xa1
>   #define HID_COLLECTION_LOGICAL		0x02
>   #define HID_COLLECTION_END		0xc0
> @@ -196,6 +197,24 @@ static int wacom_parse_logical_collection(unsigned char *report,
>   	return length;
>   }
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

Why not allocate this on the stack?
This also can't leak memory (like you currently do).

> +
> +	rep_data[0] = 12;
> +	result = wacom_get_report(intf, WAC_HID_FEATURE_REPORT,
> +		 rep_data[0], rep_data, 2, WAC_MSG_RETRIES);
> +
> +	if ((result>= 0)&&  (rep_data[1]>  2))
> +		features->touch_max = rep_data[1];
> +}
> +

-- 
Maurus Cuelenaere

