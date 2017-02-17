From: Frieder Schrempf <frieder.schrempf@exceet.de>
Subject: [PATCH v5 1/3] input: pwm-beeper: add feature to set volume via sysfs
Date: Fri, 17 Feb 2017 10:54:41 +0100
Message-ID: <cea40e680c08527626cffce979ece7f427917a03.1487323753.git.frieder.schrempf@exceet.de>
References: <cover.1487278130.git.frieder.schrempf@exceet.de> <cover.1487323753.git.frieder.schrempf@exceet.de>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1487323753.git.frieder.schrempf@exceet.de>
Sender: linux-kernel-owner@vger.kernel.org
To: robh@kernel.org
Cc: dmitry.torokhov@gmail.com, david@lechnology.com, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, luis@debethencourt.com, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Frieder Schrempf <frieder.schrempf@exceet.de>
List-Id: linux-input@vger.kernel.org

Make the driver accept switching volume levels via sysfs.
This can be helpful if the beep/bell sound intensity needs
to be adapted to the environment of the device.

The volume adjustment is done by changing the duty cycle of
the pwm signal.

This patch adds the sysfs interface with 5 default volume
levels (0 - mute, 4 - max. volume).

Signed-off-by: Frieder Schrempf <frieder.schrempf@exceet.de>
---
Changes in v5:
 - none

 Documentation/ABI/testing/sysfs-devices-pwm-beeper | 17 +++++
 drivers/input/misc/pwm-beeper.c                    | 84 +++++++++++++++++++++-
 2 files changed, 100 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/ABI/testing/sysfs-devices-pwm-beeper

diff --git a/Documentation/ABI/testing/sysfs-devices-pwm-beeper b/Documentation/ABI/testing/sysfs-devices-pwm-beeper
new file mode 100644
index 0000000..d068c58
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-devices-pwm-beeper
@@ -0,0 +1,17 @@
+What:		/sys/devices/.../pwm-beeper/volume
+Date:		February 2017
+KernelVersion:
+Contact:	Frieder Schrempf <frieder.schrempf@exceet.de>
+Description:
+		Control the volume of this pwm-beeper. Values
+		are between 0 and max_volume. This file will also
+		show the current volume level stored in the driver.
+
+What:		/sys/devices/.../pwm-beeper/max_volume
+Date:		February 2017
+KernelVersion:
+Contact:	Frieder Schrempf <frieder.schrempf@exceet.de>
+Description:
+		This file shows the maximum volume level that can be
+		assigned to volume.
+
diff --git a/drivers/input/misc/pwm-beeper.c b/drivers/input/misc/pwm-beeper.c
index 5f9655d..5fbc198 100644
--- a/drivers/input/misc/pwm-beeper.c
+++ b/drivers/input/misc/pwm-beeper.c
@@ -1,5 +1,9 @@
 /*
  *  Copyright (C) 2010, Lars-Peter Clausen <lars@metafoo.de>
+ *
+ *  Copyright (C) 2016, Frieder Schrempf <frieder.schrempf@exceet.de>
+ *  (volume support)
+ *
  *  PWM beeper driver
  *
  *  This program is free software; you can redistribute it and/or modify it
@@ -27,16 +31,69 @@ struct pwm_beeper {
 	struct pwm_device *pwm;
 	struct work_struct work;
 	unsigned long period;
+	unsigned int volume;
+	unsigned int *volume_levels;
+	unsigned int max_volume;
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
+static ssize_t beeper_show_max_volume(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct pwm_beeper *beeper = dev_get_drvdata(dev);
+
+	return sprintf(buf, "%d\n", beeper->max_volume);
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
+	if (volume > beeper->max_volume)
+		return -EINVAL;
+	pr_debug("set volume to %u\n", volume);
+	beeper->volume = volume;
+
+	return count;
+}
+
+static DEVICE_ATTR(volume, 0644, beeper_show_volume, beeper_store_volume);
+static DEVICE_ATTR(max_volume, 0644, beeper_show_max_volume, NULL);
+
+static struct attribute *pwm_beeper_attributes[] = {
+	&dev_attr_volume.attr,
+	&dev_attr_max_volume.attr,
+	NULL,
+};
+
+static struct attribute_group pwm_beeper_attribute_group = {
+	.attrs = pwm_beeper_attributes,
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
@@ -98,6 +155,7 @@ static int pwm_beeper_probe(struct platform_device *pdev)
 	unsigned long pwm_id = (unsigned long)dev_get_platdata(&pdev->dev);
 	struct pwm_beeper *beeper;
 	int error;
+	size_t size;
 
 	beeper = kzalloc(sizeof(*beeper), GFP_KERNEL);
 	if (!beeper)
@@ -123,6 +181,24 @@ static int pwm_beeper_probe(struct platform_device *pdev)
 
 	INIT_WORK(&beeper->work, pwm_beeper_work);
 
+	beeper->max_volume = 4;
+
+	size = sizeof(*beeper->volume_levels) *
+		(beeper->max_volume + 1);
+
+	beeper->volume_levels = devm_kzalloc(&(pdev->dev), size,
+		GFP_KERNEL);
+	if (!beeper->volume_levels)
+		return -ENOMEM;
+
+	beeper->volume_levels[0] = 0;
+	beeper->volume_levels[1] = 8;
+	beeper->volume_levels[2] = 20;
+	beeper->volume_levels[3] = 40;
+	beeper->volume_levels[4] = 500;
+
+	beeper->volume = beeper->max_volume;
+
 	beeper->input = input_allocate_device();
 	if (!beeper->input) {
 		dev_err(&pdev->dev, "Failed to allocate input device\n");
@@ -146,6 +222,12 @@ static int pwm_beeper_probe(struct platform_device *pdev)
 
 	input_set_drvdata(beeper->input, beeper);
 
+	error = sysfs_create_group(&pdev->dev.kobj, &pwm_beeper_attribute_group);
+	if (error) {
+		dev_err(&pdev->dev, "Failed to create sysfs group: %d\n", error);
+		goto err_pwm_free;
+	}
+
 	error = input_register_device(beeper->input);
 	if (error) {
 		dev_err(&pdev->dev, "Failed to register input device: %d\n", error);
-- 
2.7.4
