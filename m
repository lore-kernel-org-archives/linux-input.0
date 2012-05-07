From: Bo Shen <voice.shen@atmel.com>
Subject: [RFC] QT1070: change the trigger mode of QT1070
Date: Mon,  7 May 2012 10:27:33 +0800
Message-ID: <1336357653-18663-1-git-send-email-voice.shen@atmel.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from newsmtp5.atmel.com ([204.2.163.5]:22231 "EHLO
	sjogate2.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754894Ab2EGC2p (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 6 May 2012 22:28:45 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, javier.martin@vista-silicon.com
Cc: khali@linux-fr.org, w.sang@pengutronix.de, josh.wu@atmel.com, jm.lin@atmel.com, linux-input@vger.kernel.org, Bo Shen <voice.shen@atmel.com>

The default trigger mode of QT1070 is IRQF_TRIGGER_LOW,
Using TRQF_TRIGGER_FALLING to replace IRQF_TRIGGER_LOW | IRQF_ONESHOT.

Add a workaround for some SOC which can not distinguish the falling
and rising change on I/O lines.

Signed-off-by: Bo Shen <voice.shen@atmel.com>
---
 drivers/input/keyboard/qt1070.c |   13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/input/keyboard/qt1070.c b/drivers/input/keyboard/qt1070.c
index 0b7b2f8..1855e3d 100644
--- a/drivers/input/keyboard/qt1070.c
+++ b/drivers/input/keyboard/qt1070.c
@@ -201,10 +201,17 @@ static int __devinit qt1070_probe(struct i2c_client *client,
 	msleep(QT1070_RESET_TIME);
 
 	err = request_threaded_irq(client->irq, NULL, qt1070_interrupt,
-		IRQF_TRIGGER_NONE, client->dev.driver->name, data);
+		IRQF_TRIGGER_FALLING, client->dev.driver->name, data);
 	if (err) {
-		dev_err(&client->dev, "fail to request irq\n");
-		goto err_free_mem;
+		/* This is a workaround for some SOC which can not distinguish
+		 * falling and rising change on I/O lines.
+		 */
+		err = request_threaded_irq(client->irq, NULL, qt1070_interrupt,
+			IRQF_TRIGGER_NONE, client->dev.driver->name, data);
+		if (err) {
+			dev_err(&client->dev, "fail to request irq\n");
+			goto err_free_mem;
+		}
 	}
 
 	/* Register the input device */
-- 
1.7.10

