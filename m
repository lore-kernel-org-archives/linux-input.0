From: David Jander <david@protonic.nl>
Subject: [PATCH 3/3] Input: gpio_keys.c: Enable use with non-local GPIO chips.
Date: Tue,  7 Jun 2011 11:04:29 +0200
Message-ID: <1307437469-3791-4-git-send-email-david@protonic.nl>
References: <1307437469-3791-1-git-send-email-david@protonic.nl>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from protonic.xs4all.nl ([213.84.116.84]:16135 "EHLO
	protonic.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752329Ab1FGJFX (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 7 Jun 2011 05:05:23 -0400
In-Reply-To: <1307437469-3791-1-git-send-email-david@protonic.nl>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, linux-input@vger.kernel.org, David Jander <david@protonic.nl>

Use a threaded interrupt handler in order to permit the handler to use
a GPIO driver that causes things like I2C transactions being done inside
the handler context.
Also, gpio_keys_init needs to be declared as a late_initcall, to make sure
all needed GPIO drivers have been loaded if the drivers are built into the
kernel.

Signed-off-by: David Jander <david@protonic.nl>
---
 drivers/input/keyboard/gpio_keys.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index 4539b0b..bbb4e4d 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -3,7 +3,7 @@
  *
  * Copyright 2005 Phil Blundell
  *
- * Added OF support:
+ * Added OF support and enabled use with I2C GPIO expanders:
  * Copyright 2010 David Jander <david@protonic.nl>
  *
  * This program is free software; you can redistribute it and/or modify
@@ -418,7 +418,7 @@ static int __devinit gpio_keys_setup_key(struct device *dev,
 	if (!button->can_disable)
 		irqflags |= IRQF_SHARED;
 
-	error = request_any_context_irq(irq, gpio_keys_isr, irqflags, desc, bdata);
+	error = request_threaded_irq(irq, NULL, gpio_keys_isr, irqflags, desc, bdata);
 	if (error < 0) {
 		dev_err(dev, "Unable to claim irq %d; error %d\n",
 			irq, error);
@@ -770,10 +770,10 @@ static void __exit gpio_keys_exit(void)
 	platform_driver_unregister(&gpio_keys_device_driver);
 }
 
-module_init(gpio_keys_init);
+late_initcall(gpio_keys_init);
 module_exit(gpio_keys_exit);
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Phil Blundell <pb@handhelds.org>");
-MODULE_DESCRIPTION("Keyboard driver for CPU GPIOs");
+MODULE_DESCRIPTION("Keyboard driver for GPIOs");
 MODULE_ALIAS("platform:gpio-keys");
-- 
1.7.4.1

