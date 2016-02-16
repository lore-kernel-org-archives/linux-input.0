From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: logitech: fix Dual Action gamepad support
Date: Tue, 16 Feb 2016 11:02:34 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1602161102210.22700@cbobk.fhfr.pm>
References: <1455396111-2511-1-git-send-email-notasas@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:55145 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754812AbcBPKCh (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 16 Feb 2016 05:02:37 -0500
In-Reply-To: <1455396111-2511-1-git-send-email-notasas@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: linux-input@vger.kernel.org, Vitaly Katraew <zawullon@gmail.com>

On Sat, 13 Feb 2016, Grazvydas Ignotas wrote:

> The patch that added Logitech Dual Action gamepad support forgot to
> update the special driver list for the device. This caused the logitech
> driver not to probe unless kernel module load order was favorable.
> Update the special driver list to fix it. Thanks to Simon Wood for the
> idea.
> 
> Cc: Vitaly Katraew <zawullon@gmail.com>
> Fixes: 56d0c8b7c8fb ("HID: add support for Logitech Dual Action gamepads")
> Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
> ---
>  drivers/hid/hid-core.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index c6f7a69..f16155f5 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -1897,6 +1897,7 @@ static const struct hid_device_id hid_have_special_driver[] = {
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_ELITE_KBD) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_CORDLESS_DESKTOP_LX500) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_EXTREME_3D) },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_DUAL_ACTION) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_WHEEL) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_RUMBLEPAD_CORD) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_RUMBLEPAD) },

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

