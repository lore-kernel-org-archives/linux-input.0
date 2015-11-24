From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH v3 2/2] USB: quirks: Apply ALWAYS_POLL to all ELAN devices
Date: Tue, 24 Nov 2015 15:11:19 +0100
Message-ID: <CAN+gG=Fb0GD0K0pyiJ6bbK82-fa+xYhWKSjhH-DYp2BH3h2iDg@mail.gmail.com>
References: <1448165164-11398-1-git-send-email-adrienverge@gmail.com>
	<1448372948-8861-1-git-send-email-adrienverge@gmail.com>
	<1448372948-8861-3-git-send-email-adrienverge@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:36715 "EHLO
	mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752893AbbKXOLV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 24 Nov 2015 09:11:21 -0500
In-Reply-To: <1448372948-8861-3-git-send-email-adrienverge@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?UTF-8?Q?Adrien_Verg=C3=A9?= <adrienverge@gmail.com>
Cc: Oliver Neukum <oneukum@suse.com>, Jiri Kosina <jikos@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Logan Gunthorpe <logang@deltatee.com>, Hans de Goede <hdegoede@redhat.com>, Vincent Palatin <vpalatin@chromium.org>, Macpaul Lin <macpaul@gmail.com>, Adel Gadllah <adel.gadllah@gmail.com>, linux-input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>

Hi Adrien,

On Tue, Nov 24, 2015 at 2:49 PM, Adrien Verg=C3=A9 <adrienverge@gmail.c=
om> wrote:
> All ELAN hid devices seem to require the ALWAYS_POLL quirk. Let's use
> this quirk for all devices from this vendor, rather than maintaining =
a
> list of all its known product IDs.
>
> To achieve that, this patch introduces a new hid_vendor_blacklist[] t=
hat
> is checked when the product ID is not found in hid_product_blacklist[=
].
>
> Tested-by: Adrien Verg=C3=A9 <adrienverge@gmail.com>
> Signed-off-by: Adrien Verg=C3=A9 <adrienverge@gmail.com>
> ---
>  drivers/hid/hid-ids.h           |  5 -----
>  drivers/hid/usbhid/hid-quirks.c | 43 +++++++++++++++++++++++++++----=
----------
>  2 files changed, 29 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index ac1feea..3c7e0c3 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -316,11 +316,6 @@
>  #define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_A001      0xa001
>
>  #define USB_VENDOR_ID_ELAN             0x04f3
> -#define USB_DEVICE_ID_ELAN_TOUCHSCREEN 0x0089
> -#define USB_DEVICE_ID_ELAN_TOUCHSCREEN_009B    0x009b
> -#define USB_DEVICE_ID_ELAN_TOUCHSCREEN_0103    0x0103
> -#define USB_DEVICE_ID_ELAN_TOUCHSCREEN_010c    0x010c
> -#define USB_DEVICE_ID_ELAN_TOUCHSCREEN_016F    0x016f
>
>  #define USB_VENDOR_ID_ELECOM           0x056e
>  #define USB_DEVICE_ID_ELECOM_BM084     0x0061
> diff --git a/drivers/hid/usbhid/hid-quirks.c b/drivers/hid/usbhid/hid=
-quirks.c
> index 94bb137..9550497 100644
> --- a/drivers/hid/usbhid/hid-quirks.c
> +++ b/drivers/hid/usbhid/hid-quirks.c
> @@ -21,15 +21,29 @@
>
>  #include "../hid-ids.h"
>
> +struct hid_blacklist {
> +       __u16 idVendor;
> +       __u16 idProduct;
> +       __u32 quirks;
> +};
> +
> +/*
> + * Alphabetically sorted blacklist for vendor-global quirks. If a de=
vice matches
> + * both this blacklist and the product one (below), the more specifi=
c one
> + * (product ID) prevails.
> + */
> +
> +static const struct hid_blacklist hid_vendor_blacklist[] =3D {
> +       { USB_VENDOR_ID_ELAN, 0, HID_QUIRK_ALWAYS_POLL },
> +
> +       { 0, 0, 0 }
> +};

Instead of adding a second table, I'd rather have a match on
HID_ANY_ID for the product ID.

