From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v4 2/2] USB: quirks: Apply ALWAYS_POLL to all ELAN devices
Date: Tue, 1 Dec 2015 10:21:55 -0800
Message-ID: <20151201182155.GA14494@kroah.com>
References: <1448165164-11398-1-git-send-email-adrienverge@gmail.com>
 <1448377325-4725-1-git-send-email-adrienverge@gmail.com>
 <1448377325-4725-3-git-send-email-adrienverge@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1448377325-4725-3-git-send-email-adrienverge@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrien =?iso-8859-1?Q?Verg=E9?= <adrienverge@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, Oliver Neukum <oneukum@suse.com>, Jiri Kosina <jikos@kernel.org>, Logan Gunthorpe <logang@deltatee.com>, Hans de Goede <hdegoede@redhat.com>, Vincent Palatin <vpalatin@chromium.org>, Macpaul Lin <macpaul@gmail.com>, Adel Gadllah <adel.gadllah@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, Nov 24, 2015 at 04:02:05PM +0100, Adrien Verg=E9 wrote:
> All ELAN hid devices seem to require the ALWAYS_POLL quirk. Let's use
> this quirk for all devices from this vendor, rather than maintaining =
a
> list of all its known product IDs.
>=20
> Tested-by: Adrien Verg=E9 <adrienverge@gmail.com>
> Signed-off-by: Adrien Verg=E9 <adrienverge@gmail.com>
> ---
>  drivers/hid/hid-ids.h           | 5 -----
>  drivers/hid/usbhid/hid-quirks.c | 9 +++------
>  2 files changed, 3 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index ac1feea..3c7e0c3 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -316,11 +316,6 @@
>  #define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_A001	0xa001
> =20
>  #define USB_VENDOR_ID_ELAN		0x04f3
> -#define USB_DEVICE_ID_ELAN_TOUCHSCREEN	0x0089
> -#define USB_DEVICE_ID_ELAN_TOUCHSCREEN_009B	0x009b
> -#define USB_DEVICE_ID_ELAN_TOUCHSCREEN_0103	0x0103
> -#define USB_DEVICE_ID_ELAN_TOUCHSCREEN_010c	0x010c
> -#define USB_DEVICE_ID_ELAN_TOUCHSCREEN_016F	0x016f
> =20
>  #define USB_VENDOR_ID_ELECOM		0x056e
>  #define USB_DEVICE_ID_ELECOM_BM084	0x0061
> diff --git a/drivers/hid/usbhid/hid-quirks.c b/drivers/hid/usbhid/hid=
-quirks.c
> index 94bb137..b1af008 100644
> --- a/drivers/hid/usbhid/hid-quirks.c
> +++ b/drivers/hid/usbhid/hid-quirks.c
> @@ -72,11 +72,7 @@ static const struct hid_blacklist {
>  	{ USB_VENDOR_ID_CHICONY, USB_DEVICE_ID_CHICONY_PIXART_USB_OPTICAL_M=
OUSE, HID_QUIRK_ALWAYS_POLL },
>  	{ USB_VENDOR_ID_DMI, USB_DEVICE_ID_DMI_ENC, HID_QUIRK_NOGET },
>  	{ USB_VENDOR_ID_DRAGONRISE, USB_DEVICE_ID_DRAGONRISE_WIIU, HID_QUIR=
K_MULTI_INPUT },
> -	{ USB_VENDOR_ID_ELAN, USB_DEVICE_ID_ELAN_TOUCHSCREEN, HID_QUIRK_ALW=
AYS_POLL },
> -	{ USB_VENDOR_ID_ELAN, USB_DEVICE_ID_ELAN_TOUCHSCREEN_009B, HID_QUIR=
K_ALWAYS_POLL },
> -	{ USB_VENDOR_ID_ELAN, USB_DEVICE_ID_ELAN_TOUCHSCREEN_0103, HID_QUIR=
K_ALWAYS_POLL },
> -	{ USB_VENDOR_ID_ELAN, USB_DEVICE_ID_ELAN_TOUCHSCREEN_010c, HID_QUIR=
K_ALWAYS_POLL },
> -	{ USB_VENDOR_ID_ELAN, USB_DEVICE_ID_ELAN_TOUCHSCREEN_016F, HID_QUIR=
K_ALWAYS_POLL },
> +	{ USB_VENDOR_ID_ELAN, HID_ANY_ID, HID_QUIRK_ALWAYS_POLL },
>  	{ USB_VENDOR_ID_ELO, USB_DEVICE_ID_ELO_TS2700, HID_QUIRK_NOGET },
>  	{ USB_VENDOR_ID_FORMOSA, USB_DEVICE_ID_FORMOSA_IR_RECEIVER, HID_QUI=
RK_NO_INIT_REPORTS },
>  	{ USB_VENDOR_ID_FREESCALE, USB_DEVICE_ID_FREESCALE_MX28, HID_QUIRK_=
NOGET },
> @@ -339,7 +335,8 @@ static const struct hid_blacklist *usbhid_exists_=
squirk(const u16 idVendor,
> =20
>  	for (; hid_blacklist[n].idVendor; n++)
>  		if (hid_blacklist[n].idVendor =3D=3D idVendor &&
> -				hid_blacklist[n].idProduct =3D=3D idProduct)
> +			(hid_blacklist[n].idProduct =3D=3D HID_ANY_ID ||
> +				hid_blacklist[n].idProduct =3D=3D idProduct))

Please fix the warning the kbuild infrastructure told you about here.

thanks,

greg k-h
