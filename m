From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 1/1] HID: Add full support for logitech Unifying
 receivers
Date: Fri, 24 Jun 2011 14:27:16 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1106241417480.11049@pobox.suse.cz>
References: <1305297084-10224-1-git-send-email-nlopezcasad@logitech.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:59602 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754140Ab1FXM1S (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 24 Jun 2011 08:27:18 -0400
In-Reply-To: <1305297084-10224-1-git-send-email-nlopezcasad@logitech.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nestor Lopez Casado <nlopezcasad@logitech.com>
Cc: linux-input@vger.kernel.org, xnlopez@gmail.com, rtitmuss@logitech.com, ogay@logitech.com

On Fri, 13 May 2011, Nestor Lopez Casado wrote:

> Up to now, when Logitech Unifying receivers are connected to a Linux 
> based system, a single keyboard and a single mouse are presented to the 
> HID Layer, even if the Unifying receiver can pair up to six compatible 
> devices. The Unifying receiver by default multiplexes all incoming 
> events (from multiple keyboards/mice) into these two.

Sorry that it took me too long to review the driver.

Generally, I like it. The question I have -- apparently the receiver works 
in a crippled mode even without the driver. Therefore, I'd suggest to put 
the hid_have_special_driver[] uncodinitionally, the same way we do for 
other devices.

Apart from the, the driver looks good to me. Please find a few rather 
minor comments below.

> +config HID_LOGITECH_DJ
> +	tristate "Logitech Unifying receivers full support"
> +	depends on USB_HID

We already have sub-menu for Logitech devices. I think this driver should 
be in that sub-menu, even if it doesn't directly depend on hid-logitech.

> --- a/drivers/hid/Makefile
> +++ b/drivers/hid/Makefile
> @@ -44,6 +44,7 @@ obj-$(CONFIG_HID_KEYTOUCH)	+= hid-keytouch.o
>  obj-$(CONFIG_HID_KYE)		+= hid-kye.o
>  obj-$(CONFIG_HID_LCPOWER)       += hid-lcpower.o
>  obj-$(CONFIG_HID_LOGITECH)	+= hid-logitech.o
> +obj-$(CONFIG_HID_LOGITECH_DJ)	+= hid-logitech-dj.o
>  obj-$(CONFIG_HID_MAGICMOUSE)    += hid-magicmouse.o
>  obj-$(CONFIG_HID_MICROSOFT)	+= hid-microsoft.o
>  obj-$(CONFIG_HID_MONTEREY)	+= hid-monterey.o
> @@ -78,6 +79,7 @@ obj-$(CONFIG_HID_ZYDACRON)	+= hid-zydacron.o
>  obj-$(CONFIG_HID_WACOM)		+= hid-wacom.o
>  obj-$(CONFIG_HID_WALTOP)	+= hid-waltop.o
>  
> +
>  obj-$(CONFIG_USB_HID)		+= usbhid/
>  obj-$(CONFIG_USB_MOUSE)		+= usbhid/
>  obj-$(CONFIG_USB_KBD)		+= usbhid/

Why the added new line?

> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index 408c4be..2855403 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -1253,6 +1253,9 @@ int hid_connect(struct hid_device *hdev, unsigned int connect_mask)
>  	case BUS_BLUETOOTH:
>  		bus = "BLUETOOTH";
>  		break;
> +	case BUS_DJ:
> +		bus = "UNIFYING";
> +		break;

Why do we need separate bus? It's always USB, right?

>  	default:
>  		bus = "<UNKNOWN>";
>  	}
> @@ -1485,8 +1488,11 @@ static const struct hid_device_id hid_have_special_driver[] = {
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_ZEROPLUS, 0x0005) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_ZEROPLUS, 0x0030) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_ZYDACRON, USB_DEVICE_ID_ZYDACRON_REMOTE_CONTROL) },
> -
>  	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_PRESENTER_8K_BT) },
> +#if defined(CONFIG_HID_LOGITECH_DJ) || defined(CONFIG_HID_LOGITECH_DJ_MODULE)
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xc52b) },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xc532) },
> +#endif

See above.

> +static void logi_dj_recv_destroy_djhid_device(struct dj_receiver_dev *djrcv_dev,
> +						struct dj_report *dj_report)
> +{
> +	/* Called in delayed work context */
> +	struct dj_device *dj_dev;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&djrcv_dev->lock, flags);
> +	dj_dev = djrcv_dev->paired_dj_devices[dj_report->device_index];
> +	djrcv_dev->paired_dj_devices[dj_report->device_index] = NULL;
> +	spin_unlock_irqrestore(&djrcv_dev->lock, flags);
> +
> +	if (dj_dev != NULL) {
> +		hid_destroy_device(dj_dev->hdev);
> +		kfree(dj_dev);
> +	} else {
> +		dev_err(&djrcv_dev->hdev->dev, "logi_dj_recv_destroy_djhid_device"
> +					":cant destroy a NULL device\n");

The error message looks odd (cant is spelled wrong way, and directly 
attached to ':').

> --- /dev/null
> +++ b/drivers/hid/hid-logitech-dj.h
> @@ -0,0 +1,117 @@
> +#ifndef __HID_LOGITECH_DJ_H
> +#define __HID_LOGITECH_DJ_H
> +
> +/*
> + *  HID driver for Logitech Unifying receivers
> + *
> + *  Copyright (c) 2011 Logitech (c)
> + */
> +
> +/*
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.

BTW, are you sure about the "any later version" part?

Thanks,

-- 
Jiri Kosina
SUSE Labs
