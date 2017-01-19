From: Frieder Schrempf <frieder.schrempf-wPoT/lNZgHizQB+pC5nmwQ@public.gmane.org>
Subject: [PATCH v3 1/3] input: pwm-beeper: add feature to set volume via sysfs
Date: Thu, 19 Jan 2017 16:24:08 +0100
Message-ID: <49b6d7788399142ecd01f4f5dcf263ce96eb13f1.1484838551.git.frieder.schrempf@exceet.de>
References: <cover.1484838551.git.frieder.schrempf@exceet.de>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1484838551.git.frieder.schrempf-wPoT/lNZgHizQB+pC5nmwQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, luis-HiykPkW1eAzzDCI4PIEvbQC/G2K4zDHf@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Frieder Schrempf <frieder.schrempf-wPoT/lNZgHizQB+pC5nmwQ@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Make the driver accept switching volume levels via sysfs.
This can be helpful if the beep/bell sound intensity needs
to be adapted to the environment of the device.

The volume adjustment is done by changing the duty cycle of
the pwm signal.

This patch adds the sysfs interface with 5 default volume
levels (0 - mute, 4 - max. volume).

Signed-off-by: Frieder Schrempf <frieder.schrempf-wPoT/lNZgHizQB+pC5nmwQ@public.gmane.org>
---
Changes in v3:
 - update date
 
 .../ABI/testing/sysfs-class-input-pwm-beeper       | 17 ++++++
 drivers/input/misc/pwm-beeper.c                    | 71 +++++++++++++++++++++-
 2 files changed, 87 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/ABI/testing/sysfs-class-input-pwm-beeper

diff --git a/Documentation/ABI/testing/sysfs-class-input-pwm-beeper b/Documentation/ABI/testing/sysfs-class-input-pwm-beeper
new file mode 100644
index 0000000..c878a1d
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-class-input-pwm-beeper
@@ -0,0 +1,17 @@
+What:		/sys/class/input/input(x)/volume
+Date:		January 2017
+KernelVersion:
+Contact:	Frieder Schrempf <frieder.schrempf-wPoT/lNZgHizQB+pC5nmwQ@public.gmane.org>
+Description:
+		Control the volume of this pwm-beeper. Values
+		are between 0 and max_volume_level. This file will also
+		show the current volume level stored in the driver.
+
+What:		/sys/class/input/input(x)/max_volume_level
+Date:		January 2017
+KernelVersion:
+Contact:	Frieder Schrempf <frieder.schrempf-wPoT/lNZgHizQB+pC5nmwQ@public.gmane.org>
+Description:
+		This file shows the maximum volume level that can be
+		assigned to volume.
+
diff --git a/drivers/input/misc/pwm-beeper.c b/drivers/input/misc/pwm-beeper.c
index 5f9655d..3ed21da 100644
--- a/drivers/input/misc/pwm-beeper.c
+++ b/drivers/input/misc/pwm-beeper.c
@@ -1,5 +1,9 @@
 /*
  *  Copyright (C) 2010, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
+ *
+ *  Copyright (C) 2016, Frieder Schrempf <frieder.schrempf-wPoT/lNZgHizQB+pC5nmwQ@public.gmane.org>
+ *  (volume support)
+ *
  *  PWM beeper driver
  *
  *  This program is free software; you can redistribute it and/or modify it
@@ -27,16 +31,77 @@ struct pwm_beeper {
 	struct pwm_device *pwm;
 	struct work_struct work;
 	unsigned long period;
+	unsigned int volume;
+	unsigned int volume_levels[] = {0, 8, 20, 40, 500};
+	unsigned int max_volume_level;
 };
 
 #define HZ_TO_NANOSECONDS(x) (1000000000UL/(x))
 
+static ssize_t beeper_show_volume(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct pwm_beeper *beeper = dev_get_drvdata(dev);
+
+	return sprintf(buf, "%d\n", beeper->volume);
+}
+
+static ssize_t beeper_show_max_volume_level(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct pwm_beeper *beeper = dev_get_drvdata(dev);
+
+	return sprintf(buf, "%d\n", beeper->max_volume_level);
+}
+
+static ssize_t beeper_store_volume(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	int rc;
+	struct pwm_beeper *beeper = dev_get_drvdata(dev);
+	unsigned int volume;
+
+	rc = kstrtouint(buf, 0, &volume);
+	if (rc)
+		return rc;
+
+	rc = -ENXIO;
+	if (volume > beeper->max_volume_level)
+		volume = beeper->max_volume_level;
+	pr_debug("set volume to %u\n", volume);
+	if (beeper->volume != volume)
+		beeper->volume = volume;
+	rc = count;
+
+	return rc;
+}
+
+static DEVICE_ATTR(volume, 0644, beeper_show_volume, beeper_store_volume);
+static DEVICE_ATTR(max_volume_level, 0644, beeper_show_max_volume_level, NULL);
+
+static struct attribute *bp_device_attributes[] = {
+	&dev_attr_volume.attr,
+	&dev_attr_max_volume_level.attr,
+	NULL,
+};
+
+static struct attribute_group bp_device_attr_group = {
+	.attrs = bp_device_attributes,
+};
+
+static const struct attribute_group *bp_device_attr_groups[] = {
+	&bp_device_attr_group,
+	NULL,
+};
+
 static void __pwm_beeper_set(struct pwm_beeper *beeper)
 {
 	unsigned long period = beeper->period;
 
 	if (period) {
-		pwm_config(beeper->pwm, period / 2, period);
+		pwm_config(beeper->pwm,
+			period / 1000 * beeper->volume_levels[beeper->volume],
+			period);
 		pwm_enable(beeper->pwm);
 	} else
 		pwm_disable(beeper->pwm);
@@ -123,6 +188,8 @@ static int pwm_beeper_probe(struct platform_device *pdev)
 
 	INIT_WORK(&beeper->work, pwm_beeper_work);
 
+	beeper->max_volume_level = ARRAY_SIZE(beeper->volume_levels) - 1;
+
 	beeper->input = input_allocate_device();
 	if (!beeper->input) {
 		dev_err(&pdev->dev, "Failed to allocate input device\n");
@@ -146,6 +213,8 @@ static int pwm_beeper_probe(struct platform_device *pdev)
 
 	input_set_drvdata(beeper->input, beeper);
 
+	beeper->input->dev.groups = bp_device_attr_groups;
+
 	error = input_register_device(beeper->input);
 	if (error) {
 		dev_err(&pdev->dev, "Failed to register input device: %d\n", error);
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
