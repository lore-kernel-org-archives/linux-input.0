From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] hid: Remove QUANTA from special drivers list
Date: Wed, 22 Aug 2012 16:48:40 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1208221648130.32304@pobox.suse.cz>
References: <1345630637-7142-1-git-send-email-simon.farnsworth@onelan.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:36226 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752766Ab2HVOst (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 22 Aug 2012 10:48:49 -0400
In-Reply-To: <1345630637-7142-1-git-send-email-simon.farnsworth@onelan.co.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Simon Farnsworth <simon.farnsworth@onelan.co.uk>
Cc: linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Benjamin Tissoires <benjamin.tissoires@enac.fr>, Henrik Rydberg <rydberg@bitmath.se>

On Wed, 22 Aug 2012, Simon Farnsworth wrote:

> This QUANTA device is driven by the generic hid-multitouch.ko driver, and
> therefore shouldn't be in the special drivers list.
> 
> I've gone over the entire special drivers list in hid-core.c; this is the
> only device I spotted that's listed as needing a special driver, but doesn't
> have an entry in a struct hid_driver's id_table.
> 
> Signed-off-by: Simon Farnsworth <simon.farnsworth@onelan.co.uk>
> ---
> 
> Applying just this patch is enough to fix the problem I described in my mail
> "QUANTA touchscreen controller integrated in HP2310ti no longer recognised
> (regression in 3.5 and later as compared to 3.3)".
> 
> This looks like an oversight in commit 4fa3a58; that commit removes most
> multitouch screens from this list, but missed this one. Henrik should be
> able to confirm, though, so I'd appreciate his sign-off.
> 
>  drivers/hid/hid-core.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index 60ea284..8bf8a64 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -1624,7 +1624,6 @@ static const struct hid_device_id hid_have_special_driver[] = {
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_ORTEK, USB_DEVICE_ID_ORTEK_WKB2000) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_PETALYNX, USB_DEVICE_ID_PETALYNX_MAXTER_REMOTE) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_PRIMAX, USB_DEVICE_ID_PRIMAX_KEYBOARD) },
> -	{ HID_USB_DEVICE(USB_VENDOR_ID_QUANTA, USB_DEVICE_ID_PIXART_IMAGING_INC_OPTICAL_TOUCH_SCREEN) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_ROCCAT, USB_DEVICE_ID_ROCCAT_KONE) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_ROCCAT, USB_DEVICE_ID_ROCCAT_ARVO) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_ROCCAT, USB_DEVICE_ID_ROCCAT_ISKU) },

Good catch, thank you. I will be pushing this to Linus for 3.6 still.

-- 
Jiri Kosina
SUSE Labs
