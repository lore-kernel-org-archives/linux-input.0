From: Schrempf Frieder <frieder.schrempf@exceet.de>
Subject: [PATCH v2 1/3] input: pwm-beeper: add feature to set volume via
 sysfs
Date: Fri, 7 Oct 2016 09:08:16 +0000
Message-ID: <1475831223-6006-2-git-send-email-frieder.schrempf@exceet.de>
References: <fe6349a5-7935-5be7-6dc1-7e80fa9dceeb@exceet.de>
 <1475831223-6006-1-git-send-email-frieder.schrempf@exceet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.exceet.ch ([77.245.33.226]:41043 "EHLO smtp.exceet.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756368AbcJGJIT (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 7 Oct 2016 05:08:19 -0400
In-Reply-To: <1475831223-6006-1-git-send-email-frieder.schrempf@exceet.de>
Content-Language: de-DE
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "robh@kernel.org" <robh@kernel.org>
Cc: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "pawel.moll@arm.com" <pawel.moll@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "galak@codeaurora.org" <galak@codeaurora.org>, "luis@debethencourt.com" <luis@debethencourt.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Schrempf Frieder <frieder.schrempf@exceet.de>

Make the driver accept switching volume levels via sysfs.
This can be helpful if the beep/bell sound intensity needs
to be adapted to the environment of the device.

The volume adjustment is done by changing the duty cycle of
the pwm signal.

This patch adds the sysfs interface with 5 default volume
levels (0 - mute, 4 - max. volume).

Signed-off-by: Frieder Schrempf <frieder.schrempf@exceet.de>
---
Changes in v2:
 - split into 3 separate patches

 .../ABI/testing/sysfs-class-input-pwm-beeper       | 17 ++++++
 drivers/input/misc/pwm-beeper.c                    | 71 +++++++++++++++++++++-
 2 files changed, 87 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/ABI/testing/sysfs-class-input-pwm-beeper

diff --git a/Documentation/ABI/testing/sysfs-class-input-pwm-beeper b/Documentation/ABI/testing/sysfs-class-input-pwm-beeper
new file mode 100644
index 0000000..bcf8d8b
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-class-input-pwm-beeper
@@ -0,0 +1,17 @@
+What:		/sys/class/input/input(x)/volume
+Date:		April 2016
+KernelVersion:
+Contact:	Frieder Schrempf <frieder.schrempf@exceet.de>
+Description:
+		Control the volume of this pwm-beeper. Values
+		are between 0 and max_volume_level. This file will also
+		show the current volume level stored in the driver.
+
+What:		/sys/class/input/input(x)/max_volume_level
+Date:		April 2016
+KernelVersion:
+Contact:	Frieder Schrempf <frieder.schrempf@exceet.de>
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
  *  Copyright (C) 2010, Lars-Peter Clausen <lars@metafoo.de>
+ *
+ *  Copyright (C) 2016, Frieder Schrempf <frieder.schrempf@exceet.de>
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
1.9.1
