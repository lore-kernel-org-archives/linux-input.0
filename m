From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RFC][PATCH] GPIO keys
Date: Tue, 3 Aug 2010 01:15:51 -0700
Message-ID: <20100803081551.GA16029@core.coreip.homeip.net>
References: <1280300530-17096-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:53119 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752171Ab0HCIP5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 3 Aug 2010 04:15:57 -0400
Received: by pzk26 with SMTP id 26so1567447pzk.19
        for <linux-input@vger.kernel.org>; Tue, 03 Aug 2010 01:15:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1280300530-17096-1-git-send-email-shubhrajyoti@ti.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Shubhrajyoti D <shubhrajyoti@ti.com>
Cc: linux-input@vger.kernel.org

Hi,

On Wed, Jul 28, 2010 at 12:32:10PM +0530, Shubhrajyoti D wrote:
> Allowing the call of open and close functions.
> If the gpio-keys device has some initialization
> to be done allow the call of platform functions.
> An example would be to enable the device.
> - Having seperate functions for open and close
> 

I think the patch can be improved still:

 - enable() should be allowed to fail and stop the device from
   being opened;

 - Pass the parent device into the callbacks so that they can
   differentiate in case there are 2 sets of gpio keys (or maybe
   you share the callbacks beween drivers, etc.

Does the following work for you?

Thanks.

-- 
Dmitry

Input: gpio_keys - add hooks to enable/disable device

From: Shubhrajyoti D <shubhrajyoti@ti.com>

Allow platform code to specify callbcks that will be invoked when
input device is opened or closed, allowing, for example, to enable
the device.

Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/keyboard/gpio_keys.c |   22 ++++++++++++++++++++++
 include/linux/gpio_keys.h          |    2 ++
 2 files changed, 24 insertions(+), 0 deletions(-)


diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index a9fd147..6069abe 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -39,6 +39,8 @@ struct gpio_keys_drvdata {
 	struct input_dev *input;
 	struct mutex disable_lock;
 	unsigned int n_buttons;
+	int (*enable)(struct device *dev);
+	void (*disable)(struct device *dev);
 	struct gpio_button_data data[0];
 };
 
@@ -423,6 +425,21 @@ fail2:
 	return error;
 }
 
+static int gpio_keys_open(struct input_dev *input)
+{
+	struct gpio_keys_drvdata *ddata = input_get_drvdata(input);
+
+	return ddata->enable ? ddata->enable(input->dev.parent) : 0;
+}
+
+static void gpio_keys_close(struct input_dev *input)
+{
+	struct gpio_keys_drvdata *ddata = input_get_drvdata(input);
+
+	if (ddata->disable)
+		ddata->disable(input->dev.parent);
+}
+
 static int __devinit gpio_keys_probe(struct platform_device *pdev)
 {
 	struct gpio_keys_platform_data *pdata = pdev->dev.platform_data;
@@ -444,13 +461,18 @@ static int __devinit gpio_keys_probe(struct platform_device *pdev)
 
 	ddata->input = input;
 	ddata->n_buttons = pdata->nbuttons;
+	ddata->enable = pdata->enable;
+	ddata->disable = pdata->disable;
 	mutex_init(&ddata->disable_lock);
 
 	platform_set_drvdata(pdev, ddata);
+	input_set_drvdata(input, ddata);
 
 	input->name = pdev->name;
 	input->phys = "gpio-keys/input0";
 	input->dev.parent = &pdev->dev;
+	input->open = gpio_keys_open;
+	input->close = gpio_keys_close;
 
 	input->id.bustype = BUS_HOST;
 	input->id.vendor = 0x0001;
diff --git a/include/linux/gpio_keys.h b/include/linux/gpio_keys.h
index cd0b3f3..ce73a30 100644
--- a/include/linux/gpio_keys.h
+++ b/include/linux/gpio_keys.h
@@ -17,6 +17,8 @@ struct gpio_keys_platform_data {
 	struct gpio_keys_button *buttons;
 	int nbuttons;
 	unsigned int rep:1;		/* enable input subsystem auto repeat */
+	int (*enable)(struct device *dev);
+	void (*disable)(struct device *dev);
 };
 
 #endif
