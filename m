From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 1/1] usbhid: add Sennheiser BTD500USB device support
Date: Mon, 9 Jul 2012 16:21:50 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1207091621440.19366@pobox.suse.cz>
References: <1341520369-13655-1-git-send-email-xxxxxmichl@googlemail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:41023 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750932Ab2GIOV4 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 9 Jul 2012 10:21:56 -0400
In-Reply-To: <1341520369-13655-1-git-send-email-xxxxxmichl@googlemail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Frank Kunz <xxxxxmichl@googlemail.com>
Cc: linux-input@vger.kernel.org

On Thu, 5 Jul 2012, xxxxxmichl@googlemail.com wrote:

> From: Frank Kunz <xxxxxmichl@googlemail.com>
> 
> The Sennheiser BTD500USB composit device requires the
> HID_QUIRK_NOGET flag to be set for working proper. Without the
> flag the device crashes during hid intialization.
> 
> Signed-off-by: Frank Kunz <xxxxxmichl@googlemail.com>
> ---
>  drivers/hid/hid-ids.h           |    3 +++
>  drivers/hid/usbhid/hid-quirks.c |    1 +
>  2 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index d1cdd2d..fc0c68e 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -653,6 +653,9 @@
>  #define USB_DEVICE_ID_SAMSUNG_IR_REMOTE	0x0001
>  #define USB_DEVICE_ID_SAMSUNG_WIRELESS_KBD_MOUSE	0x0600
>  
> +#define USB_VENDOR_ID_SENNHEISER	0x1395
> +#define USB_DEVICE_ID_SENNHEISER_BTD500USB	0x002c
> +
>  #define USB_VENDOR_ID_SIGMA_MICRO	0x1c4f
>  #define USB_DEVICE_ID_SIGMA_MICRO_KEYBOARD	0x0002
>  
> diff --git a/drivers/hid/usbhid/hid-quirks.c b/drivers/hid/usbhid/hid-quirks.c
> index 0597ee6..903eef3 100644
> --- a/drivers/hid/usbhid/hid-quirks.c
> +++ b/drivers/hid/usbhid/hid-quirks.c
> @@ -76,6 +76,7 @@ static const struct hid_blacklist {
>  	{ USB_VENDOR_ID_PRODIGE, USB_DEVICE_ID_PRODIGE_CORDLESS, HID_QUIRK_NOGET },
>  	{ USB_VENDOR_ID_QUANTA, USB_DEVICE_ID_PIXART_IMAGING_INC_OPTICAL_TOUCH_SCREEN, HID_QUIRK_NOGET },
>  	{ USB_VENDOR_ID_QUANTA, USB_DEVICE_ID_QUANTA_OPTICAL_TOUCH_3008, HID_QUIRK_NOGET },
> +	{ USB_VENDOR_ID_SENNHEISER, USB_DEVICE_ID_SENNHEISER_BTD500USB, HID_QUIRK_NOGET },
>  	{ USB_VENDOR_ID_SUN, USB_DEVICE_ID_RARITAN_KVM_DONGLE, HID_QUIRK_NOGET },
>  	{ USB_VENDOR_ID_SYMBOL, USB_DEVICE_ID_SYMBOL_SCANNER_1, HID_QUIRK_NOGET },
>  	{ USB_VENDOR_ID_SYMBOL, USB_DEVICE_ID_SYMBOL_SCANNER_2, HID_QUIRK_NOGET },

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs
