From: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] HID: hid-sensor-hub: Add Microsoft Surface Pro 2 HID
 ID and set report quirk
Date: Sat, 24 May 2014 11:27:07 +0100
Message-ID: <538073FB.30903@kernel.org>
References: <1400031685-28090-1-git-send-email-reyad.attiyat@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1400031685-28090-1-git-send-email-reyad.attiyat-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Reyad Attiyat <reyad.attiyat-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On 14/05/14 02:41, Reyad Attiyat wrote:
Again, this has no sign off and is not cc'd to Jiri.

Note these don't need my Ack as far as I'm concerned.

Jonathan
> ---
>   drivers/hid/hid-ids.h        | 3 +++
>   drivers/hid/hid-sensor-hub.c | 9 +++++++++
>   2 files changed, 12 insertions(+)
>
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index 34bb220..18e2099 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -633,6 +633,9 @@
>   #define USB_DEVICE_ID_MS_PRESENTER_8K_USB	0x0713
>   #define USB_DEVICE_ID_MS_DIGITAL_MEDIA_3K	0x0730
>   #define USB_DEVICE_ID_MS_COMFORT_MOUSE_4500	0x076c
> +#define USB_DEVICE_ID_MS_SURFACE_PRO_2   0x0799
> +#define USB_DEVICE_ID_MS_TOUCH_COVER_2   0x07a7
> +#define USB_DEVICE_ID_MS_TYPE_COVER_2    0x07a9
>
>   #define USB_VENDOR_ID_MOJO		0x8282
>   #define USB_DEVICE_ID_RETRO_ADAPTER	0x3201
> diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.c
> index be14b56..eefaaf6 100644
> --- a/drivers/hid/hid-sensor-hub.c
> +++ b/drivers/hid/hid-sensor-hub.c
> @@ -711,6 +711,15 @@ static const struct hid_device_id sensor_hub_devices[] = {
>   	{ HID_DEVICE(HID_BUS_ANY, HID_GROUP_SENSOR_HUB, USB_VENDOR_ID_TEXAS_INSTRUMENTS,
>   			USB_DEVICE_ID_TEXAS_INSTRUMENTS_LENOVO_YOGA),
>   			.driver_data = HID_SENSOR_HUB_ENUM_QUIRK},
> +	{ HID_DEVICE(HID_BUS_ANY, HID_GROUP_SENSOR_HUB, USB_VENDOR_ID_MICROSOFT,
> +			USB_DEVICE_ID_MS_SURFACE_PRO_2),
> +			.driver_data = HID_SENSOR_HUB_ENUM_QUIRK},
> +	{ HID_DEVICE(HID_BUS_ANY, HID_GROUP_SENSOR_HUB, USB_VENDOR_ID_MICROSOFT,
> +			USB_DEVICE_ID_MS_TOUCH_COVER_2),
> +			.driver_data = HID_SENSOR_HUB_ENUM_QUIRK},
> +	{ HID_DEVICE(HID_BUS_ANY, HID_GROUP_SENSOR_HUB, USB_VENDOR_ID_MICROSOFT,
> +			USB_DEVICE_ID_MS_TYPE_COVER_2),
> +			.driver_data = HID_SENSOR_HUB_ENUM_QUIRK},
>   	{ HID_DEVICE(HID_BUS_ANY, HID_GROUP_SENSOR_HUB, HID_ANY_ID,
>   		     HID_ANY_ID) },
>   	{ }
>
