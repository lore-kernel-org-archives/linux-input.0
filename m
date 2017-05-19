From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH] input: silead: Disable interrupt during suspend
Date: Fri, 19 May 2017 16:06:42 +0200
Message-ID: <20170519140642.31800-1-hdegoede@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:35642 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755608AbdESOGo (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 19 May 2017 10:06:44 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org

When we put the touchscreen controller in low-power mode the irq
pin may trigger (float) and if we then try to read a data packet we
get the following error in dmesg:

[  478.801017] silead_ts i2c-MSSL1680:00: Data read error -121

This commit disables the irq during suspend/resume fixing this error.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/input/touchscreen/silead.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/input/touchscreen/silead.c b/drivers/input/touchscreen/silead.c
index 9b36f2750b9f..52c878a20a92 100644
--- a/drivers/input/touchscreen/silead.c
+++ b/drivers/input/touchscreen/silead.c
@@ -536,6 +536,7 @@ static int __maybe_unused silead_ts_suspend(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 
+	disable_irq(client->irq);
 	silead_ts_set_power(client, SILEAD_POWER_OFF);
 	return 0;
 }
@@ -561,6 +562,8 @@ static int __maybe_unused silead_ts_resume(struct device *dev)
 		return -ENODEV;
 	}
 
+	enable_irq(client->irq);
+
 	return 0;
 }
 
-- 
2.12.2

