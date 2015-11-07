From: Simon Wood <simon@mungewell.org>
Subject: [PATCH 4/6] HID: hid-logitech-hidpp: Add range sysfs for Logitech G920
Date: Sat,  7 Nov 2015 09:10:07 -0700
Message-ID: <1446912609-2573-5-git-send-email-simon@mungewell.org>
References: <1446912609-2573-1-git-send-email-simon@mungewell.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1446912609-2573-1-git-send-email-simon@mungewell.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Edwin <Edwin@Velds.nl>, =?UTF-8?q?Michal=20Mal=C3=BD?= <madcatxster@devoid-pointer.net>, elias vanderstuyft <elias.vds@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Simon Wood <simon@mungewell.org>
List-Id: linux-input@vger.kernel.org

The G920 can adjust the amount of 'turn' it permits, this patch adds
a sysfs file 'range' to control this.

Signed-off-by: Simon Wood <simon@mungewell.org>
---
 drivers/hid/hid-logitech-hidpp.c | 140 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 139 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index dbb9ff3..03e01be 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -1295,6 +1295,133 @@ static int k400_connect(struct hid_device *hdev, bool connected)
 	return k400_disable_tap_to_click(hidpp);
 }
 
+/* ------------------------------------------------------------------------- */
+/* Logitech G920 Driving Force Racing Wheel for Xbox One                     */
+/* ------------------------------------------------------------------------- */
+
+#define HIDPP_PAGE_G920_FORCE_FEEDBACK			0x8123
+
+/* Using session ID = 1 */
+#define CMD_G920_FORCE_GET_APERTURE			0x51
+#define CMD_G920_FORCE_SET_APERTURE			0x61
+
+struct g920_private_data {
+	u8 force_feature;
+	u16 range;
+};
+
+#define to_hid_device(pdev) container_of(pdev, struct hid_device, dev)
+
+static ssize_t g920_range_show(struct device *dev, struct device_attribute *attr,
+				char *buf)
+{
+	struct hid_device *hid = to_hid_device(dev);
+	struct hidpp_device *hidpp = hid_get_drvdata(hid);
+	struct g920_private_data *pdata;
+
+	pdata = hidpp->private_data;
+	if (!pdata) {
+		hid_err(hid, "Private driver data not found!\n");
+		return -EINVAL;
+	}
+
+	return scnprintf(buf, PAGE_SIZE, "%u\n", pdata->range);
+}
+
+static ssize_t g920_range_store(struct device *dev, struct device_attribute *attr,
+				 const char *buf, size_t count)
+{
+	struct hid_device *hid = to_hid_device(dev);
+	struct hidpp_device *hidpp = hid_get_drvdata(hid);
+	struct g920_private_data *pdata;
+	struct hidpp_report response;
+	u8 params[2];
+	int ret;
+	u16 range = simple_strtoul(buf, NULL, 10);
+
+	pdata = hidpp->private_data;
+	if (!pdata) {
+		hid_err(hid, "Private driver data not found!\n");
+		return -EINVAL;
+	}
+
+	if (range < 180)
+		range = 180;
+	else if (range > 900)
+		range = 900;
+
+	params[0] = range >> 8;
+	params[1] = range & 0x00FF;
+
+	ret = hidpp_send_fap_command_sync(hidpp, pdata->force_feature,
+		CMD_G920_FORCE_SET_APERTURE, params, 2, &response);
+	if (ret)
+		return ret;
+
+	pdata->range = range;
+	return count;
+}
+
+static DEVICE_ATTR(range, S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP | S_IROTH, g920_range_show, g920_range_store);
+
+static int g920_allocate(struct hid_device *hdev)
+{
+	struct hidpp_device *hidpp = hid_get_drvdata(hdev);
+	struct g920_private_data *pdata;
+
+	pdata = devm_kzalloc(&hdev->dev, sizeof(struct g920_private_data),
+			GFP_KERNEL);
+	if (!pdata)
+		return -ENOMEM;
+
+	hidpp->private_data = pdata;
+
+	return 0;
+}
+
+static int g920_get_config(struct hidpp_device *hidpp)
+{
+	struct g920_private_data *pdata = hidpp->private_data;
+	struct hidpp_report response;
+	u8 feature_type;
+	u8 feature_index;
+	int ret;
+
+	pdata = hidpp->private_data;
+	if (!pdata) {
+		hid_err(hidpp->hid_dev, "Private driver data not found!\n");
+		return -EINVAL;
+	}
+
+	/* Find feature and store for later use */
+	ret = hidpp_root_get_feature(hidpp, HIDPP_PAGE_G920_FORCE_FEEDBACK,
+		&feature_index, &feature_type);
+	if (ret)
+		return ret;
+
+	pdata->force_feature = feature_index;
+
+	/* Read current Range */
+	ret = hidpp_send_fap_command_sync(hidpp, feature_index,
+		CMD_G920_FORCE_GET_APERTURE, NULL, 0, &response);
+	if (ret > 0) {
+		hid_err(hidpp->hid_dev, "%s: received protocol error 0x%02x\n",
+			__func__, ret);
+		return -EPROTO;
+	}
+	if (ret)
+		return ret;
+
+	pdata->range = get_unaligned_be16(&response.fap.params[0]);
+
+	/* Create sysfs interface */
+	ret = device_create_file(&(hidpp->hid_dev->dev), &dev_attr_range);
+	if (ret)
+		hid_warn(hidpp->hid_dev, "Unable to create sysfs interface for \"range\", errno %d\n", ret);
+
+	return 0;
+}
+
 /* -------------------------------------------------------------------------- */
 /* Generic HID++ devices                                                      */
 /* -------------------------------------------------------------------------- */
@@ -1593,6 +1720,10 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		ret = k400_allocate(hdev);
 		if (ret)
 			goto allocate_fail;
+	} else if (hidpp->quirks & HIDPP_QUIRK_CLASS_G920) {
+		ret = g920_allocate(hdev);
+		if (ret)
+			goto allocate_fail;
 	}
 
 	INIT_WORK(&hidpp->work, delayed_work_cb);
@@ -1646,6 +1777,10 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		ret = wtp_get_config(hidpp);
 		if (ret)
 			goto hid_hw_open_failed;
+	} else if (connected && (hidpp->quirks & HIDPP_QUIRK_CLASS_G920)) {
+		ret = g920_get_config(hidpp);
+		if (ret)
+			goto hid_hw_open_failed;
 	}
 
 	/* Block incoming packets */
@@ -1671,6 +1806,7 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
 hid_hw_open_failed:
 	hid_device_io_stop(hdev);
 	if (hidpp->quirks & HIDPP_QUIRK_CLASS_G920) {
+		device_remove_file(&hdev->dev, &dev_attr_range);
 		hid_hw_close(hdev);
 		hid_hw_stop(hdev);
 	}
@@ -1687,8 +1823,10 @@ static void hidpp_remove(struct hid_device *hdev)
 {
 	struct hidpp_device *hidpp = hid_get_drvdata(hdev);
 
-	if (hidpp->quirks & HIDPP_QUIRK_CLASS_G920)
+	if (hidpp->quirks & HIDPP_QUIRK_CLASS_G920) {
+		device_remove_file(&hdev->dev, &dev_attr_range);
 		hid_hw_close(hdev);
+	}
 	hid_hw_stop(hdev);
 	cancel_work_sync(&hidpp->work);
 	mutex_destroy(&hidpp->send_mutex);
-- 
2.1.4
