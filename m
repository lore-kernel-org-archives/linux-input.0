From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] unswap the grave and 102nd keys on Apple Alu ISO
 keyboard
Date: Mon, 4 May 2015 10:07:56 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1505041006330.3081@pobox.suse.cz>
References: <1430471843-3455-1-git-send-email-knasher@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:34333 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751409AbbEDIH7 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 4 May 2015 04:07:59 -0400
In-Reply-To: <1430471843-3455-1-git-send-email-knasher@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: John Horan <knasher@gmail.com>
Cc: linux-input@vger.kernel.org, Michel Daenzer <michel@tungstengraphics.com>

On Fri, 1 May 2015, John Horan wrote:

> The quirk for swapping the grave and 102nd keys should be applied to the 
> APPLE_ALU_ISO keyboard, as they aren't actually swapped.
> 
> Signed-off-by: John Horan <knasher@gmail.com>
> ---
>  drivers/hid/hid-apple.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/hid-apple.c b/drivers/hid/hid-apple.c
> index f822fd2..e4bbfc0 100644
> --- a/drivers/hid/hid-apple.c
> +++ b/drivers/hid/hid-apple.c
> @@ -441,7 +441,7 @@ static const struct hid_device_id apple_devices[] = {
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_ALU_ANSI),
>  		.driver_data = APPLE_HAS_FN },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_ALU_ISO),
> -		.driver_data = APPLE_HAS_FN | APPLE_ISO_KEYBOARD },
> +		.driver_data = APPLE_HAS_FN },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_ALU_JIS),
>  		.driver_data = APPLE_HAS_FN },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER4_HF_ANSI),

Okay, this has been there since 2007, so one would guess there must be a 
reason for noone complaining about this for past 8 years. I'd rather be 
careful here so that we don't introduce any regressions.

Adding Michel, who added the original quirk back in 2007 (through commit 
a45d82d19a6 ("HID: Add support for Apple aluminum USB keyboards")) to CC.

-- 
Jiri Kosina
SUSE Labs
