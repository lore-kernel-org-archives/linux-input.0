From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH] input: tca6416-keypad: add IRQF_ONESHOT IRQ flag
Date: Wed, 4 Jul 2012 12:19:13 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1207041217420.21042@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:58705 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932623Ab2GDKTP (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 4 Jul 2012 06:19:15 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>

request_threaded_irq() without a hard IRQ handler can only be used, if the
driver also requests to keep the interrupt masked by using the IRQF_ONESHOT
IRQ flag.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

This has to go to 3.5 to fix otherwise broken platforms.

 drivers/input/keyboard/tca6416-keypad.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/input/keyboard/tca6416-keypad.c b/drivers/input/keyboard/tca6416-keypad.c
index 3afea3f..4559859 100644
--- a/drivers/input/keyboard/tca6416-keypad.c
+++ b/drivers/input/keyboard/tca6416-keypad.c
@@ -278,7 +278,7 @@ static int __devinit tca6416_keypad_probe(struct i2c_client *client,
 
 		error = request_threaded_irq(chip->irqnum, NULL,
 					     tca6416_keys_isr,
-					     IRQF_TRIGGER_FALLING,
+					     IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
 					     "tca6416-keypad", chip);
 		if (error) {
 			dev_dbg(&client->dev,
-- 
1.7.2.5

