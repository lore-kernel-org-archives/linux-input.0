From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH] hid-multitouch: Add LG Display Multitouch device.
Date: Tue, 16 Aug 2011 09:32:16 +0200
Message-ID: <CAN+gG=GYZxxOL8PKDdvb-HNhBq-M+rWu+qFkiZTFufyciqP3vQ@mail.gmail.com>
References: <1313467929-28250-1-git-send-email-jeffbrown@android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:50105 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750869Ab1HPHcR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 16 Aug 2011 03:32:17 -0400
In-Reply-To: <1313467929-28250-1-git-send-email-jeffbrown@android.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jeffbrown@android.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, jkosina@suse.cz, rydberg@euromail.se, chatty@enac.fr

On Tue, Aug 16, 2011 at 06:12,  <jeffbrown@android.com> wrote:
> From: Jeff Brown <jeffbrown@android.com>
>
> This panel is also known as the Dell ST2220Tc.

Reviewed-By: Benjamin Tissoires <Benjamin_Tissoires@logitech.com>

>
> Signed-off-by: jeffbrown@android.com
>
> ---
> =A0drivers/hid/Kconfig =A0 =A0 =A0 =A0 =A0| =A0 =A01 +
> =A0drivers/hid/hid-core.c =A0 =A0 =A0 | =A0 =A01 +
> =A0drivers/hid/hid-ids.h =A0 =A0 =A0 =A0| =A0 =A03 +++
> =A0drivers/hid/hid-multitouch.c | =A0 =A05 +++++
> =A04 files changed, 10 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> index 306b15f..3cbe8cc 100644
> --- a/drivers/hid/Kconfig
> +++ b/drivers/hid/Kconfig
> @@ -328,6 +328,7 @@ config HID_MULTITOUCH
> =A0 =A0 =A0 =A0 =A0- Hanvon dual touch panels
> =A0 =A0 =A0 =A0 =A0- Ilitek dual touch panels
> =A0 =A0 =A0 =A0 =A0- IrTouch Infrared USB panels
> + =A0 =A0 =A0 =A0 - LG Display panels (Dell ST2220Tc)
> =A0 =A0 =A0 =A0 =A0- Lumio CrystalTouch panels
> =A0 =A0 =A0 =A0 =A0- MosArt dual-touch panels
> =A0 =A0 =A0 =A0 =A0- PenMount dual touch panels
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index 1a5cf0c..11b3b39 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -1396,6 +1396,7 @@ static const struct hid_device_id hid_have_spec=
ial_driver[] =3D {
> =A0 =A0 =A0 =A0{ HID_USB_DEVICE(USB_VENDOR_ID_KYE, USB_DEVICE_ID_KYE_=
ERGO_525V) },
> =A0 =A0 =A0 =A0{ HID_USB_DEVICE(USB_VENDOR_ID_LABTEC, USB_DEVICE_ID_L=
ABTEC_WIRELESS_KEYBOARD) },
> =A0 =A0 =A0 =A0{ HID_USB_DEVICE(USB_VENDOR_ID_LCPOWER, USB_DEVICE_ID_=
LCPOWER_LC1000 ) },
> + =A0 =A0 =A0 { HID_USB_DEVICE(USB_VENDOR_ID_LG, USB_DEVICE_ID_LG_MUL=
TITOUCH) },
> =A0 =A0 =A0 =A0{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID=
_MX3000_RECEIVER) },
> =A0 =A0 =A0 =A0{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID=
_S510_RECEIVER) },
> =A0 =A0 =A0 =A0{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID=
_S510_RECEIVER_2) },
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index db63ccf..637e6e9 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -419,6 +419,9 @@
> =A0#define USB_DEVICE_ID_LD_HYBRID =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x2=
090
> =A0#define USB_DEVICE_ID_LD_HEATCONTROL =A0 0x20A0
>
> +#define USB_VENDOR_ID_LG =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x1fd2
> +#define USB_DEVICE_ID_LG_MULTITOUCH =A0 =A00x0064
> +
> =A0#define USB_VENDOR_ID_LOGITECH =A0 =A0 =A0 =A0 0x046d
> =A0#define USB_DEVICE_ID_LOGITECH_RECEIVER =A0 =A0 =A0 =A00xc101
> =A0#define USB_DEVICE_ID_LOGITECH_HARMONY_FIRST =A00xc110
> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouc=
h.c
> index 58d0e7a..9fc15e1 100644
> --- a/drivers/hid/hid-multitouch.c
> +++ b/drivers/hid/hid-multitouch.c
> @@ -672,6 +672,11 @@ static const struct hid_device_id mt_devices[] =3D=
 {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0HID_USB_DEVICE(USB_VENDOR_ID_IRTOUCHSY=
STEMS,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0USB_DEVICE_ID_IRTOUCH_=
INFRARED_USB) },
>
> + =A0 =A0 =A0 /* LG Display panels */
> + =A0 =A0 =A0 { .driver_data =3D MT_CLS_DEFAULT,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 HID_USB_DEVICE(USB_VENDOR_ID_LG,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 USB_DEVICE_ID_LG_MULTIT=
OUCH) },
> +
> =A0 =A0 =A0 =A0/* Lumio panels */
> =A0 =A0 =A0 =A0{ .driver_data =3D MT_CLS_CONFIDENCE_MINUS_ONE,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0HID_USB_DEVICE(USB_VENDOR_ID_LUMIO,
> --
> 1.7.0.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
