From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] HID: use generic driver for ThingM blink(1) if
 !CONFIG_HID_THINGM
Date: Sun, 2 Aug 2015 09:13:41 +0200
Message-ID: <20150802071341.GE32270@amd>
References: <1438024626-36448-1-git-send-email-reillyg@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:46866 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751546AbbHBHNn (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 2 Aug 2015 03:13:43 -0400
Content-Disposition: inline
In-Reply-To: <1438024626-36448-1-git-send-email-reillyg@chromium.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Reilly Grant <reillyg@chromium.org>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon 2015-07-27 12:17:06, Reilly Grant wrote:
> In commit 30ba2fbde1840db44 an LED class driver for this device was
> added and at the same time it was blacklisted by the hid-generic
> driver. This patch removes the device from the hid-generic driver's
> blacklist if the LED class driver is not enabled.
> 
> Signed-off-by: Reilly Grant <reillyg@chromium.org>

I'd not do it.

Either special driver for this is not needed, and should be
removed. Or we should ask users to always use the special driver. We
should not have two drivers for same hardware.

								Pavel

>  drivers/hid/hid-core.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index d9c7cd9..afa744f 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -1978,7 +1978,9 @@ static const struct hid_device_id hid_have_special_driver[] = {
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_VAIO_VGP_MOUSE) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES, USB_DEVICE_ID_STEELSERIES_SRWS1) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_SUNPLUS, USB_DEVICE_ID_SUNPLUS_WDESKTOP) },
> +#if IS_ENABLED(CONFIG_HID_THINGM)
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_THINGM, USB_DEVICE_ID_BLINK1) },
> +#endif
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_THRUSTMASTER, 0xb300) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_THRUSTMASTER, 0xb304) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_THRUSTMASTER, 0xb323) },

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
