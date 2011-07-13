From: Benjamin Tissoires <benjamin.tissoires@enac.fr>
Subject: Re: [PATCH] hid-multitouch driver: add one new hid multitouch
 device's VID/PID
Date: Wed, 13 Jul 2011 21:41:15 +0200
Message-ID: <CAN+gG=FCB-8mOxEuhutGd0F3n1nQzoZcCpkNchq91Y4V7hdw9Q@mail.gmail.com>
References: <1310362809-15273-1-git-send-email-ravishankarkm32@gmail.com>
	<CAN+gG=EUD+y1sUSvKT45zqQWXSUiEtxfMc21ip5um=D=psA9-w@mail.gmail.com>
	<C3F4720C7083254FAB01F1C177F02212098A3A@exsvr1.accupoint.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:65180 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750951Ab1GMTlR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 13 Jul 2011 15:41:17 -0400
In-Reply-To: <C3F4720C7083254FAB01F1C177F02212098A3A@exsvr1.accupoint.com.tw>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Ice.Chien" <ice.chien@accupoint.com.tw>
Cc: linux-kernel@vger.kernel.org, Jonson Wu <jonson.wu@accupoint.com.tw>, linux-input <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, =?ISO-8859-1?Q?St=E9phane_Chatty?= <chatty@enac.fr>

Hi,

the patch looks good in terms of functionality. However there is still
a problem in the format introduced by your mail client.
As mentioned by Jiri, you'll find some answers in the file
Documentation/email-clients.txt at the root of the kernel tree (or
directly at http://git.kernel.org/?p=3Dlinux/kernel/git/next/linux-next=
=2Egit;a=3Dblob_plain;f=3DDocumentation/email-clients.txt;hb=3DHEAD).
Basically copy/paste usually doesn't work.

If you still have problem in formatting the mail, you can also send me
the patch in private and I'll send it for you.

Cheers,
Benjamin

On Tue, Jul 12, 2011 at 04:46, Ice.Chien <ice.chien@accupoint.com.tw> w=
rote:
> Hi Benjamin,
>
> This is a patch to add one hid multitouch device's VID/PID in hid-cor=
e.c, hid-ids.h, hid-multitouch.c and Kconfig.
> Please review if I make the correct change
> Thanks.
>
> Signed-off-by: Ice Chien <ice.chien@accupoint.com.tw>
> ---
> diff =A0 =A0-u =A0 =A0 =A0./linux-2.6.39.3/drivers/hid//hid-core.c =A0=
 =A0 =A0 =A0./modified/drivers/hid//hid-core.c
> --- =A0 =A0 ./linux-2.6.39.3/drivers/hid//hid-core.c =A0 =A0 =A0 =A02=
011-07-09 14:16:06.000000000 =A0 +0800
> +++ =A0 =A0 ./modified/drivers/hid//hid-core.c =A0 =A0 =A02011-07-11 =
13:36:07.784957908 =A0 +0800
> @@ =A0 =A0 =A0-1482,6 +1482,7 @@
> =A0 =A0 =A0 =A0{ =A0 =A0 =A0 HID_USB_DEVICE(USB_VENDOR_ID_WALTOP, =A0=
 =A0USB_DEVICE_ID_WALTOP_SLIM_TABLET_12_1_INCH) =A0 =A0 },
> =A0 =A0 =A0 =A0{ =A0 =A0 =A0 HID_USB_DEVICE(USB_VENDOR_ID_WALTOP, =A0=
 =A0USB_DEVICE_ID_WALTOP_MEDIA_TABLET_10_6_INCH) =A0 =A0},
> =A0 =A0 =A0 =A0{ =A0 =A0 =A0 HID_USB_DEVICE(USB_VENDOR_ID_WALTOP, =A0=
 =A0USB_DEVICE_ID_WALTOP_MEDIA_TABLET_14_1_INCH) =A0 =A0},
> + =A0 =A0 =A0 { =A0 =A0 =A0 HID_USB_DEVICE(USB_VENDOR_ID_XAT, =A0 =A0=
 =A0 USB_DEVICE_ID_XAT_CSR) =A0},
