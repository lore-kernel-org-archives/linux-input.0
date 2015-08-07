From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH] Input: do not emit unneeded EV_SYN when suspending
Date: Thu, 6 Aug 2015 19:26:24 -0700
Message-ID: <20150807022624.GA11834@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:36632 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751003AbbHGC01 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 6 Aug 2015 22:26:27 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Benson Leung <bleung@chromium.org>, linux-kernel@vger.kernel.org

Do not emit EV_SYN/SYN_REPORT on suspend if there were no keys that are
still pressed as we are suspending the device.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/input.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/input/input.c b/drivers/input/input.c
index 78d2499..5391abd 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -674,13 +674,19 @@ EXPORT_SYMBOL(input_close_device);
  */
 static void input_dev_release_keys(struct input_dev *dev)
 {
+	bool need_sync = false;
 	int code;
 
 	if (is_event_supported(EV_KEY, dev->evbit, EV_MAX)) {
-		for_each_set_bit(code, dev->key, KEY_CNT)
+		for_each_set_bit(code, dev->key, KEY_CNT) {
 			input_pass_event(dev, EV_KEY, code, 0);
+			need_sync = true;
+		}
+
+		if (need_sync)
+			input_pass_event(dev, EV_SYN, SYN_REPORT, 1);
+
 		memset(dev->key, 0, sizeof(dev->key));
-		input_pass_event(dev, EV_SYN, SYN_REPORT, 1);
 	}
 }
 
-- 
2.5.0.rc2.392.g76e840b


-- 
Dmitry
