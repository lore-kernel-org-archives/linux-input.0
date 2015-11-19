From: Simon Wood <simon@mungewell.org>
Subject: [Patch-V3 1/6] INPUT: xpad: switch Logitech G920 Wheel into HID mode
Date: Thu, 19 Nov 2015 16:42:10 -0700
Message-ID: <1447976535-2281-2-git-send-email-simon@mungewell.org>
References: <1447976535-2281-1-git-send-email-simon@mungewell.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1447976535-2281-1-git-send-email-simon@mungewell.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Edwin <Edwin@Velds.nl>, =?UTF-8?q?Michal=20Mal=C3=BD?= <madcatxster@devoid-pointer.net>, elias vanderstuyft <elias.vds@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Simon Wood <simon@mungewell.org>
List-Id: linux-input@vger.kernel.org

When plugged in the Logitech G920 wheel starts with USBID 046d:c261
and behaviors as a vendor specific class. If a 'magic' byte sequence
is sent the wheel will detach and reconnect as a HID device with the
USBID 046d:c262.

Signed-off-by: Simon Wood <simon@mungewell.org>
---
 drivers/input/joystick/xpad.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index fd4100d..338a3a4 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -93,6 +93,7 @@
 #define MAP_STICKS_TO_NULL		(1 << 2)
 #define DANCEPAD_MAP_CONFIG	(MAP_DPAD_TO_BUTTONS |			\
 				MAP_TRIGGERS_TO_BUTTONS | MAP_STICKS_TO_NULL)
+#define SWITCH_G920_TO_HID_MODE		(1 << 3)
 
 #define XTYPE_XBOX        0
 #define XTYPE_XBOX360     1
@@ -134,6 +135,7 @@ static const struct xpad_device {
 	{ 0x046d, 0xc21e, "Logitech Gamepad F510", 0, XTYPE_XBOX360 },
 	{ 0x046d, 0xc21f, "Logitech Gamepad F710", 0, XTYPE_XBOX360 },
 	{ 0x046d, 0xc242, "Logitech Chillstream Controller", 0, XTYPE_XBOX360 },
+	{ 0x046d, 0xc261, "Logitech G920 Driving Force Racing Wheel", SWITCH_G920_TO_HID_MODE, XTYPE_XBOXONE },
 	{ 0x046d, 0xca84, "Logitech Xbox Cordless Controller", 0, XTYPE_XBOX },
 	{ 0x046d, 0xca88, "Logitech Compact Controller for Xbox", 0, XTYPE_XBOX },
 	{ 0x05fd, 0x1007, "Mad Catz Controller (unverified)", 0, XTYPE_XBOX },
@@ -299,6 +301,7 @@ static struct usb_device_id xpad_table[] = {
 	XPAD_XBOX360_VENDOR(0x045e),		/* Microsoft X-Box 360 controllers */
 	XPAD_XBOXONE_VENDOR(0x045e),		/* Microsoft X-Box One controllers */
 	XPAD_XBOX360_VENDOR(0x046d),		/* Logitech X-Box 360 style controllers */
+	XPAD_XBOXONE_VENDOR(0x046d),		/* Logitech X-Box One style controllers */
 	XPAD_XBOX360_VENDOR(0x0738),		/* Mad Catz X-Box 360 controllers */
 	{ USB_DEVICE(0x0738, 0x4540) },		/* Mad Catz Beat Pad */
 	XPAD_XBOX360_VENDOR(0x0e6f),		/* 0x0e6f X-Box 360 controllers */
@@ -1048,6 +1051,19 @@ static int xpad_open(struct input_dev *dev)
 	if (usb_submit_urb(xpad->irq_in, GFP_KERNEL))
 		return -EIO;
 
+	/* Logitect G920 wheel starts in XBOX mode, but is reconfigured to be HID  */
+	/* device with USBID of 046D:C262. Wheel will detach when 'magic' is sent. */
+	if (xpad->mapping & SWITCH_G920_TO_HID_MODE) {
+		xpad->odata[0] = 0x0F;
+		xpad->odata[1] = 0x00;
+		xpad->odata[2] = 0x01;
+		xpad->odata[3] = 0x01;
+		xpad->odata[4] = 0x42;
+		xpad->irq_out->transfer_buffer_length = 5;
+
+		return usb_submit_urb(xpad->irq_out, GFP_KERNEL);
+	}
+
 	if (xpad->xtype == XTYPE_XBOXONE) {
 		/* Xbox one controller needs to be initialized. */
 		xpad->odata[0] = 0x05;
-- 
2.1.4
