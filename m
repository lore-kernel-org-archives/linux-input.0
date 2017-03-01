From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] hid-chicony: Add support for another ASUS Zen AiO
 keyboard
Date: Wed, 1 Mar 2017 18:15:14 +0100
Message-ID: <20170301171514.GJ7064@mail.corp.redhat.com>
References: <20170217134052.440-1-drake@endlessm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57240 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751035AbdCARQA (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 1 Mar 2017 12:16:00 -0500
Content-Disposition: inline
In-Reply-To: <20170217134052.440-1-drake@endlessm.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Drake <drake@endlessm.com>
Cc: jikos@kernel.org, linux-input@vger.kernel.org, linux@endlessm.com

On Feb 17 2017 or thereabouts, Daniel Drake wrote:
> Add support for media keys on the keyboard that comes with the
> Asus V221ID and ZN241IC All In One computers.
> 
> The keys to support here are WLAN, BRIGHTNESSDOWN and BRIGHTNESSUP.
> 
> This device is not visibly branded as Chicony, and the USB Vendor ID
> suggests that it is a JESS device. However this seems like the right place
> to put it: the usage codes are identical to the currently supported
> devices, and this driver already supports the ASUS AIO keyboard AK1D.

Except that the AK1D is branded as Chicony. So I think it will confuse
users to ask them to load hid-chicony on a Asus keyboard branded as
JESS.

How about adding this one to hid-asus directly (with maybe a guard
against either the PID or a quirk for it)?

Cheers,
Benjamin

> 
> Signed-off-by: Daniel Drake <drake@endlessm.com>
> ---
>  drivers/hid/Kconfig       | 4 ++--
>  drivers/hid/hid-chicony.c | 1 +
>  drivers/hid/hid-core.c    | 1 +
>  drivers/hid/hid-ids.h     | 1 +
>  4 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> index 1aeb80e..8eab320 100644
> --- a/drivers/hid/Kconfig
> +++ b/drivers/hid/Kconfig
> @@ -175,11 +175,11 @@ config HID_CHERRY
>  	Support for Cherry Cymotion keyboard.
>  
>  config HID_CHICONY
> -	tristate "Chicony Tactical pad"
> +	tristate "Chicony devices"
>  	depends on HID
>  	default !EXPERT
>  	---help---
> -	Support for Chicony Tactical pad.
> +	Support for Chicony Tactical pad and special keys on Chicony keyboards.
>  
>  config HID_CORSAIR
>  	tristate "Corsair devices"
> diff --git a/drivers/hid/hid-chicony.c b/drivers/hid/hid-chicony.c
> index bc3cec1..f04ed9a 100644
> --- a/drivers/hid/hid-chicony.c
> +++ b/drivers/hid/hid-chicony.c
> @@ -86,6 +86,7 @@ static const struct hid_device_id ch_devices[] = {
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_CHICONY, USB_DEVICE_ID_CHICONY_WIRELESS2) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_CHICONY, USB_DEVICE_ID_CHICONY_AK1D) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_CHICONY, USB_DEVICE_ID_CHICONY_ACER_SWITCH12) },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_JESS, USB_DEVICE_ID_JESS_ZEN_AIO_KBD) },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(hid, ch_devices);
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index 538ff69..405819d 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -1909,6 +1909,7 @@ static const struct hid_device_id hid_have_special_driver[] = {
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_HOLTEK_ALT, USB_DEVICE_ID_HOLTEK_ALT_MOUSE_A081) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_HOLTEK_ALT, USB_DEVICE_ID_HOLTEK_ALT_MOUSE_A0C2) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_HUION, USB_DEVICE_ID_HUION_TABLET) },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_JESS, USB_DEVICE_ID_JESS_ZEN_AIO_KBD) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_JESS2, USB_DEVICE_ID_JESS2_COLOR_RUMBLE_PAD) },
>  	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_ION, USB_DEVICE_ID_ICADE) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_KENSINGTON, USB_DEVICE_ID_KS_SLIMBLADE) },
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index 86c95d3..b3df60d 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -557,6 +557,7 @@
>  
>  #define USB_VENDOR_ID_JESS		0x0c45
>  #define USB_DEVICE_ID_JESS_YUREX	0x1010
> +#define USB_DEVICE_ID_JESS_ZEN_AIO_KBD	0x5112
>  
>  #define USB_VENDOR_ID_JESS2		0x0f30
>  #define USB_DEVICE_ID_JESS2_COLOR_RUMBLE_PAD 0x0111
> -- 
> 2.9.3
> 
