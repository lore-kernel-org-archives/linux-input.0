From: jooaun <jasaw81@gmail.com>
Subject: [PATCH 7/8] qt2160: optional interrupt flag
Date: Tue,  9 Nov 2010 13:15:10 +1100
Message-ID: <1289268911-32322-7-git-send-email-jasaw81@gmail.com>
References: <1289268911-32322-1-git-send-email-jasaw81@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:49374 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752055Ab0KICQE (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 8 Nov 2010 21:16:04 -0500
Received: by mail-gy0-f174.google.com with SMTP id 4so3965040gyh.19
        for <linux-input@vger.kernel.org>; Mon, 08 Nov 2010 18:16:03 -0800 (PST)
In-Reply-To: <1289268911-32322-1-git-send-email-jasaw81@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, raphaelpereira@gmail.com, jooaun <jasaw81@gmail.com>

Some GPIOs do not support falling edge only interrupt, so make interrupt flag configurable.
Signed-off-by: Joo Aun Saw <jasaw81@gmail.com>

Conflicts:

	include/linux/input/qt2160.h
---
 drivers/input/keyboard/qt2160.c |   11 +++++++++--
 include/linux/input/qt2160.h    |    2 ++
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/input/keyboard/qt2160.c b/drivers/input/keyboard/qt2160.c
index 8316fde..d2ce573 100755
--- a/drivers/input/keyboard/qt2160.c
+++ b/drivers/input/keyboard/qt2160.c
@@ -487,8 +487,15 @@ static int __devinit qt2160_probe(struct i2c_client *client,
 	}
 
 	if (client->irq) {
-		error = request_irq(client->irq, qt2160_irq,
-				    IRQF_TRIGGER_FALLING, "qt2160", qt2160);
+		if (hw_info->irq_flags) {
+			error = request_irq(client->irq, qt2160_irq,
+					    hw_info->irq_flags, "qt2160",
+					    qt2160);
+		} else {
+			error = request_irq(client->irq, qt2160_irq,
+					    IRQF_TRIGGER_FALLING, "qt2160",
+					    qt2160);
+		}
 		if (error) {
 			dev_err(&client->dev,
 				"failed to allocate irq %d\n", client->irq);
diff --git a/include/linux/input/qt2160.h b/include/linux/input/qt2160.h
index 4eb7e18..dad11bb 100755
--- a/include/linux/input/qt2160.h
+++ b/include/linux/input/qt2160.h
@@ -21,6 +21,7 @@
  * @key_burst_length: key sensitivity; 0 use default
  * @low_power_mode: value 0 use default; each +1 increment causes the chip to
  *  sleep 16ms longer before detecting a touch (slower response); max 255
+ * @irq_flags: value 0 use default IRQF_TRIGGER_FALLING
  */
 struct qt2160_info {
 	void *data;
@@ -31,6 +32,7 @@ struct qt2160_info {
 	unsigned char key_aks[QT2160_MAXKEYS];
 	unsigned char key_burst_length[QT2160_MAXKEYS];
 	unsigned char low_power_mode;
+	unsigned long irq_flags;
 };
 
 #endif /* __QT2160_H__ */
-- 
1.7.0.4

