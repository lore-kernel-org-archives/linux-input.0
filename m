From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: Trouble with an HP stylus
Date: Tue, 29 Jul 2014 11:50:54 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1407291147190.16390@pobox.suse.cz>
References: <2325454.r4RE9vHMoF@romarin>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:41024 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751587AbaG2Ju4 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 29 Jul 2014 05:50:56 -0400
In-Reply-To: <2325454.r4RE9vHMoF@romarin>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-15?Q?=C9ric_Brunet?= <Eric.Brunet@lps.ens.fr>
Cc: linux-input@vger.kernel.org

On Thu, 24 Jul 2014, =C3=89ric Brunet wrote:

> I have a HP EliteBook Revolve 810 (which is a hybrid laptop/tablet) w=
ith
> the HP active pen that goes with it. I have installed fedora 20 (kern=
el
> 3.15.6-200.fc20.x86_64) on this, and the pen does not work out of the=
 box.
> Playing with evtest, it appears that the kernel reports the X coordin=
ate in
> ABS_X and in ABS_Y, while the Y coordinate goes into ABS_Z and ABS_RX=
; here
> are a few lines of output:
>=20
> Event: time 1406153996.865044, -------------- SYN_REPORT ------------
> Event: time 1406153996.873047, type 3 (EV_ABS), code 0 (ABS_X), value=
 1087
> Event: time 1406153996.873047, type 3 (EV_ABS), code 1 (ABS_Y), value=
 1087
> Event: time 1406153996.873047, type 3 (EV_ABS), code 2 (ABS_Z), value=
 1599
> Event: time 1406153996.873047, type 3 (EV_ABS), code 3 (ABS_RX), valu=
e 1599
>=20
> Of course, XOrg's evdev driver is confused and the pointer is stuck o=
n the
> diagonal X=3DY.
>=20
> I guess this hardware needs a new quirk to usbhid, unless there is al=
ready
> a way to correct it ?
>=20
> Here is the content of /sys/class/input/event8/device/uevent:
>=20
> PRODUCT=3D3/3eb/840b/111
> NAME=3D"Atmel Atmel maXTouch Digitizer Pen"
> PHYS=3D"usb-0000:00:1a.0-1.1/input0"
> UNIQ=3D""
> PROP=3D0
> EV=3D1b
> KEY=3Dc01 1 0 0 0 0
> ABS=3D100000f
> MSC=3D10
> MODALIAS=3Dinput:b0003v03EBp840Be0111-
> e0,1,3,4,k100,140,14A,14B,ra0,1,2,3,18,m4,lsfw
>=20
> I hope I gave enough information on this. I don't read the mailing li=
st,
> please CC any answer.

Does the patch below fix the problem for you please?






diff --git a/drivers/hid/usbhid/hid-quirks.c b/drivers/hid/usbhid/hid-q=
uirks.c
index 31e6727..d48574d 100644
--- a/drivers/hid/usbhid/hid-quirks.c
+++ b/drivers/hid/usbhid/hid-quirks.c
@@ -97,6 +97,7 @@ static const struct hid_blacklist {
 	{ USB_VENDOR_ID_SYMBOL, USB_DEVICE_ID_SYMBOL_SCANNER_2, HID_QUIRK_NOG=
ET },
 	{ USB_VENDOR_ID_TPV, USB_DEVICE_ID_TPV_OPTICAL_TOUCHSCREEN, HID_QUIRK=
_NOGET },
 	{ USB_VENDOR_ID_TURBOX, USB_DEVICE_ID_TURBOX_KEYBOARD, HID_QUIRK_NOGE=
T },
+	{ 0x03EB, 0x840B, HID_QUIRK_MULTI_INPUT },
 	{ USB_VENDOR_ID_UCLOGIC, USB_DEVICE_ID_UCLOGIC_TABLET_PF1209, HID_QUI=
RK_MULTI_INPUT },
 	{ USB_VENDOR_ID_UCLOGIC, USB_DEVICE_ID_UCLOGIC_TABLET_WP4030U, HID_QU=
IRK_MULTI_INPUT },
 	{ USB_VENDOR_ID_UCLOGIC, USB_DEVICE_ID_UCLOGIC_TABLET_KNA5, HID_QUIRK=
_MULTI_INPUT },

--=20
Jiri Kosina
SUSE Labs
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
