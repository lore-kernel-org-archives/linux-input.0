From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] hid-quirks: Add NO_INIT_REPORTS quirk for Synaptics
 Touch Pad V 103S
Date: Mon, 5 May 2014 15:57:51 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1405051557440.3969@pobox.suse.cz>
References: <1399052893-3762-1-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1399052893-3762-1-git-send-email-hdegoede@redhat.com>
Sender: stable-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <btissoir@redhat.com>, Peter Hutterer <peter.hutterer@redhat.com>, linux-input@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, 2 May 2014, Hans de Goede wrote:

> This touchpad seriously dislikes init reports, not only timeing out, but
> also refusing to work after this.
> 
> Cc: stable@vger.kernel.org
> Reported-and-tested-by: Vincent Fortier <th0ma7@gmail.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/hid/hid-ids.h           | 1 +
>  drivers/hid/usbhid/hid-quirks.c | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index c8af720..43f246e 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -834,6 +834,7 @@
>  #define USB_DEVICE_ID_SYNAPTICS_LTS2	0x1d10
>  #define USB_DEVICE_ID_SYNAPTICS_HD	0x0ac3
>  #define USB_DEVICE_ID_SYNAPTICS_QUAD_HD	0x1ac3
> +#define USB_DEVICE_ID_SYNAPTICS_TP_V103	0x5710
>  
>  #define USB_VENDOR_ID_THINGM		0x27b8
>  #define USB_DEVICE_ID_BLINK1		0x01ed
> diff --git a/drivers/hid/usbhid/hid-quirks.c b/drivers/hid/usbhid/hid-quirks.c
> index dbd8387..8e4ddb3 100644
> --- a/drivers/hid/usbhid/hid-quirks.c
> +++ b/drivers/hid/usbhid/hid-quirks.c
> @@ -119,6 +119,7 @@ static const struct hid_blacklist {
>  	{ USB_VENDOR_ID_SYNAPTICS, USB_DEVICE_ID_SYNAPTICS_LTS2, HID_QUIRK_NO_INIT_REPORTS },
>  	{ USB_VENDOR_ID_SYNAPTICS, USB_DEVICE_ID_SYNAPTICS_HD, HID_QUIRK_NO_INIT_REPORTS },
>  	{ USB_VENDOR_ID_SYNAPTICS, USB_DEVICE_ID_SYNAPTICS_QUAD_HD, HID_QUIRK_NO_INIT_REPORTS },
> +	{ USB_VENDOR_ID_SYNAPTICS, USB_DEVICE_ID_SYNAPTICS_TP_V103, HID_QUIRK_NO_INIT_REPORTS },
>  
>  	{ 0, 0 }
>  };

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs
