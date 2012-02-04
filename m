From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] Input: gpio_mouse - Use linux/gpio.h rather than asm/gpio.h
Date: Sat,  4 Feb 2012 16:23:45 +0000
Message-ID: <1328372625-31659-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:46007 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753276Ab2BDQXs (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 4 Feb 2012 11:23:48 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alessandro Rubini <rubini@ipvvis.unipv.it>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>

Direct usage of the asm include has long been deprecated by the
introduction of gpiolib.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 drivers/input/mouse/gpio_mouse.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/input/mouse/gpio_mouse.c b/drivers/input/mouse/gpio_mouse.c
index a9ad8e1..39fe9b7 100644
--- a/drivers/input/mouse/gpio_mouse.c
+++ b/drivers/input/mouse/gpio_mouse.c
@@ -12,9 +12,9 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/input-polldev.h>
+#include <linux/gpio.h>
 #include <linux/gpio_mouse.h>
 
-#include <asm/gpio.h>
 
 /*
  * Timer function which is run every scan_ms ms when the device is opened.
-- 
1.7.9.rc1

