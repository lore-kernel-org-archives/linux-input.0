From: samwise <samwise-vJ/aiZqeRX8j6p08zn7w4Q@public.gmane.org>
Subject: [PATCHv1] USB HID DRIVERS: Enable HID_QUIRK_MULTI_INPUT for Retro
	Adaptor
Date: Sun, 11 Jul 2010 17:45:50 +0100
Message-ID: <AANLkTilCk7q_GsrBtxsuNGTwsQMZmUJN7O8e1G0q3fqA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Stephane Chatty <chatty-rXV5z7KbLFk@public.gmane.org>, Don Prince <dhprince-devel-/E1597aS9LT10XsdtD+oqA@public.gmane.org>, Peter Hutterer <peter.hutterer-Pf4JEFdB4epeoWH0uzbU5w@public.gmane.org>, Thadeu Lima de Souza Cascardo <cascardo-DmMZpsCg3uxeGPcbtGPokg@public.gmane.org>, Daniel Oliveira Nascimento <don-rBL4DdiBytkIdKJ7tpkyPg@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Paul Qureshi <retro-eOIbr2w7E9SsTnJN9+BGXg@public.gmane.org>
List-Id: linux-input@vger.kernel.org

From: Peter Edwards <samwise-vJ/aiZqeRX8j6p08zn7w4Q@public.gmane.org>

Patch for linux-2.6.35-rc4 mainline kernel to enable Paul Qureshi's
Retro Adapter [http://keio.dk/retroadapter.html], an open source USB
device which allows controllers and joysticks from classic computers
and consoles to work on modern PCs, to appear as two separate devices
under Linux.
Signed-off-by: Peter Edwards <samwise-vJ/aiZqeRX8j6p08zn7w4Q@public.gmane.org>
Acked-by: Paul Qureshi <retro-eOIbr2w7E9SsTnJN9+BGXg@public.gmane.org>
---

This is a first patch submission following the
Documentation/SubmittingPatches guidelines. Hope this is in the
correct format for inclusion and is directed at the correct
maintainer. Please reply if any modifications or further info is
required.

diff -uprN -X linux-2.6.35-rc4-vanilla/Documentation/dontdiff
linux-2.6.35-rc4-vanilla/drivers/hid/hid-ids.h
linux-2.6.35-rc4/drivers/hid/hid-ids.h
--- linux-2.6.35-rc4-vanilla/drivers/hid/hid-ids.h	2010-07-05
04:22:50.000000000 +0100
+++ linux-2.6.35-rc4/drivers/hid/hid-ids.h	2010-07-11 16:54:07.948153000 +0100
@@ -369,6 +369,8 @@
 #define USB_DEVICE_ID_MS_PRESENTER_8K_BT	0x0701
 #define USB_DEVICE_ID_MS_PRESENTER_8K_USB	0x0713

+#define USB_VENDOR_ID_MOJO              0x8282
+#define USB_DEVICE_ID_RETRO_ADAPTER     0x3201

 #define USB_VENDOR_ID_MONTEREY		0x0566
 #define USB_DEVICE_ID_GENIUS_KB29E	0x3004
diff -uprN -X linux-2.6.35-rc4-vanilla/Documentation/dontdiff
linux-2.6.35-rc4-vanilla/drivers/hid/usbhid/hid-quirks.c
linux-2.6.35-rc4/drivers/hid/usbhid/hid-quirks.c
--- linux-2.6.35-rc4-vanilla/drivers/hid/usbhid/hid-quirks.c	2010-07-05
04:22:50.000000000 +0100
+++ linux-2.6.35-rc4/drivers/hid/usbhid/hid-quirks.c	2010-07-11
16:55:22.028152999 +0100
@@ -37,6 +37,7 @@ static const struct hid_blacklist {
 	{ USB_VENDOR_ID_HAPP, USB_DEVICE_ID_UGCI_DRIVING, HID_QUIRK_BADPAD |
HID_QUIRK_MULTI_INPUT },
 	{ USB_VENDOR_ID_HAPP, USB_DEVICE_ID_UGCI_FLYING, HID_QUIRK_BADPAD |
HID_QUIRK_MULTI_INPUT },
 	{ USB_VENDOR_ID_HAPP, USB_DEVICE_ID_UGCI_FIGHTING, HID_QUIRK_BADPAD
| HID_QUIRK_MULTI_INPUT },
+{ USB_VENDOR_ID_MOJO, USB_DEVICE_ID_RETRO_ADAPTER, HID_QUIRK_MULTI_INPUT },
 	{ USB_VENDOR_ID_NATSU, USB_DEVICE_ID_NATSU_GAMEPAD, HID_QUIRK_BADPAD },
 	{ USB_VENDOR_ID_NEC, USB_DEVICE_ID_NEC_USB_GAME_PAD, HID_QUIRK_BADPAD },
 	{ USB_VENDOR_ID_NEXTWINDOW, USB_DEVICE_ID_NEXTWINDOW_TOUCHSCREEN,
HID_QUIRK_MULTI_INPUT},
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
