From: Benjamin Tissoires <benjamin.tissoires@enac.fr>
Subject: Re: [PATCH]HID: hid-multitouch: add support for Chunghwa multi-touch panel
Date: Fri, 27 May 2011 10:48:25 +0200
Message-ID: <BANLkTin3jqYUASnW+wExAHd2YCBqB2j9Uw@mail.gmail.com>
References: <BANLkTi=52uMg4Ut2Bs5VbgSeRO4wJeLgHw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:44815 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758776Ab1E0Is0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 27 May 2011 04:48:26 -0400
Received: by wya21 with SMTP id 21so1075845wya.19
        for <linux-input@vger.kernel.org>; Fri, 27 May 2011 01:48:25 -0700 (PDT)
In-Reply-To: <BANLkTi=52uMg4Ut2Bs5VbgSeRO4wJeLgHw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Austin Zhang <zhang.austin@gmail.com>
Cc: =?ISO-8859-1?Q?St=E9phane_Chatty?= <chatty@enac.fr>, Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org, jkosina@suse.cz, dmitry.torokhov@gmail.com

Hi,

The patch has been corrupted by your mail client.
Please use git send-email to resend it.
Please also add the authors of the driver (me and St=E9phane Chatty) an=
d
the MT maintainer (Henrik Rydberg).

If the patch does not mismatch tabs and spaces, you can have my Reviewe=
d-by.

Cheers,
Benjamin

On Fri, May 27, 2011 at 10:20, Austin Zhang <zhang.austin@gmail.com> wr=
ote:
> Added Chunghwa hid multitouch panel support into hid-multitouch.
>
> Signed-off-by: Austin Zhang <zhang.austin@gmail.com>
> ---
> =A0Kconfig =A0 =A0 =A0 =A0 =A0| =A0 =A01 +
> =A0hid-core.c =A0 =A0 =A0 | =A0 =A01 +
> =A0hid-ids.h =A0 =A0 =A0 =A0| =A0 =A03 +++
> =A0hid-multitouch.c | =A0 =A05 +++++
> =A04 files changed, 10 insertions(+)
>
> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> index 67d2a75..36ca465 100644
> --- a/drivers/hid/Kconfig
> +++ b/drivers/hid/Kconfig
> @@ -305,6 +305,7 @@ config HID_MULTITOUCH
> =A0 =A0 =A0 =A0 =A0- 3M PCT touch screens
> =A0 =A0 =A0 =A0 =A0- ActionStar dual touch panels
> =A0 =A0 =A0 =A0 =A0- Cando dual touch panels
> + =A0 =A0 =A0 =A0 - Chunghwa panels
> =A0 =A0 =A0 =A0 =A0- CVTouch panels
> =A0 =A0 =A0 =A0 =A0- Cypress TrueTouch panels
> =A0 =A0 =A0 =A0 =A0- Elo TouchSystems IntelliTouch Plus panels
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index c957c4b..f7440e8 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -1359,6 +1359,7 @@ static const struct hid_device_id
> hid_have_special_driver[] =3D {
> =A0 =A0 =A0 =A0{ HID_USB_DEVICE(USB_VENDOR_ID_CHERRY,
> USB_DEVICE_ID_CHERRY_CYMOTION_SOLAR) },
> =A0 =A0 =A0 =A0{ HID_USB_DEVICE(USB_VENDOR_ID_CHICONY,
> USB_DEVICE_ID_CHICONY_TACTICAL_PAD) },
> =A0 =A0 =A0 =A0{ HID_USB_DEVICE(USB_VENDOR_ID_CHICONY,
> USB_DEVICE_ID_CHICONY_WIRELESS) },
> + =A0 =A0 =A0 { HID_USB_DEVICE(USB_VENDOR_ID_CHUNGHWAT,
> USB_DEVICE_ID_CHUNGHWAT_MULTITOUCH) },
> =A0 =A0 =A0 =A0{ HID_USB_DEVICE(USB_VENDOR_ID_CREATIVELABS,
> USB_DEVICE_ID_PRODIKEYS_PCMIDI) },
> =A0 =A0 =A0 =A0{ HID_USB_DEVICE(USB_VENDOR_ID_CVTOUCH, USB_DEVICE_ID_=
CVTOUCH_SCREEN) },
> =A0 =A0 =A0 =A0{ HID_USB_DEVICE(USB_VENDOR_ID_CYPRESS,
> USB_DEVICE_ID_CYPRESS_BARCODE_1) },
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index 0b374a6..82be975 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -173,6 +173,9 @@
> =A0#define USB_DEVICE_ID_CHICONY_MULTI_TOUCH =A0 =A0 =A00xb19d
> =A0#define USB_DEVICE_ID_CHICONY_WIRELESS 0x0618
>
> +#define USB_VENDOR_ID_CHUNGHWAT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x224=
7
> +#define USB_DEVICE_ID_CHUNGHWAT_MULTITOUCH =A0 =A0 0x0001
> +
> =A0#define USB_VENDOR_ID_CIDC =A0 =A0 =A0 =A0 =A0 =A0 0x1677
>
> =A0#define USB_VENDOR_ID_CMEDIA =A0 =A0 =A0 =A0 =A0 0x0d8c
> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouc=
h.c
> index ecd4d2d..8bc32a0 100644
> --- a/drivers/hid/hid-multitouch.c
> +++ b/drivers/hid/hid-multitouch.c
> @@ -593,6 +593,11 @@ static const struct hid_device_id mt_devices[] =3D=
 {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0HID_USB_DEVICE(USB_VENDOR_ID_CANDO,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0USB_DEVICE_ID_CANDO_MU=
LTI_TOUCH_15_6) },
>
> + =A0 =A0 =A0 /* Chunghwa Telecom touch panels */
> + =A0 =A0 =A0 { =A0.driver_data =3D MT_CLS_DEFAULT,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 HID_USB_DEVICE(USB_VENDOR_ID_CHUNGHWAT,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 USB_DEVICE_ID_CHUNGHWAT=
_MULTITOUCH) },
> +
> =A0 =A0 =A0 =A0/* CVTouch panels */
> =A0 =A0 =A0 =A0{ .driver_data =3D MT_CLS_DEFAULT,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0HID_USB_DEVICE(USB_VENDOR_ID_CVTOUCH,
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
