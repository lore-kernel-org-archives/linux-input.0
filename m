From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: Add MULTI_INPUT quirk for MozArt touchscreen
Date: Tue, 12 Oct 2010 11:41:11 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1010121140190.6879@pobox.suse.cz>
References: <20101011165455.1e13789c@destiny.ordissimo>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:46744 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756939Ab0JLJlN (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 12 Oct 2010 05:41:13 -0400
In-Reply-To: <20101011165455.1e13789c@destiny.ordissimo>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Anisse Astier <anisse@astier.eu>
Cc: linux-input@vger.kernel.org, Pierre BAILLY <pierre@substantiel.fr>

On Mon, 11 Oct 2010, Anisse Astier wrote:

> From: Pierre BAILLY <pierre@substantiel.fr>
> 
> This device generates ABS_Z and ABS_RX events, while it should be
> generating ABS_X and ABS_Y instead. Using the MULTI_INPUT quirk solves
> this issue.
> 
> Reference: https://bugs.launchpad.net/ubuntu/+bug/620609/
> 
> Signed-off-by: Pierre BAILLY <pierre@substantiel.fr>
> Signed-off-by: Anisse Astier <anisse@astier.eu>
> ---
>  drivers/hid/hid-ids.h           |    1 +
>  drivers/hid/usbhid/hid-quirks.c |    1 +
>  2 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index 31601ee..4df6036 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -483,6 +483,7 @@
>  
>  #define USB_VENDOR_ID_TURBOX		0x062a
>  #define USB_DEVICE_ID_TURBOX_KEYBOARD	0x0201
> +#define USB_DEVICE_ID_TURBOX_TOUCHSCREEN_MOSART	0x7100
>  
>  #define USB_VENDOR_ID_TWINHAN           0x6253
>  #define USB_DEVICE_ID_TWINHAN_IR_REMOTE 0x0100
> diff --git a/drivers/hid/usbhid/hid-quirks.c b/drivers/hid/usbhid/hid-quirks.c
> index 5f5aa39..a22e38c 100644
> --- a/drivers/hid/usbhid/hid-quirks.c
> +++ b/drivers/hid/usbhid/hid-quirks.c
> @@ -34,6 +34,7 @@ static const struct hid_blacklist {
>  	{ USB_VENDOR_ID_ALPS, USB_DEVICE_ID_IBM_GAMEPAD, HID_QUIRK_BADPAD },
>  	{ USB_VENDOR_ID_CHIC, USB_DEVICE_ID_CHIC_GAMEPAD, HID_QUIRK_BADPAD },
>  	{ USB_VENDOR_ID_DWAV, USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH, HID_QUIRK_MULTI_INPUT },
> +	{ USB_VENDOR_ID_TURBOX, USB_DEVICE_ID_TURBOX_TOUCHSCREEN_MOSART, HID_QUIRK_MULTI_INPUT },
>  	{ USB_VENDOR_ID_MOJO, USB_DEVICE_ID_RETRO_ADAPTER, HID_QUIRK_MULTI_INPUT },
>  	{ USB_VENDOR_ID_HAPP, USB_DEVICE_ID_UGCI_DRIVING, HID_QUIRK_BADPAD | HID_QUIRK_MULTI_INPUT },
>  	{ USB_VENDOR_ID_HAPP, USB_DEVICE_ID_UGCI_FLYING, HID_QUIRK_BADPAD | HID_QUIRK_MULTI_INPUT },

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
