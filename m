From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Fwd: [RFC] [PATCH] Input: ADP5588 - Support gpio function on
 unused pin
Date: Fri, 30 Jul 2010 10:08:54 -0700
Message-ID: <20100730170854.GA22450@core.coreip.homeip.net>
References: <4c459b70.0aee8c0a.1c29.3e9e@mx.google.com>
 <4C4DADA7.9000201@gmail.com>
 <20100726173844.GC14609@core.coreip.homeip.net>
 <AANLkTi=qHUknGZdoj75Nr9gCKe-TRPMf3cgtsHejSrOc@mail.gmail.com>
 <544AC56F16B56944AEC3BD4E3D5917712E7EC2301D@LIMKCMBX1.ad.analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:36028 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751921Ab0G3RJD (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 30 Jul 2010 13:09:03 -0400
Received: by pvc7 with SMTP id 7so617117pvc.19
        for <linux-input@vger.kernel.org>; Fri, 30 Jul 2010 10:09:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <544AC56F16B56944AEC3BD4E3D5917712E7EC2301D@LIMKCMBX1.ad.analog.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Hennerich, Michael" <Michael.Hennerich@analog.com>
Cc: Xiaolong Chen <xiaolong.chen@gmail.com>, "david-b@pacbell.net" <david-b@pacbell.net>, Michael Hennerich <hennerich@blackfin.uclinux.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, TAO HU <taohu@motorola.com>, "Yuan.Bo YE" <yuan-bo.ye@motorola.com>, Xiaolong CHEN <a21785@motorola.com>, uclinux-dist-devel <uclinux-dist-devel@blackfin.uclinux.org>

Hi Michael,

On Fri, Jul 30, 2010 at 09:29:36AM +0100, Hennerich, Michael wrote:
> Hi Dmitry,
> 
> I took a look at the driver in your next tree.
> 
> Two issues:
> -Avoid NULL pointer dereference in adp5588_gpio_add(),
> set clientdata before call to adp5588_gpio_add().

Ah, I see. However, now that you pointed this out, I do not like that
we pass 'struct dev ice *' and use dev_get_drvdata() when adding and
removing gpios. I'd rather pass keypad structre there, as in the patch
below. What do you think?

-- 
Dmitry


Input: adp5588-keypad - fix NULL dereference in adp5588_gpio_add()

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

The kpad structure is assigned to i2c client via i2s_set_clientdata()
at the end of adp5588_probe(), but in adp5588_gpio_add() we tried to
access it (via dev_get_drvdata! which is not nice at all) causing an
oops.

Let's pass pointer to kpad directly into adp5588_gpio_add() and
adp5588_gpio_remove() to avoid accessing driver data before it is
set up.

Also split out building of gpiomap into a separate function to
clear the logic.

Reported-by: Michael Hennerich <michael.hennerich@analog.com>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/keyboard/adp5588-keys.c |   64 ++++++++++++++++++---------------
 1 files changed, 35 insertions(+), 29 deletions(-)


diff --git a/drivers/input/keyboard/adp5588-keys.c b/drivers/input/keyboard/adp5588-keys.c
index c39ec93..4208ff5 100644
--- a/drivers/input/keyboard/adp5588-keys.c
+++ b/drivers/input/keyboard/adp5588-keys.c
@@ -173,41 +173,47 @@ static int adp5588_gpio_direction_output(struct gpio_chip *chip,
 	return ret;
 }
 
-static int __devinit adp5588_gpio_add(struct device *dev)
+static int __devinit adp5588_build_gpiomap(struct adp5588_kpad *kpad,
+				const struct adp5588_kpad_platform_data *pdata)
 {
-	struct adp5588_kpad *kpad = dev_get_drvdata(dev);
-	const struct adp5588_kpad_platform_data *pdata = dev->platform_data;
-	const struct adp5588_gpio_platform_data *gpio_data = pdata->gpio_data;
-	int i, error;
+	bool pin_used[MAXGPIO];
+	int n_unused = 0;
+	int i;
 
-	if (gpio_data) {
-		int j = 0;
-		bool pin_used[MAXGPIO];
+	for (i = 0; i < pdata->rows; i++)
+		pin_used[i] = true;
 
-		for (i = 0; i < pdata->rows; i++)
-			pin_used[i] = true;
+	for (i = 0; i < pdata->cols; i++)
+		pin_used[i + GPI_PIN_COL_BASE - GPI_PIN_BASE] = true;
 
-		for (i = 0; i < pdata->cols; i++)
-			pin_used[i + GPI_PIN_COL_BASE - GPI_PIN_BASE] = true;
+	for (i = 0; i < kpad->gpimapsize; i++)
+		pin_used[kpad->gpimap[i].pin - GPI_PIN_BASE] = true;
 
-		for (i = 0; i < kpad->gpimapsize; i++)
-			pin_used[kpad->gpimap[i].pin - GPI_PIN_BASE] = true;
+	for (i = 0; i < MAXGPIO; i++)
+		if (!pin_used[i])
+			kpad->gpiomap[n_unused++] = i;
 
-		for (i = 0; i < MAXGPIO; i++) {
-			if (!pin_used[i])
-				kpad->gpiomap[j++] = i;
-		}
-		kpad->gc.ngpio = j;
+	return n_unused;
+}
 
-		if (kpad->gc.ngpio)
-			kpad->export_gpio = true;
-	}
+static int __devinit adp5588_gpio_add(struct adp5588_kpad *kpad)
+{
+	struct device *dev = &kpad->client->dev;
+	const struct adp5588_kpad_platform_data *pdata = dev->platform_data;
+	const struct adp5588_gpio_platform_data *gpio_data = pdata->gpio_data;
+	int i, error;
 
-	if (!kpad->export_gpio) {
+	if (!gpio_data)
+		return 0;
+
+	kpad->gc.ngpio = adp5588_build_gpiomap(kpad, pdata);
+	if (kpad->gc.ngpio == 0) {
 		dev_info(dev, "No unused gpios left to export\n");
 		return 0;
 	}
 
+	kpad->export_gpio = true;
+
 	kpad->gc.direction_input = adp5588_gpio_direction_input;
 	kpad->gc.direction_output = adp5588_gpio_direction_output;
 	kpad->gc.get = adp5588_gpio_get_value;
@@ -243,9 +249,9 @@ static int __devinit adp5588_gpio_add(struct device *dev)
 	return 0;
 }
 
-static void __devexit adp5588_gpio_remove(struct device *dev)
+static void __devexit adp5588_gpio_remove(struct adp5588_kpad *kpad)
 {
-	struct adp5588_kpad *kpad = dev_get_drvdata(dev);
+	struct device *dev = &kpad->client->dev;
 	const struct adp5588_kpad_platform_data *pdata = dev->platform_data;
 	const struct adp5588_gpio_platform_data *gpio_data = pdata->gpio_data;
 	int error;
@@ -266,12 +272,12 @@ static void __devexit adp5588_gpio_remove(struct device *dev)
 		dev_warn(dev, "gpiochip_remove failed %d\n", error);
 }
 #else
-static inline int adp5588_gpio_add(struct device *dev)
+static inline int adp5588_gpio_add(struct adp5588_kpad *kpad)
 {
 	return 0;
 }
 
-static inline void adp5588_gpio_remove(struct device *dev)
+static inline void adp5588_gpio_remove(struct adp5588_kpad *kpad)
 {
 }
 #endif
@@ -581,7 +587,7 @@ static int __devinit adp5588_probe(struct i2c_client *client,
 	if (kpad->gpimapsize)
 		adp5588_report_switch_state(kpad);
 
-	error = adp5588_gpio_add(&client->dev);
+	error = adp5588_gpio_add(kpad);
 	if (error)
 		goto err_free_irq;
 
@@ -611,7 +617,7 @@ static int __devexit adp5588_remove(struct i2c_client *client)
 	free_irq(client->irq, kpad);
 	cancel_delayed_work_sync(&kpad->work);
 	input_unregister_device(kpad->input);
-	adp5588_gpio_remove(&client->dev);
+	adp5588_gpio_remove(kpad);
 	kfree(kpad);
 
 	return 0;
