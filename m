From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH 2/2 ] Surface Pro 2 HID sensor, wacom, keyboard/multitouch
 composite device
Date: Fri, 7 Mar 2014 12:01:44 -0500
Message-ID: <CAN+gG=EpfxeOGvUUQvLxRL9o_SWSmRJkuD7qDc6JkUz1aP_GNw@mail.gmail.com>
References: <5319EB7C.5070209@yahoo.de>
	<5319EC8D.9070302@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lb0-f178.google.com ([209.85.217.178]:48018 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752299AbaCGRBq (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 7 Mar 2014 12:01:46 -0500
Received: by mail-lb0-f178.google.com with SMTP id s7so3014746lbd.9
        for <linux-input@vger.kernel.org>; Fri, 07 Mar 2014 09:01:44 -0800 (PST)
In-Reply-To: <5319EC8D.9070302@yahoo.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Derya <derya.kiran@yahoo.de>
Cc: linux-input <linux-input@vger.kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jkosina@suse.cz>

On Fri, Mar 7, 2014 at 10:58 AM, Derya <derya.kiran@yahoo.de> wrote:
> Enumeration quirks for Surface Pro 2 sensor-hub
>
> Signed-off-by: Derya <derya.kiran@yahoo.de>
> ---
>  drivers/hid/hid-sensor-hub.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.c
> index 9c22e14..16f4bb8 100644
> --- a/drivers/hid/hid-sensor-hub.c
> +++ b/drivers/hid/hid-sensor-hub.c
> @@ -668,6 +668,15 @@ static const struct hid_device_id sensor_hub_devices[]
> = {
>      { HID_DEVICE(HID_BUS_ANY, HID_GROUP_SENSOR_HUB, USB_VENDOR_ID_STM_0,
>              USB_DEVICE_ID_STM_HID_SENSOR),
>              .driver_data = HID_SENSOR_HUB_ENUM_QUIRK},
> +    { HID_DEVICE(HID_BUS_ANY, HID_GROUP_SENSOR_HUB,
> USB_VENDOR_ID_MICROSOFT,
> +             USB_DEVICE_ID_MS_TOUCH_COVER_2),
> +            .driver_data = HID_SENSOR_HUB_ENUM_QUIRK},
> +    { HID_DEVICE(HID_BUS_ANY, HID_GROUP_SENSOR_HUB,
> USB_VENDOR_ID_MICROSOFT,
> +             USB_DEVICE_ID_MS_TYPE_COVER_2),
> +            .driver_data = HID_SENSOR_HUB_ENUM_QUIRK},
> +    { HID_DEVICE(HID_BUS_ANY, HID_GROUP_SENSOR_HUB,
> USB_VENDOR_ID_MICROSOFT,
> +             USB_DEVICE_ID_MS_SURFACE_PRO_2),
> +            .driver_data = HID_SENSOR_HUB_ENUM_QUIRK},

this seems to be pretty heavy to have all three product id in the sensor hub.
Is it mandatory?

Cheers,
Benjamin

>      { HID_DEVICE(HID_BUS_ANY, HID_GROUP_SENSOR_HUB, HID_ANY_ID,
>               HID_ANY_ID) },
>      { }
> --
> 1.8.3.2
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
