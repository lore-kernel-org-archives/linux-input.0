From: KT Liao <ktalex.liao@gmail.com>
Subject: [PATCH] Input: /input/input-mt.c Emit BTN_TOO_FINGER in function input_mt_report_pointer_emulation if touchpad meets hover condition Signed-off-by: KT Liao <kt.liao@emc.com.tw>
Date: Sun, 29 May 2016 11:39:12 +0800
Message-ID: <1464493153-2509-1-git-send-email-kt.liao@emc.com.tw>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33919 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751907AbcE2Dj1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 28 May 2016 23:39:27 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
Cc: phoenix@emc.com.tw, kt.liao@emc.com.tw, jeff.chung@emc.com.tw, charliemooney@google.com

---
 drivers/input/input-mt.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/input/input-mt.c b/drivers/input/input-mt.c
index 54fce56..b89aaa7 100644
--- a/drivers/input/input-mt.c
+++ b/drivers/input/input-mt.c
@@ -218,8 +218,17 @@ void input_mt_report_pointer_emulation(struct input_dev *dev, bool use_count)
 	}
 
 	input_event(dev, EV_KEY, BTN_TOUCH, count > 0);
-	if (use_count)
+
+	if (use_count) {
+		if (count == 0 &&
+		    !test_bit(ABS_MT_DISTANCE, dev->absbit) &&
+		    test_bit(ABS_DISTANCE, dev->absbit) &&
+		    input_abs_get_val(dev, ABS_DISTANCE) != 0) {
+			count = 1;
+		}
 		input_mt_report_finger_count(dev, count);
+	}
+
 
 	if (oldest) {
 		int x = input_mt_get_value(oldest, ABS_MT_POSITION_X);
-- 
2.7.4

