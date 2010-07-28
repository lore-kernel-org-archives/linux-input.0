From: Shubhrajyoti D <shubhrajyoti@ti.com>
Subject: [RFC][PATCH] GPIO keys
Date: Wed, 28 Jul 2010 12:32:10 +0530
Message-ID: <1280300530-17096-1-git-send-email-shubhrajyoti@ti.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41826 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750749Ab0G1HCP (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 28 Jul 2010 03:02:15 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id o6S72CU3011872
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-input@vger.kernel.org>; Wed, 28 Jul 2010 02:02:14 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Shubhrajyoti D <shubhrajyoti@ti.com>

Allowing the call of open and close functions.
If the gpio-keys device has some initialization
to be done allow the call of platform functions.
An example would be to enable the device.
- Having seperate functions for open and close

Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
 drivers/input/keyboard/gpio_keys.c |   25 +++++++++++++++++++++++++
 include/linux/gpio_keys.h          |    2 ++
 2 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index b8213fd..d06644d 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -38,6 +38,8 @@ struct gpio_keys_drvdata {
 	struct input_dev *input;
 	struct mutex disable_lock;
 	unsigned int n_buttons;
+	void (*enable)(void);
+	void (*disable)(void);
 	struct gpio_button_data data[0];
 };
 
@@ -414,6 +416,24 @@ fail2:
 	return error;
 }
 
+static int gpio_keys_open(struct input_dev *dev)
+{
+	struct gpio_keys_drvdata *ddata;
+	ddata = input_get_drvdata(dev);
+	if (ddata->enable)
+		ddata->enable();
+	return 0;
+}
+
+static void gpio_keys_close(struct input_dev *dev)
+{
+	struct gpio_keys_drvdata *ddata;
+
+	ddata = input_get_drvdata(dev);
+	if (ddata->disable)
+		ddata->disable();
+}
+
 static int __devinit gpio_keys_probe(struct platform_device *pdev)
 {
 	struct gpio_keys_platform_data *pdata = pdev->dev.platform_data;
@@ -435,13 +455,18 @@ static int __devinit gpio_keys_probe(struct platform_device *pdev)
 
 	ddata->input = input;
 	ddata->n_buttons = pdata->nbuttons;
+	ddata->enable =  pdata->enable;
+	ddata->disable =  pdata->disable;
 	mutex_init(&ddata->disable_lock);
 
 	platform_set_drvdata(pdev, ddata);
+	input_set_drvdata(input , ddata);
 
 	input->name = pdev->name;
 	input->phys = "gpio-keys/input0";
 	input->dev.parent = &pdev->dev;
+	input->open = gpio_keys_open;
+	input->close = gpio_keys_close;
 
 	input->id.bustype = BUS_HOST;
 	input->id.vendor = 0x0001;
diff --git a/include/linux/gpio_keys.h b/include/linux/gpio_keys.h
index cd0b3f3..5089b1b 100644
--- a/include/linux/gpio_keys.h
+++ b/include/linux/gpio_keys.h
@@ -17,6 +17,8 @@ struct gpio_keys_platform_data {
 	struct gpio_keys_button *buttons;
 	int nbuttons;
 	unsigned int rep:1;		/* enable input subsystem auto repeat */
+	void (*enable)(void);
+	void (*disable)(void);
 };
 
 #endif
-- 
1.5.4.7

