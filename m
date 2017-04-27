From: Masaki Ota <012nexus@gmail.com>
Subject: [PATCH 3/4] Add new Alps U1 Touchpad device
Date: Thu, 27 Apr 2017 16:40:33 +0900
Message-ID: <1493278834-8523-4-git-send-email-masaki.ota@jp.alps.com>
References: <1493278834-8523-1-git-send-email-masaki.ota@jp.alps.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1493278834-8523-1-git-send-email-masaki.ota@jp.alps.com>
Sender: linux-kernel-owner@vger.kernel.org
To: benjamin.tissoires@redhat.com, jikos@kernel.org
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, masaki.ota@jp.alps.com
List-Id: linux-input@vger.kernel.org

From: Masaki Ota <masaki.ota@jp.alps.com>
-Add new Alps U1 Touchpad device ID
-Laptop names that use this Touchpad:HP Elitebook x360 1030 G2

Signed-off-by: Masaki Ota <masaki.ota@jp.alps.com>
---
 drivers/hid/hid-alps.c | 3 +++
 drivers/hid/hid-core.c | 1 +
 drivers/hid/hid-ids.h  | 1 +
 3 files changed, 5 insertions(+)

diff --git a/drivers/hid/hid-alps.c b/drivers/hid/hid-alps.c
index 0a6c54f..e7ae3a7 100644
--- a/drivers/hid/hid-alps.c
+++ b/drivers/hid/hid-alps.c
@@ -771,6 +771,7 @@ static int alps_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		data->dev_type = T4;
 		break;
 	case HID_DEVICE_ID_ALPS_U1_DUAL:
+	case HID_DEVICE_ID_ALPS_U1:
 		data->dev_type = U1;
 		break;
 	default:
@@ -795,6 +796,8 @@ static const struct hid_device_id alps_id[] = {
 	{ HID_DEVICE(HID_BUS_ANY, HID_GROUP_ANY,
 		USB_VENDOR_ID_ALPS_JP, HID_DEVICE_ID_ALPS_U1_DUAL) },
 	{ HID_DEVICE(HID_BUS_ANY, HID_GROUP_ANY,
+		USB_VENDOR_ID_ALPS_JP, HID_DEVICE_ID_ALPS_U1) },
+	{ HID_DEVICE(HID_BUS_ANY, HID_GROUP_ANY,
 		USB_VENDOR_ID_ALPS_JP, HID_DEVICE_ID_ALPS_T4_BTNLESS) },
 	{ }
 };
diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 9c3cb2e..779e26c 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1775,6 +1775,7 @@ static const struct hid_device_id hid_have_special_driver[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ACRUX, 0x0802) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ACRUX, 0xf705) },
 	{ HID_I2C_DEVICE(USB_VENDOR_ID_ALPS_JP, HID_DEVICE_ID_ALPS_U1_DUAL) },
+	{ HID_I2C_DEVICE(USB_VENDOR_ID_ALPS_JP, HID_DEVICE_ID_ALPS_U1) },
 	{ HID_I2C_DEVICE(USB_VENDOR_ID_ALPS_JP, HID_DEVICE_ID_ALPS_T4_BTNLESS) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_MIGHTYMOUSE) },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_MAGICMOUSE) },
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 0b9726d..2b50d12 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -75,6 +75,7 @@
 
 #define USB_VENDOR_ID_ALPS_JP		0x044E
 #define HID_DEVICE_ID_ALPS_U1_DUAL	0x120B
+#define HID_DEVICE_ID_ALPS_U1	0x1215
 #define HID_DEVICE_ID_ALPS_T4_BTNLESS	0x120C
 
 #define USB_VENDOR_ID_AMI		0x046b
-- 
2.7.4
