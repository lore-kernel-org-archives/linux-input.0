From: jooaun <jasaw81@gmail.com>
Subject: [PATCH 6/8] qt2160: only read device when Change pin is active
Date: Tue,  9 Nov 2010 13:45:38 +1100
Message-ID: <1289270738-4297-1-git-send-email-jasaw81@gmail.com>
References: <1289268911-32322-6-git-send-email-jasaw81@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:59232 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754722Ab0KICp5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 8 Nov 2010 21:45:57 -0500
Received: by gxk23 with SMTP id 23so3945227gxk.19
        for <linux-input@vger.kernel.org>; Mon, 08 Nov 2010 18:45:57 -0800 (PST)
In-Reply-To: <1289268911-32322-6-git-send-email-jasaw81@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, raphaelpereira@gmail.com, jooaun <jasaw81@gmail.com>

Check Change state and only read device when required.
Signed-off-by: Joo Aun Saw <jasaw81@gmail.com>
---
 drivers/input/keyboard/qt2160.c |   12 ++++++++++++
 include/linux/input/qt2160.h    |    5 +++++
 2 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/drivers/input/keyboard/qt2160.c b/drivers/input/keyboard/qt2160.c
index 7647849..8316fde 100755
--- a/drivers/input/keyboard/qt2160.c
+++ b/drivers/input/keyboard/qt2160.c
@@ -213,6 +213,12 @@ static irqreturn_t qt2160_irq(int irq, void *_qt2160)
 	struct qt2160_data *qt2160 = _qt2160;
 	unsigned long flags;
 
+	if (qt2160->hw_info->getchange) {
+		/* if change is not active, no IRQ to service */
+		if (qt2160->hw_info->getchange(qt2160->hw_info->data) > 0)
+			return IRQ_HANDLED;
+	}
+
 	spin_lock_irqsave(&qt2160->lock, flags);
 
 	__cancel_delayed_work(&qt2160->dwork);
@@ -225,6 +231,12 @@ static irqreturn_t qt2160_irq(int irq, void *_qt2160)
 
 static void qt2160_schedule_read(struct qt2160_data *qt2160)
 {
+	if (qt2160->hw_info->getchange) {
+		/* if change is not active, no need to read device */
+		if (qt2160->hw_info->getchange(qt2160->hw_info->data) > 0)
+			return;
+	}
+
 	spin_lock_irq(&qt2160->lock);
 	schedule_delayed_work(&qt2160->dwork, QT2160_CYCLE_INTERVAL);
 	spin_unlock_irq(&qt2160->lock);
diff --git a/include/linux/input/qt2160.h b/include/linux/input/qt2160.h
index 8a1913f..4eb7e18 100755
--- a/include/linux/input/qt2160.h
+++ b/include/linux/input/qt2160.h
@@ -7,6 +7,9 @@
 
 /**
  * struct qt2160_info - defines the chip configuration
+ * @data: private data for lowlevel IO abstraction routines
+ * @getchange: return 0 when CHANGE pin is active/low; return 1 when CHANGE pin
+ *  is deactivated/high
  * @slider_length: number of keys to use as slider, max 8 keys, min 2 keys
  * @slider_axis: absolute axis type, value 0 is ABS_X
  * @keycodes: key codes for keys that are part of the slider are ignored; slider
@@ -20,6 +23,8 @@
  *  sleep 16ms longer before detecting a touch (slower response); max 255
  */
 struct qt2160_info {
+	void *data;
+	int (*getchange) (void *data);
 	unsigned char slider_length;
 	unsigned int slider_axis;
 	unsigned short keycodes[QT2160_MAXKEYS];
-- 
1.7.0.4

