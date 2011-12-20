From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] Enable HID_QUIRK_MULTI_INPUT for Trio Linker Plus II
Date: Wed, 21 Dec 2011 00:28:00 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1112210027550.8727@pobox.suse.cz>
References: <4EEC8839.1010801@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4EEC8839.1010801@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Ignaz Forster <ignaz.forster@gmx.de>
Cc: linux-usb@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Sat, 17 Dec 2011, Ignaz Forster wrote:

> Add quirk for the Trio Linker Plus II - the adapter supports several controllers simultaneously, generating a new HID entry for each connected device.
> 
> Signed-off-by: Ignaz Forster <ignaz.forster@gmx.de>
> ---
> diff --git a/drivers/hid/usbhid/hid-quirks.c b/drivers/hid/usbhid/hid-quirks.c
> index 5028d60..4d256a7 100644
> --- a/drivers/hid/usbhid/hid-quirks.c
> +++ b/drivers/hid/usbhid/hid-quirks.c
> @@ -47,6 +47,7 @@ static const struct hid_blacklist {
>  
>  	{ USB_VENDOR_ID_AFATECH, USB_DEVICE_ID_AFATECH_AF9016, HID_QUIRK_FULLSPEED_INTERVAL },
>  
> +	{ USB_VENDOR_ID_EMS, USB_DEVICE_ID_EMS_TRIO_LINKER_PLUS_II, HID_QUIRK_MULTI_INPUT },
>  	{ USB_VENDOR_ID_ETURBOTOUCH, USB_DEVICE_ID_ETURBOTOUCH, HID_QUIRK_MULTI_INPUT },
>  	{ USB_VENDOR_ID_GREENASIA, USB_DEVICE_ID_GREENASIA_DUAL_USB_JOYPAD, HID_QUIRK_MULTI_INPUT },
>  	{ USB_VENDOR_ID_PANTHERLORD, USB_DEVICE_ID_PANTHERLORD_TWIN_USB_JOYSTICK, HID_QUIRK_MULTI_INPUT | HID_QUIRK_SKIP_OUTPUT_REPORTS },

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs
