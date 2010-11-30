From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH WIP 0/6] suggested changes to gpio_buttons driver
Date: Mon, 29 Nov 2010 23:56:10 -0800
Message-ID: <20101130075610.GB15731@core.coreip.homeip.net>
References: <1290524800-21419-10-git-send-email-juhosg@openwrt.org>
 <cover.1290631852.git.bengardiner@nanometrics.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:47729 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754157Ab0K3H4S (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 30 Nov 2010 02:56:18 -0500
Received: by yxt3 with SMTP id 3so2037060yxt.19
        for <linux-input@vger.kernel.org>; Mon, 29 Nov 2010 23:56:17 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <cover.1290631852.git.bengardiner@nanometrics.ca>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ben Gardiner <bengardiner@nanometrics.ca>
Cc: Gabor Juhos <juhosg@openwrt.org>, linux-input@vger.kernel.org

Hi Gabor, Ben,

On Wed, Nov 24, 2010 at 04:01:34PM -0500, Ben Gardiner wrote:
> These are just some suggested changes from the review in patch-form. I will
> do my best to make time for reviewing and testing any future versions of the
> patch that you submit but I will regrettably be moving to other projects 
> for awhile. Until then I will not be able to spend much time on integration.
> 
> With these patches applied I was able to build the da850-evm buttons and keys
> support with minimal changes.As I said, these are just suggested changes,
> please feel free to squash, edit or drop them as you see fit. My motivation 
> here is that if you pickup the driver name and config symbol names as-is then
> I will have no remaining integration to perform in the da850-evm series. I
> hope you don't mind that I have to patch and run here.
> 
> I look forward to your next version of the patch. 

I do like the original patch and even more so Ben changes. Could you
tell me if the following still works for you (goes on top of Ben's)
and if it does I'll fold everything together and queue for 2.6.38.

Thanks!

-- 
Dmitry

Input: gpio-buttons - misc changes

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/keyboard/gpio_keys_polled.c |   38 ++++++++++++++++++++++-------
 include/linux/gpio_keys.h                 |    2 ++
 include/linux/gpio_keys_polled.h          |   26 --------------------
 3 files changed, 31 insertions(+), 35 deletions(-)
 delete mode 100644 include/linux/gpio_keys_polled.h


diff --git a/drivers/input/keyboard/gpio_keys_polled.c b/drivers/input/keyboard/gpio_keys_polled.c
index 390ed93..6ed6910 100644
--- a/drivers/input/keyboard/gpio_keys_polled.c
+++ b/drivers/input/keyboard/gpio_keys_polled.c
@@ -25,7 +25,7 @@
 #include <linux/ioport.h>
 #include <linux/platform_device.h>
 #include <linux/gpio.h>
-#include <linux/gpio_keys_polled.h>
+#include <linux/gpio_keys.h>
 
 #define DRV_NAME	"gpio-keys-polled"
 
@@ -37,8 +37,9 @@ struct gpio_keys_button_data {
 
 struct gpio_keys_polled_dev {
 	struct input_polled_dev *poll_dev;
-	struct gpio_keys_polled_platform_data *pdata;
-	struct gpio_keys_button_data *data;
+	struct device *dev;
+	struct gpio_keys_platform_data *pdata;
+	struct gpio_keys_button_data data[0];
 };
 
 static void gpio_keys_polled_check_state(struct input_dev *input,
@@ -66,7 +67,7 @@ static void gpio_keys_polled_check_state(struct input_dev *input,
 static void gpio_keys_polled_poll(struct input_polled_dev *dev)
 {
 	struct gpio_keys_polled_dev *bdev = dev->private;
-	struct gpio_keys_polled_platform_data *pdata = bdev->pdata;
+	struct gpio_keys_platform_data *pdata = bdev->pdata;
 	struct input_dev *input = dev->input;
 	int i, threshold;
 
@@ -85,9 +86,27 @@ static void gpio_keys_polled_poll(struct input_polled_dev *dev)
 	}
 }
 
+static void gpio_keys_polled_open(struct input_polled_dev *dev)
+{
+	struct gpio_keys_polled_dev *bdev = dev->private;
+	struct gpio_keys_platform_data *pdata = bdev->pdata;
+
+	if (pdata->enable)
+		pdata->enable(bdev->dev);
+}
+
+static void gpio_keys_polled_close(struct input_polled_dev *dev)
+{
+	struct gpio_keys_polled_dev *bdev = dev->private;
+	struct gpio_keys_platform_data *pdata = bdev->pdata;
+
+	if (pdata->disable)
+		pdata->disable(bdev->dev);
+}
+
 static int __devinit gpio_keys_polled_probe(struct platform_device *pdev)
 {
-	struct gpio_keys_polled_platform_data *pdata = pdev->dev.platform_data;
+	struct gpio_keys_platform_data *pdata = pdev->dev.platform_data;
 	struct device *dev = &pdev->dev;
 	struct gpio_keys_polled_dev *bdev;
 	struct input_polled_dev *poll_dev;
@@ -106,8 +125,6 @@ static int __devinit gpio_keys_polled_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
-	bdev->data = (struct gpio_keys_button_data *) &bdev[1];
-
 	poll_dev = input_allocate_polled_device();
 	if (!poll_dev) {
 		dev_err(dev, "no memory for polled device\n");
@@ -118,6 +135,8 @@ static int __devinit gpio_keys_polled_probe(struct platform_device *pdev)
 	poll_dev->private = bdev;
 	poll_dev->poll = gpio_keys_polled_poll;
 	poll_dev->poll_interval = pdata->poll_interval;
+	poll_dev->open = gpio_keys_polled_open;
+	poll_dev->close = gpio_keys_polled_close;
 
 	input = poll_dev->input;
 
@@ -164,6 +183,7 @@ static int __devinit gpio_keys_polled_probe(struct platform_device *pdev)
 	}
 
 	bdev->poll_dev = poll_dev;
+	bdev->dev = dev;
 	bdev->pdata = pdata;
 	platform_set_drvdata(pdev, bdev);
 
@@ -182,7 +202,7 @@ static int __devinit gpio_keys_polled_probe(struct platform_device *pdev)
 	return 0;
 
 err_free_gpio:
-	for (i = i - 1; i >= 0; i--)
+	while (--i >= 0)
 		gpio_free(pdata->buttons[i].gpio);
 
 	input_free_polled_device(poll_dev);
@@ -197,7 +217,7 @@ err_free_bdev:
 static int __devexit gpio_keys_polled_remove(struct platform_device *pdev)
 {
 	struct gpio_keys_polled_dev *bdev = platform_get_drvdata(pdev);
-	struct gpio_keys_polled_platform_data *pdata = bdev->pdata;
+	struct gpio_keys_platform_data *pdata = bdev->pdata;
 	int i;
 
 	input_unregister_polled_device(bdev->poll_dev);
diff --git a/include/linux/gpio_keys.h b/include/linux/gpio_keys.h
index ce73a30..dd1a56f 100644
--- a/include/linux/gpio_keys.h
+++ b/include/linux/gpio_keys.h
@@ -16,6 +16,8 @@ struct gpio_keys_button {
 struct gpio_keys_platform_data {
 	struct gpio_keys_button *buttons;
 	int nbuttons;
+	unsigned int poll_interval;	/* polling interval in msecs -
+					   for polling driver only */
 	unsigned int rep:1;		/* enable input subsystem auto repeat */
 	int (*enable)(struct device *dev);
 	void (*disable)(struct device *dev);
diff --git a/include/linux/gpio_keys_polled.h b/include/linux/gpio_keys_polled.h
deleted file mode 100644
index bf7f94a..0000000
--- a/include/linux/gpio_keys_polled.h
+++ /dev/null
@@ -1,26 +0,0 @@
-/*
- *  Definitions for the GPIO buttons interface driver
- *
- *  Copyright (C) 2007-2010 Gabor Juhos <juhosg@openwrt.org>
- *
- *  This file was based on: /include/linux/gpio_keys.h
- *	The original gpio_keys.h seems not to have a license.
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License version 2 as
- *  published by the Free Software Foundation.
- *
- */
-
-#ifndef _GPIO_BUTTONS_H_
-#define _GPIO_BUTTONS_H_
-
-#include <linux/gpio_keys.h>
-
-struct gpio_keys_polled_platform_data {
-	struct gpio_keys_button *buttons;
-	int	nbuttons;		/* number of buttons */
-	int	poll_interval;		/* polling interval in msecs*/
-};
-
-#endif /* _GPIO_BUTTONS_H_ */
