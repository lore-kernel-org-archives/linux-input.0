From: Schrempf Frieder <frieder.schrempf-wPoT/lNZgHizQB+pC5nmwQ@public.gmane.org>
Subject: [PATCH 1/1] input: pwm-beeper: add feature to set volume via sysfs
Date: Thu, 7 Apr 2016 15:58:40 +0000
Message-ID: <1460044644-12419-1-git-send-email-frieder.schrempf@exceet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Language: de-DE
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "pawel.moll-5wv7dgnIgG8@public.gmane.org" <pawel.moll-5wv7dgnIgG8@public.gmane.org>, "ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org" <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, "galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org" <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Schrempf Frieder <frieder.schrempf-wPoT/lNZgHizQB+pC5nmwQ@public.gmane.org>, "luis-HiykPkW1eAzzDCI4PIEvbQC/G2K4zDHf@public.gmane.org" <luis-HiykPkW1eAzzDCI4PIEvbQC/G2K4zDHf@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Make the driver accept different volume levels via sysfs.
This can be helpful if the beep/bell sound intensity needs
to be adapted to the environment of the device.

The number of volume levels available and their values can
be specified via device tree (similar to pwm-backlight).

This patch was tested with linux-imx 3.10.17 and was
applied to current mainline without any changes.

Signed-off-by: Frieder Schrempf <frieder.schrempf-wPoT/lNZgHizQB+pC5nmwQ@public.gmane.org>
---
 .../devicetree/bindings/input/pwm-beeper.txt    |  20 ++++
 drivers/input/misc/pwm-beeper.c                 | 109 ++++++++++++++++++-
 2 files changed, 126 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/pwm-beeper.txt b/Documentation/devicetree/bindings/input/pwm-beeper.txt
index be332ae..153cd3f 100644
--- a/Documentation/devicetree/bindings/input/pwm-beeper.txt
+++ b/Documentation/devicetree/bindings/input/pwm-beeper.txt
@@ -5,3 +5,23 @@ Registers a PWM device as beeper.
 Required properties:
 - compatible: should be "pwm-beeper"
 - pwms: phandle to the physical PWM device
+- volume-levels: Array of distinct volume levels. These need to be in the
+      range of 0 to 500, while 0 means 0% duty cycle (mute) and 500 means
+      50% duty cycle (max volume).
+      Please note that the actual volume of most beepers is highly
+      non-linear, which means that low volume levels are probably somewhere
+      in the range of 1 to 30 (0.1-3% duty cycle).
+- default-volume-level: the default volume level (index into the
+      array defined by the "volume-levels" property)
+
+The volume level can be set via sysfs under /sys/class/input/inputX/volume.
+The maximum volume level index can be read from /sys/class/input/inputX/max_volume_level.
+
+Example:
+
+	pwm-beeper {
+		compatible = "pwm-beeper";
+		pwms = <&pwm4 0 5000>;
+		volume-levels = <0 8 20 40 500>;
+		default-volume-level = <4>;
+	};
diff --git a/drivers/input/misc/pwm-beeper.c b/drivers/input/misc/pwm-beeper.c
index f2261ab..f3eb8f8 100644
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
@@ -25,10 +29,69 @@ struct pwm_beeper {
 	struct input_dev *input;
 	struct pwm_device *pwm;
 	unsigned long period;
+	unsigned int volume;
+	unsigned int *volume_levels;
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
 static int pwm_beeper_event(struct input_dev *input,
 			    unsigned int type, unsigned int code, int value)
 {
@@ -53,7 +116,9 @@ static int pwm_beeper_event(struct input_dev *input,
 		pwm_disable(beeper->pwm);
 	} else {
 		period = HZ_TO_NANOSECONDS(value);
-		ret = pwm_config(beeper->pwm, period / 2, period);
+		ret = pwm_config(beeper->pwm,
+			period / 1000 * beeper->volume_levels[beeper->volume],
+			period);
 		if (ret)
 			return ret;
 		ret = pwm_enable(beeper->pwm);
@@ -68,8 +133,11 @@ static int pwm_beeper_event(struct input_dev *input,
 static int pwm_beeper_probe(struct platform_device *pdev)
 {
 	unsigned long pwm_id = (unsigned long)dev_get_platdata(&pdev->dev);
+	struct device_node *np = pdev->dev.of_node;
 	struct pwm_beeper *beeper;
-	int error;
+	struct property *prop;
+	int error, length;
+	u32 value;
 
 	beeper = kzalloc(sizeof(*beeper), GFP_KERNEL);
 	if (!beeper)
@@ -87,6 +155,36 @@ static int pwm_beeper_probe(struct platform_device *pdev)
 		goto err_free;
 	}
 
+	/* determine the number of volume levels */
+	prop = of_find_property(np, "volume-levels", &length);
+	if (!prop)
+		return -EINVAL;
+
+	beeper->max_volume_level = length / sizeof(u32);
+
+	/* read volume levels from DT property */
+	if (beeper->max_volume_level > 0) {
+		size_t size = sizeof(*beeper->volume_levels) *
+			beeper->max_volume_level;
+
+		beeper->volume_levels = devm_kzalloc(&(pdev->dev), size,
+			GFP_KERNEL);
+		if (!beeper->volume_levels)
+			return -ENOMEM;
+
+		error = of_property_read_u32_array(np, "volume-levels",
+						 beeper->volume_levels,
+						 beeper->max_volume_level);
+
+		error = of_property_read_u32(np, "default-volume-level",
+					   &value);
+		if (error < 0)
+			return error;
+
+		beeper->volume = value;
+		beeper->max_volume_level--;
+	}
+
 	beeper->input = input_allocate_device();
 	if (!beeper->input) {
 		dev_err(&pdev->dev, "Failed to allocate input device\n");
@@ -109,6 +207,8 @@ static int pwm_beeper_probe(struct platform_device *pdev)
 
 	input_set_drvdata(beeper->input, beeper);
 
+	beeper->input->dev.groups = bp_device_attr_groups;
+
 	error = input_register_device(beeper->input);
 	if (error) {
 		dev_err(&pdev->dev, "Failed to register input device: %d\n", error);
@@ -158,7 +258,10 @@ static int __maybe_unused pwm_beeper_resume(struct device *dev)
 	struct pwm_beeper *beeper = dev_get_drvdata(dev);
 
 	if (beeper->period) {
-		pwm_config(beeper->pwm, beeper->period / 2, beeper->period);
+		pwm_config(beeper->pwm,
+			beeper->period / 1000 *
+			beeper->volume_levels[beeper->volume],
+			beeper->period);
 		pwm_enable(beeper->pwm);
 	}
 
-- 
1.9.1
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
