From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] hid-lg: Fixes immediate disconnection of Logitech
 Rumblepad 2
Date: Tue, 24 Jan 2017 09:07:22 +0100
Message-ID: <20170124080722.GF9285@mail.corp.redhat.com>
References: <72472ae2-17b1-7e1b-11f2-3ff00c7c6d87@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45862 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752319AbdAXIH0 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 24 Jan 2017 03:07:26 -0500
Content-Disposition: inline
In-Reply-To: <72472ae2-17b1-7e1b-11f2-3ff00c7c6d87@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: ardinar23@gmail.com
Cc: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>

Hi,

On Jan 20 2017 or thereabouts, Ardinartsev Nikita wrote:
> hid-lg: Fixes immediate disconnection of Logitech Rumblepad 2
> 
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=117091

Having a bug link is fine, but please also write a short description of
what you are trying to solve.

> Signed-off-by: Ardinartsev Nikita <ardinar23@gmail.com>
> ---
>  drivers/hid/hid-lg.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/hid-lg.c b/drivers/hid/hid-lg.c
> index c5c5fbe..f1afb6b 100644
> --- a/drivers/hid/hid-lg.c
> +++ b/drivers/hid/hid-lg.c
> @@ -872,7 +872,7 @@ static const struct hid_device_id lg_devices[] = {
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH,
> USB_DEVICE_ID_LOGITECH_WINGMAN_FFG),
>  		.driver_data = LG_NOGET | LG_FF4 },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH,
> USB_DEVICE_ID_LOGITECH_RUMBLEPAD2),
> -		.driver_data = LG_FF2 },
> +		.driver_data = LG_FF2 | LG_NOGET },

This looks OK, but I'd like to get the confirmation first that the
rumble effects are still working.

Cheers,
Benjamin

>  	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH,
> USB_DEVICE_ID_LOGITECH_FLIGHT_SYSTEM_G940),
>  		.driver_data = LG_FF3 },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_SPACENAVIGATOR),
> -- 
> 2.7.4