> =A0 =A0 =A0 =A0{ =A0 =A0 =A0 HID_USB_DEVICE(USB_VENDOR_ID_ZEROPLUS, =A0=
0x0005) },
> =A0 =A0 =A0 =A0{ =A0 =A0 =A0 HID_USB_DEVICE(USB_VENDOR_ID_ZEROPLUS, =A0=
0x0030) },
> =A0 =A0 =A0 =A0{ =A0 =A0 =A0 HID_USB_DEVICE(USB_VENDOR_ID_ZYDACRON, =A0=
USB_DEVICE_ID_ZYDACRON_REMOTE_CONTROL) =A0},
> Diff =A0 =A0-u =A0 =A0 =A0./linux-2.6.39.3/drivers/hid//hid-ids.h ./m=
odified/drivers/hid//hid-ids.h
> --- =A0 =A0 ./linux-2.6.39.3/drivers/hid//hid-ids.h 2011-07-09 14:16:=
06.000000000 =A0 +0800
> +++ =A0 =A0 ./modified/drivers/hid//hid-ids.h =A0 =A0 =A0 2011-07-11 =
13:36:05.969865971 =A0 +0800
> @@ =A0 =A0 =A0-607,6 =A0+607,9 =A0@@
> =A0#define =A0 =A0 =A0 =A0USB_VENDOR_ID_WISEGROUP_LTD2 =A0 =A00x6677
> =A0#define =A0 =A0 =A0 =A0USB_DEVICE_ID_SMARTJOY_DUAL_PLUS =A0 =A0 =A0=
 =A00x8802
>
> +#define =A0 =A0 =A0 =A0USB_VENDOR_ID_XAT =A0 =A0 =A0 0x2505
> +#define =A0 =A0 =A0 =A0USB_DEVICE_ID_XAT_CSR =A0 0x0220
> +
> =A0#define =A0 =A0 =A0 =A0USB_VENDOR_ID_YEALINK =A0 0x6993
> =A0#define =A0 =A0 =A0 =A0USB_DEVICE_ID_YEALINK_P1K_P4K_B2K =A0 =A0 =A0=
 0xb001
>
> Diff =A0 =A0-u =A0 =A0 =A0./linux-2.6.39.3/drivers/hid//hid-multitouc=
h.c =A0./modified/drivers/hid//hid-multitouch.c
> --- =A0 =A0 ./linux-2.6.39.3/drivers/hid//hid-multitouch.c =A02011-07=
-09 14:16:06.000000000 =A0 +0800
> +++ =A0 =A0 ./modified/drivers/hid//hid-multitouch.c =A0 =A0 =A0 =A02=
011-07-12 10:07:46.505165622 =A0 +0800
> @@ =A0 =A0 =A0-487,6 =A0+487,10 @@
> =A0}
>
> =A0Static const =A0 struct =A0hid_device_id mt_devices[] =A0 =A0 =A0=3D=
 =A0 =A0 =A0 {
> + =A0 =A0 =A0 /* XAT */
> + =A0 =A0 =A0 { =A0 =A0 =A0 .driver_data =A0 =A0=3D =A0 =A0 =A0 MT_CL=
S_DEFAULT,
> + =A0 =A0 =A0 HID_USB_DEVICE(USB_VENDOR_ID_XAT,
> + =A0 =A0 =A0 USB_DEVICE_ID_XAT_CSR) },
>
> =A0 =A0 =A0 =A0/* Cypress panel */
> =A0 =A0 =A0 =A0{ =A0 =A0 =A0 .driver_data =A0 =A0=3D =A0 =A0 =A0 MT_C=
LS_CYPRESS,
> Diff =A0 =A0-u =A0 =A0 =A0./linux-2.6.39.3/drivers/hid//Kconfig =A0 .=
/modified/drivers/hid//Kconfig
> --- =A0 =A0 ./linux-2.6.39.3/drivers/hid//Kconfig =A0 2011-07-09 =A0 =
=A0 =A014:16:06.000000000 =A0 =A0 =A0+0800
> +++ =A0 =A0 ./modified/drivers/hid//Kconfig 2011-07-12 =A0 =A0 =A010:=
08:33.617597671 =A0 =A0 =A0+0800
> @@ =A0 =A0 =A0-327,6 +327,7 =A0 @@
> =A0 =A0 =A0 =A0- 'Sensing Win7-TwoFinger' panel by GeneralTouch
> =A0 =A0 =A0 =A0- eGalax dual-touch panels, including the
> =A0 =A0 =A0 =A0Joojoo and Wetab tablets
> + =A0 =A0 =A0 - XAT optical touch panels
>
> =A0 =A0 =A0 =A0If unsure, say N.
>
> Common subdirectories: ./linux-2.6.39.3/drivers/hid//usbhid and ./mod=
ified/drivers/hid//usbhid
>
> -----Original Message-----
> From: benjamin.tissoires@gmail.com [mailto:benjamin.tissoires@gmail.c=
om] On Behalf Of Benjamin Tissoires
> Sent: Monday, July 11, 2011 2:52 PM
> To: Ice.Chien
> Cc: linux-kernel@vger.kernel.org; Jonson Wu; linux-input; Jiri Kosina=
; Dmitry Torokhov; Henrik Rydberg; St=E9phane Chatty
> Subject: Re: [PATCH] hid-multitouch driver: add one new hid multitouc=
h device's VID/PID
>
> Hi,
>
> adding in CC the input list and the maintainers ;-)
>
> Though the patch is clean (except that you should replace spaces by
> tabs of 8 chars, I will mention it inlined in the patch), don't you
> want to also add your device to the hid-multitouch driver?
> If it's the case (we can still add it from the user space, but it wil=
l
> not work out of the box for everybody), please also add it to
> hid-multitouch and to the HID_MULTITOUCH section in the Kconfig =A0fi=
le.
>
> Thanks for the work.
>
> On Mon, Jul 11, 2011 at 07:59, Ice.Chien <ice.chien@accupoint.com.tw>=
 wrote:
