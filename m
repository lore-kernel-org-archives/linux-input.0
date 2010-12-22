From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Add support for the built-in digitizer in the Lenovo W700
Date: Wed, 22 Dec 2010 11:47:03 -0800
Message-ID: <20101222194703.GA15605@core.coreip.homeip.net>
References: <1293046395-2264-1-git-send-email-pinglinux@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:65294 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750828Ab0LVTrJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 22 Dec 2010 14:47:09 -0500
Received: by iyi12 with SMTP id 12so4369743iyi.19
        for <linux-input@vger.kernel.org>; Wed, 22 Dec 2010 11:47:09 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1293046395-2264-1-git-send-email-pinglinux@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: linux-input@vger.kernel.org, Ajay Ramaswamy <ajay@ramaswamy.net>

On Wed, Dec 22, 2010 at 11:33:15AM -0800, Ping Cheng wrote:
> From: Ajay Ramaswamy <ajay@ramaswamy.net>
> 
> The patch is based on git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git next
> 
> Signed-off-by: Ajay Ramaswamy <ajay@ramaswamy.net>
> Reviewed-by: Ping Cheng <pingc@wacom.com>

Don't we need to add HID blacklist for this as well?

> ---
>  drivers/input/tablet/wacom.h     |    1 +
>  drivers/input/tablet/wacom_wac.c |    7 +++++++
>  2 files changed, 8 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/input/tablet/wacom.h b/drivers/input/tablet/wacom.h
> index de5adb1..23317bd 100644
> --- a/drivers/input/tablet/wacom.h
> +++ b/drivers/input/tablet/wacom.h
> @@ -103,6 +103,7 @@ MODULE_DESCRIPTION(DRIVER_DESC);
>  MODULE_LICENSE(DRIVER_LICENSE);
>  
>  #define USB_VENDOR_ID_WACOM	0x056a
> +#define USB_VENDOR_ID_LENOVO	0x17ef
>  
>  struct wacom {
>  	dma_addr_t data_dma;
> diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/wacom_wac.c
> index 0b05254..0024d3e 100644
> --- a/drivers/input/tablet/wacom_wac.c
> +++ b/drivers/input/tablet/wacom_wac.c
> @@ -1424,11 +1424,17 @@ static struct wacom_features wacom_features_0xD2 =
>  	{ "Wacom Bamboo Craft",   WACOM_PKGLEN_BBFUN,     14720,  9200, 1023, 63, BAMBOO_PT };
>  static struct wacom_features wacom_features_0xD3 =
>  	{ "Wacom Bamboo 2FG 6x8", WACOM_PKGLEN_BBFUN,     21648, 13530, 1023, 63, BAMBOO_PT };
> +static const struct wacom_features wacom_features_0x6004 =
> +	{ "ISD-V4",               WACOM_PKGLEN_GRAPHIRE,  12800, 8000, 255, 0, TABLETPC };
>  
>  #define USB_DEVICE_WACOM(prod)					\
>  	USB_DEVICE(USB_VENDOR_ID_WACOM, prod),			\
>  	.driver_info = (kernel_ulong_t)&wacom_features_##prod
>  
> +#define USB_DEVICE_LENOVO(prod)					\
> +	USB_DEVICE(USB_VENDOR_ID_LENOVO, prod),			\
> +	.driver_info = (kernel_ulong_t)&wacom_features_##prod
> +
>  const struct usb_device_id wacom_ids[] = {
>  	{ USB_DEVICE_WACOM(0x00) },
>  	{ USB_DEVICE_WACOM(0x10) },
> @@ -1501,6 +1507,7 @@ const struct usb_device_id wacom_ids[] = {
>  	{ USB_DEVICE_WACOM(0xE2) },
>  	{ USB_DEVICE_WACOM(0xE3) },
>  	{ USB_DEVICE_WACOM(0x47) },
> +	{ USB_DEVICE_LENOVO(0x6004) },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(usb, wacom_ids);
> -- 
> 1.7.3.4
> 

-- 
Dmitry
