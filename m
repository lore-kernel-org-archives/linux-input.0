From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
Subject: Re: [PATCH] usbtouchscreen: add elo intellitouch 2700 support
Date: Fri, 04 Nov 2011 08:45:21 +0800
Message-ID: <4EB335A1.7010809@cn.fujitsu.com>
References: <1320315318-15998-1-git-send-email-michael@mgeb.org> <1320315318-15998-2-git-send-email-michael@mgeb.org>
Reply-To: gaowanlong@cn.fujitsu.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([222.73.24.84]:62294 "EHLO song.cn.fujitsu.com"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1750704Ab1KDAqZ (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 3 Nov 2011 20:46:25 -0400
In-Reply-To: <1320315318-15998-2-git-send-email-michael@mgeb.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Michael Gebetsroither <michael@mgeb.org>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>

Hi Michael:

Looks good, just a comment below,

> Signed-off-by: Michael Gebetsroither <michael@mgeb.org>

Reviewed-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>

> ---
>  drivers/input/touchscreen/Kconfig          |    6 ++++
>  drivers/input/touchscreen/usbtouchscreen.c |   36 ++++++++++++++++++++++++++++
>  2 files changed, 42 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
> index cabd9e5..9dfb340 100644
> --- a/drivers/input/touchscreen/Kconfig
> +++ b/drivers/input/touchscreen/Kconfig
> @@ -541,6 +541,7 @@ config TOUCHSCREEN_USB_COMPOSITE
>  	  - GoTop Super_Q2/GogoPen/PenPower tablets
>  	  - JASTEC USB Touch Controller/DigiTech DTR-02U
>  	  - Zytronic controllers
> +	  - Elo TouchSystems 2700 IntelliTouch
>  
>  	  Have a look at <http://linux.chapter7.ch/touchkit/> for
>  	  a usage description and the required user-space stuff.
> @@ -620,6 +621,11 @@ config TOUCHSCREEN_USB_JASTEC
>  	bool "JASTEC/DigiTech DTR-02U USB touch controller device support" if EXPERT
>  	depends on TOUCHSCREEN_USB_COMPOSITE
>  
> +config TOUCHSCREEN_USB_ELO
> +	default y
> +	bool "Elo TouchSystems 2700 IntelliTouch controller device support" if EXPERT
> +	depends on TOUCHSCREEN_USB_COMPOSITE
> +
>  config TOUCHSCREEN_USB_E2I
>  	default y
>  	bool "e2i Touchscreen controller (e.g. from Mimo 740)"
> diff --git a/drivers/input/touchscreen/usbtouchscreen.c b/drivers/input/touchscreen/usbtouchscreen.c
> index 73fd664..e2b63d9 100644
> --- a/drivers/input/touchscreen/usbtouchscreen.c
> +++ b/drivers/input/touchscreen/usbtouchscreen.c
> @@ -16,6 +16,7 @@
>   *  - JASTEC USB touch controller/DigiTech DTR-02U
>   *  - Zytronic capacitive touchscreen
>   *  - NEXIO/iNexio
> + *  - Elo TouchSystems 2700 IntelliTouch
>   *
>   * Copyright (C) 2004-2007 by Daniel Ritz <daniel.ritz@gmx.ch>
>   * Copyright (C) by Todd E. Johnson (mtouchusb.c)
> @@ -138,6 +139,7 @@ enum {
>  	DEVTYPE_ZYTRONIC,
>  	DEVTYPE_TC45USB,
>  	DEVTYPE_NEXIO,
> +	DEVTYPE_ELO,
>  };
>  
>  #define USB_DEVICE_HID_CLASS(vend, prod) \
> @@ -239,6 +241,10 @@ static const struct usb_device_id usbtouch_devices[] = {
>  		.driver_info = DEVTYPE_NEXIO},
>  #endif
>  
> +#ifdef CONFIG_TOUCHSCREEN_USB_ELO
> +	{USB_DEVICE(0x04e7, 0x0020), .driver_info = DEVTYPE_ELO},
> +#endif
> +
>  	{}
>  };
>  
> @@ -278,6 +284,24 @@ static int e2i_read_data(struct usbtouch_usb *dev, unsigned char *pkt)
>  
>  
>  /*****************************************************************************
> + * ELO part
> + */
> +
> +#ifdef CONFIG_TOUCHSCREEN_USB_ELO
> +
> +static int elo_read_data(struct usbtouch_usb *dev, unsigned char *pkt)
> +{
> +	dev->x = ((pkt[3] << 8) | pkt[2]);
> +	dev->y = ((pkt[5] << 8) | pkt[4]);
> +	dev->touch = (pkt[6] > 0);
> +	dev->press = pkt[6];
> +	return 1;
> +
> +}
> +#endif
> +
> +
> +/*****************************************************************************
>   * eGalax part
>   */
>  
> @@ -953,6 +977,18 @@ static void usbtouch_process_multi(struct usbtouch_usb *usbtouch,
>  #endif
>  
>  static struct usbtouch_device_info usbtouch_dev_info[] = {
> +#ifdef CONFIG_TOUCHSCREEN_USB_ELO
> +	[DEVTYPE_ELO] = {
> +		.min_xc		= 0x0,
> +		.max_xc		= 0x0fff,
> +		.min_yc		= 0x0,
> +		.max_yc		= 0x0fff,
> +		.max_press	= 0xff,
> +		.rept_size	= 8,
> +		.read_data	= elo_read_data,
> +	},
> +#endif


Maybe you can move this *dev_info* to end to be consistent with the order of *enum*?


Thanks
-Wanlong Gao
