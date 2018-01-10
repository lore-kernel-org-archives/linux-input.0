From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH] Input: goodix - disable IRQs while suspended
Date: Wed, 10 Jan 2018 12:34:56 +0100
Message-ID: <20180110113456.3091-1-hdegoede@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38156 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964819AbeAJLe7 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 10 Jan 2018 06:34:59 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bastien Nocera <hadess@hadess.net>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org

We should not try to do any i2c transfers before the controller is
resumed (which happens before our resume method gets called).

So we need to disable our IRQ while suspended to enforce this. The
code paths for devices with GPIOs for the int and reset pins already
disable the IRQ the through goodix_free_irq().

This commit also disables the IRQ while suspended for devices without
GPIOs for the int and reset pins.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/input/touchscreen/goodix.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
index 69d0b8cbc71f..ecec8eb17f28 100644
--- a/drivers/input/touchscreen/goodix.c
+++ b/drivers/input/touchscreen/goodix.c
@@ -878,8 +878,10 @@ static int __maybe_unused goodix_suspend(struct device *dev)
 	int error;
 
 	/* We need gpio pins to suspend/resume */
-	if (!ts->gpiod_int || !ts->gpiod_rst)
+	if (!ts->gpiod_int || !ts->gpiod_rst) {
+		disable_irq(client->irq);
 		return 0;
+	}
 
 	wait_for_completion(&ts->firmware_loading_complete);
 
@@ -919,8 +921,10 @@ static int __maybe_unused goodix_resume(struct device *dev)
 	struct goodix_ts_data *ts = i2c_get_clientdata(client);
 	int error;
 
-	if (!ts->gpiod_int || !ts->gpiod_rst)
+	if (!ts->gpiod_int || !ts->gpiod_rst) {
+		enable_irq(client->irq);
 		return 0;
+	}
 
 	/*
 	 * Exit sleep mode by outputting HIGH level to INT pin
-- 
2.14.3

