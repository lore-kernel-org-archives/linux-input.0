From: Paul Collins <paul-dsjeNyW6Qm/D+ROgJ3VA+kB+6BGkLq7r@public.gmane.org>
Subject: [PATCH] fix HID quirks for aluminium apple wireless keyboards
Date: Fri, 13 Jun 2008 00:26:19 +1200
Message-ID: <87iqweltzo.fsf@burly.wgtn.ondioline.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org, jkosina-AlSwsSmVLrQ@public.gmane.org
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hi Marcel and Jiri,

I noticed that the quirks for Bluetooth Apple keyboards seem to have
been incorrectly added to the USB HID, thus rendering them ineffective.
Here is a patch that moves them to the Bluetooth HID.  With this patch
applied the Fn key on my Apple wireless keyboard now works as expected.

I also took the liberty of adding defines for the vendor and for the
existing Mighty Mouse quirk.

Signed-off-by: Paul Collins <paul-ElVlcqu8pLbNLxjTenLetw@public.gmane.org

diff --git a/drivers/hid/usbhid/hid-quirks.c b/drivers/hid/usbhid/hid-quirks.c
index 1df832a..ff41c07 100644
--- a/drivers/hid/usbhid/hid-quirks.c
+++ b/drivers/hid/usbhid/hid-quirks.c
@@ -72,9 +72,6 @@
 #define USB_DEVICE_ID_APPLE_GEYSER4_HF_ANSI    0x0229
 #define USB_DEVICE_ID_APPLE_GEYSER4_HF_ISO     0x022a
 #define USB_DEVICE_ID_APPLE_GEYSER4_HF_JIS     0x022b
-#define USB_DEVICE_ID_APPLE_ALU_WIRELESS_ANSI  0x022c
-#define USB_DEVICE_ID_APPLE_ALU_WIRELESS_ISO   0x022d
-#define USB_DEVICE_ID_APPLE_ALU_WIRELESS_JIS   0x022e
 #define USB_DEVICE_ID_APPLE_FOUNTAIN_TP_ONLY	0x030a
 #define USB_DEVICE_ID_APPLE_GEYSER1_TP_ONLY	0x030b
 #define USB_DEVICE_ID_APPLE_IRCONTROL4	0x8242
@@ -639,9 +636,6 @@ static const struct hid_blacklist {
 	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER4_HF_ANSI, HID_QUIRK_APPLE_NUMLOCK_EMULATION | HID_QUIRK_APPLE_HAS_FN | HID_QUIRK_IGNORE_MOUSE },
 	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER4_HF_ISO, HID_QUIRK_APPLE_NUMLOCK_EMULATION | HID_QUIRK_APPLE_HAS_FN | HID_QUIRK_IGNORE_MOUSE },
 	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER4_HF_JIS, HID_QUIRK_APPLE_NUMLOCK_EMULATION | HID_QUIRK_APPLE_HAS_FN | HID_QUIRK_IGNORE_MOUSE },
-	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_ALU_WIRELESS_ANSI, HID_QUIRK_APPLE_NUMLOCK_EMULATION | HID_QUIRK_APPLE_HAS_FN },
-	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_ALU_WIRELESS_ISO, HID_QUIRK_APPLE_NUMLOCK_EMULATION | HID_QUIRK_APPLE_HAS_FN | HID_QUIRK_APPLE_ISO_KEYBOARD },
-	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_ALU_WIRELESS_JIS, HID_QUIRK_APPLE_NUMLOCK_EMULATION | HID_QUIRK_APPLE_HAS_FN },
 	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_FOUNTAIN_TP_ONLY, HID_QUIRK_APPLE_NUMLOCK_EMULATION | HID_QUIRK_APPLE_HAS_FN | HID_QUIRK_IGNORE_MOUSE },
 	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER1_TP_ONLY, HID_QUIRK_APPLE_NUMLOCK_EMULATION | HID_QUIRK_APPLE_HAS_FN | HID_QUIRK_IGNORE_MOUSE },
 
diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
index 519cdb9..f0762e5 100644
--- a/net/bluetooth/hidp/core.c
+++ b/net/bluetooth/hidp/core.c
@@ -671,14 +671,26 @@ static void hidp_close(struct hid_device *hid)
 {
 }
 
+#define BT_VENDOR_ID_APPLE				0x05ac
+
+#define BT_DEVICE_ID_APPLE_ALU_WIRELESS_ANSI		0x022c
+#define BT_DEVICE_ID_APPLE_ALU_WIRELESS_ISO		0x022d
+#define BT_DEVICE_ID_APPLE_ALU_WIRELESS_JIS		0x022e
+#define BT_DEVICE_ID_APPLE_MIGHTY_MOUSE_WIRELESS	0x030c
+
 static const struct {
 	__u16 idVendor;
 	__u16 idProduct;
 	unsigned quirks;
 } hidp_blacklist[] = {
-	/* Apple wireless Mighty Mouse */
-	{ 0x05ac, 0x030c, HID_QUIRK_MIGHTYMOUSE | HID_QUIRK_INVERT_HWHEEL },
