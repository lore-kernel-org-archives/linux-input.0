From: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: [PATCH] usbhid: Add quirk for eGalax touch controler.
Date: Mon, 30 Aug 2010 15:50:24 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1008301550130.1019@pobox.suse.cz>
References: <1283166702-28582-1-git-send-email-thierry.reding@avionic-design.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1283166702-28582-1-git-send-email-thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Peter Hutterer <peter.hutterer-Pf4JEFdB4epeoWH0uzbU5w@public.gmane.org>, Thadeu Lima de Souza Cascardo <cascardo-DmMZpsCg3uxeGPcbtGPokg@public.gmane.org>, Daniel Oliveira Nascimento <don-rBL4DdiBytkIdKJ7tpkyPg@public.gmane.org>, Keith Rutkowski <rutkowski-T1p9dGDnAHDoS6w7zS32OEtZW7PLQM7H@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Mon, 30 Aug 2010, Thierry Reding wrote:

> This patch adds a quirk for the eGalax touch controller which reports
> two pairs of axes.
> 
> Signed-off-by: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
> ---
>  drivers/hid/usbhid/hid-quirks.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/hid/usbhid/hid-quirks.c b/drivers/hid/usbhid/hid-quirks.c
> index 2643d31..48120a2 100644
> --- a/drivers/hid/usbhid/hid-quirks.c
> +++ b/drivers/hid/usbhid/hid-quirks.c
> @@ -33,6 +33,7 @@ static const struct hid_blacklist {
>  	{ USB_VENDOR_ID_AASHIMA, USB_DEVICE_ID_AASHIMA_PREDATOR, HID_QUIRK_BADPAD },
>  	{ USB_VENDOR_ID_ALPS, USB_DEVICE_ID_IBM_GAMEPAD, HID_QUIRK_BADPAD },
>  	{ USB_VENDOR_ID_CHIC, USB_DEVICE_ID_CHIC_GAMEPAD, HID_QUIRK_BADPAD },
> +	{ USB_VENDOR_ID_DWAV, USB_DEVICE_ID_EGALAX_TOUCHCONTROLLER, HID_QUIRK_MULTI_INPUT },
>  	{ USB_VENDOR_ID_DWAV, USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH, HID_QUIRK_MULTI_INPUT },
>  	{ USB_VENDOR_ID_MOJO, USB_DEVICE_ID_RETRO_ADAPTER, HID_QUIRK_MULTI_INPUT },
>  	{ USB_VENDOR_ID_HAPP, USB_DEVICE_ID_UGCI_DRIVING, HID_QUIRK_BADPAD | HID_QUIRK_MULTI_INPUT },

Applied, thank you Thierry.

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
