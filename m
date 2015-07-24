From: Joshua Clayton <stillcompiling@gmail.com>
Subject: [RFC PATCH 2/2] Input: evifpanel: show sliders through sysfs
Date: Fri, 24 Jul 2015 10:43:21 -0700
Message-ID: <1437759801-24622-2-git-send-email-stillcompiling@gmail.com>
References: <1437759801-24622-1-git-send-email-stillcompiling@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1437759801-24622-1-git-send-email-stillcompiling@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Dan Murphy <dmurphy@ti.com>, Nishanth Menon <nm@ti.com>, Chanwoo Choi <cw00.choi@samsung.com>, Jaewon Kim <jaewon02.kim@samsung.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Joshua Clayton <stillcompiling@gmail.com>
List-Id: linux-input@vger.kernel.org

sysfs file export the sliders in short int range

slider sysfs files will be superceded by input events
when we figure out what that should look like.

Signed-off-by: Joshua Clayton <stillcompiling@gmail.com>
---
 drivers/input/misc/evifpanel.c | 112 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 112 insertions(+)

diff --git a/drivers/input/misc/evifpanel.c b/drivers/input/misc/evifpanel.c
index aa28e6c..0bda86f 100644
--- a/drivers/input/misc/evifpanel.c
+++ b/drivers/input/misc/evifpanel.c
@@ -14,12 +14,18 @@
 #include <linux/init.h>
 #include <linux/serio.h>
 #include <linux/slab.h>
+#include <linux/sysfs.h>
 
 #define DRIVER_DESC "Uniwest EVI Frontpanel input driver"
 MODULE_AUTHOR("Joshua Clayton <stillcompiling@gmail.com>");
 MODULE_DESCRIPTION(DRIVER_DESC);
 MODULE_LICENSE("GPL");
 
