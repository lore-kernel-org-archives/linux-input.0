From: Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>
Subject: [PATCH] input: update author email for gpio_mouse, at32psif, and atmel-wm97xx
Date: Tue, 28 Jun 2011 17:02:25 +0200
Message-ID: <1309273345-8830-1-git-send-email-hans-christian.egtvedt@atmel.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from forward.atmel.no ([194.19.124.53]:60041 "EHLO forward.atmel.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758765Ab1F1P1u (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 28 Jun 2011 11:27:50 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
Cc: Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>

This patch updates the email address of the gpio_mouse, at32psif, and
atmel-wm97xx drivers supported by me to an email account I will use on a more
regular basis in the future.

Signed-off-by: Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>
---
 drivers/input/mouse/gpio_mouse.c         |    2 +-
 drivers/input/serio/at32psif.c           |    2 +-
 drivers/input/touchscreen/atmel-wm97xx.c |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/input/mouse/gpio_mouse.c b/drivers/input/mouse/gpio_mouse.c
index 7b6ce17..58902fb 100644
--- a/drivers/input/mouse/gpio_mouse.c
+++ b/drivers/input/mouse/gpio_mouse.c
@@ -191,7 +191,7 @@ static void __exit gpio_mouse_exit(void)
 }
 module_exit(gpio_mouse_exit);
 
-MODULE_AUTHOR("Hans-Christian Egtvedt <hcegtvedt@atmel.com>");
+MODULE_AUTHOR("Hans-Christian Egtvedt <egtvedt@samfundet.no>");
 MODULE_DESCRIPTION("GPIO mouse driver");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("platform:gpio_mouse"); /* work with hotplug and coldplug */
diff --git a/drivers/input/serio/at32psif.c b/drivers/input/serio/at32psif.c
index 6ee8f0d..95280f9 100644
--- a/drivers/input/serio/at32psif.c
+++ b/drivers/input/serio/at32psif.c
@@ -372,6 +372,6 @@ static void __exit psif_exit(void)
 module_init(psif_init);
 module_exit(psif_exit);
 
-MODULE_AUTHOR("Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>");
+MODULE_AUTHOR("Hans-Christian Egtvedt <egtvedt@samfundet.no>");
 MODULE_DESCRIPTION("Atmel AVR32 PSIF PS/2 driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/input/touchscreen/atmel-wm97xx.c b/drivers/input/touchscreen/atmel-wm97xx.c
index fa8e56b..c804189 100644
--- a/drivers/input/touchscreen/atmel-wm97xx.c
+++ b/drivers/input/touchscreen/atmel-wm97xx.c
@@ -442,6 +442,6 @@ static void __exit atmel_wm97xx_exit(void)
 }
 module_exit(atmel_wm97xx_exit);
 
-MODULE_AUTHOR("Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>");
+MODULE_AUTHOR("Hans-Christian Egtvedt <egtvedt@samfundet.no>");
 MODULE_DESCRIPTION("wm97xx continuous touch driver for Atmel AT91 and AVR32");
 MODULE_LICENSE("GPL");
-- 
1.7.4.1

