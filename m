From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH] hid-multitouch: Add device id for another DWAV/eGalax variant
Date: Thu, 23 Jun 2011 08:40:35 +0200
Message-ID: <BANLkTi=psjAa2NNoENCRDfE7vJqfsfgorw@mail.gmail.com>
References: <201106222147.29915.gabrbedd@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:58006 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756583Ab1FWGkh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 23 Jun 2011 02:40:37 -0400
Received: by wwe5 with SMTP id 5so1592161wwe.1
        for <linux-input@vger.kernel.org>; Wed, 22 Jun 2011 23:40:36 -0700 (PDT)
In-Reply-To: <201106222147.29915.gabrbedd@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Gabriel M. Beddingfield" <gabrbedd@gmail.com>
Cc: linux-input@vger.kernel.org

Reviewed-By: Benjamin Tissoires <benjamin.tissoires@enac.fr>

Thanks,
Benjamin

On Thu, Jun 23, 2011 at 04:47, Gabriel M. Beddingfield
<gabrbedd@gmail.com> wrote:
> Add the device id for a DWAV eGalax touchscreen, found
> on the Dell Inspiron Duo.
>
> Signed-off-by: Gabriel M. Beddingfield <gabrbedd@gmail.com>
> ---
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index f7440e8..594e9e4 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -1374,6 +1374,7 @@ static const struct hid_device_id hid_have_spec=
ial_driver[] =3D {
> =A0 =A0 =A0 =A0{ HID_USB_DEVICE(USB_VENDOR_ID_DWAV, USB_DEVICE_ID_DWA=
V_EGALAX_MULTITOUCH2) },
> =A0 =A0 =A0 =A0{ HID_USB_DEVICE(USB_VENDOR_ID_DWAV, USB_DEVICE_ID_DWA=
V_EGALAX_MULTITOUCH3) },
> =A0 =A0 =A0 =A0{ HID_USB_DEVICE(USB_VENDOR_ID_DWAV, USB_DEVICE_ID_DWA=
V_EGALAX_MULTITOUCH4) },
> + =A0 =A0 =A0 { HID_USB_DEVICE(USB_VENDOR_ID_DWAV, USB_DEVICE_ID_DWAV=
_EGALAX_MULTITOUCH5) },
> =A0 =A0 =A0 =A0{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVIC=
E_ID_ELECOM_BM084) },
> =A0 =A0 =A0 =A0{ HID_USB_DEVICE(USB_VENDOR_ID_ELO, USB_DEVICE_ID_ELO_=
TS2515) },
> =A0 =A0 =A0 =A0{ HID_USB_DEVICE(USB_VENDOR_ID_EMS, USB_DEVICE_ID_EMS_=
TRIO_LINKER_PLUS_II) },
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index aecb5a4..8b0d757 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -222,6 +222,7 @@
> =A0#define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH2 =A00x72a1
> =A0#define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH3 =A00x480e
> =A0#define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH4 =A00x726b
> +#define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH5 =A00x725e
>
> =A0#define USB_VENDOR_ID_ELECOM =A0 =A0 =A0 =A0 =A0 0x056e
> =A0#define USB_DEVICE_ID_ELECOM_BM084 =A0 =A0 0x0061
> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouc=
h.c
> index 0b2dcd0..06edd68 100644
> --- a/drivers/hid/hid-multitouch.c
> +++ b/drivers/hid/hid-multitouch.c
> @@ -647,6 +647,9 @@ static const struct hid_device_id mt_devices[] =3D=
 {
> =A0 =A0 =A0 =A0{ =A0.driver_data =3D MT_CLS_EGALAX,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0HID_USB_DEVICE(USB_VENDOR_ID_DWAV,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0USB_DEVICE_ID_DWAV_EGA=
LAX_MULTITOUCH4) },
> + =A0 =A0 =A0 { =A0.driver_data =3D MT_CLS_EGALAX,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 HID_USB_DEVICE(USB_VENDOR_ID_DWAV,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 USB_DEVICE_ID_DWAV_EGAL=
AX_MULTITOUCH5) },
>
> =A0 =A0 =A0 =A0/* Elo TouchSystems IntelliTouch Plus panel */
> =A0 =A0 =A0 =A0{ .driver_data =3D MT_CLS_DUAL_NSMU_CONTACTID,
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
