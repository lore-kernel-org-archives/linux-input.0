From: "Datta, Shubhrajyoti" <shubhrajyoti@ti.com>
Subject: [RFC][PATCH] GPIO keys
Date: Tue, 27 Jul 2010 20:11:31 +0530
Message-ID: <0680EC522D0CC943BC586913CF3768C003B37D1C39@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:35935 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756177Ab0G0Olf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 27 Jul 2010 10:41:35 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id o6REfWaw006759
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-input@vger.kernel.org>; Tue, 27 Jul 2010 09:41:35 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id o6REfWEt001229
	for <linux-input@vger.kernel.org>; Tue, 27 Jul 2010 20:11:32 +0530 (IST)
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>


Allowing the call of open and close functions.
If the gpio-keys device has some initialization
to be done allow the call of platform functions.
An example would be to enable the device.

Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
 drivers/input/keyboard/gpio_keys.c |   23 +++++++++++++++++++++++
 include/linux/gpio_keys.h          |    1 +
 2 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index b8213fd..f459f38 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -38,6 +38,7 @@ struct gpio_keys_drvdata {
 	struct input_dev *input;
 	struct mutex disable_lock;
 	unsigned int n_buttons;
+	void (*enable)(int state);
 	struct gpio_button_data data[0];
 };
 
@@ -414,6 +415,24 @@ fail2:
 	return error;
 }
 
+static int gpio_keys_open(struct input_dev *dev)
+{
+	struct gpio_keys_drvdata *ddata;
+	ddata = input_get_drvdata(dev);
+	if (ddata->enable)
+		ddata->enable(1);
+	return 0;
+}
+
+static void gpio_keys_close(struct input_dev *dev)
+{
+	struct gpio_keys_drvdata *ddata;
+
+	ddata = input_get_drvdata(dev);
+	if (ddata->enable)
+		ddata->enable(0);
+}
+
 static int __devinit gpio_keys_probe(struct platform_device *pdev)
 {
 	struct gpio_keys_platform_data *pdata = pdev->dev.platform_data;
@@ -435,13 +454,17 @@ static int __devinit gpio_keys_probe(struct platform_device *pdev)
 
 	ddata->input = input;
 	ddata->n_buttons = pdata->nbuttons;
+	ddata->enable =  pdata->enable;
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
index cd0b3f3..5645996 100644
--- a/include/linux/gpio_keys.h
+++ b/include/linux/gpio_keys.h
@@ -17,6 +17,7 @@ struct gpio_keys_platform_data {
 	struct gpio_keys_button *buttons;
 	int nbuttons;
 	unsigned int rep:1;		/* enable input subsystem auto repeat */
+	void (*enable)(int state);
 };
 
 #endif
-- 
1.5.4.7

