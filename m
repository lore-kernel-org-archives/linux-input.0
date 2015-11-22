From: =?UTF-8?q?Adrien=20Verg=C3=A9?= <adrienverge-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] USB: quirks: Fix another ELAN touchscreen
Date: Sat, 21 Nov 2015 20:06:04 -0800
Message-ID: <1448165164-11398-1-git-send-email-adrienverge@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jiri Kosina <jikos-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Macpaul Lin <macpaul-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Vincent Palatin <vpalatin-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Logan Gunthorpe <logang-OTvnGxWRz7hWk0Htik3J/w@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, =?UTF-8?q?Adrien=20Verg=C3=A9?= <adrienverge-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Yao-Wen Mao <yaowen-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Like other buggy models that had their fixes [1], the touchscreen with
id 04f3:21b8 from ELAN Microelectronics needs the device-qualifier
quirk. Otherwise, it fails to respond, blocks the boot for a random
amount of time and pollutes dmesg with:

[ 2887.373196] usb 1-5: new full-speed USB device number 41 using xhci_=
hcd
[ 2889.502000] usb 1-5: unable to read config index 0 descriptor/start:=
 -71
[ 2889.502005] usb 1-5: can't read configurations, error -71
[ 2889.654571] usb 1-5: new full-speed USB device number 42 using xhci_=
hcd
[ 2891.783438] usb 1-5: unable to read config index 0 descriptor/start:=
 -71
[ 2891.783443] usb 1-5: can't read configurations, error -71

[1]: See commits c68929f, 876af5d, d749947, a32c99e and dc703ec.

Tested-by: Adrien Verg=C3=A9 <adrienverge-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/hid/hid-ids.h           | 1 +
 drivers/hid/usbhid/hid-quirks.c | 1 +
 drivers/usb/core/quirks.c       | 3 +++
 3 files changed, 5 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index ac1feea..6b68408 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -321,6 +321,7 @@
 #define USB_DEVICE_ID_ELAN_TOUCHSCREEN_0103	0x0103
 #define USB_DEVICE_ID_ELAN_TOUCHSCREEN_010c	0x010c
 #define USB_DEVICE_ID_ELAN_TOUCHSCREEN_016F	0x016f
+#define USB_DEVICE_ID_ELAN_TOUCHSCREEN_21B8	0x21b8
=20
 #define USB_VENDOR_ID_ELECOM		0x056e
 #define USB_DEVICE_ID_ELECOM_BM084	0x0061
diff --git a/drivers/hid/usbhid/hid-quirks.c b/drivers/hid/usbhid/hid-q=
uirks.c
index 94bb137..7a45942 100644
--- a/drivers/hid/usbhid/hid-quirks.c
+++ b/drivers/hid/usbhid/hid-quirks.c
@@ -77,6 +77,7 @@ static const struct hid_blacklist {
 	{ USB_VENDOR_ID_ELAN, USB_DEVICE_ID_ELAN_TOUCHSCREEN_0103, HID_QUIRK_=
ALWAYS_POLL },
 	{ USB_VENDOR_ID_ELAN, USB_DEVICE_ID_ELAN_TOUCHSCREEN_010c, HID_QUIRK_=
ALWAYS_POLL },
 	{ USB_VENDOR_ID_ELAN, USB_DEVICE_ID_ELAN_TOUCHSCREEN_016F, HID_QUIRK_=
ALWAYS_POLL },
+	{ USB_VENDOR_ID_ELAN, USB_DEVICE_ID_ELAN_TOUCHSCREEN_21B8, HID_QUIRK_=
ALWAYS_POLL },
 	{ USB_VENDOR_ID_ELO, USB_DEVICE_ID_ELO_TS2700, HID_QUIRK_NOGET },
 	{ USB_VENDOR_ID_FORMOSA, USB_DEVICE_ID_FORMOSA_IR_RECEIVER, HID_QUIRK=
_NO_INIT_REPORTS },
 	{ USB_VENDOR_ID_FREESCALE, USB_DEVICE_ID_FREESCALE_MX28, HID_QUIRK_NO=
GET },
diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
index f5a3819..fcd6ac0 100644
--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -125,6 +125,9 @@ static const struct usb_device_id usb_quirk_list[] =
=3D {
 	{ USB_DEVICE(0x04f3, 0x016f), .driver_info =3D
 			USB_QUIRK_DEVICE_QUALIFIER },
=20
+	{ USB_DEVICE(0x04f3, 0x21b8), .driver_info =3D
+			USB_QUIRK_DEVICE_QUALIFIER },
+
 	/* Roland SC-8820 */
 	{ USB_DEVICE(0x0582, 0x0007), .driver_info =3D USB_QUIRK_RESET_RESUME=
 },
=20
--=20
2.4.3

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
