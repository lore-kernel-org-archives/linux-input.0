From: Masaki Ota <012nexus@gmail.com>
Subject: [PATCH 7/7] Support Alps U1 USB device
Date: Tue, 12 Sep 2017 11:54:14 +0900
Message-ID: <20170912025414.3784-8-masaki.ota@jp.alps.com>
References: <20170912025414.3784-1-masaki.ota@jp.alps.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170912025414.3784-1-masaki.ota@jp.alps.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jikos@kernel.org, benjamin.tissoires@redhat.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, masaki.ota@jp.alps.com
List-Id: linux-input@vger.kernel.org

From: Masaki Ota <masaki.ota@jp.alps.com>
-Add T4 USB device code and Product ID
-This device is used on HP Elite x2 series

Signed-off-by: Masaki Ota <masaki.ota@jp.alps.com>
---
 drivers/hid/hid-alps.c | 35 +++++++++++++++++++++++++----------
 drivers/hid/hid-core.c |  1 +
 drivers/hid/hid-ids.h  |  1 +
 3 files changed, 27 insertions(+), 10 deletions(-)

diff --git a/drivers/hid/hid-alps.c b/drivers/hid/hid-alps.c
index e7ae3a7b8e7d..e7a4e063597f 100644
--- a/drivers/hid/hid-alps.c
+++ b/drivers/hid/hid-alps.c
@@ -444,6 +444,7 @@ static int alps_raw_event(struct hid_device *hdev,
 
 	switch (hdev->product) {
 	case HID_PRODUCT_ID_T4_BTNLESS:
+	case HID_DEVICE_ID_ALPS_T4_USB:
 		ret = t4_raw_event(hdata, data, size);
 		break;
 	default:
@@ -598,13 +599,29 @@ static int T4_init(struct hid_device *hdev, struct alps_dev *pri_data)
 	int ret;
 	u8 tmp, sen_line_num_x, sen_line_num_y;
 
-	ret = t4_read_write_register(hdev, T4_PRM_ID_CONFIG_3, &tmp, 0, true);
-	if (ret < 0) {
-		dev_err(&hdev->dev, "failed T4_PRM_ID_CONFIG_3 (%d)\n", ret);
+	if (hdev->product == HID_DEVICE_ID_ALPS_T4_BTNLESS) {
+		ret = t4_read_write_register(hdev,
+					T4_PRM_ID_CONFIG_3, &tmp, 0, true);
+		if (ret < 0) {
+			dev_err(&hdev->dev,
+				"failed T4_PRM_ID_CONFIG_3 (%d)\n", ret);
 		goto exit;
+		}
+		sen_line_num_x = 16 + ((tmp & 0x0F)  | (tmp & 0x08 ? 0xF0 : 0));
+		sen_line_num_y =
+			12 + (((tmp & 0xF0) >> 4)  | (tmp & 0x80 ? 0xF0 : 0));
+
+		ret = t4_read_write_register(hdev,
+				PRM_SYS_CONFIG_1, &tmp, 0, true);
+		if (ret < 0) {
+			dev_err(&hdev->dev,
+				"failed PRM_SYS_CONFIG_1 (%d)\n", ret);
+			goto exit;
+		}
+	} else {
+		sen_line_num_x = 20;
+		sen_line_num_y = 12;
 	}
-	sen_line_num_x = 16 + ((tmp & 0x0F)  | (tmp & 0x08 ? 0xF0 : 0));
-	sen_line_num_y = 12 + (((tmp & 0xF0) >> 4)  | (tmp & 0x80 ? 0xF0 : 0));
 
 	pri_data->x_max = sen_line_num_x * T4_COUNT_PER_ELECTRODE;
 	pri_data->x_min = T4_COUNT_PER_ELECTRODE;
@@ -613,11 +630,6 @@ static int T4_init(struct hid_device *hdev, struct alps_dev *pri_data)
 	pri_data->x_active_len_mm = pri_data->y_active_len_mm = 0;
 	pri_data->btn_cnt = 1;
 
-	ret = t4_read_write_register(hdev, PRM_SYS_CONFIG_1, &tmp, 0, true);
-	if (ret < 0) {
-		dev_err(&hdev->dev, "failed PRM_SYS_CONFIG_1 (%d)\n", ret);
-		goto exit;
-	}
 	tmp |= 0x02;
 	ret = t4_read_write_register(hdev, PRM_SYS_CONFIG_1, NULL, tmp, false);
 	if (ret < 0) {
@@ -768,6 +780,7 @@ static int alps_probe(struct hid_device *hdev, const struct hid_device_id *id)
 
 	switch (hdev->product) {
 	case HID_DEVICE_ID_ALPS_T4_BTNLESS:
+	case HID_DEVICE_ID_ALPS_T4_USB:
 		data->dev_type = T4;
 		break;
 	case HID_DEVICE_ID_ALPS_U1_DUAL:
@@ -799,6 +812,8 @@ static const struct hid_device_id alps_id[] = {
 		USB_VENDOR_ID_ALPS_JP, HID_DEVICE_ID_ALPS_U1) },
 	{ HID_DEVICE(HID_BUS_ANY, HID_GROUP_ANY,
 		USB_VENDOR_ID_ALPS_JP, HID_DEVICE_ID_ALPS_T4_BTNLESS) },
+	{ HID_DEVICE(HID_BUS_ANY, HID_GROUP_ANY,
+		USB_VENDOR_ID_ALPS_JP, HID_DEVICE_ID_ALPS_T4_USB) },
 	{ }
 };
 MODULE_DEVICE_TABLE(hid, alps_id);
diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 779e26cb3ba9..13ded460885e 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1777,6 +1777,7 @@ static const struct hid_device_id hid_have_special_driver[] = {
 	{ HID_I2C_DEVICE(USB_VENDOR_ID_ALPS_JP, HID_DEVICE_ID_ALPS_U1_DUAL) },
 	{ HID_I2C_DEVICE(USB_VENDOR_ID_ALPS_JP, HID_DEVICE_ID_ALPS_U1) },
 	{ HID_I2C_DEVICE(USB_VENDOR_ID_ALPS_JP, HID_DEVICE_ID_ALPS_T4_BTNLESS) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_ALPS_JP, HID_DEVICE_ID_ALPS_T4_USB) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_MIGHTYMOUSE) },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_MAGICMOUSE) },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_MAGICTRACKPAD) },
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 2b50d12b993e..71c2a021e296 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -76,6 +76,7 @@
 #define USB_VENDOR_ID_ALPS_JP		0x044E
 #define HID_DEVICE_ID_ALPS_U1_DUAL	0x120B
 #define HID_DEVICE_ID_ALPS_U1	0x1215
+#define HID_DEVICE_ID_ALPS_T4_USB	0x1216
 #define HID_DEVICE_ID_ALPS_T4_BTNLESS	0x120C
 
 #define USB_VENDOR_ID_AMI		0x046b
-- 
2.11.0