> +
>  /*
>   * Alphabetically sorted blacklist by quirk type.
>   */
>
> -static const struct hid_blacklist {
> -       __u16 idVendor;
> -       __u16 idProduct;
> -       __u32 quirks;
> -} hid_blacklist[] =3D {
> +static const struct hid_blacklist hid_product_blacklist[] =3D {
>         { USB_VENDOR_ID_AASHIMA, USB_DEVICE_ID_AASHIMA_GAMEPAD, HID_Q=
UIRK_BADPAD },
>         { USB_VENDOR_ID_AASHIMA, USB_DEVICE_ID_AASHIMA_PREDATOR, HID_=
QUIRK_BADPAD },
>         { USB_VENDOR_ID_ALPS, USB_DEVICE_ID_IBM_GAMEPAD, HID_QUIRK_BA=
DPAD },
> @@ -72,11 +86,6 @@ static const struct hid_blacklist {
>         { USB_VENDOR_ID_CHICONY, USB_DEVICE_ID_CHICONY_PIXART_USB_OPT=
ICAL_MOUSE, HID_QUIRK_ALWAYS_POLL },
>         { USB_VENDOR_ID_DMI, USB_DEVICE_ID_DMI_ENC, HID_QUIRK_NOGET }=
,
>         { USB_VENDOR_ID_DRAGONRISE, USB_DEVICE_ID_DRAGONRISE_WIIU, HI=
D_QUIRK_MULTI_INPUT },
> -       { USB_VENDOR_ID_ELAN, USB_DEVICE_ID_ELAN_TOUCHSCREEN, HID_QUI=
RK_ALWAYS_POLL },
> -       { USB_VENDOR_ID_ELAN, USB_DEVICE_ID_ELAN_TOUCHSCREEN_009B, HI=
D_QUIRK_ALWAYS_POLL },
> -       { USB_VENDOR_ID_ELAN, USB_DEVICE_ID_ELAN_TOUCHSCREEN_0103, HI=
D_QUIRK_ALWAYS_POLL },
> -       { USB_VENDOR_ID_ELAN, USB_DEVICE_ID_ELAN_TOUCHSCREEN_010c, HI=
D_QUIRK_ALWAYS_POLL },
> -       { USB_VENDOR_ID_ELAN, USB_DEVICE_ID_ELAN_TOUCHSCREEN_016F, HI=
D_QUIRK_ALWAYS_POLL },

This becomes:
{ USB_VENDOR_ID_ELAN, HID_ANY_ID, HID_QUIRK_ALWAYS_POLL },

>         { USB_VENDOR_ID_ELO, USB_DEVICE_ID_ELO_TS2700, HID_QUIRK_NOGE=
T },
>         { USB_VENDOR_ID_FORMOSA, USB_DEVICE_ID_FORMOSA_IR_RECEIVER, H=
ID_QUIRK_NO_INIT_REPORTS },
>         { USB_VENDOR_ID_FREESCALE, USB_DEVICE_ID_FREESCALE_MX28, HID_=
QUIRK_NOGET },
> @@ -337,10 +346,16 @@ static const struct hid_blacklist *usbhid_exist=
s_squirk(const u16 idVendor,
>         const struct hid_blacklist *bl_entry =3D NULL;
>         int n =3D 0;
>
> -       for (; hid_blacklist[n].idVendor; n++)
> -               if (hid_blacklist[n].idVendor =3D=3D idVendor &&
> -                               hid_blacklist[n].idProduct =3D=3D idP=
roduct)

And here you need to check also on the match with HID_ANY_ID for both
idVendor and idProduct.

Cheers,
Benjamin

> -                       bl_entry =3D &hid_blacklist[n];
> +       for (; hid_product_blacklist[n].idVendor; n++)
> +               if (hid_product_blacklist[n].idVendor =3D=3D idVendor=
 &&
> +                               hid_product_blacklist[n].idProduct =3D=
=3D idProduct)
> +                       bl_entry =3D &hid_product_blacklist[n];
> +
> +       if (bl_entry =3D=3D NULL) {
> +               for (n =3D 0; hid_vendor_blacklist[n].idVendor; n++)
> +                       if (hid_vendor_blacklist[n].idVendor =3D=3D i=
dVendor)
> +                               bl_entry =3D &hid_vendor_blacklist[n]=
;
> +       }
>
>         if (bl_entry !=3D NULL)
>                 dbg_hid("Found squirk 0x%x for USB HID vendor 0x%hx p=
rod 0x%hx\n",
> --
> 2.4.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
