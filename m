From: Rafi Rubin <rafi@seas.upenn.edu>
Subject: [PATCH 3/4] identify firmware version
Date: Thu, 26 Aug 2010 00:54:56 -0400
Message-ID: <1282798497-19791-4-git-send-email-rafi@seas.upenn.edu>
References: <1282798497-19791-1-git-send-email-rafi@seas.upenn.edu>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1282798497-19791-1-git-send-email-rafi@seas.upenn.edu>
Sender: linux-kernel-owner@vger.kernel.org
To: jkosina@suse.cz, linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com, chatty@enac.fr, micki@n-trig.com, Rafi Rubin <rafi@seas.upenn.edu>
List-Id: linux-input@vger.kernel.org

This adds firmware version polling to the end of probe and reports the
version both in the raw form and proccessed to match the formatting used
by ntrig in windows.

Signed-off-by: Rafi Rubin <rafi@seas.upenn.edu>
---
 drivers/hid/hid-ntrig.c |   60 +++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 60 insertions(+), 0 deletions(-)

diff --git a/drivers/hid/hid-ntrig.c b/drivers/hid/hid-ntrig.c
index 43e95de..ab0ca7f 100644
--- a/drivers/hid/hid-ntrig.c
+++ b/drivers/hid/hid-ntrig.c
@@ -63,6 +63,9 @@ struct ntrig_data {
 
 	bool reading_mt;
 
+	/* The raw firmware version code */
+	__u8 firmware_version[4];
+
 	__u8 mt_footer[4];
 	__u8 mt_foot_count;
 
@@ -90,6 +93,26 @@ struct ntrig_data {
 };
 
 
+/*
+ * This function converts the 4 byte raw firmware code into
+ * a string containing 5 comma separated numbers.
+ */
+static int ntrig_version_string(unsigned char *raw, char *buf)
+{
+	__u8 a =  (raw[1] & 0b00001110) >> 1;
+	__u8 b =  (raw[0] & 0b00111100) >> 2;
+	__u8 c = ((raw[0] & 0b00000011) << 3) | ((raw[3] & 0b11100000) >> 5);
+	__u8 d = ((raw[3] & 0b00000111) << 3) | ((raw[2] & 0b11100000) >> 5);
+	__u8 e =   raw[2] & 0b00000111;
+
+	/*
+	 * As yet unmapped bits:
+	 * 0b11000000 0b11110001 0b00011000 0b00011000
+	 */
+
+	return sprintf(buf, "%u.%u.%u.%u.%u", a, b, c, d, e);
+}
+
 static ssize_t show_phys_width(struct device *dev,
 			       struct device_attribute *attr,
 			       char *buf)
@@ -776,6 +799,9 @@ static int ntrig_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	struct hid_input *hidinput;
 	struct input_dev *input;
 	struct hid_report *report;
+	unsigned char *data;
+	struct usb_device *usb_dev = hid_to_usb_dev(hdev);
+	char *buf;
 
 	if (id->driver_data)
 		hdev->quirks |= HID_QUIRK_MULTI_INPUT;
@@ -848,10 +874,44 @@ static int ntrig_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	if (report)
 		usbhid_submit_report(hdev, report, USB_DIR_OUT);
 
+	data = kmalloc(8, GFP_KERNEL);
+	if (!data) {
+		ret = -ENOMEM;
+		goto err_free;
+	}
+
+	ret = usb_control_msg(usb_dev, usb_rcvctrlpipe(usb_dev, 0),
+			      USB_REQ_CLEAR_FEATURE,
+			      USB_TYPE_CLASS | USB_RECIP_INTERFACE |
+			      USB_DIR_IN,
+			      0x30c, 1, data, 8,
+			      USB_CTRL_SET_TIMEOUT);
+
+	if (ret == 8) {
+		buf = kmalloc(20, GFP_KERNEL);
+		if (!buf) {
+			ret = -ENOMEM;
+			goto err_free_data;
+		}
+
+		ret = ntrig_version_string(&data[2], buf);
+
+		dev_info(&hdev->dev,
+			 "Firmware version: %s (%02x%02x %02x%02x)\n",
+			 buf, data[2], data[3], data[4], data[5]);
+
+		nd->firmware_version[0] = data[2];
+		nd->firmware_version[1] = data[3];
+		nd->firmware_version[2] = data[4];
+		nd->firmware_version[3] = data[5];
+	}
+
 	ret = sysfs_create_group(&hdev->dev.kobj,
 			&ntrig_attribute_group);
 
 	return 0;
+err_free_data:
+	kfree(data);
 err_free:
 	kfree(nd);
 	return ret;
-- 
1.7.1