+struct fp_slider {
+	s32 sum;
+	s32 count;
+};
+
 struct evifpanel {
 	struct input_dev *dev;
 	struct serio *serio;
@@ -27,6 +33,8 @@ struct evifpanel {
 	char name[64];
 	char phys[32];
 	unsigned char buf[8];
+	s32 h_slider;
+	s32 v_slider;
 };
 
 struct key_map {
@@ -38,6 +46,30 @@ struct key_map {
 };
 
 static struct key_map btns[] = {
+	{ EV_ABS, ABS_X, 0, 3, 4 },
+	{ EV_ABS, ABS_X, 1, 3, 0 },
+	{ EV_ABS, ABS_X, 2, 4, 6 },
+	{ EV_ABS, ABS_X, 3, 4, 5 },
+	{ EV_ABS, ABS_X, 4, 4, 4 },
+	{ EV_ABS, ABS_X, 5, 4, 3 },
+	{ EV_ABS, ABS_X, 6, 4, 2 },
+	{ EV_ABS, ABS_X, 7, 4, 1 },
+	{ EV_ABS, ABS_X, 8, 4, 0 },
+	{ EV_ABS, ABS_X, 9, 5, 6 },
+	{ EV_ABS, ABS_X, 10, 5, 5 },
+	{ EV_ABS, ABS_X, 11, 3, 3 },
+	{ EV_ABS, ABS_Y, 0, 3, 2 },
+	{ EV_ABS, ABS_Y, 1, 6, 2 },
+	{ EV_ABS, ABS_Y, 2, 6, 3 },
+	{ EV_ABS, ABS_Y, 3, 6, 4 },
+	{ EV_ABS, ABS_Y, 4, 6, 5 },
+	{ EV_ABS, ABS_Y, 5, 6, 6 },
+	{ EV_ABS, ABS_Y, 6, 5, 0 },
+	{ EV_ABS, ABS_Y, 7, 5, 1 },
+	{ EV_ABS, ABS_Y, 8, 5, 2 },
+	{ EV_ABS, ABS_Y, 9, 5, 3 },
+	{ EV_ABS, ABS_Y, 10, 5, 4 },
+	{ EV_ABS, ABS_Y, 11, 3, 1 },
 	{ EV_KEY, KEY_F1, 1, 6, 0 },
 	{ EV_KEY, KEY_D, 1, 6, 1 },
 	{ EV_KEY, KEY_N, 1, 7, 0 },
@@ -57,22 +89,63 @@ static void fp_check_key(struct evifpanel *fp, struct key_map *key)
 	input_report_key(fp->dev, key->code, value);
 }
 
+static void fp_slider_accumulate(struct evifpanel *fp,
+		struct fp_slider *slider, struct key_map *key)
+{
+	s32 value = !!(fp->buf[key->byte] & BIT(key->offset));
+
+	slider->sum += value * key->value;
+	slider->count += value;
+}
+
+static s32 fp_slider_value(struct evifpanel *fp, struct fp_slider *slider)
+{
+	s32 value;
+
+	if (slider->count)
+		value = (slider->sum * 0xffff / (11 * slider->count)) - 0x8000;
+	else
+		value = 0;
+
+	if (value == -1)
+		value = 0;
+
+	return value;
+}
+
 /*
  * Check buttons against array of key_map
  */
 static void fp_check_btns(struct evifpanel *fp, struct key_map *key)
 {
+	struct fp_slider h_axis, v_axis;
+
+	h_axis.sum = 0;
+	h_axis.count = 0;
+	v_axis.sum = 0;
+	v_axis.count = 0;
+
 	while (key->type) {
 		switch (key->type) {
 		case EV_KEY:
 			fp_check_key(fp, key);
 			break;
+		case EV_ABS:
+			if (key->code == ABS_X)
+				fp_slider_accumulate(fp, &h_axis, key);
+			else
+				fp_slider_accumulate(fp, &v_axis, key);
+
+			break;
 		default:
 			break; /* ignore unknown types */
 		}
 		key++;
 	}
 
+	fp->h_slider = fp_slider_value(fp, &h_axis);
+	fp->v_slider = fp_slider_value(fp, &v_axis);
+
 	input_sync(fp->dev);
 }
 
@@ -161,6 +234,37 @@ static irqreturn_t fp_interrupt(struct serio *serio, unsigned char data,
 	return IRQ_HANDLED;
 }
 
+static ssize_t v_slider_show(struct device *dev, struct device_attribute *attr,
+		char *buf)
+{
+	struct serio *serio = to_serio_port(dev);
+	struct evifpanel *fp = serio_get_drvdata(serio);
+
+	return scnprintf(buf, PAGE_SIZE, "%d\n", fp->v_slider);
+}
+
+static ssize_t h_slider_show(struct device *dev, struct device_attribute *attr,
+		char *buf)
+{
+	struct serio *serio = to_serio_port(dev);
+	struct evifpanel *fp = serio_get_drvdata(serio);
+
+	return scnprintf(buf, PAGE_SIZE, "%d\n", fp->h_slider);
+}
+
+static DEVICE_ATTR_RO(v_slider);
+static DEVICE_ATTR_RO(h_slider);
+
+static struct attribute *attrs[] = {
+	&dev_attr_v_slider.attr,
+	&dev_attr_h_slider.attr,
+	NULL,
+};
+
+struct attribute_group fp_attrs = {
+	.attrs = attrs,
+};
+
 static void fp_set_device_attrs(struct evifpanel *fp)
 {
 	snprintf(fp->name, sizeof(fp->name),
@@ -210,6 +314,11 @@ static int fp_connect(struct serio *serio, struct serio_driver *drv)
 		goto fail2;
 	}
 	fp_request_fw_ver(fp);
+	error = sysfs_create_group(&serio->dev.kobj, &fp_attrs);
+	if (error) {
+		dev_err(&serio->dev, "failed to add sysfs group\n");
+		goto sysfs_fail;
+	}
 
 	error = input_register_device(input_dev);
 	if (error) {
@@ -221,6 +330,8 @@ static int fp_connect(struct serio *serio, struct serio_driver *drv)
 
 fail3:
 	serio_close(serio);
+sysfs_fail:
+	sysfs_remove_group(&serio->dev.kobj, &fp_attrs);
 fail2:
 	serio_set_drvdata(serio, NULL);
 fail1:
@@ -236,6 +347,7 @@ static void fp_disconnect(struct serio *serio)
 	struct evifpanel *fp = serio_get_drvdata(serio);
 
 	input_unregister_device(fp->dev);
+	sysfs_remove_group(&serio->dev.kobj, &fp_attrs);
 	serio_close(serio);
 	serio_set_drvdata(serio, NULL);
 	kfree(fp);
-- 
2.1.4
