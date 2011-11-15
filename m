From: Chris Bagwell <chris@cnpbagwell.com>
Subject: Re: [PATCH] Input: HID-multitouch: Add egalax ID for Acer Iconia W500
Date: Tue, 15 Nov 2011 15:23:16 -0600
Message-ID: <CAGzDe_Ze8qyYjv7WJh_qtH=g7j1FCSJxp6maLZED_CE_EHFcbw@mail.gmail.com>
References: <1321288906-14289-1-git-send-email-marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:48124 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932385Ab1KOVXS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 15 Nov 2011 16:23:18 -0500
Received: by eye27 with SMTP id 27so6186747eye.19
        for <linux-input@vger.kernel.org>; Tue, 15 Nov 2011 13:23:16 -0800 (PST)
In-Reply-To: <1321288906-14289-1-git-send-email-marek.vasut@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Marek Vasut <marek.vasut@gmail.com>
Cc: linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@gmail.com>

On Mon, Nov 14, 2011 at 10:41 AM, Marek Vasut <marek.vasut@gmail.com> w=
rote:
> This patch adds USB ID for the touchpanel in Acer Iconia W500. The pa=
nel
> supports up to five fingers, therefore the need for a new addition of=
 panel
> types.
>
> Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
> Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>
> Cc: chris@cnpbagwell.com
> ---
> =A0drivers/hid/hid-core.c =A0 =A0 =A0 | =A0 =A01 +
> =A0drivers/hid/hid-ids.h =A0 =A0 =A0 =A0| =A0 =A01 +
> =A0drivers/hid/hid-multitouch.c | =A0 12 ++++++++++++
> =A03 files changed, 14 insertions(+), 0 deletions(-)
>
> NOTE: That checkpatch warning is there because I followed the pattern=
 in
> hid-core.c
>
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index 242353d..6600ac7 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -1377,6 +1377,7 @@ static const struct hid_device_id hid_have_spec=
ial_driver[] =3D {
> =A0 =A0 =A0 =A0{ HID_USB_DEVICE(USB_VENDOR_ID_DWAV, USB_DEVICE_ID_DWA=
V_EGALAX_MULTITOUCH2) },
> =A0 =A0 =A0 =A0{ HID_USB_DEVICE(USB_VENDOR_ID_DWAV, USB_DEVICE_ID_DWA=
V_EGALAX_MULTITOUCH3) },
> =A0 =A0 =A0 =A0{ HID_USB_DEVICE(USB_VENDOR_ID_DWAV, USB_DEVICE_ID_DWA=
V_EGALAX_MULTITOUCH4) },
> + =A0 =A0 =A0 { HID_USB_DEVICE(USB_VENDOR_ID_DWAV, USB_DEVICE_ID_DWAV=
_EGALAX_MULTITOUCH5) },

We have a merge issue here since the 0xa001 got committed as #5.

> =A0 =A0 =A0 =A0{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVIC=
E_ID_ELECOM_BM084) },
> =A0 =A0 =A0 =A0{ HID_USB_DEVICE(USB_VENDOR_ID_ELO, USB_DEVICE_ID_ELO_=
TS2515) },
> =A0 =A0 =A0 =A0{ HID_USB_DEVICE(USB_VENDOR_ID_EMS, USB_DEVICE_ID_EMS_=
TRIO_LINKER_PLUS_II) },
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index 7484e1b..c2e9369 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -225,6 +225,7 @@
> =A0#define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH2 =A00x72a1
> =A0#define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH3 =A00x480e
> =A0#define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH4 =A00x726b
> +#define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH5 =A00x7302
>
> =A0#define USB_VENDOR_ID_ELECOM =A0 =A0 =A0 =A0 =A0 0x056e
> =A0#define USB_DEVICE_ID_ELECOM_BM084 =A0 =A0 0x0061
> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouc=
h.c
> index 58d0e7a..35c53db 100644
> --- a/drivers/hid/hid-multitouch.c
> +++ b/drivers/hid/hid-multitouch.c
> @@ -96,6 +96,7 @@ struct mt_class {
> =A0#define MT_CLS_3M =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A00x0101
> =A0#define MT_CLS_CYPRESS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 0x0102
> =A0#define MT_CLS_EGALAX =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A00x0103
> +#define MT_CLS_EGALAX_5FINGER =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x0=
104
>
> =A0#define MT_DEFAULT_MAXCONTACT =A010
>
> @@ -173,6 +174,13 @@ struct mt_class mt_classes[] =3D {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.sn_move =3D 4096,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.sn_pressure =3D 32,
> =A0 =A0 =A0 =A0},
> + =A0 =A0 =A0 { .name =3D MT_CLS_EGALAX_5FINGER,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .quirks =3D =A0MT_QUIRK_SLOT_IS_CONTACT=
ID |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 MT_QUIRK_VALID_IS_INRAN=
GE |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 MT_QUIRK_EGALAX_XYZ_FIX=
UP,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .sn_move =3D 4096,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .sn_pressure =3D 32,
> + =A0 =A0 =A0 },

I went and looked up the original thread to see background on this chan=
ge.

The original thread in September requested to remove .maxcontacts from
MT_CLS_EGALAX. I'd either do that if it works or I would rename this
to something like MT_CLS_EGALAX_HAS_MAXCONTACTS because the 5FINGER
part is misleading.

Chris

>
> =A0 =A0 =A0 =A0{ }
> =A0};
> @@ -646,6 +655,9 @@ static const struct hid_device_id mt_devices[] =3D=
 {
> =A0 =A0 =A0 =A0{ =A0.driver_data =3D MT_CLS_EGALAX,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0HID_USB_DEVICE(USB_VENDOR_ID_DWAV,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0USB_DEVICE_ID_DWAV_EGA=
LAX_MULTITOUCH4) },
> + =A0 =A0 =A0 { =A0.driver_data =3D MT_CLS_EGALAX_5FINGER,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 HID_USB_DEVICE(USB_VENDOR_ID_DWAV,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 USB_DEVICE_ID_DWAV_EGAL=
AX_MULTITOUCH5) },
>
> =A0 =A0 =A0 =A0/* Elo TouchSystems IntelliTouch Plus panel */
> =A0 =A0 =A0 =A0{ .driver_data =3D MT_CLS_DUAL_NSMU_CONTACTID,
> --
> 1.7.5.4
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
