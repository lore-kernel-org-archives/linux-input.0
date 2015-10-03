From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] usbhid: Fix for the WiiU adapter from Mayflash
Date: Sat, 3 Oct 2015 16:19:40 -0500
Message-ID: <87a8rzfy4z.fsf@saruman.tx.rr.com>
References: <1443889202-12113-1-git-send-email-voltumna@gmx.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-="; micalg=pgp-sha1;
	protocol="application/pgp-signature"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:40876 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750788AbbJCVTv (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 3 Oct 2015 17:19:51 -0400
In-Reply-To: <1443889202-12113-1-git-send-email-voltumna@gmx.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jikos@kernel.org
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, Oliver Schmitt <voltumna@gmx.net>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Oliver Schmitt <voltumna@gmx.net> writes:

Hi,

> The WiiU adapter from Mayflash (see http://www.mayflash.com/Products/NINT=
ENDOWiiU/W009.html) is not working correctly.
>
> The "XInput" mode works fine, the controller is recognized as a xbox cont=
roller. But it is only possible to connect one controller with this method.
>
> In "DInput" mode the device is recognized as some kind of mouse input but=
 no joystick is created. This commit will change this behavior with HID_QUI=
RK_MULTI_INPUT to split the device into 4 input devices so that it will als=
o create joysticks in /dev/input/js*.
>

Please split your commit log so that sentences don't go over 72
characters.

Other than that:

Reviewed-by: Felipe Balbi <balbi@ti.com>

> Signed-off-by: Oliver Schmitt <voltumna@gmx.net>
> ---
>  drivers/hid/hid-ids.h           | 1 +
>  drivers/hid/usbhid/hid-quirks.c | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index f769208..cfb317e 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -288,6 +288,7 @@
>  #define USB_DEVICE_ID_DMI_ENC		0x5fab
>=20=20
>  #define USB_VENDOR_ID_DRAGONRISE	0x0079
> +#define USB_DEVICE_ID_DRAGONRISE_WIIU	0x1800
>=20=20
>  #define USB_VENDOR_ID_DWAV		0x0eef
>  #define USB_DEVICE_ID_EGALAX_TOUCHCONTROLLER	0x0001
> diff --git a/drivers/hid/usbhid/hid-quirks.c b/drivers/hid/usbhid/hid-qui=
rks.c
> index 1dff8f0..26d2f83 100644
> --- a/drivers/hid/usbhid/hid-quirks.c
> +++ b/drivers/hid/usbhid/hid-quirks.c
> @@ -71,6 +71,7 @@ static const struct hid_blacklist {
>  	{ USB_VENDOR_ID_CH, USB_DEVICE_ID_CH_AXIS_295, HID_QUIRK_NOGET },
>  	{ USB_VENDOR_ID_CHICONY, USB_DEVICE_ID_CHICONY_PIXART_USB_OPTICAL_MOUSE=
, HID_QUIRK_ALWAYS_POLL },
>  	{ USB_VENDOR_ID_DMI, USB_DEVICE_ID_DMI_ENC, HID_QUIRK_NOGET },
> +	{ USB_VENDOR_ID_DRAGONRISE, USB_DEVICE_ID_DRAGONRISE_WIIU, HID_QUIRK_MU=
LTI_INPUT },
>  	{ USB_VENDOR_ID_ELAN, USB_DEVICE_ID_ELAN_TOUCHSCREEN, HID_QUIRK_ALWAYS_=
POLL },
>  	{ USB_VENDOR_ID_ELAN, USB_DEVICE_ID_ELAN_TOUCHSCREEN_009B, HID_QUIRK_AL=
WAYS_POLL },
>  	{ USB_VENDOR_ID_ELAN, USB_DEVICE_ID_ELAN_TOUCHSCREEN_0103, HID_QUIRK_AL=
WAYS_POLL },
> --=20
> 2.5.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWEEZuAAoJEIaOsuA1yqREOCoP/iYoRsZvaBItCuDOLms4f2rD
MTX0zD+Ok+IQuhEdsD84M1KzUDbqz9kNbsuKIfZc5t4OG+s84KaFEZBspcg8BP0t
+zhSAAYX6dk4DeoNb4lW4Q2EMsKlVZv6YYBueq6ASZcya++Tuv+j20lyHJz8JnqT
e1B155PtYqLvzfAMsC4AioLrvNqBKSahFCvexlgdTPgubp22m9y2WDkn7DQa6xGt
A7qmEgHXigshumCsP9IHPU1gX6C7sl9xqN9Jlt0RGXCeiFSLzSbgsf3uWYRzNp5L
BITWbW2mf+BbsLAgjzubuWaREevFK+LAtEm/s426nkOkg1wOODJMu9opvL2vf+zI
IZ17I2SB4dTukyQ2AAMcPF8TKjFVRDRTl1XT54Yo31GAiw5Elk7wpHlO182gam6G
SNVvTV3nxwAfhg9xZ/NSC2X38HCgGXYj79N2EWyNPMuWo8Tt2Mqc1COuiOeY9sq+
gZsAucZg4zpjBwYRX/mPAvOw7kX9MCzEMoJShycRA4NJl/bRahs7vsFycH6z3sYO
IDQUiaocRLBX4fVuaCfXssVGppXqfWbVOBJa/c+Tqvl+XgjIMOUZ+1MgVCDcW98r
rNkGaNYT7HLA5IM5qTSdqx5u7F0xlO8fvo7hx0/z7lUBIQLtLMrWv9kMYXmfTWsY
YHd2bvwUkqPUYieHAxkU
=1kmG
-----END PGP SIGNATURE-----
--=-=-=--
