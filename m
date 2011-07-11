From: Benjamin Tissoires <benjamin.tissoires@enac.fr>
Subject: Re: [PATCH] hid-multitouch driver: add one new hid multitouch
 device's VID/PID
Date: Mon, 11 Jul 2011 08:51:41 +0200
Message-ID: <CAN+gG=EUD+y1sUSvKT45zqQWXSUiEtxfMc21ip5um=D=psA9-w@mail.gmail.com>
References: <1310362809-15273-1-git-send-email-ravishankarkm32@gmail.com>
	<C3F4720C7083254FAB01F1C177F02212098A1B@exsvr1.accupoint.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:53180 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756588Ab1GKGvm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 11 Jul 2011 02:51:42 -0400
In-Reply-To: <C3F4720C7083254FAB01F1C177F02212098A1B@exsvr1.accupoint.com.tw>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Ice.Chien" <ice.chien@accupoint.com.tw>
Cc: linux-kernel@vger.kernel.org, Jonson Wu <jonson.wu@accupoint.com.tw>, linux-input <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, =?ISO-8859-1?Q?St=E9phane_Chatty?= <chatty@enac.fr>

Hi,

adding in CC the input list and the maintainers ;-)

Though the patch is clean (except that you should replace spaces by
tabs of 8 chars, I will mention it inlined in the patch), don't you
want to also add your device to the hid-multitouch driver?
If it's the case (we can still add it from the user space, but it will
not work out of the box for everybody), please also add it to
hid-multitouch and to the HID_MULTITOUCH section in the Kconfig  file.

Thanks for the work.

On Mon, Jul 11, 2011 at 07:59, Ice.Chien <ice.chien@accupoint.com.tw> w=
rote:
> This is a patch to add one hid multitouch device's VID/PID in hid-ids=
=2Eh
> and hid-core.c
>
> Signed-off-by: Ice Chien <ice.chien@accupoint.com.tw>
> ---
> diff -u ./linux-2.6.39.3/drivers/hid//hid-core.c
> ./modified/drivers/hid//hid-core.c
> --- ./linux-2.6.39.3/drivers/hid//hid-core.c =A0 =A02011-07-09
> 14:16:06.000000000 +0800
> +++ ./modified/drivers/hid//hid-core.c =A02011-07-11 13:36:07.7849579=
08
> +0800
> @@ -1482,6 +1482,7 @@
> =A0 =A0 =A0 =A0{ HID_USB_DEVICE(USB_VENDOR_ID_WALTOP,
> USB_DEVICE_ID_WALTOP_SLIM_TABLET_12_1_INCH) },
> =A0 =A0 =A0 =A0{ HID_USB_DEVICE(USB_VENDOR_ID_WALTOP,
> USB_DEVICE_ID_WALTOP_MEDIA_TABLET_10_6_INCH) },
> =A0 =A0 =A0 =A0{ HID_USB_DEVICE(USB_VENDOR_ID_WALTOP,
> USB_DEVICE_ID_WALTOP_MEDIA_TABLET_14_1_INCH) },
> + =A0 =A0 =A0 { HID_USB_DEVICE(USB_VENDOR_ID_XAT, USB_DEVICE_ID_XAT_C=
SR) },

replace leading spaces by tabs here

> =A0 =A0 =A0 =A0{ HID_USB_DEVICE(USB_VENDOR_ID_ZEROPLUS, 0x0005) },
> =A0 =A0 =A0 =A0{ HID_USB_DEVICE(USB_VENDOR_ID_ZEROPLUS, 0x0030) },
> =A0 =A0 =A0 =A0{ HID_USB_DEVICE(USB_VENDOR_ID_ZYDACRON,
> USB_DEVICE_ID_ZYDACRON_REMOTE_CONTROL) },
> diff -u ./linux-2.6.39.3/drivers/hid//hid-ids.h
> ./modified/drivers/hid//hid-ids.h
> --- ./linux-2.6.39.3/drivers/hid//hid-ids.h =A0 =A0 2011-07-09
> 14:16:06.000000000 +0800
> +++ ./modified/drivers/hid//hid-ids.h =A0 2011-07-11 13:36:05.9698659=
71
> +0800
> @@ -607,6 +607,9 @@
> =A0#define USB_VENDOR_ID_WISEGROUP_LTD2 =A0 0x6677
> =A0#define USB_DEVICE_ID_SMARTJOY_DUAL_PLUS 0x8802
>
> +#define USB_VENDOR_ID_XAT =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x2505

replace spaces by tabs

> +#define USB_DEVICE_ID_XAT_CSR =A0 =A0 =A0 =A0 =A0 0x0220

again ;-)

Cheers,
Benjamin

> +
> =A0#define USB_VENDOR_ID_YEALINK =A0 =A0 =A0 =A0 =A00x6993
> =A0#define USB_DEVICE_ID_YEALINK_P1K_P4K_B2K =A0 =A0 =A00xb001
>
> Common subdirectories: ./linux-2.6.39.3/drivers/hid//usbhid and
> ./modified/drivers/hid//usbhid
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
