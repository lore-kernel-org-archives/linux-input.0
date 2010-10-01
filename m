From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] hid: support STmicroelectronics and Sitronix with
 hid-stantuml driver
Date: Fri, 1 Oct 2010 15:26:56 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1010011526290.29535@pobox.suse.cz>
References: <39DA9B419B56B14AB97E543A876B0ECF195F57B883@stantum-exch.stantum.local>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:51670 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751210Ab0JAN06 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 1 Oct 2010 09:26:58 -0400
In-Reply-To: <39DA9B419B56B14AB97E543A876B0ECF195F57B883@stantum-exch.stantum.local>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pascal Auriel - Stantum <P.Auriel@stantum.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "chatty@enac.fr" <chatty@enac.fr>, Gowri Ries - Stantum <G.Ries@stantum.com>

On Fri, 1 Oct 2010, Pascal Auriel - Stantum wrote:

> Topic: New VendorsIds/ProductIds using hid-stantum driver
> Issued-by: Stantum <software@stantum.com>

Can I please get your

	Signed-off-by:

line (as documented in Documentation/SubmittingPatches), so that I can 
apply it to my tree?

Thanks.

> diff -rupN before/drivers/hid/hid-core.c after/drivers/hid/hid-core.c
> --- before/drivers/hid/hid-core.c	2010-10-01 13:01:34.485323002 +0200
> +++ after/drivers/hid/hid-core.c	2010-10-01 13:04:23.869323000 +0200
> @@ -1376,6 +1376,8 @@ static const struct hid_device_id hid_bl
>  	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS3_CONTROLLER) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_VAIO_VGX_MOUSE) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_STANTUM, USB_DEVICE_ID_MTP) },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_STANTUM_STM, USB_DEVICE_ID_MTP_STM) },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_STANTUM_SITRONIX, USB_DEVICE_ID_MTP_SITRONIX) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_SUNPLUS, USB_DEVICE_ID_SUNPLUS_WDESKTOP) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_THRUSTMASTER, 0xb300) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_THRUSTMASTER, 0xb304) },
> diff -rupN before/drivers/hid/hid-ids.h after/drivers/hid/hid-ids.h
> --- before/drivers/hid/hid-ids.h	2010-10-01 13:01:47.085323001 +0200
> +++ after/drivers/hid/hid-ids.h	2010-10-01 13:04:33.285323000 +0200
> @@ -481,6 +481,12 @@
>  #define USB_VENDOR_ID_STANTUM		0x1f87
>  #define USB_DEVICE_ID_MTP		0x0002
>  
> +#define USB_VENDOR_ID_STANTUM_STM		0x0483
> +#define USB_DEVICE_ID_MTP_STM		0x3261
> +
> +#define USB_VENDOR_ID_STANTUM_SITRONIX		0x1403
> +#define USB_DEVICE_ID_MTP_SITRONIX		0x5001
> +
>  #define USB_VENDOR_ID_SUN		0x0430
>  #define USB_DEVICE_ID_RARITAN_KVM_DONGLE	0xcdab
>  
> diff -rupN before/drivers/hid/hid-stantum.c after/drivers/hid/hid-stantum.c
> --- before/drivers/hid/hid-stantum.c	2010-10-01 13:01:40.181323000 +0200
> +++ after/drivers/hid/hid-stantum.c	2010-10-01 13:04:43.717323001 +0200
> @@ -249,6 +249,8 @@ static void stantum_remove(struct hid_de
>  
>  static const struct hid_device_id stantum_devices[] = {
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_STANTUM, USB_DEVICE_ID_MTP) },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_STANTUM_STM, USB_DEVICE_ID_MTP_STM) },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_STANTUM_SITRONIX, USB_DEVICE_ID_MTP_SITRONIX) },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(hid, stantum_devices);
> 

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
