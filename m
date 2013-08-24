From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: wacom - add support for 0x300 and 0x301
Date: Sat, 24 Aug 2013 16:46:47 -0700
Message-ID: <20130824234647.GF4454@core.coreip.homeip.net>
References: <1377046419-12376-1-git-send-email-pingc@wacom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:36272 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755911Ab3HXXqw (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 24 Aug 2013 19:46:52 -0400
Received: by mail-pa0-f50.google.com with SMTP id fb10so2039378pad.37
        for <linux-input@vger.kernel.org>; Sat, 24 Aug 2013 16:46:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1377046419-12376-1-git-send-email-pingc@wacom.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: linux-input@vger.kernel.org, Ping Cheng <pingc@wacom.com>

On Tue, Aug 20, 2013 at 05:53:39PM -0700, Ping Cheng wrote:
> Tested-by: Arjuna Rao Chavala <arjunaraoc@gmail.com>
> Signed-off-by: Ping Cheng <pingc@wacom.com>

Applied, thank you.

> ---
>  drivers/input/tablet/wacom_wac.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/wacom_wac.c
> index 541197b..5e67cbf 100644
> --- a/drivers/input/tablet/wacom_wac.c
> +++ b/drivers/input/tablet/wacom_wac.c
> @@ -2099,7 +2099,7 @@ static const struct wacom_features wacom_features_0xDA =
>  	{ "Wacom Bamboo 2FG 4x5 SE", WACOM_PKGLEN_BBFUN,  14720,  9200, 1023,
>  	  31, BAMBOO_PT, WACOM_INTUOS_RES, WACOM_INTUOS_RES,
>  	  .touch_max = 2 };
> -static struct wacom_features wacom_features_0xDB =
> +static const struct wacom_features wacom_features_0xDB =
>  	{ "Wacom Bamboo 2FG 6x8 SE", WACOM_PKGLEN_BBFUN,  21648, 13700, 1023,
>  	  31, BAMBOO_PT, WACOM_INTUOS_RES, WACOM_INTUOS_RES,
>  	  .touch_max = 2 };
> @@ -2114,6 +2114,12 @@ static const struct wacom_features wacom_features_0xDF =
>          { "Wacom Bamboo 16FG 6x8", WACOM_PKGLEN_BBPEN,    21648, 13700, 1023,
>  	  31, BAMBOO_PT, WACOM_INTUOS_RES, WACOM_INTUOS_RES,
>  	  .touch_max = 16 };
> +static const struct wacom_features wacom_features_0x300 =
> +	{ "Wacom Bamboo One S",    WACOM_PKGLEN_BBPEN,    14720,  9225, 1023,
> +	  31, BAMBOO_PT, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
> +static const struct wacom_features wacom_features_0x301 =
> +	{ "Wacom Bamboo One M",    WACOM_PKGLEN_BBPEN,    21648, 13530, 1023,
> +	  31, BAMBOO_PT, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
>  static const struct wacom_features wacom_features_0x6004 =
>  	{ "ISD-V4",               WACOM_PKGLEN_GRAPHIRE,  12800,  8000,  255,
>  	  0, TABLETPC, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
> @@ -2240,6 +2246,8 @@ const struct usb_device_id wacom_ids[] = {
>  	{ USB_DEVICE_WACOM(0x100) },
>  	{ USB_DEVICE_WACOM(0x101) },
>  	{ USB_DEVICE_WACOM(0x10D) },
> +	{ USB_DEVICE_WACOM(0x300) },
> +	{ USB_DEVICE_WACOM(0x301) },
>  	{ USB_DEVICE_WACOM(0x304) },
>  	{ USB_DEVICE_WACOM(0x4001) },
>  	{ USB_DEVICE_WACOM(0x47) },
> -- 
> 1.8.1.2
> 

-- 
Dmitry
