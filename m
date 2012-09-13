From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 4/4] HID: lenovo-tpkbd: Remove unnecessary casts of void
 pointers
Date: Thu, 13 Sep 2012 14:12:08 +0800
Message-ID: <1347516728.3319.6.camel@phoenix>
References: <1347516512.3319.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:56234 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751146Ab2IMGMN (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 13 Sep 2012 02:12:13 -0400
Received: by obbuo13 with SMTP id uo13so3972830obb.19
        for <linux-input@vger.kernel.org>; Wed, 12 Sep 2012 23:12:12 -0700 (PDT)
In-Reply-To: <1347516512.3319.2.camel@phoenix>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Bernhard Seibold <mail@bernhard-seibold.de>, linux-input@vger.kernel.org

container_of() never returns NULL, thus also remove the NULL checking for it.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 drivers/hid/hid-lenovo-tpkbd.c |  147 +++++++++-------------------------------
 1 file changed, 33 insertions(+), 114 deletions(-)

diff --git a/drivers/hid/hid-lenovo-tpkbd.c b/drivers/hid/hid-lenovo-tpkbd.c
index 60c4e1e..cea016e 100644
--- a/drivers/hid/hid-lenovo-tpkbd.c
+++ b/drivers/hid/hid-lenovo-tpkbd.c
@@ -56,9 +56,8 @@ static int tpkbd_input_mapping(struct hid_device *hdev,
 static int tpkbd_features_set(struct hid_device *hdev)
 {
 	struct hid_report *report;
-	struct tpkbd_data_pointer *data_pointer;
+	struct tpkbd_data_pointer *data_pointer = hid_get_drvdata(hdev);
 
-	data_pointer = (struct tpkbd_data_pointer *) hid_get_drvdata(hdev);
 	report = hdev->report_enum[HID_FEATURE_REPORT].report_id_hash[4];
 
 	report->field[0]->value[0]  = data_pointer->press_to_select   ? 0x01 : 0x02;
@@ -77,14 +76,8 @@ static ssize_t pointer_press_to_select_show(struct device *dev,
 		struct device_attribute *attr,
 		char *buf)
 {
-	struct hid_device *hdev;
-	struct tpkbd_data_pointer *data_pointer;
-
-	hdev = container_of(dev, struct hid_device, dev);
-	if (hdev == NULL)
-		return -ENODEV;
-
-	data_pointer = (struct tpkbd_data_pointer *) hid_get_drvdata(hdev);
+	struct hid_device *hdev = container_of(dev, struct hid_device, dev);
+	struct tpkbd_data_pointer *data_pointer = hid_get_drvdata(hdev);
 
 	return snprintf(buf, PAGE_SIZE, "%u\n", data_pointer->press_to_select);
 }
@@ -94,16 +87,10 @@ static ssize_t pointer_press_to_select_store(struct device *dev,
 		const char *buf,
 		size_t count)
 {
-	struct hid_device *hdev;
-	struct tpkbd_data_pointer *data_pointer;
+	struct hid_device *hdev = container_of(dev, struct hid_device, dev);
+	struct tpkbd_data_pointer *data_pointer = hid_get_drvdata(hdev);
 	int value;
 
-	hdev = container_of(dev, struct hid_device, dev);
-	if (hdev == NULL)
-		return -ENODEV;
-
-	data_pointer = (struct tpkbd_data_pointer *) hid_get_drvdata(hdev);
-
 	if (kstrtoint(buf, 10, &value))
 		return -EINVAL;
 	if (value < 0 || value > 1)
@@ -119,14 +106,8 @@ static ssize_t pointer_dragging_show(struct device *dev,
 		struct device_attribute *attr,
 		char *buf)
 {
-	struct hid_device *hdev;
-	struct tpkbd_data_pointer *data_pointer;
-
-	hdev = container_of(dev, struct hid_device, dev);
-	if (hdev == NULL)
-		return -ENODEV;
-
-	data_pointer = (struct tpkbd_data_pointer *) hid_get_drvdata(hdev);
+	struct hid_device *hdev = container_of(dev, struct hid_device, dev);
+	struct tpkbd_data_pointer *data_pointer = hid_get_drvdata(hdev);
 
 	return snprintf(buf, PAGE_SIZE, "%u\n", data_pointer->dragging);
 }
@@ -136,16 +117,10 @@ static ssize_t pointer_dragging_store(struct device *dev,
 		const char *buf,
 		size_t count)
 {
-	struct hid_device *hdev;
-	struct tpkbd_data_pointer *data_pointer;
+	struct hid_device *hdev = container_of(dev, struct hid_device, dev);
+	struct tpkbd_data_pointer *data_pointer = hid_get_drvdata(hdev);
 	int value;
 
-	hdev = container_of(dev, struct hid_device, dev);
-	if (hdev == NULL)
-		return -ENODEV;
-
-	data_pointer = (struct tpkbd_data_pointer *) hid_get_drvdata(hdev);
-
 	if (kstrtoint(buf, 10, &value))
 		return -EINVAL;
 	if (value < 0 || value > 1)
@@ -161,14 +136,8 @@ static ssize_t pointer_release_to_select_show(struct device *dev,
 		struct device_attribute *attr,
 		char *buf)
 {
-	struct hid_device *hdev;
-	struct tpkbd_data_pointer *data_pointer;
-
-	hdev = container_of(dev, struct hid_device, dev);
-	if (hdev == NULL)
-		return -ENODEV;
-
-	data_pointer = (struct tpkbd_data_pointer *) hid_get_drvdata(hdev);
+	struct hid_device *hdev = container_of(dev, struct hid_device, dev);
+	struct tpkbd_data_pointer *data_pointer = hid_get_drvdata(hdev);
 
 	return snprintf(buf, PAGE_SIZE, "%u\n", data_pointer->release_to_select);
 }
@@ -178,16 +147,10 @@ static ssize_t pointer_release_to_select_store(struct device *dev,
 		const char *buf,
 		size_t count)
 {
-	struct hid_device *hdev;
-	struct tpkbd_data_pointer *data_pointer;
+	struct hid_device *hdev = container_of(dev, struct hid_device, dev);
+	struct tpkbd_data_pointer *data_pointer = hid_get_drvdata(hdev);
 	int value;
 
-	hdev = container_of(dev, struct hid_device, dev);
-	if (hdev == NULL)
-		return -ENODEV;
-
-	data_pointer = (struct tpkbd_data_pointer *) hid_get_drvdata(hdev);
-
 	if (kstrtoint(buf, 10, &value))
 		return -EINVAL;
 	if (value < 0 || value > 1)
@@ -203,14 +166,8 @@ static ssize_t pointer_select_right_show(struct device *dev,
 		struct device_attribute *attr,
 		char *buf)
 {
-	struct hid_device *hdev;
-	struct tpkbd_data_pointer *data_pointer;
-
-	hdev = container_of(dev, struct hid_device, dev);
-	if (hdev == NULL)
-		return -ENODEV;
-
-	data_pointer = (struct tpkbd_data_pointer *) hid_get_drvdata(hdev);
+	struct hid_device *hdev = container_of(dev, struct hid_device, dev);
+	struct tpkbd_data_pointer *data_pointer = hid_get_drvdata(hdev);
 
 	return snprintf(buf, PAGE_SIZE, "%u\n", data_pointer->select_right);
 }
@@ -220,16 +177,10 @@ static ssize_t pointer_select_right_store(struct device *dev,
 		const char *buf,
 		size_t count)
 {
-	struct hid_device *hdev;
-	struct tpkbd_data_pointer *data_pointer;
+	struct hid_device *hdev = container_of(dev, struct hid_device, dev);
+	struct tpkbd_data_pointer *data_pointer = hid_get_drvdata(hdev);
 	int value;
 
-	hdev = container_of(dev, struct hid_device, dev);
-	if (hdev == NULL)
-		return -ENODEV;
-
-	data_pointer = (struct tpkbd_data_pointer *) hid_get_drvdata(hdev);
-
 	if (kstrtoint(buf, 10, &value))
 		return -EINVAL;
 	if (value < 0 || value > 1)
@@ -245,14 +196,8 @@ static ssize_t pointer_sensitivity_show(struct device *dev,
 		struct device_attribute *attr,
 		char *buf)
 {
-	struct hid_device *hdev;
-	struct tpkbd_data_pointer *data_pointer;
-
-	hdev = container_of(dev, struct hid_device, dev);
-	if (hdev == NULL)
-		return -ENODEV;
-
-	data_pointer = (struct tpkbd_data_pointer *) hid_get_drvdata(hdev);
+	struct hid_device *hdev = container_of(dev, struct hid_device, dev);
+	struct tpkbd_data_pointer *data_pointer = hid_get_drvdata(hdev);
 
 	return snprintf(buf, PAGE_SIZE, "%u\n",
 		data_pointer->sensitivity);
@@ -263,16 +208,10 @@ static ssize_t pointer_sensitivity_store(struct device *dev,
 		const char *buf,
 		size_t count)
 {
-	struct hid_device *hdev;
-	struct tpkbd_data_pointer *data_pointer;
+	struct hid_device *hdev = container_of(dev, struct hid_device, dev);
+	struct tpkbd_data_pointer *data_pointer = hid_get_drvdata(hdev);
 	int value;
 
-	hdev = container_of(dev, struct hid_device, dev);
-	if (hdev == NULL)
-		return -ENODEV;
-
-	data_pointer = (struct tpkbd_data_pointer *) hid_get_drvdata(hdev);
-
 	if (kstrtoint(buf, 10, &value) || value < 1 || value > 255)
 		return -EINVAL;
 
@@ -286,14 +225,10 @@ static ssize_t pointer_press_speed_show(struct device *dev,
 		struct device_attribute *attr,
 		char *buf)
 {
-	struct hid_device *hdev;
-	struct tpkbd_data_pointer *data_pointer;
+	struct hid_device *hdev = container_of(dev, struct hid_device, dev);
+	struct tpkbd_data_pointer *data_pointer = hid_get_drvdata(hdev);
 
-	hdev = container_of(dev, struct hid_device, dev);
-	if (hdev == NULL)
-		return -ENODEV;
-
-	data_pointer = (struct tpkbd_data_pointer *) hid_get_drvdata(hdev);
+	data_pointer = hid_get_drvdata(hdev);
 
 	return snprintf(buf, PAGE_SIZE, "%u\n",
 		data_pointer->press_speed);
@@ -304,16 +239,10 @@ static ssize_t pointer_press_speed_store(struct device *dev,
 		const char *buf,
 		size_t count)
 {
-	struct hid_device *hdev;
-	struct tpkbd_data_pointer *data_pointer;
+	struct hid_device *hdev = container_of(dev, struct hid_device, dev);
+	struct tpkbd_data_pointer *data_pointer = hid_get_drvdata(hdev);
 	int value;
 
-	hdev = container_of(dev, struct hid_device, dev);
-	if (hdev == NULL)
-		return -ENODEV;
-
-	data_pointer = (struct tpkbd_data_pointer *) hid_get_drvdata(hdev);
-
 	if (kstrtoint(buf, 10, &value) || value < 1 || value > 255)
 		return -EINVAL;
 
@@ -370,15 +299,11 @@ static const struct attribute_group tpkbd_attr_group_pointer = {
 static enum led_brightness tpkbd_led_brightness_get(
 			struct led_classdev *led_cdev)
 {
-	struct device *dev;
-	struct hid_device *hdev;
-	struct tpkbd_data_pointer *data_pointer;
+	struct device *dev = led_cdev->dev->parent;
+	struct hid_device *hdev = container_of(dev, struct hid_device, dev);
+	struct tpkbd_data_pointer *data_pointer = hid_get_drvdata(hdev);
 	int led_nr = 0;
 
-	dev = led_cdev->dev->parent;
-	hdev = container_of(dev, struct hid_device, dev);
-	data_pointer = (struct tpkbd_data_pointer *) hid_get_drvdata(hdev);
-
 	if (led_cdev == &data_pointer->led_micmute)
 		led_nr = 1;
 
@@ -390,16 +315,12 @@ static enum led_brightness tpkbd_led_brightness_get(
 static void tpkbd_led_brightness_set(struct led_classdev *led_cdev,
 			enum led_brightness value)
 {
-	struct device *dev;
-	struct hid_device *hdev;
+	struct device *dev = led_cdev->dev->parent;
+	struct hid_device *hdev = container_of(dev, struct hid_device, dev);
+	struct tpkbd_data_pointer *data_pointer = hid_get_drvdata(hdev);
 	struct hid_report *report;
-	struct tpkbd_data_pointer *data_pointer;
 	int led_nr = 0;
 
-	dev = led_cdev->dev->parent;
-	hdev = container_of(dev, struct hid_device, dev);
-	data_pointer = (struct tpkbd_data_pointer *) hid_get_drvdata(hdev);
-
 	if (led_cdev == &data_pointer->led_micmute)
 		led_nr = 1;
 
@@ -508,13 +429,11 @@ err_free:
 
 static void tpkbd_remove_tp(struct hid_device *hdev)
 {
-	struct tpkbd_data_pointer *data_pointer;
+	struct tpkbd_data_pointer *data_pointer = hid_get_drvdata(hdev);
 
 	sysfs_remove_group(&hdev->dev.kobj,
 			&tpkbd_attr_group_pointer);
 
-	data_pointer = (struct tpkbd_data_pointer *) hid_get_drvdata(hdev);
-
 	led_classdev_unregister(&data_pointer->led_micmute);
 	led_classdev_unregister(&data_pointer->led_mute);
 
-- 
1.7.9.5



