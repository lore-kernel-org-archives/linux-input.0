From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 1/1] [PATCH] HID: usbhid: Quirk for Formosa IR receiver
Date: Thu, 3 Jan 2013 11:15:52 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1301031115360.27348@pobox.suse.cz>
References: <1356750422-13372-1-git-send-email-nicholas.santos@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:52430 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753073Ab3ACKP4 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 3 Jan 2013 05:15:56 -0500
In-Reply-To: <1356750422-13372-1-git-send-email-nicholas.santos@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nicholas Santos <nicholas.santos@gmail.com>
Cc: linux-input@vger.kernel.org, linux-usb@vger.kernel.org

On Fri, 28 Dec 2012, Nicholas Santos wrote:

> Patch to add the Formosa Industrial Computing, Inc. Infrared Receiver [IR605A/Q] to
> hid-ids.h and hid-quirks.c.  This IR receiver causes about a 10 second timeout when the
> usbhid driver attempts to initialze the device.  Adding this device to the quirks list with
> HID_QUIRK_NO_INIT_REPORTS removes the delay.
> 
> Signed-off-by: Nicholas Santos <nicholas.santos@gmail.com>
> ---
>  drivers/hid/hid-ids.h           |    3 +++
>  drivers/hid/usbhid/hid-quirks.c |    1 +
>  2 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index 4dfa605..34e2547 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -306,6 +306,9 @@
>  #define USB_VENDOR_ID_EZKEY		0x0518
>  #define USB_DEVICE_ID_BTC_8193		0x0002
> 
> +#define USB_VENDOR_ID_FORMOSA          0x147a
> +#define USB_DEVICE_ID_FORMOSA_IR_RECEIVER      0xe03e
> +
>  #define USB_VENDOR_ID_FREESCALE		0x15A2
>  #define USB_DEVICE_ID_FREESCALE_MX28	0x004F
> 
> diff --git a/drivers/hid/usbhid/hid-quirks.c b/drivers/hid/usbhid/hid-quirks.c
> index ac9e352..90b4a38 100644
> --- a/drivers/hid/usbhid/hid-quirks.c
> +++ b/drivers/hid/usbhid/hid-quirks.c
> @@ -72,6 +72,7 @@ static const struct hid_blacklist {
> 	{ USB_VENDOR_ID_ELO, USB_DEVICE_ID_ELO_TS2700, HID_QUIRK_NOGET },
> 	{ USB_VENDOR_ID_FREESCALE, USB_DEVICE_ID_FREESCALE_MX28, HID_QUIRK_NOGET },
> 	{ USB_VENDOR_ID_MGE, USB_DEVICE_ID_MGE_UPS, HID_QUIRK_NOGET },
> +	{ USB_VENDOR_ID_FORMOSA, USB_DEVICE_ID_FORMOSA_IR_RECEIVER, HID_QUIRK_NO_INIT_REPORTS },

I have fixed the alphabetical ordering and applied, thanks.

-- 
Jiri Kosina
SUSE Labs
