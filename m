From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: add ASUS AIO keyboard model AK1D
Date: Mon, 23 Jul 2012 10:50:36 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1207231050200.21929@pobox.suse.cz>
References: <1343033198-9754-1-git-send-email-cyruslien@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:40546 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750957Ab2GWIun (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 23 Jul 2012 04:50:43 -0400
In-Reply-To: <1343033198-9754-1-git-send-email-cyruslien@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: cyruslien@gmail.com
Cc: linux-input@vger.kernel.org, Cyrus Lien <cyrus.lien@canonical.com>

On Mon, 23 Jul 2012, cyruslien@gmail.com wrote:

> From: Cyrus Lien <cyrus.lien@canonical.com>
> 
> Add Asus All-In-One PC keyboard model AK1D.
> 
> BugLink: https://bugs.launchpad.net/bugs/1027789
> 
> Signed-off-by: Cyrus Lien <cyrus.lien@canonical.com>
> ---
>  drivers/hid/hid-chicony.c |    1 +
>  drivers/hid/hid-ids.h     |    1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/drivers/hid/hid-chicony.c b/drivers/hid/hid-chicony.c
> index b99af34..a2abb8e 100644
> --- a/drivers/hid/hid-chicony.c
> +++ b/drivers/hid/hid-chicony.c
> @@ -60,6 +60,7 @@ static int ch_input_mapping(struct hid_device *hdev, struct hid_input *hi,
>  static const struct hid_device_id ch_devices[] = {
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_CHICONY, USB_DEVICE_ID_CHICONY_TACTICAL_PAD) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_CHICONY, USB_DEVICE_ID_CHICONY_WIRELESS2) },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_CHICONY, USB_DEVICE_ID_CHICONY_AK1D) },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(hid, ch_devices);
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index 3203923..dcfeb3c 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -208,6 +208,7 @@
>  #define USB_DEVICE_ID_CHICONY_MULTI_TOUCH	0xb19d
>  #define USB_DEVICE_ID_CHICONY_WIRELESS	0x0618
>  #define USB_DEVICE_ID_CHICONY_WIRELESS2	0x1123
> +#define USB_DEVICE_ID_CHICONY_AK1D	0x1125
>  
>  #define USB_VENDOR_ID_CHUNGHWAT		0x2247
>  #define USB_DEVICE_ID_CHUNGHWAT_MULTITOUCH	0x0001

Seems like you are missing update to hid_have_special_driver[].

-- 
Jiri Kosina
SUSE Labs
