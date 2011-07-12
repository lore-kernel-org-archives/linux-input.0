From: "Ice.Chien" <ice.chien@accupoint.com.tw>
Subject: RE: [PATCH] hid-multitouch driver: add one new hid multitouch device's VID/PID
Date: Tue, 12 Jul 2011 10:46:14 +0800
Message-ID: <C3F4720C7083254FAB01F1C177F02212098A3A@exsvr1.accupoint.com.tw>
References: <1310362809-15273-1-git-send-email-ravishankarkm32@gmail.com><C3F4720C7083254FAB01F1C177F02212098A1B@exsvr1.accupoint.com.tw> <CAN+gG=EUD+y1sUSvKT45zqQWXSUiEtxfMc21ip5um=D=psA9-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-class: urn:content-classes:message
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@enac.fr>
Cc: linux-kernel@vger.kernel.org, Jonson Wu <jonson.wu@accupoint.com.tw>, linux-input <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, =?ISO-8859-1?Q?St=E9phane_Chatty?= <chatty@enac.fr>
List-Id: linux-input@vger.kernel.org

Hi Benjamin,

This is a patch to add one hid multitouch device's VID/PID in hid-core.=
c, hid-ids.h, hid-multitouch.c and Kconfig.
Please review if I make the correct change
Thanks.

Signed-off-by: Ice Chien <ice.chien@accupoint.com.tw>
---
diff	-u	./linux-2.6.39.3/drivers/hid//hid-core.c	./modified/drivers/hid=
//hid-core.c
---	./linux-2.6.39.3/drivers/hid//hid-core.c	2011-07-09 14:16:06.000000=
000	+0800
+++	./modified/drivers/hid//hid-core.c	2011-07-11 13:36:07.784957908	+0=
800
@@	-1482,6	+1482,7	@@
 	{	HID_USB_DEVICE(USB_VENDOR_ID_WALTOP,	USB_DEVICE_ID_WALTOP_SLIM_TABL=
ET_12_1_INCH)	},
 	{	HID_USB_DEVICE(USB_VENDOR_ID_WALTOP,	USB_DEVICE_ID_WALTOP_MEDIA_TAB=
LET_10_6_INCH)	},
 	{	HID_USB_DEVICE(USB_VENDOR_ID_WALTOP,	USB_DEVICE_ID_WALTOP_MEDIA_TAB=
LET_14_1_INCH)	},
+	{	HID_USB_DEVICE(USB_VENDOR_ID_XAT,	USB_DEVICE_ID_XAT_CSR)	},
 	{	HID_USB_DEVICE(USB_VENDOR_ID_ZEROPLUS,	0x0005)	},
 	{	HID_USB_DEVICE(USB_VENDOR_ID_ZEROPLUS,	0x0030)	},
 	{	HID_USB_DEVICE(USB_VENDOR_ID_ZYDACRON,	USB_DEVICE_ID_ZYDACRON_REMOT=
E_CONTROL)	},
Diff	-u	./linux-2.6.39.3/drivers/hid//hid-ids.h	./modified/drivers/hid/=
/hid-ids.h
---	./linux-2.6.39.3/drivers/hid//hid-ids.h	2011-07-09 14:16:06.0000000=
00	+0800
+++	./modified/drivers/hid//hid-ids.h	2011-07-11 13:36:05.969865971	+08=
00
@@	-607,6	+607,9	@@
 #define	USB_VENDOR_ID_WISEGROUP_LTD2	0x6677
 #define	USB_DEVICE_ID_SMARTJOY_DUAL_PLUS	0x8802
=20
+#define	USB_VENDOR_ID_XAT	0x2505
+#define	USB_DEVICE_ID_XAT_CSR	0x0220
+
 #define	USB_VENDOR_ID_YEALINK	0x6993
 #define	USB_DEVICE_ID_YEALINK_P1K_P4K_B2K	0xb001
=20
Diff	-u	./linux-2.6.39.3/drivers/hid//hid-multitouch.c	./modified/drive=
rs/hid//hid-multitouch.c
---	./linux-2.6.39.3/drivers/hid//hid-multitouch.c	2011-07-09 14:16:06.=
000000000	+0800
+++	./modified/drivers/hid//hid-multitouch.c	2011-07-12 10:07:46.505165=
622	+0800
@@	-487,6	+487,10	@@
 }
=20
 Static	const	struct	hid_device_id mt_devices[]	=3D	{
+	/* XAT */
+	{	.driver_data	=3D	MT_CLS_DEFAULT,
+	HID_USB_DEVICE(USB_VENDOR_ID_XAT,
+	USB_DEVICE_ID_XAT_CSR) },
=20
 	/* Cypress panel */
 	{	.driver_data	=3D	MT_CLS_CYPRESS,
Diff	-u	./linux-2.6.39.3/drivers/hid//Kconfig	./modified/drivers/hid//K=
config
---	./linux-2.6.39.3/drivers/hid//Kconfig	2011-07-09	14:16:06.000000000=
	+0800
+++	./modified/drivers/hid//Kconfig	2011-07-12	10:08:33.617597671	+0800
@@	-327,6 +327,7	@@
	- 'Sensing Win7-TwoFinger' panel by GeneralTouch
	- eGalax dual-touch panels, including the
	Joojoo and Wetab tablets
+	- XAT optical touch panels
=20
	If unsure, say N.
=20
Common subdirectories: ./linux-2.6.39.3/drivers/hid//usbhid and ./modif=
ied/drivers/hid//usbhid

-----Original Message-----
=46rom: benjamin.tissoires@gmail.com [mailto:benjamin.tissoires@gmail.c=
om] On Behalf Of Benjamin Tissoires
Sent: Monday, July 11, 2011 2:52 PM
To: Ice.Chien
Cc: linux-kernel@vger.kernel.org; Jonson Wu; linux-input; Jiri Kosina; =
Dmitry Torokhov; Henrik Rydberg; St=E9phane Chatty
Subject: Re: [PATCH] hid-multitouch driver: add one new hid multitouch =
device's VID/PID

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
