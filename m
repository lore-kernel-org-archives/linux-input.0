From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: [PATCH] USBHID: add NOGET quirk for devices from CH Products
Date: Wed, 6 May 2009 15:48:49 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0905061543290.4430-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
Cc: Sean Hildebrand <silverwraithii-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sid Boyce <sboyce-QgLWrMLu8clzjhtm8Ag3mw@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, stable-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: linux-input@vger.kernel.org

This patch (as1240) adds the NOGET quirk for three devices from CH
Products: the Pro pedals, the Combatstick joystick, and the Flight-Sim
yoke.  Without these quirks, the devices haven't worked for many
kernel releases.  Sometimes replugging them after boot-up would get
them to work and sometimes they wouldn't work at all.

Signed-off-by: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Reported-by: Sean Hildebrand <silverwraithii-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Reported-by: Sid Boyce <sboyce-QgLWrMLu8clzjhtm8Ag3mw@public.gmane.org>
Tested-by: Sean Hildebrand <silverwraithii-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Tested-by: Sid Boyce <sboyce-QgLWrMLu8clzjhtm8Ag3mw@public.gmane.org>

---

Index: usb-2.6/drivers/hid/hid-ids.h
===================================================================
--- usb-2.6.orig/drivers/hid/hid-ids.h
+++ usb-2.6/drivers/hid/hid-ids.h
@@ -113,6 +113,11 @@
 #define USB_VENDOR_ID_BERKSHIRE		0x0c98
 #define USB_DEVICE_ID_BERKSHIRE_PCWD	0x1140
 
+#define USB_VENDOR_ID_CH		0x068e
+#define USB_DEVICE_ID_CH_PRO_PEDALS	0x00f2
+#define USB_DEVICE_ID_CH_COMBATSTICK	0x00f4
+#define USB_DEVICE_ID_CH_FLIGHT_SIM_YOKE	0x00ff
+
 #define USB_VENDOR_ID_CHERRY		0x046a
 #define USB_DEVICE_ID_CHERRY_CYMOTION	0x0023
 
Index: usb-2.6/drivers/hid/usbhid/hid-quirks.c
===================================================================
--- usb-2.6.orig/drivers/hid/usbhid/hid-quirks.c
+++ usb-2.6/drivers/hid/usbhid/hid-quirks.c
@@ -50,6 +50,9 @@ static const struct hid_blacklist {
 	{ USB_VENDOR_ID_ATEN, USB_DEVICE_ID_ATEN_2PORTKVM, HID_QUIRK_NOGET },
 	{ USB_VENDOR_ID_ATEN, USB_DEVICE_ID_ATEN_4PORTKVM, HID_QUIRK_NOGET },
 	{ USB_VENDOR_ID_ATEN, USB_DEVICE_ID_ATEN_4PORTKVMC, HID_QUIRK_NOGET },
+	{ USB_VENDOR_ID_CH, USB_DEVICE_ID_CH_COMBATSTICK, HID_QUIRK_NOGET },
+	{ USB_VENDOR_ID_CH, USB_DEVICE_ID_CH_FLIGHT_SIM_YOKE, HID_QUIRK_NOGET },
+	{ USB_VENDOR_ID_CH, USB_DEVICE_ID_CH_PRO_PEDALS, HID_QUIRK_NOGET },
 	{ USB_VENDOR_ID_DMI, USB_DEVICE_ID_DMI_ENC, HID_QUIRK_NOGET },
 	{ USB_VENDOR_ID_ELO, USB_DEVICE_ID_ELO_TS2700, HID_QUIRK_NOGET },
 	{ USB_VENDOR_ID_SUN, USB_DEVICE_ID_RARITAN_KVM_DONGLE, HID_QUIRK_NOGET },

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
