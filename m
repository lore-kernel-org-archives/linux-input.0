From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH v2] hid-lg: Fix immediate disconnection of Logitech
 Rumblepad 2
Date: Thu, 26 Jan 2017 15:17:20 +0100
Message-ID: <20170126141720.GD13244@mail.corp.redhat.com>
References: <bd414b27-d1c8-9395-7552-5dfe9a3ce63a@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34720 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752303AbdAZORZ (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 26 Jan 2017 09:17:25 -0500
Content-Disposition: inline
In-Reply-To: <bd414b27-d1c8-9395-7552-5dfe9a3ce63a@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: ardinar23@gmail.com
Cc: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>

On Jan 26 2017 or thereabouts, Ardinartsev Nikita wrote:
> hid-lg: Fix immediate disconnection of Logitech Rumblepad 2
> 
> With NOGET quirk Logitech F510 is now fully workable in dinput mode
> including rumble effects (according to fftest).
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=117091
> Signed-off-by: Ardinartsev Nikita <ardinar23@gmail.com>
> ---

Acked-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

>  drivers/hid/hid-lg.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/hid-lg.c b/drivers/hid/hid-lg.c
> index c5c5fbe..52026dc 100644
> --- a/drivers/hid/hid-lg.c
> +++ b/drivers/hid/hid-lg.c
> @@ -872,7 +872,7 @@ static const struct hid_device_id lg_devices[] = {
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH,
> USB_DEVICE_ID_LOGITECH_WINGMAN_FFG),
>  		.driver_data = LG_NOGET | LG_FF4 },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH,
> USB_DEVICE_ID_LOGITECH_RUMBLEPAD2),
> -		.driver_data = LG_FF2 },
> +		.driver_data = LG_NOGET | LG_FF2 },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH,
> USB_DEVICE_ID_LOGITECH_FLIGHT_SYSTEM_G940),
>  		.driver_data = LG_FF3 },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_SPACENAVIGATOR),
> -- 
> 2.7.4
> 
