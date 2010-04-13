From: Daniel Mack <daniel@caiaq.de>
Subject: [PATCH] input: eeti_ts: cancel pending work when going to suspend
Date: Tue, 13 Apr 2010 20:31:45 +0200
Message-ID: <1271183505-28133-1-git-send-email-daniel@caiaq.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from buzzloop.caiaq.de ([212.112.241.133]:55062 "EHLO
	buzzloop.caiaq.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753492Ab0DMSbz (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 13 Apr 2010 14:31:55 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Daniel Mack <daniel@caiaq.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

This fixes a race between the suspend code and input events.

Signed-off-by: Daniel Mack <daniel@caiaq.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/touchscreen/eeti_ts.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/drivers/input/touchscreen/eeti_ts.c b/drivers/input/touchscreen/eeti_ts.c
index 204b8a1..2a01695 100644
--- a/drivers/input/touchscreen/eeti_ts.c
+++ b/drivers/input/touchscreen/eeti_ts.c
@@ -250,6 +250,9 @@ static int eeti_ts_suspend(struct i2c_client *client, pm_message_t mesg)
 	if (device_may_wakeup(&client->dev))
 		enable_irq_wake(priv->irq);
 
+	disable_irq(priv->irq);
+	cancel_work_sync(&priv->work);
+
 	return 0;
 }
 
@@ -260,6 +263,10 @@ static int eeti_ts_resume(struct i2c_client *client)
 	if (device_may_wakeup(&client->dev))
 		disable_irq_wake(priv->irq);
 
+	/* If we have active users, read the events once to arm the IRQ */
+	if (priv->input->users)
+		eeti_ts_read(&priv->work);
+
 	return 0;
 }
 #else
-- 
1.7.0.3

