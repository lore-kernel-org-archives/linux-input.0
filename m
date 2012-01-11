From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 1/2] Input: nomadik-ske-keypad - do not assign driver's
 probe() method
Date: Tue, 10 Jan 2012 23:35:31 -0800
Message-ID: <20120111073531.18870.48568.stgit@hammer.corenet.prv>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:43800 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752457Ab2AKHfg (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 11 Jan 2012 02:35:36 -0500
Received: by iabz25 with SMTP id z25so710880iab.19
        for <linux-input@vger.kernel.org>; Tue, 10 Jan 2012 23:35:35 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sundar Iyer <sundar.iyer@stericsson.com>
Cc: linux-input@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>

Because we are using platform_device_probe() to register the driver
we do not need to assign driver's probe method. We also can mark
ske_keypad_probe(), together with ske_keypad_chip_init(), as __init
instead of __devinit.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/keyboard/nomadik-ske-keypad.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/input/keyboard/nomadik-ske-keypad.c b/drivers/input/keyboard/nomadik-ske-keypad.c
index e35566a..bc9f339 100644
--- a/drivers/input/keyboard/nomadik-ske-keypad.c
+++ b/drivers/input/keyboard/nomadik-ske-keypad.c
@@ -88,7 +88,7 @@ static void ske_keypad_set_bits(struct ske_keypad *keypad, u16 addr,
  *
  * Enable Multi key press detection, auto scan mode
  */
-static int __devinit ske_keypad_chip_init(struct ske_keypad *keypad)
+static int __init ske_keypad_chip_init(struct ske_keypad *keypad)
 {
 	u32 value;
 	int timeout = 50;
@@ -198,7 +198,7 @@ static irqreturn_t ske_keypad_irq(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static int __devinit ske_keypad_probe(struct platform_device *pdev)
+static int __init ske_keypad_probe(struct platform_device *pdev)
 {
 	const struct ske_keypad_platform_data *plat = pdev->dev.platform_data;
 	struct ske_keypad *keypad;
@@ -387,7 +387,6 @@ static struct platform_driver ske_keypad_driver = {
 		.pm = &ske_keypad_dev_pm_ops,
 #endif
 	},
-	.probe = ske_keypad_probe,
 	.remove = __devexit_p(ske_keypad_remove),
 };
 