>> This is a patch to add one hid multitouch device's VID/PID in hid-id=
s.h
>> and hid-core.c
>>
>> Signed-off-by: Ice Chien <ice.chien@accupoint.com.tw>
>> ---
>> diff -u ./linux-2.6.39.3/drivers/hid//hid-core.c
>> ./modified/drivers/hid//hid-core.c
>> --- ./linux-2.6.39.3/drivers/hid//hid-core.c =A0 =A02011-07-09
>> 14:16:06.000000000 +0800
>> +++ ./modified/drivers/hid//hid-core.c =A02011-07-11 13:36:07.784957=
908
>> +0800
>> @@ -1482,6 +1482,7 @@
>> =A0 =A0 =A0 =A0{ HID_USB_DEVICE(USB_VENDOR_ID_WALTOP,
>> USB_DEVICE_ID_WALTOP_SLIM_TABLET_12_1_INCH) },
>> =A0 =A0 =A0 =A0{ HID_USB_DEVICE(USB_VENDOR_ID_WALTOP,
>> USB_DEVICE_ID_WALTOP_MEDIA_TABLET_10_6_INCH) },
>> =A0 =A0 =A0 =A0{ HID_USB_DEVICE(USB_VENDOR_ID_WALTOP,
>> USB_DEVICE_ID_WALTOP_MEDIA_TABLET_14_1_INCH) },
>> + =A0 =A0 =A0 { HID_USB_DEVICE(USB_VENDOR_ID_XAT, USB_DEVICE_ID_XAT_=
CSR) },
>
> replace leading spaces by tabs here
>
>> =A0 =A0 =A0 =A0{ HID_USB_DEVICE(USB_VENDOR_ID_ZEROPLUS, 0x0005) },
>> =A0 =A0 =A0 =A0{ HID_USB_DEVICE(USB_VENDOR_ID_ZEROPLUS, 0x0030) },
>> =A0 =A0 =A0 =A0{ HID_USB_DEVICE(USB_VENDOR_ID_ZYDACRON,
>> USB_DEVICE_ID_ZYDACRON_REMOTE_CONTROL) },
>> diff -u ./linux-2.6.39.3/drivers/hid//hid-ids.h
>> ./modified/drivers/hid//hid-ids.h
>> --- ./linux-2.6.39.3/drivers/hid//hid-ids.h =A0 =A0 2011-07-09
>> 14:16:06.000000000 +0800
>> +++ ./modified/drivers/hid//hid-ids.h =A0 2011-07-11 13:36:05.969865=
971
>> +0800
>> @@ -607,6 +607,9 @@
>> =A0#define USB_VENDOR_ID_WISEGROUP_LTD2 =A0 0x6677
>> =A0#define USB_DEVICE_ID_SMARTJOY_DUAL_PLUS 0x8802
>>
>> +#define USB_VENDOR_ID_XAT =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x2505
>
> replace spaces by tabs
>
>> +#define USB_DEVICE_ID_XAT_CSR =A0 =A0 =A0 =A0 =A0 0x0220
>
> again ;-)
>
> Cheers,
> Benjamin
>
>> +
>> =A0#define USB_VENDOR_ID_YEALINK =A0 =A0 =A0 =A0 =A00x6993
>> =A0#define USB_DEVICE_ID_YEALINK_P1K_P4K_B2K =A0 =A0 =A00xb001
>>
>> Common subdirectories: ./linux-2.6.39.3/drivers/hid//usbhid and
>> ./modified/drivers/hid//usbhid
>>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
