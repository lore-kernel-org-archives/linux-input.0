From: Anton Chikin <Anton.Chikin-2rKlv3v387hBDgjK7y7TUQ@public.gmane.org>
Subject: RE: [PATCH] hid: usbhid: New hid quirks for Panasonic Elite
 Panaboard T-780 and T-880
Date: Fri, 29 Oct 2010 17:42:42 +0400
Message-ID: <3BF066A8BAB61C43B779966CEE6D7FA018BC9E19F2@e6.universe.dart.spb>
References: <1288169825-15422-1-git-send-email-Anton.Chikin@dataart.com>
 <alpine.LNX.2.00.1010291453460.6879@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <alpine.LNX.2.00.1010291453460.6879-ztGlSCb7Y1iN3ZZ/Hiejyg@public.gmane.org>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
Cc: "chatty-rXV5z7KbLFk@public.gmane.org" <chatty-rXV5z7KbLFk@public.gmane.org>, "spbnick-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <spbnick-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "anisse-fwwRqrJYcP2HXe+LvDLADg@public.gmane.org" <anisse-fwwRqrJYcP2HXe+LvDLADg@public.gmane.org>, "cascardo-DmMZpsCg3uxeGPcbtGPokg@public.gmane.org" <cascardo-DmMZpsCg3uxeGPcbtGPokg@public.gmane.org>, "don-rBL4DdiBytkIdKJ7tpkyPg@public.gmane.org" <don-rBL4DdiBytkIdKJ7tpkyPg@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Gregory Burmistrov <grig-2rKlv3v387hBDgjK7y7TUQ@public.gmane.org>, Paul Osborn <Paul.Osborn-+dFpGaSyCl6S7A1Ibl2khg@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Hello Jiri,

Panasonic Elite Panaboard UB-T780 is a touchscreen whiteboard. It uses projector to present PC's screen onto the board. So we need to calibrate it according to the projector's position and apply calibration data inside our driver.

There is no other driver for this device. I'm working directly for Panasonic on this driver.

Is this nice for changelog comment?

With best regards,
Anton Chikin

-----Original Message-----
From: Jiri Kosina [mailto:jkosina-AlSwsSmVLrQ@public.gmane.org] 
Sent: Friday, October 29, 2010 4:55 PM
To: Anton Chikin
Cc: chatty-rXV5z7KbLFk@public.gmane.org; spbnick-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org; anisse-fwwRqrJYcP2HXe+LvDLADg@public.gmane.org; cascardo-DmMZpsCg3uxeGPcbtGPokg@public.gmane.org; don-rBL4DdiBytkIdKJ7tpkyPg@public.gmane.org; linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Gregory Burmistrov; Anton Chikin; Anton Chikin
Subject: Re: [PATCH] hid: usbhid: New hid quirks for Panasonic Elite Panaboard T-780 and T-880

On Wed, 27 Oct 2010, Anton Chikin wrote:

> Added Panasonic vendor ID, two device IDs for Panasonic Whiteboard devices and new quirk to ignore
> these devices in hid-core driver.

Could you please be more verbose in the changelog?

Is the generic HID driver not working with these devices at all? Or is the 
functionality only limited, not exploiting all the features the hardware 
provides?

Is there any other driver available for these devices?

Thanks.

> 
> Signed-off-by: Anton Chikin <anton.chikin-2rKlv3v387hBDgjK7y7TUQ@public.gmane.org>
> ---
>  drivers/hid/hid-ids.h           |    4 ++++
>  drivers/hid/usbhid/hid-quirks.c |    2 ++
>  2 files changed, 6 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index 3341baa..b5542d3 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -446,6 +446,10 @@
>  #define USB_VENDOR_ID_ORTEK		0x05a4
>  #define USB_DEVICE_ID_ORTEK_WKB2000	0x2000
>  
> +#define USB_VENDOR_ID_PANASONIC 	0x04da
> +#define USB_DEVICE_ID_PANASONIC_PANABOARD_T780 	0x1044
> +#define USB_DEVICE_ID_PANASONIC_PANABOARD_T880	0x104d 
> +
>  #define USB_VENDOR_ID_PANJIT		0x134c
>  
>  #define USB_VENDOR_ID_PANTHERLORD	0x0810
> diff --git a/drivers/hid/usbhid/hid-quirks.c b/drivers/hid/usbhid/hid-quirks.c
> index 2c18547..b5788b0 100644
> --- a/drivers/hid/usbhid/hid-quirks.c
> +++ b/drivers/hid/usbhid/hid-quirks.c
> @@ -65,6 +65,8 @@ static const struct hid_blacklist {
>  	{ USB_VENDOR_ID_CH, USB_DEVICE_ID_CH_AXIS_295, HID_QUIRK_NOGET },
>  	{ USB_VENDOR_ID_DMI, USB_DEVICE_ID_DMI_ENC, HID_QUIRK_NOGET },
>  	{ USB_VENDOR_ID_ELO, USB_DEVICE_ID_ELO_TS2700, HID_QUIRK_NOGET },
> +	{ USB_VENDOR_ID_PANASONIC, USB_DEVICE_ID_PANASONIC_PANABOARD_T780, HID_QUIRK_IGNORE },
> +	{ USB_VENDOR_ID_PANASONIC, USB_DEVICE_ID_PANASONIC_PANABOARD_T880, HID_QUIRK_IGNORE },
>  	{ USB_VENDOR_ID_PRODIGE, USB_DEVICE_ID_PRODIGE_CORDLESS, HID_QUIRK_NOGET },
>  	{ USB_VENDOR_ID_QUANTA, USB_DEVICE_ID_PIXART_IMAGING_INC_OPTICAL_TOUCH_SCREEN, HID_QUIRK_NOGET },
>  	{ USB_VENDOR_ID_SUN, USB_DEVICE_ID_RARITAN_KVM_DONGLE, HID_QUIRK_NOGET },
> -- 
> 1.7.0.4
> 

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
