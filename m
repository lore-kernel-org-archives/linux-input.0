From: Bastien Nocera <hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org>
Subject: [PATCH] [hid] Enable Sixaxis controller over Bluetooth as well
Date: Wed, 20 Jan 2010 12:01:53 +0000
Message-ID: <1263988913.1735.2532.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-input <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, BlueZ development <linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Jiri Kosina <jikos-wDf7oJUeT2I@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Now that hid_output_raw_report works, port the PS3 Sixaxis
Bluetooth quirk from user-space, into kernel-space.

Signed-off-by: Bastien Nocera <hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org>
---
 drivers/hid/hid-core.c |    1 +
 drivers/hid/hid-sony.c |   15 ++++++++++++++-
 2 files changed, 15 insertions(+), 1 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 3773f69..d88bebf 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1337,6 +1337,7 @@ static const struct hid_device_id hid_blacklist[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_PETALYNX, USB_DEVICE_ID_PETALYNX_MAXTER_REMOTE) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SAMSUNG, USB_DEVICE_ID_SAMSUNG_IR_REMOTE) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS3_CONTROLLER) },
+	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS3_CONTROLLER) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_VAIO_VGX_MOUSE) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SUNPLUS, USB_DEVICE_ID_SUNPLUS_WDESKTOP) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_THRUSTMASTER, 0xb300) },
diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index 96d723e..d69ac22 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -73,6 +73,12 @@ static int sony_set_operational(struct hid_device *hdev)
 	return ret;
 }
 
+static int sony_set_operational_bt(struct hid_device *hdev)
+{
+	unsigned char buf[] = { 0x53, 0xf4,  0x42, 0x03, 0x00, 0x00 };
+	return hdev->hid_output_raw_report(hdev, buf, sizeof(buf));
+}
+
 static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
 {
 	int ret;
@@ -101,7 +107,13 @@ static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		goto err_free;
 	}
 
-	ret = sony_set_operational(hdev);
+	if (hdev->bus == BUS_USB)
+		ret = sony_set_operational(hdev);
+	else if (hdev->bus == BUS_BLUETOOTH)
+		ret = sony_set_operational_bt(hdev);
+	else
+		ret = 0;
+
 	if (ret < 0)
 		goto err_stop;
 
@@ -121,6 +133,7 @@ static void sony_remove(struct hid_device *hdev)
 
 static const struct hid_device_id sony_devices[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS3_CONTROLLER) },
+	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS3_CONTROLLER) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_VAIO_VGX_MOUSE),
 		.driver_data = VAIO_RDESC_CONSTANT },
 	{ }
-- 
1.6.5.2
